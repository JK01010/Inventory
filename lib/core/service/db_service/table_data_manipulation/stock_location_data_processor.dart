import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/good_receipts/data/models/stock_location_model.dart';
import '../../../di/service_locator.dart';
import '../../../utils/app_logger.dart';
import '../app_database.dart';
import '../tables/item_master_table.dart';
import '../tables/stock_location_table.dart';

abstract interface class StockLocationDataProcessor {
  Future<void> insertStockLocationItems({
    required List<StockLocationModel> stockLocationModelList,
  });

  Future<List<Map<String, dynamic>>> getStockLocationItems();

  Future<Unit> updateStockLocationsByItemId(int itemId);

  Future<List<Map<String, dynamic>>> getStockLocationsByItemId(int itemId);

  Future<List<Map<String, dynamic>>> getStockLocationsByStorageLocationId(
    int storageLocationId,
  );

  Future<void> clearStockLocationTable();
}

class StockLocationDataProcessorImpl implements StockLocationDataProcessor {
  StockLocationDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertStockLocationItems({
    required List<StockLocationModel> stockLocationModelList,
  }) async {
    final Batch batch = db.batch();

    for (var stockLocationModelItem in stockLocationModelList) {
      batch.insert(StockLocationTable.tableName, {
        StockLocationTable.id: stockLocationModelItem.id,
        StockLocationTable.itemId: stockLocationModelItem.itemId,
        StockLocationTable.quantity: stockLocationModelItem.quantity,
        StockLocationTable.storageLocationId:
            stockLocationModelItem.storageLocationId,
        StockLocationTable.tags: stockLocationModelItem.tags,
      });
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getStockLocationItems() async {
    final db = await AppDatabase.getInstance();
    return db.query(StockLocationTable.tableName);
  }

  @override
  Future<void> clearStockLocationTable() async {
    await db.delete(StockLocationTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getStockLocationsByItemId(
    int itemId,
  ) async {
    final db = await AppDatabase.getInstance();
    return db.rawQuery(
      '''
    SELECT 
    sl.*,   im.*
    FROM ${StockLocationTable.tableName} AS sl
    JOIN ${ItemMasterTable.tableName} AS im ON sl.itemId = im.itemId
    WHERE sl.itemId = ?
    ''',
      [itemId],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getStockLocationsByStorageLocationId(
    int storageLocationId,
  ) async {
    final db = await AppDatabase.getInstance();
    return db.rawQuery(
      '''
    SELECT 
    sl.*,   storage_loc.*
    FROM ${StockLocationTable.tableName} AS sl
    JOIN ${StockLocationTable.tableName} AS storage_loc ON sl.storageLocationId = storage_loc.id
    WHERE sl.storageLocationId = ?
    ''',
      [storageLocationId],
    );
  }

  @override
  Future<Unit> updateStockLocationsByItemId(int itemId) async {
    await db.rawUpdate(
      '''
      UPDATE ${StockLocationTable.tableName}
      SET 
      ${StockLocationTable.quantity}=?
      WHERE itemId IN ($itemId)
      ''',
      ["1000"],
    );
    return unit;
  }
}
