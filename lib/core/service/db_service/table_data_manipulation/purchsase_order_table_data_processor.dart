import 'dart:developer';

import 'dart:developer';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../../../features/good_receipts/purchase_order/data/model/purchase_order_filter_model.dart';
import '../../../../features/good_receipts/purchase_order/data/model/purchase_order_model.dart';
import '../tables/purchase_order_table.dart';

abstract interface class PurchaseOrderTableDataProcessor {
  Future<void> insertPurchaseOrder({
    required List<PurchaseOrderModel> purchaseOrderModelList,
  });

  Future<List<Map<String, dynamic>>> getAllPurchaseOrderFromDb({
    PurchaseOrderFilterModel? filter,
  });
}

class PurchaseOrderTableDataProcessorImpl
    implements PurchaseOrderTableDataProcessor {
  PurchaseOrderTableDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertPurchaseOrder({
    required List<PurchaseOrderModel> purchaseOrderModelList,
  }) async {
    final Batch batch = db.batch();

    for (var element in purchaseOrderModelList) {
      batch.insert(
        PurchaseOrderTable.tableName,
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllPurchaseOrderFromDb({
    PurchaseOrderFilterModel? filter,
  }) async {
    // table name
    const table = PurchaseOrderTable.tableName;

    // list to hold WHERE conditions
    List<String> conditions = [];
    List<dynamic> whereArgs = [];

    if (filter != null) {
      // poTitle / poNo / grnId search (PARTIAL MATCH using LIKE)
      if (filter.poNumberOrTitle != null &&
          filter.poNumberOrTitle!.isNotEmpty) {
        final String trimmed = filter.poNumberOrTitle!.trim();
        conditions.add(
          '(${PurchaseOrderTable.title} LIKE ? '
          'OR ${PurchaseOrderTable.poCode} LIKE ? '
          'OR ${PurchaseOrderTable.grnId} LIKE ?)',
        );
        final String likeValue = '%$trimmed%';
        whereArgs.addAll([likeValue, likeValue, likeValue]);
      }

      // category filter (list → exact match handled by IN)

      if (filter.categoryList.isNotEmpty) {
        final likeClauses = filter.categoryList
            .map((e) => '${PurchaseOrderTable.requisitionCategoryId} LIKE ?')
            .join(' OR ');

        conditions.add('($likeClauses)');
        whereArgs.addAll(filter.categoryList.map((e) => '%${e.categoryName}%'));
      }

      // // delivery port filter (PARTIAL MATCH using LIKE)
      if (filter.deliveryPortName != null &&
          filter.deliveryPortName!.isNotEmpty) {
        conditions.add('${PurchaseOrderTable.deliveryPort} LIKE ?');
        whereArgs.add('%${filter.deliveryPortName}%');
      }

      // grnNo filter (PARTIAL MATCH using LIKE)
      if (filter.grnNo != null && filter.grnNo!.isNotEmpty) {
        conditions.add('${PurchaseOrderTable.grnId} LIKE ?');
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
        conditions.add('${PurchaseOrderTable.poCreatedOn} BETWEEN ? AND ?');
        whereArgs.addAll([
          fromDate.toIso8601String(),
          toDate.toIso8601String(),
        ]);
      } else if (fromDate != null) {
        conditions.add('${PurchaseOrderTable.poCreatedOn} >= ?');
        whereArgs.add(fromDate.toIso8601String());
      } else if (toDate != null) {
        conditions.add('${PurchaseOrderTable.poCreatedOn} <= ?');
        whereArgs.add(toDate.toIso8601String());
      }
    }

    // final WHERE clause
    final whereClause = conditions.isNotEmpty ? conditions.join(' AND ') : null;

    // execute query
    return db.query(table, where: whereClause, whereArgs: whereArgs);
  }
}
