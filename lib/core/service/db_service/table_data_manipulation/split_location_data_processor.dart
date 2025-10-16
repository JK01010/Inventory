import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../features/good_receipts/transaction_item_detail/data/models/split_location_model.dart';
import '../tables/split_location_table.dart';

abstract interface class SplitLocationDataProcessor {
  Future<void> insertSplitLocationItems({
    required List<SplitLocationData> splitLocationData,
  });

  Future<void> clearSplitLocationTable();

  Future<void> insertOrUpdateSplitLocationItems(
    List<SplitLocationData> splitLocationModelList,
  );

  Future<void> deleteSplitStorageLocationItemById(
    SplitLocationData splitLocationModel,
  );

  Future<List<Map<String, dynamic>>> getSplitStorageLocationForTransactionItem({
    required int grnId,
    required int grnDtId,
  });
}

class SplitLocationDataProcessorImpl implements SplitLocationDataProcessor {
  SplitLocationDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertSplitLocationItems({
    required List<SplitLocationData> splitLocationData,
  }) async {
    final Batch batch = db.batch();

    for (var splitLocationDataItem in splitLocationData) {
      batch.insert(
        SplitLocationTable.tableName,
        splitLocationDataItem.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<void> clearSplitLocationTable() async {
    await db.delete(SplitLocationTable.tableName);
  }

  @override
  Future<Unit> insertOrUpdateSplitLocationItems(
    List<SplitLocationData> splitLocationModelList,
  ) async {
    for (var splitLocation in splitLocationModelList) {
      final existing = await db.query(
        SplitLocationTable.tableName,
        where: 'id = ?',
        whereArgs: [splitLocation.id],
      );

      if (existing.isEmpty) {
        final map = splitLocation.toJson()..remove('locationName');
        await db.insert(SplitLocationTable.tableName, map);
      } else {
        await db.update(
          SplitLocationTable.tableName,
          splitLocation.toJson(),
          where: 'id = ?',
          whereArgs: [splitLocation.id],
        );
      }
    }
    return unit;
  }

  @override
  Future<Unit> deleteSplitStorageLocationItemById(
    SplitLocationData splitLocationModel,
  ) async {
    await db.delete(
      SplitLocationTable.tableName,
      where:
          '${SplitLocationTable.id} =? AND ${SplitLocationTable.grnhdId} =? AND ${SplitLocationTable.grnDtId} =?',
      whereArgs: [
        splitLocationModel.id,
        splitLocationModel.grnhdid,
        splitLocationModel.grndtid,
      ],
    );
    return unit;
  }

  @override
  Future<List<Map<String, dynamic>>> getSplitStorageLocationForTransactionItem({
    required int grnId,
    required int grnDtId,
  }) async {
    final result = await db.query(
      SplitLocationTable.tableName,
      where:
          '${SplitLocationTable.grnhdId} = ? AND ${SplitLocationTable.grnDtId} = ?',
      whereArgs: [grnId, grnDtId],
    );
    return result;
  }
}
