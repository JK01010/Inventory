import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/bagging_tagging_confirmtaion/model/bagging_confirmation_list_model.dart';
import '../../../../features/good_receipts/purchase_order_detail/data/models/purchase_order_items_list_model.dart';
import '../tables/purchase_order_items_table.dart';

abstract interface class PurchaseOrderItemsTableProcessor {
  Future<void> insertPurchaseOrderItemsList({
    required List<PurchaseOrderItemsData> purchaseOrderItemsData,
  });

  Future<List<Map<String, dynamic>>> getPurchaseOrderItemsData({
    required int poHdId,
  });

  Future<int> clearPurchaseOrderItemsTable();

  Future<int> updatePurchaseOrderItemData({
    required int poHdId,
    required int poDtId,
    required Map<String, dynamic> data,
  });
}

class PurchaseOrderItemsTableProcessorImpl
    implements PurchaseOrderItemsTableProcessor {
  PurchaseOrderItemsTableProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertPurchaseOrderItemsList({
    required List<PurchaseOrderItemsData> purchaseOrderItemsData,
  }) async {
    final Batch batch = db.batch();
    for (var element in purchaseOrderItemsData) {
      batch.insert(PurchaseOrderItemsTable.tableName, element.toJson());
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getPurchaseOrderItemsData({
    required int poHdId,
  }) async {
    return db.query(
      PurchaseOrderItemsTable.tableName,
      where: "${PurchaseOrderItemsTable.poHdId} = ?",
      whereArgs: [poHdId],
    );
  }

  @override
  Future<int> clearPurchaseOrderItemsTable() async {
    return db.delete(PurchaseOrderItemsTable.tableName);
  }

  @override
  Future<int> updatePurchaseOrderItemData({
    required int poHdId,
    required int poDtId,
    required Map<String, dynamic> data,
  }) {
    return db.update(
      PurchaseOrderItemsTable.tableName,
      data,
      where:
          "${PurchaseOrderItemsTable.poHdId} = ? AND ${PurchaseOrderItemsTable.poDtId} = ?",
      whereArgs: [poHdId, poDtId],
    );
  }
}
