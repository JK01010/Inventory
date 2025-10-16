import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/stock_update/data/models/stocck_update_transaction_fetch_api_response_model.dart';
import '../../../../features/stock_update/data/models/stock_update_response_model.dart';
import '../../../../features/stock_update/data/models/stock_update_transaction_save_response_model.dart';
import '../tables/stock_update_table.dart';

abstract interface class StockUpdateDataProcessor {
  Future<void> insertStockUpdateTransactionList({
    required List<StockUpdateTrnFetchApiModel> stockUpdateList,
  });

  Future<void> singleInsertStockUpdate({
    required StockUpdateModel stockUpdateModel,
  });

  Future<void> multipleInsertStockUpdate({
    required List<StockUpdateModel> stockUpdateList,
  });

  Future<List<Map<String, dynamic>>> fetchUnSyncedStockUpdateTransactionList();

  Future<void> clearDataFromTable();

  Future<List<Map<String, dynamic>>> fetchAllStockUpdateViewData({
    required int offSet,
  });

  Future<List<Map<String, dynamic>>> fetchSearchStockUpdateViewData({
    required String searchText,
  });

  Future<List<Map<String, dynamic>>> fetchAllStockUpdateViewDataForFilter({
    required String itemName,
    required String articleNo,
  });

  //rfidListing
  Future<List<Map<String, dynamic>>> fetchAllRfidScanningListByRfIds({
    required List<String> rfIds,
  });

  Future<void> updateSyncedDataFromApiStockUpdate({
    required int transactionHdId,
    required List<TransactionHdModel> responseModel,
  });
}

