import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/bagging_tagging_confirmtaion/model/bagging_confirmation_list_model.dart';
import '../tables/bagging_confirmation_list_table.dart';
import '../tables/item_master_table.dart';
import '../tables/rfid_listing_table.dart';
import '../tables/stock_location_table.dart';
import '../tables/storage_location_table.dart';

abstract interface class BaggingConfirmationListDatasource {
  Future<void> insertConfirmationListsData({
    required List<BaggingConfirmationListModel> baggingConfirmationListModel,
  });

  Future<List<Map<String, dynamic>>> getAllConfirmationListsData();

  Future<String> getAllStorageLocationData({
    //Todo
    required int storageLocationId,
  });

  Future<void> clearConfirmationListsData();

  //confirmation search

  Future<List<Map<String, dynamic>>> searchBaggingConfirmationOrders({
    required String query,
  });

  Future<List<Map<String, dynamic>>> fetchAllLocationOnScanningFromDb({
    required List<String> rfid,
    required int itemId,
    required int grnId,
  });

  Future<List<Map<String, dynamic>>> fetchConfirmationListByItemIds({
    required List<int> itemIds,
    required int storageLocationId,
    required int grnId,
  });

  Future<List<Map<String, dynamic>>> fetchConfirmationListByGRNId({
    required String grnId,
  });

  Future<List<int>>fetchItemIdsBasedOnRfid({required List<String> rfid});

  Future<Unit> saveConfirmation({required int grnId,required List<int> items});

}

