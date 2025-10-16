import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../features/consumption/data/models/consumption_equipment_list_fetch_api_response_model.dart';
import '../../../../features/consumption/data/models/consumption_location_model.dart';
import '../../../../features/consumption/data/models/consumption_taransaction_response_model.dart';
import '../../../../features/consumption/data/models/consumption_transaction_fetch_api_response_model.dart';
import '../../../../features/consumption/data/models/consumption_transaction_save_api_response_model.dart';
import '../../../../features/consumption/data/models/equipment_fetch_api_response_model.dart';
import '../../../../features/consumption/data/models/equipment_list_model.dart';
import '../tables/con_transaction_table.dart';
import '../tables/consumption_location_list_table.dart';
import '../tables/equipment_list_table.dart';

abstract interface class ConsumptionTransactionDataProcessor {
  Future<void> multipleInsertConsumptionTransactionList({required List<ConsumptionTransactionModel> consumptionTransactionList});
  Future<void> singleInsertConsumptionTransactionList({required ConsumptionTransactionModel model,});
  Future<List<Map<String, dynamic>>> fetchAllConTransactionListFromDb();
  Future<List<Map<String, dynamic>>> searchConTransactionDataFromDb({required String searchText});
  Future<void> clearConTransactionTable();
  Future<List<Map<String, dynamic>>> fetchConTransactionListForFilter(String itemName, String articleNo);
  //rfidListing
  Future<List<Map<String, dynamic>>> fetchAllRfidScanningListByRfIds({required List<String> rfIds});

  //location_list
  Future<void> insertLocationList({required List<LocationModel> consumptionLocationList});
  Future<List<Map<String, dynamic>>> fetchAllLocationListFromDb();
  Future<void> clearLocationData();

  //equipment_list
  Future<void> insertEquipmentList({required List<ConsumptionEquipmentListModel> equipmentListModel,});
  Future<void> clearEquipmentList();

  //api side
  Future<void> insertConsumptionTransactionList({required List<ConsumptionTrnFetchApiModel> consumptionTransactionList});
  Future<List<Map<String, dynamic>>> fetchUnSyncedConsumptionTransactionList();

  Future<int> fetchRobConsumptionAdd({required int itemId});

  Future<void> updateSyncedDataFromApi({required int transactionHdId,required List<TransactionHdModel> responseModel});
}