class StockUpdateDataProcessorImpl implements StockUpdateDataProcessor {
  const StockUpdateDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertStockUpdateTransactionList({
    required List<StockUpdateTrnFetchApiModel> stockUpdateList,
  }) async {
    final Batch batch = db.batch();
    for (var item in stockUpdateList) {
      batch.insert(StockUpdateTable.tableName, {
        StockUpdateTable.transactionDtId: item.transactionDtId,
        StockUpdateTable.itemId: item.itemId,
        StockUpdateTable.quantity: item.quantity,
        StockUpdateTable.storageLocationId: item.storageLocationId,
        StockUpdateTable.remarks: item.remarks,
        StockUpdateTable.modifiedOn: item.modifiedOn,
        StockUpdateTable.syncStatus: "Y",
        StockUpdateTable.syncMerge: item.syncMerge,
        StockUpdateTable.transactionId: item.transactionId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  @override
  Future<void> singleInsertStockUpdate({
    required StockUpdateModel stockUpdateModel,
  }) async {
    await db.insert(StockUpdateTable.tableName, {
      StockUpdateTable.transactionDtId: stockUpdateModel.id,
      StockUpdateTable.itemId: stockUpdateModel.itemId,
      StockUpdateTable.quantity: stockUpdateModel.quantity,
      StockUpdateTable.storageLocationId: stockUpdateModel.storageLocationId,
      StockUpdateTable.remarks: stockUpdateModel.remarks,
      StockUpdateTable.modifiedOn: stockUpdateModel.modifiedOn,
      StockUpdateTable.syncStatus: stockUpdateModel.syncStatus,
      StockUpdateTable.syncMerge: stockUpdateModel.syncMerge,
      StockUpdateTable.transactionId: stockUpdateModel.transactionId,
      StockUpdateTable.totalRob: stockUpdateModel.totalRob,
      StockUpdateTable.adjustNewStock: stockUpdateModel.adjustNewStock,
      StockUpdateTable.adjustReconditionStock:
          stockUpdateModel.adjustReconditionStock,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    //update split_location quantity
    var updatedQuantity = stockUpdateModel.totalRob + stockUpdateModel.quantity;
    await db.rawUpdate(
      '''
        UPDATE split_location 
          SET Quantity = ? 
          WHERE StorageLocationID = ? 
          AND ItemID = ? 
        ''',
      [
        updatedQuantity,
        stockUpdateModel.storageLocationId,
        stockUpdateModel.itemId,
      ],
    );
   //update ItemRobDetails quantity
    await db.rawUpdate(
      '''
       UPDATE ItemRobDetails
        SET NewStock = ?, 
            ReconditionedStock = ?,
            TotalROB = ?
        WHERE StorageLocationID = ? 
        AND ItemID = ?
        ''',
      [
        stockUpdateModel.adjustNewStock,
        stockUpdateModel.adjustReconditionStock,
        updatedQuantity,
        stockUpdateModel.storageLocationId,
        stockUpdateModel.itemId,
      ],
    );
  }

  @override
  Future<void> clearDataFromTable() async {
    db.delete(StockUpdateTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllStockUpdateViewData({
    required int offSet,
  }) {
    //need to join storageLocation table for defaultStorageLocation
    return db.rawQuery('''
     SELECT
      IM.itemName as itemName,
      IM.articleNumber as articleNumber,
      SU.remarks,
      cast(SU.quantity as TEXT) as quantity,
      SL.LocName as  defaultStorageLocation,
      SU.syncStatus 
 
    FROM stockUpdate AS SU 
    JOIN item_master AS IM 
    
    ON SU.itemId = IM.itemId
    
   JOIN storage_location AS SL
   ON SL.ID = SU.storageLocationId
    
    group by SU.transactionId
  ''');
  }

  @override
  Future<List<Map<String, dynamic>>> fetchSearchStockUpdateViewData({
    required String searchText,
  }) {
    return db.rawQuery('''
     SELECT
      IM.itemName as itemName,
      IM.articleNumber as articleNumber,
      SU.remarks,
      cast(SU.quantity as TEXT) as quantity,
      SL.LocName as  defaultStorageLocation,
      SU.syncStatus 
 
    FROM stockUpdate AS SU 
    JOIN item_master AS IM 
    
    ON SU.itemId = IM.itemId
    
   JOIN storage_location AS SL
   ON SL.ID = SU.storageLocationId
   
   WHERE IM.itemName LIKE '%$searchText%' 
    
    group by SU.transactionId
    
  ''');
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllStockUpdateViewDataForFilter({
    required String itemName,
    required String articleNo,
  }) {
    String mainQuery = '''
      SELECT
      IM.itemName as itemName,
      IM.articleNumber as articleNumber,
      SU.remarks,
      cast(SU.quantity as TEXT) as quantity,
      SL.LocName as  defaultStorageLocation,
      SU.syncStatus 
 
    FROM stockUpdate AS SU 
    JOIN item_master AS IM 
    
    ON SU.itemId = IM.itemId
    
    JOIN storage_location AS SL
    ON SL.ID = SU.storageLocationId
    
        ''';
    String secondaryQuery = " WHERE ";

    if (itemName != "" || articleNo != "") {
      if (itemName != "") {
        secondaryQuery += " IM.itemName = '$itemName' ";
      }
      if (articleNo != "") {
        secondaryQuery += " IM.articleNumber = '$articleNo' ";
      }
      return db.rawQuery('''
      $mainQuery$secondaryQuery group by SU.transactionId
      ''');
    }
    if (kDebugMode) {
      print(mainQuery);
    }
    return db.rawQuery(mainQuery);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllRfidScanningListByRfIds({
    required List<String> rfIds,
  }) async {
    if (rfIds.isNotEmpty) {
      final List<Map<String, dynamic>> allList = [];
      for (int i = 0; i < rfIds.length; i++) {
        ///todo change storageLocation & installedOnLocation getting from the table
        final List<Map<String, dynamic>> data = await db.rawQuery('''
    SELECT 
     IM.itemId,
     IM.itemName,
     IM.itemCode,
     RL.rfidId,
     CAST(STKL.quantity AS INT) AS rob,
     IM.articleNumber AS articleNo,
     STOL.LocName AS storageLocation,
     IM.itemName AS installedOnLocation,
     STKL.storageLocationId as defaultStorageLocationId,
     IM.equipmentFlag
     
      FROM 
      item_master AS IM join rfidListing AS RL 
      ON IM.itemId = RL.itemId 
      
      join split_location AS STKL ON
      STKL.itemId = IM.itemId
      
      join storage_location AS STOL ON
      STOL.id = STKL.storageLocationId
      
      WHERE RL.rfidId = '${rfIds[i]}' 
  ''');
        allList.addAll(data);
      }

      // ✅ Remove duplicates by defaultStorageLocationId
      final seen = <dynamic>{};
      final uniqueList =
          allList.where((row) {
            final id = row['defaultStorageLocationId'];
            if (seen.contains(id)) {
              return false;
            } else {
              seen.add(id);
              return true;
            }
          }).toList();

      return uniqueList;
    } else {
      return [];
    }
  }

  @override
  Future<void> multipleInsertStockUpdate({
    required List<StockUpdateModel> stockUpdateList,
  }) async {
    final Batch batch = db.batch();
    for (var item in stockUpdateList) {
      batch.insert(StockUpdateTable.tableName, {
        StockUpdateTable.transactionDtId: item.id,
        StockUpdateTable.itemId: item.itemId,
        StockUpdateTable.quantity: item.quantity,
        StockUpdateTable.storageLocationId: item.storageLocationId,
        StockUpdateTable.remarks: item.remarks,
        StockUpdateTable.modifiedOn: item.modifiedOn,
        StockUpdateTable.syncStatus: item.syncStatus,
        StockUpdateTable.syncMerge: item.syncMerge,
        StockUpdateTable.transactionId: item.transactionId,
        StockUpdateTable.totalRob: item.totalRob,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      //need to update each items
      var updatedQuantity = item.totalRob + item.quantity;

      await db.rawUpdate(
        '''
        UPDATE split_location 
          SET Quantity = ? 
          WHERE StorageLocationID = ? 
          AND ItemID = ? 
        ''',
        [updatedQuantity, item.storageLocationId, item.itemId],
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchUnSyncedStockUpdateTransactionList() {
    return db.rawQuery('''
       SELECT * FROM ${StockUpdateTable.tableName} WHERE syncStatus <> 'Y'
    ''');
  }

  @override
  Future<void> updateSyncedDataFromApiStockUpdate({
    required int transactionHdId,
    required List<TransactionHdModel> responseModel,
  }) async {
    await db.rawUpdate('''
    UPDATE ${StockUpdateTable.tableName} SET transactionDtId = ${responseModel.first.id} , syncStatus = 'Y' WHERE transactionId = $transactionHdId
    ''');
  }
}