class BaggingConfirmationListDatasourceImpl
    implements BaggingConfirmationListDatasource {
  BaggingConfirmationListDatasourceImpl({required this.db});

  final Database db;

  @override
  Future<void> insertConfirmationListsData({
    required List<BaggingConfirmationListModel> baggingConfirmationListModel,
  }) async {
    final Batch batch = db.batch();
    for (var element in baggingConfirmationListModel) {
      batch.insert(
        BaggingConfirmationListTable.tableName,
        {
          BaggingConfirmationListTable.id: element.id,
          BaggingConfirmationListTable.poId: element.poId,
          BaggingConfirmationListTable.poCode: element.poCode,
          BaggingConfirmationListTable.transactionId: element.transactionId,
          BaggingConfirmationListTable.grnNo: element.grnNo,
          BaggingConfirmationListTable.status: element.status,
          BaggingConfirmationListTable.syncStatus: element.syncStatus,
          BaggingConfirmationListTable.syncMessage: element.syncMessage,
          BaggingConfirmationListTable.storageLocationCount:
              element.storageLocationCount,
          BaggingConfirmationListTable.storageLocationId:
              element.storageLocationId,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllConfirmationListsData() {
    return db.query(BaggingConfirmationListTable.tableName);
  }

  @override
  Future<void> clearConfirmationListsData() async {
    await db.delete(BaggingConfirmationListTable.tableName);
  }

  @override
  Future<String> getAllStorageLocationData({
    ///TODO
    required int storageLocationId,
  }) async {
    List<Map<String, dynamic>> data = await db.rawQuery('''
    
    Select STL.LocName  from 

    ${RfIdListingTable.tableName} as RF join ${ItemMasterTable.tableName} as IM 
    on RF.itemId = IM.itemId
 
    join ${StockLocationTable.tableName} as SL  on 
    SL.itemId = IM.itemId
 
    join ${BaggingConfirmationListTable.tableName} as BCL on
    SL.storageLocationId = BCL.storageLocationId
   
   join ${StorageLocationTable.tableName} as STL on 
   STL.ID = SL.storageLocationId 
  
where BCL.storageLocationId = $storageLocationId

    ''');
    if (data.isNotEmpty && data.first['LocName'] != null) {
      return data.first['LocName'] as String;
    }
    return "";
  }

  //confirmation search
  @override
  Future<List<Map<String, dynamic>>> searchBaggingConfirmationOrders({
    required String query,
  }) async {
    if (query.isNotEmpty) {
      final String trimmedText = query.trim();
      return db.query(
        BaggingConfirmationListTable.tableName,
        where: '''
                ${BaggingConfirmationListTable.poCode} LIKE ?
                OR ${BaggingConfirmationListTable.grnNo} LIKE ?
                OR ${BaggingConfirmationListTable.poId} LIKE ?
''',
        whereArgs: ['%$trimmedText%', '%$trimmedText%', '%$trimmedText%'],
      );
    } else {
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllLocationOnScanningFromDb({
    required List<String> rfid,
    required int itemId,
    required int grnId,
  }) async {
    List<Map<String, dynamic>> listOne = await db.rawQuery('''
       select SL.ID,SL.LocName,GH.ItemID as itemId from 
        
       GR_Transaction_HD as GR
  
       join GR_Transaction_DT as GH on GR.GrnId = GH.GrnId
  
       join split_location as SPLOC on SPLOC.GRNHDID = GR.GrnId
  
       join storage_location as SL on SL.ID = SPLOC.StorageLocationID where GR.GrnId = $grnId
        
     GROUP BY GR.GrnId 
     ''');

    List<Map<String, dynamic>> allData = [];

    if (rfid.isNotEmpty) {
      for (int i = 0; i < rfid.length; i++) {
        List<Map<String, dynamic>> data = await db.rawQuery('''
        
        select STL.LocName,STL.ID as storageLocationId,IM.itemId from 

        item_master as IM
           
        join rfidListing as RL on IM.itemId = RL.itemId
          
        join  split_location as SL on IM.itemId = SL.itemId
          
        join storage_location as STL  on SL.storageLocationId = STL.id
           
        where RL.rfidId = "${rfid[i]}"
          
        GROUP BY STL.ID
     ''');
        // add results into allData
        allData.addAll(data);
      }
    }

    if (listOne.isEmpty || allData.isEmpty) {
      return [];
    }

    // Find common locations
    Set<String> listOneLocNames =
        listOne.map((e) => e['LocName'] as String).toSet();
    List<Map<String, dynamic>> result =
        allData
            .where(
              (item) => listOneLocNames.contains(item['LocName'] as String),
            )
            .toList();

    // Remove duplicates
    final seen = <String>{};
    List<Map<String, dynamic>> distinctResult = [];
    for (var item in result) {
      String locName = item['LocName'] as String;
      if (!seen.contains(locName)) {
        seen.add(locName);
        distinctResult.add(item);
      }
    }

    return distinctResult;
  }

  @override
  Future<List<int>> fetchItemIdsBasedOnRfid({
    required List<String> rfid,
  }) async {
    List<int> itemIdList = [];
    if (rfid.isNotEmpty) {
      for (int i = 0; i < rfid.length; i++) {
        List<Map<String, dynamic>> fetchRfid = await db.rawQuery('''
        select itemId from rfidListing as RL    
        where RL.rfidId = "${rfid[i]}"
     ''');
        if (fetchRfid.isNotEmpty && fetchRfid.first['itemId'] != null) {
          itemIdList.add(fetchRfid.first['itemId'] as int);
        }
      }
    }
    return itemIdList;
  }

  /// for item listing page
  @override
  Future<List<Map<String, dynamic>>> fetchConfirmationListByItemIds({
    required List<int> itemIds,
    required int storageLocationId,
    required int grnId,
  }) async {
    if (itemIds.isEmpty) {
      return [];
    }

    // Create placeholders for itemIds (?, ?, ?)
    final placeholders = List.filled(itemIds.length, '?').join(',');
    final result = await db.rawQuery(
      '''
    SELECT  
      IM.itemName,
      SPLOC.Quantity,
      IM.articleNumber,
      GH.ItemID,
      SPLOC.StorageLocationID,
      GH.GrnId,
      GH.poNo,
      CASE 
          WHEN GH.ItemID IN ($placeholders) THEN 'Found'
          ELSE 'NotFound'
      END AS IsInList
    FROM GR_Transaction_HD AS GR
    JOIN GR_Transaction_DT AS GH ON GR.GrnId = GH.GrnId
    JOIN split_location AS SPLOC ON SPLOC.GRNHDID = GR.GrnId
    JOIN item_master AS IM ON IM.itemId = GH.ItemID
    JOIN storage_location AS SL ON SL.id = SPLOC.StorageLocationID
    WHERE GH.GrnId = ? AND SPLOC.StorageLocationID = ?
    GROUP BY GH.ItemID
    ''',
      [
        ...itemIds,   // Binds for IN clause
        grnId,        // Binds for WHERE GH.GrnId = ?
        storageLocationId, // Binds for WHERE StorageLocationID = ?
      ],
    );

    return result;
  }


  @override
  Future<List<Map<String, dynamic>>> fetchConfirmationListByGRNId({
    required String grnId,
  }) async {
   /* final result = await db.rawQuery('''
    
    select IM.itemName,SL.quantity,IM.articleNumber from 

         item_master as IM
          
        join rfidListing as RL on IM.itemId = RL.itemId
         
         join  stock_location as SL on IM.itemId = SL.itemId
         
         join storage_location as STL  on SL.storageLocationId = STL.id
          
        where IM.itemId= "2016222695933490"
         
        GROUP BY STL.ID
    
    ''');*/

    return [];
  }

  @override
  Future<Unit> saveConfirmation({required int grnId, required List<int> items}) async {
    final Batch batch = db.batch();

    log("grnId at save ----- $grnId");

    ///first update DT table with isConfirmed = 1
    for (var itemId in items) {
      batch.rawUpdate(
        'UPDATE GR_Transaction_DT SET isConfirmed = 1 WHERE grnID = ? AND ItemID = ?',
        [grnId, itemId],
      );
    }
    await batch.commit(noResult: true);

   ///second update HD table with isConfirmed = 1
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(*) as totalConfirmed FROM GR_Transaction_DT WHERE grnID = ? AND isConfirmed = 1 ',
      [grnId],
    );

    final int totalConfirmed = result.first['totalConfirmed'] as int;

    final List<Map<String, dynamic>> totalItemsResult = await db.rawQuery(
      'SELECT COUNT(*) as totalItems FROM GR_Transaction_DT WHERE grnID = ?',
      [grnId],
    );
    final int totalItems = totalItemsResult.first['totalItems'] as int;

    log(" totalItems $totalItems");
    log(" totalConfirmed $totalConfirmed");


    if (totalConfirmed == totalItems) {
      log(" totalItems 2 $totalItems");
      log(" totalConfirmed 2 $totalConfirmed");
      batch.rawUpdate(
        'UPDATE GR_Transaction_HD SET isConfirmed = 1 WHERE GrnId = ?',
        [grnId],
      );
      await batch.commit(noResult: true);
    }

    return unit;
  }
}