class ConsumptionTransactionDataProcessorImpl
    implements ConsumptionTransactionDataProcessor {
  const ConsumptionTransactionDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> clearEquipmentList() async {
    await db.delete(EquipmentListTable.tableName);
  }


  @override
  Future<void> updateSyncedDataFromApi({required int transactionHdId,required List<TransactionHdModel> responseModel}) async {
    await db.rawUpdate('''
    UPDATE ${ConTransactionTable.tableName} SET transactionDtId = ${responseModel.first.id} , syncStatus = 'Y' WHERE transactionId = $transactionHdId
    ''');
  }

  @override
  //db-insertion
  Future<void> insertConsumptionTransactionList({
    required List<ConsumptionTrnFetchApiModel> consumptionTransactionList,
  }) async {
    final Batch batch = db.batch();
    for (var model in consumptionTransactionList) {
      batch.insert(
        ConTransactionTable.tableName,
        {
          ConTransactionTable.transactionDtId: model.transactionDtId,
          ConTransactionTable.itemId: model.itemId,
          ConTransactionTable.quantity: model.quantity,
          ConTransactionTable.storageLocationId: model.storageLocationId,
          ConTransactionTable.remarks: model.remarks,
          ConTransactionTable.modifiedOn: model.modifiedOn,
          ConTransactionTable.syncStatus: "Y",
          ConTransactionTable.syncMerge: model.syncMerge,
          ConTransactionTable.transactionId: model.transactionId,
          ConTransactionTable.tags: "",
          ConTransactionTable.locationId: model.locationId,
          ConTransactionTable.equipmentId: model.equipmentId,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<void> singleInsertConsumptionTransactionList({
    required ConsumptionTransactionModel model,
  }) async {
    await db.insert(ConTransactionTable.tableName, {
      ConTransactionTable.transactionDtId: model.id,
      ConTransactionTable.itemId: model.itemId,
      ConTransactionTable.quantity: model.quantity,
      ConTransactionTable.storageLocationId: model.storageLocationId,
      ConTransactionTable.remarks: model.remarks,
      ConTransactionTable.modifiedOn: model.modifiedOn,
      ConTransactionTable.syncStatus: model.syncStatus,
      ConTransactionTable.syncMerge: model.syncMerge,
      ConTransactionTable.transactionId: model.transactionId,
      ConTransactionTable.tags: "",
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  //db-fetchAllData
  Future<List<Map<String, dynamic>>> fetchAllConTransactionListFromDb() async {
    return db.rawQuery('''
   SELECT
      IM.itemName as itemName,
      IM.articleNumber as articleNumber,
      CT.remarks,
      cast(CT.quantity as TEXT) as quantity,
      cast(CT.storageLocationId as TEXT) as  defaultStorageLocation,
      CT.syncStatus 
 
    FROM ${ConTransactionTable.tableName} AS CT 
    JOIN item_master AS IM 
    
    ON CT.itemId = IM.itemId
  ''');
  }

  @override
  //db-clearData
  Future<void> clearConTransactionTable() async {
    await db.delete(ConTransactionTable.tableName);
  }

  @override
  //filter
  Future<List<Map<String, dynamic>>> fetchConTransactionListForFilter(
    String itemName,
    String articleNo,
  ) {
    String mainQuery = '''
   SELECT
      IM.itemName as itemName,
      IM.articleNumber as articleNumber,
      CT.remarks,
      cast(CT.quantity as TEXT) as quantity,
      cast(CT.storageLocationId as TEXT) as  defaultStorageLocation,
      CT.syncStatus 
 
    FROM ${ConTransactionTable.tableName} AS CT 
    JOIN item_master AS IM 
    
    ON CT.itemId = IM.itemId
  ''';
    //itemName
    List<String> conditions = [];

    if (itemName.isNotEmpty) {
      conditions.add("IM.itemName = '$itemName'");
    }

    if (articleNo.isNotEmpty) {
      conditions.add("IM.articleNumber = '$articleNo'");
    }

    if (conditions.isNotEmpty) {
      mainQuery += " WHERE ${conditions.join(' AND ')}";
    }

    debugPrint("mainQuery: $mainQuery");
    return db.rawQuery(mainQuery);

  }

/*  @override
  Future<List<Map<String, dynamic>>> fetchAllRfidScanningListByRfIds({
    required List<String> rfIds,
  }) async {
    if (rfIds.isNotEmpty) {
      final List<Map<String, dynamic>> allList = [];
      for (int i = 0; i < rfIds.length; i++) {
        log("Rfid ------- ${rfIds[i]}");
        ///todo change installedOnLocation getting from the table
      *//*  final List<Map<String, dynamic>> data = await db.rawQuery('''
     SELECT
     IM.itemId,
     IM.itemName,
     IM.itemCode,
     RL.rfidId,
     STKL.quantity AS rob,
     IM.articleNumber AS articleNo,
     STOL.LocName AS storageLocation,
     IM.itemName AS installedOnLocation,
     STKL.storageLocationId as defaultStorageLocationId,
     IM.equipmentFlag

      FROM
      item_master AS IM join rfidListing AS RL
      ON IM.itemId = RL.itemId

      join stock_location AS STKL ON
      STKL.itemId = IM.itemId

      join storage_location AS STOL ON
      STOL.id = STKL.storageLocationId

      WHERE RL.rfidId = '${rfIds[i]}' AND STKL.quantity > 0
  ''');*//*
        final List<Map<String, dynamic>> data = await db.rawQuery('''
    SELECT
  IM.itemId,
  IM.itemName,
  IM.itemCode,
  IM.articleNumber AS rfidId,
  STKL.quantity AS rob,
  IM.articleNumber AS articleNo,
  IM.articleNumber AS storageLocation,
  IM.itemName AS installedOnLocation,
  STKL.storageLocationId as defaultStorageLocationId,
  IM.equipmentFlag

   FROM
         item_master AS IM join rfidListing AS RL
         ON IM.itemId = RL.itemId

   join stock_location AS STKL ON
   STKL.itemId = IM.itemId
   
   WHERE RL.rfidId = '${rfIds[i]}'

  '''); // WHERE RL.rfidId = '${rfIds[i]}' AND STKL.quantity > 0
        allList.addAll(data);
      }
      return allList;
    } else {
      return [];
    }
  }*/

  @override
  Future<List<Map<String, dynamic>>> fetchAllRfidScanningListByRfIds({
    required List<String> rfIds,
  }) async {
    if (rfIds.isNotEmpty) {
      final List<Map<String, dynamic>> allList = [];

      for (int i = 0; i < rfIds.length; i++) {
        log("Rfid ------- ${rfIds[i]}");

        ///todo change installedOnLocation getting from the table
        /*  final List<Map<String, dynamic>> data = await db.rawQuery('''
     SELECT
     IM.itemId,
     IM.itemName,
     IM.itemCode,
     RL.rfidId,
     STKL.quantity AS rob,
     IM.articleNumber AS articleNo,
     STOL.LocName AS storageLocation,
     IM.itemName AS installedOnLocation,
     STKL.storageLocationId as defaultStorageLocationId,
     IM.equipmentFlag

      FROM
      item_master AS IM join rfidListing AS RL
      ON IM.itemId = RL.itemId

      join stock_location AS STKL ON
      STKL.itemId = IM.itemId

      join storage_location AS STOL ON
      STOL.id = STKL.storageLocationId

      WHERE RL.rfidId = '${rfIds[i]}' AND STKL.quantity > 0
  ''');*/

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
      final uniqueList = allList.where((row) {
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
  Future<List<Map<String, dynamic>>> searchConTransactionDataFromDb({required String searchText}) {
    return db.rawQuery('''
   SELECT
      IM.itemName as itemName,
      IM.articleNumber as articleNumber,
      CT.remarks,
      cast(CT.quantity as TEXT) as quantity,
      cast(CT.storageLocationId as TEXT) as  defaultStorageLocation,
      CT.syncStatus 
 
    FROM ${ConTransactionTable.tableName} AS CT 
    JOIN item_master AS IM 
    
    ON CT.itemId = IM.itemId
    
    WHERE IM.itemName LIKE '%$searchText%' 
  '''); //OR IM.articleNumber LIKE '%$searchText%'
  }

  @override
  Future<void> multipleInsertConsumptionTransactionList({
    required List<ConsumptionTransactionModel> consumptionTransactionList,
  }) async {
    final Batch batch = db.batch();
    for (var model in consumptionTransactionList) {
      batch.insert(
        ConTransactionTable.tableName,
        {
          ConTransactionTable.transactionDtId: model.id,
          ConTransactionTable.itemId: model.itemId,
          ConTransactionTable.quantity: model.quantity,
          ConTransactionTable.storageLocationId: model.storageLocationId,
          ConTransactionTable.remarks: model.remarks,
          ConTransactionTable.modifiedOn: model.modifiedOn,
          ConTransactionTable.syncStatus: model.syncStatus,
          ConTransactionTable.syncMerge: model.syncMerge,
          ConTransactionTable.transactionId: model.transactionId,
          ConTransactionTable.tags: "",
          ConTransactionTable.locationId: model.locationId,
          ConTransactionTable.equipmentId: model.equipmentId,
          ConTransactionTable.totalRob: model.totalRob,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //need to update each items
      await db.rawUpdate(
        '''
        UPDATE stock_location 
          SET quantity = quantity - ? 
          WHERE storageLocationId = ? 
          AND itemId = ? 
          AND quantity > 0
        ''',
        [model.quantity, model.storageLocationId, model.itemId],
      );
    }
    await batch.commit();
  }



  @override
  Future<List<Map<String, dynamic>>> fetchAllLocationListFromDb() async{
    return db.query(ConsumptionLocationListTable.tableName);
  }

  @override
  Future<void> clearLocationData() {
    return db.delete(ConsumptionLocationListTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchUnSyncedConsumptionTransactionList() {
    return db.rawQuery('''
       SELECT * FROM ${ConTransactionTable.tableName} WHERE syncStatus <> 'Y'
    ''');
  }

///Insert
  //equipment_list
  @override
  Future<void> insertEquipmentList({
    required List<ConsumptionEquipmentListModel> equipmentListModel,
  }) async {
    final Batch batch = db.batch();
    for (var element in equipmentListModel) {
      batch.insert(EquipmentListTable.tableName, {
        EquipmentListTable.vesselStructureId: element.vesselStructureId,
        EquipmentListTable.vesselComponentId: element.vesselComponentId,
        EquipmentListTable.parentEquipmentId: element.parentEquipmentId,
        EquipmentListTable.componentName: element.componentName,
        EquipmentListTable.code: element.code,
        EquipmentListTable.equipmentTypeId: element.equipmentTypeId,
        EquipmentListTable.equipmentType: element.equipmentType,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }
  //location_list
  @override
  Future<void> insertLocationList({required List<LocationModel> consumptionLocationList}) async {
    final Batch batch = db.batch();
    for (var model in consumptionLocationList) {
      batch.insert(
        ConsumptionLocationListTable.tableName,
        {
          ConsumptionLocationListTable.id: model.id,
          ConsumptionLocationListTable.parentId: model.parentId,
          ConsumptionLocationListTable.name: model.name,
          ConsumptionLocationListTable.code: model.code,
          ConsumptionLocationListTable.parentName: model.parentName,
          ConsumptionLocationListTable.activeFlag: model.activeFlag,
          ConsumptionLocationListTable.type: model.type,
          ConsumptionLocationListTable.sortOrder: model.sortOrder,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<int> fetchRobConsumptionAdd({required int itemId}) async {
   List<Map<String, dynamic>> data = await db.rawQuery('''
   select SL.quantity 
   from
   item_master as IM join stock_location as SL 
   on IM.itemId = SL.itemId 
   where SL.itemId = $itemId group by IM.itemId
   ''');
   if (data.isNotEmpty && data.first['quantity'] != null) {
     return data.first['quantity'] as int;
   }
   return 0;
  }

}
