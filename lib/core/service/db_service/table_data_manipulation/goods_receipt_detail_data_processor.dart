import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/good_receipts/data/models/purcase_order_hd_model.dart';
import '../app_database.dart';
import '../tables/fetch_imdg_class_table.dart';
import '../tables/purchase_order_table.dart';
import '../tables/storage_location_table.dart';

abstract interface class GoodsReceiptDetailDataProcessor {
  Future<List<Map<String, dynamic>>> getGoodsReceiptPoDetail(String poId);

  Future<void> clearGoodsReceiptPoDetailTable();

  Future<void> updateGoodsReceiptPoDetail(
    PurchaseOrderHDModel purchaseOrderHDModel,
  );

  Future<List<Map<String, dynamic>>> getAllStorageLocations();

  Future<List<Map<String, dynamic>>> getAllImdgClasses();
}

class GoodsReceiptDetailDataProcessorImpl
    implements GoodsReceiptDetailDataProcessor {
  GoodsReceiptDetailDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> clearGoodsReceiptPoDetailTable() async {
    final db = await AppDatabase.getInstance();
    await db.delete(PurchaseOrderTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getGoodsReceiptPoDetail(
    String poId,
  ) async {
    final db = await AppDatabase.getInstance();
    return db.query(
      PurchaseOrderTable.tableName,
      where: '${PurchaseOrderTable.poHdId} = ?',
      whereArgs: [poId],
    );
  }

  @override
  Future<void> updateGoodsReceiptPoDetail(
    PurchaseOrderHDModel purchaseOrderHDModel,
  ) async {
    await db.rawUpdate(
      '''
      UPDATE ${PurchaseOrderTable.tableName}
      SET 
 
      WHERE POHDID IN (${purchaseOrderHDModel.poHdId})
      ''',
      [
        "${purchaseOrderHDModel.deliveryPort}",
        "${purchaseOrderHDModel.deliveryDate}",
        "${purchaseOrderHDModel.weight}",
        "${purchaseOrderHDModel.actualVolume}",
        "${purchaseOrderHDModel.noOfPackets}",
        "${purchaseOrderHDModel.poRemarks}",
        (purchaseOrderHDModel.isFull == true ? "No" : "Yes"),
        (purchaseOrderHDModel.isBaggingCompleted == true ? "Yes" : "No"),
        (purchaseOrderHDModel.isLocked == true ? "Yes" : "No"),
      ],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAllStorageLocations() {
    return db.query(StorageLocationTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllImdgClasses() {
    return db.query(IMDGClassTable.tableName);
  }
}
