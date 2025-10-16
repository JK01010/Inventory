import 'package:sqflite/sqflite.dart';

import '../../../../features/good_receipts/data/models/pending_po_split_location_model.dart';
import '../../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_purchase_order_item_split_location_data.dart';
import '../tables/pending_po_split_location_table.dart';

abstract interface class PendingPoSplitLocationTableProcessor {
  Future<void> insertSplitLocationItems({
    required List<PendingPoSplitLocationModel> pendingPoSplitLocationDataItem,
  });

  Future<List<Map<String, dynamic>>> getSplitLocationItems({
    required GetPurchaseOrderItemSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  });

  ///storage location deletion
  // Future<Unit> deleteSplitStorageLocationItemById(
  //     SplitLocationData splitLocationModel,
  //     );
}

class PendingPoSplitLocationTableProcessorImpl
    implements PendingPoSplitLocationTableProcessor {
  PendingPoSplitLocationTableProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertSplitLocationItems({
    required List<PendingPoSplitLocationModel> pendingPoSplitLocationDataItem,
  }) async {
    final Batch batch = db.batch();

    for (var pendingPoSplitLocationDataItem in pendingPoSplitLocationDataItem) {
      final List<Map<String, dynamic>> existingRecords = await db.query(
        PendingPoSplitLocationTable.tableName,
        where: '${PendingPoSplitLocationTable.id} = ?',
        whereArgs: [pendingPoSplitLocationDataItem.id],
      );
      if (existingRecords.isEmpty) {
        batch.insert(
          PendingPoSplitLocationTable.tableName,
          pendingPoSplitLocationDataItem.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        batch.update(
          PendingPoSplitLocationTable.tableName,
          pendingPoSplitLocationDataItem.toJson(),
          where: '${PendingPoSplitLocationTable.id} = ?',
          whereArgs: [pendingPoSplitLocationDataItem.id],
        );
      }
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getSplitLocationItems({
    required GetPurchaseOrderItemSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  }) async {
    if (getPendingPoSplitLocationDataParams.poDtId == -2) {
      return db.query(
        PendingPoSplitLocationTable.tableName,
        where: '${PendingPoSplitLocationTable.poHdId} =?',
        whereArgs: [getPendingPoSplitLocationDataParams.poHdId],
      );
    } else {
      return db.query(
        PendingPoSplitLocationTable.tableName,
        where:
            '${PendingPoSplitLocationTable.poHdId} =? AND ${PendingPoSplitLocationTable.poDtId} =?',
        whereArgs: [
          getPendingPoSplitLocationDataParams.poHdId,
          getPendingPoSplitLocationDataParams.poDtId,
        ],
      );
    }
  }

  ///storage location deletion
  // @override
  // Future<Unit> deleteSplitStorageLocationItemById(
  //     SplitLocationData splitLocationModel,
  //     ) async {
  //   final db = await AppDatabase.getInstance();
  //
  //   await db.delete(
  //     SplitLocationTable.tableName,
  //     where:
  //     '${SplitLocationTable.id} =? AND ${SplitLocationTable.grnhdId} =? AND ${SplitLocationTable.grnDtId} =?',
  //     whereArgs: [
  //       splitLocationModel.id,
  //       splitLocationModel.grnhdid,
  //       splitLocationModel.grndtid,
  //     ],
  //   );
  //   return unit;
  // }
}
