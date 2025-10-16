import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import '../../../../features/good_receipts/transaction_item_detail/data/models/transaction_item_detail_model.dart';
import '../tables/default_location_table.dart';
import '../tables/item_master_table.dart';
import '../tables/transaction_dt_table.dart';

abstract interface class TransactionItemsTableProcessor {
  Future<void> insertTransactionDtData({
    required List<TransactionItemDetailsModel> transactionDtList,
  });

  Future<List<Map<String, Object?>>> getAllTransactionItemDetailData();

  Future<List<Map<String, dynamic>>> getAllTransactionItemsByGrn({
    required int grnId,
  });
}

class TransactionItemsTableProcessorImpl
    implements TransactionItemsTableProcessor {
  TransactionItemsTableProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertTransactionDtData({
    required List<TransactionItemDetailsModel> transactionDtList,
  }) async {
    final batch = db.batch();

    for (var element in transactionDtList) {
      batch.insert(TransactionItemsTable.tableName, element.toJson());
    }

    await batch.commit();
  }

  @override
  Future<List<Map<String, Object?>>> getAllTransactionItemDetailData() async {
    final data = await db.query(TransactionItemsTable.tableName);
    return data;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllTransactionItemsByGrn({
    required int grnId,
  }) async {
    final String query = '''
      SELECT TI.*,IM.${ItemMasterTable.packSize},IM.${ItemMasterTable.serialNo},DL.${DefaultLocationTable.id} AS default_location_id,DL.${DefaultLocationTable.locationName} AS default_location FROM ${TransactionItemsTable.tableName} AS TI
      JOIN ${ItemMasterTable.tableName} AS IM
      ON IM.${ItemMasterTable.itemId} = TI.${TransactionItemsTable.itemId}
      JOIN ${DefaultLocationTable.tableName} AS DL
      ON DL.${DefaultLocationTable.itemId} = TI.${TransactionItemsTable.itemId}
      WHERE TI.${TransactionItemsTable.grnId} = $grnId
      GROUP BY TI.${TransactionItemsTable.grnDtId}
    ''';
    final data = await db.rawQuery(query);
    return data;
  }
}
