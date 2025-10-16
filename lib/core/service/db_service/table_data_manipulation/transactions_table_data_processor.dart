import 'package:flutter/material.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../../../features/good_receipts/data/models/transaction_filter_model.dart';
import '../../../../features/good_receipts/transaction/data/model/transaction_model.dart';
import '../../../constants/app_enum.dart';
import '../tables/transaction_dt_table.dart';
import '../tables/transaction_table.dart';

abstract interface class TransactionsTableDataProcessor {
  Future<void> insertTransactionData({
    required List<TransactionModel> goodsReceiptTransactionModelList,
  });

  Future<List<Map<String, dynamic>>> getAllTransaction({
    TransactionFilterModel? filter,
  });
}

class TransactionsTableDataProcessorImpl
    implements TransactionsTableDataProcessor {
  TransactionsTableDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertTransactionData({
    required List<TransactionModel> goodsReceiptTransactionModelList,
  }) async {
    final Batch batch = db.batch();
    for (var element in goodsReceiptTransactionModelList) {
      // Check if the record exists and isConfirmed is 0
      final existingRecord = await db.query(
        TransactionTable.tableName,
        where:
            '${TransactionTable.grnId} = ? AND ${TransactionTable.isConfirmed} = ?',
        whereArgs: [element.grnId, 0],
      );

      if (existingRecord.isNotEmpty) {
        // If record exists with isConfirmed = 0, then insert/replace
        batch.insert(
          TransactionTable.tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else if (existingRecord.isEmpty) {
        // If record does not exist, then insert
        batch.insert(TransactionTable.tableName, element.toJson());
      }
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllTransaction({
    TransactionFilterModel? filter,
  }) async {
    // table name
    const table = TransactionTable.tableName;

    // list to hold WHERE conditions
    List<String> conditions = [];
    List<dynamic> whereArgs = [];

    if (filter != null) {
      if (filter.poNumberOrTitle != null &&
          filter.poNumberOrTitle!.isNotEmpty) {
        final String trimmed = filter.poNumberOrTitle!.trim();

        conditions.add(
          '(${TransactionTable.poNo} LIKE ? '
          'OR ${TransactionTable.poNo} LIKE ? '
          'OR ${TransactionTable.grnId} LIKE ?)',
        );
        final String likeValue = '%$trimmed%';
        whereArgs.addAll([likeValue, likeValue, likeValue]);
      }

      // syncStatus filter (enum -> db value)
      if (filter.syncFilter != null && filter.syncFilter != SyncFilter.all) {
        if (filter.syncFilter == SyncFilter.synced) {
          conditions.add('${TransactionTable.syncStatus} = ?');
          whereArgs.add(1);
        } else if (filter.syncFilter == SyncFilter.unSynced) {
          conditions.add('${TransactionTable.syncStatus} = ?');
          whereArgs.add(0);
        }
      }

      // category filter (list → exact match handled by IN)
      if (filter.categoryList?.isNotEmpty ?? false) {
        final likeClauses = filter.categoryList
            ?.map((e) => '${TransactionTable.category} LIKE ?')
            .join(' OR ');

        conditions.add('($likeClauses)');
        whereArgs.addAll(
          filter.categoryList?.map((e) => '%${e.categoryName}') ?? [],
        );
      }
      // // delivery port filter (PARTIAL MATCH using LIKE)
      if (filter.deliveryPort != null && filter.deliveryPort != -1) {
        conditions.add('${TransactionTable.portID} LIKE ?');
        whereArgs.add('%${filter.deliveryPort}%');
      }
      // grnNo filter (PARTIAL MATCH using LIKE)
      if (filter.grnNo != null && filter.grnNo!.isNotEmpty) {
        conditions.add('${TransactionTable.receiptNo} LIKE ?');
        whereArgs.add('%${filter.grnNo}%');
      }
      // date range filter (keep as is → BETWEEN/<=/>= makes sense here)

      DateTime? fromDate = filter.fromDate;
      DateTime? toDate = filter.toDate;

      if (fromDate != null) {
        fromDate = DateTime(
          fromDate.year,
          fromDate.month,
          fromDate.day,
        ); // start of day
      }

      if (toDate != null) {
        toDate = DateTime(
          toDate.year,
          toDate.month,
          toDate.day,
          23,
          59,
          59,
          999,
        ); // end of day
      }

      if (fromDate != null && toDate != null) {
        conditions.add('${TransactionTable.receiptDate} BETWEEN ? AND ?');
        whereArgs.addAll([
          fromDate.toIso8601String(),
          toDate.toIso8601String(),
        ]);
      } else if (fromDate != null) {
        conditions.add('${TransactionTable.receiptDate} >= ?');
        whereArgs.add(fromDate.toIso8601String());
      } else if (toDate != null) {
        conditions.add('${TransactionTable.receiptDate} <= ?');
        whereArgs.add(toDate.toIso8601String());
      }
    }
    final whereClause = conditions.isNotEmpty ? conditions.join(' AND ') : null;
    final String query = """
SELECT t.*,
IFNULL(SUM(d.${TransactionItemsTable.damagedOrWrongSupply}),0) AS DamagedOrwrongSupply,
IFNULL(SUM(d.${TransactionItemsTable.newStock}), 0) AS NewStock,
IFNULL(SUM(d.${TransactionItemsTable.receivedQty}), 0) AS ReceivedQty,
 COUNT(d.${TransactionItemsTable.itemId}) AS ItemCount

FROM ${TransactionTable.tableName} t
LEFT JOIN ${TransactionItemsTable.tableName} d
ON t.${TransactionTable.grnId}=d.${TransactionItemsTable.grnId}
${whereClause != null ? 'WHERE $whereClause' : ''}
GROUP BY t.${TransactionTable.grnId}


 """;

    // final WHERE clause

    final data = await db.rawQuery(query, whereArgs);
    return data;
  }
}
