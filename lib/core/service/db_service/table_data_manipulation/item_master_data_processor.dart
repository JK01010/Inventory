import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/item_master/data/models/item_group_common_response_model.dart';
import '../../../../features/item_master/data/models/item_master_api_response_model.dart';
import '../../../../features/item_master/data/models/item_master_filter_model.dart';
import '../../../../features/item_master/data/models/rfid_listing_common_response_model.dart';
import '../../../../features/item_master/data/models/serial_number_common_response_model.dart';
import '../tables/item_group.dart';
import '../tables/item_master_table.dart';
import '../tables/rfid_listing_table.dart';
import '../tables/serial_number_table.dart';

abstract interface class ItemMasterDataProcessor {
  //itemMasterListing
  Future<void> insertItemMasterListPurchase({
    required List<ItemMasterApiModelPurchase> itemMasterList,
  });
  Future<void> insertItemMasterListPms({
    required List<ItemMasterApiModelPMS> itemMasterList,
  });
  Future<void> clearItemMasterTable();
  Future<List<Map<String, dynamic>>> fetchAllItemMasterList({
    required int offSet,
  });
  Future<List<Map<String, dynamic>>> fetchSearchItemMasterList({
    required String searchText,
  });
  Future<List<Map<String, dynamic>>> fetchFilterItemMasterList({
    required ItemMasterFilterModel itemMasterFilterModel,
  });

  //rfidListing
  Future<void> insertRfidListing({required List<RfidIdModel> rfidIdModelList});

  Future<void> insertRfidBasedOnItemId({required List<String> rfidList,required int itemId});

  Future<List<String>> fetchAllRfidFromDb();

  Future<void> clearRfidListingData();
  Future<List<Map<String, dynamic>>> fetchItemMasterRfidList({required int itemId});

  //common table (ports and serialNo)

  Future<void> insertCommonSerialNumberList({
    required List<SerialNumberModel> serialNumberList,
  });
  Future<void> insertCommonItemGroupList({
    required List<ItemGroupModel> itemGroupList,
  });
}

class ItemMasterDataProcessorImpl implements ItemMasterDataProcessor {
  const ItemMasterDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertItemMasterListPurchase({
    required List<ItemMasterApiModelPurchase> itemMasterList,
  }) async {
    try {
      final Batch batch = db.batch();
      if (kDebugMode) {
        print("itemMasterList : $itemMasterList");
      }
      for (var item in itemMasterList) {
        batch.insert(
            ItemMasterTable.tableName,
            {
              ItemMasterTable.itemId: item.itemID.toString(),
              ItemMasterTable.itemCode: item.itemCode,
              ItemMasterTable.itemName: item.itemName,
              //        ItemMasterTable.defaultStorageLocationId: item.defaultStorageLocationId,
        ItemMasterTable.partNo: item.partNumber,
        //ItemMasterTable.drawingNo: item.drawingNo,
              ItemMasterTable.articleNumber: item.itemCode, //As per Purchase team article number is item code
              ItemMasterTable.uomId: item.uomId.toString(),
              ItemMasterTable.uomName: item.uomName.toString(),
              ItemMasterTable.uomCode: item.uomCode.toString(),
              /*       ItemMasterTable.totalAcceptedQty: item.totalAcceptedQty,
        ItemMasterTable.returnQty: item.returnQty,
        ItemMasterTable.stockAdjustmentFlag: item.stockAdjustmentFlag,*/
        // ItemMasterTable.equipmentName: item.equipmentName,
        // ItemMasterTable.equipmentFlag: item.equipmentFlag,
              ItemMasterTable.activeFlag: item.isActive == true ? 1 : 0,
              ItemMasterTable.categoryId: item.categoryId.toString(),
              ItemMasterTable.sectionId: item.sectionId.toString(),
              ItemMasterTable.subSectionId: item.subSectionId.toString(),
              // ItemMasterTable.serialNo: item.serialNo,
              ItemMasterTable.ihm: item.isIhm == true ? 1 : 0,
              ItemMasterTable.groupId: item.groupId.toString(),
              ItemMasterTable.mdRequired: item.md == true ? 1 : 0,
              ItemMasterTable.sDocRequired: item.sdoc == true ? 1 : 0,
              ItemMasterTable.zeroDeclaration: item.isIhm == true ? 1 : 0,
              ItemMasterTable.iMDGClassName: item.imdgClass,
              ItemMasterTable.packSize: item.packSize,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
      debugPrint("itemMasterList Insert: Complete");
    } catch (e) {
      debugPrint("Error inserting itemMasterList: $e");
    }
  }
  @override
  Future<void> insertItemMasterListPms({
    required List<ItemMasterApiModelPMS> itemMasterList,
  }) async {
    try {
      final Batch batch = db.batch();

      for (var item in itemMasterList) {
        if (kDebugMode) {
          print("insertItemMasterListPms item : ${item.itemId}");
        }
        batch.insert(
            ItemMasterTable.tableName,
            {
              ItemMasterTable.itemId: item.itemId.toString(),
              ItemMasterTable.itemCode: item.itemCode,
              ItemMasterTable.itemName: item.itemName,
              //        ItemMasterTable.defaultStorageLocationId: item.defaultStorageLocationId,
              ItemMasterTable.partNo: item.partNumber,
              ItemMasterTable.drawingNo: item.drawingNumber,
              ItemMasterTable.articleNumber: item.articleNumber, //As per Purchase team article number is item code
              ItemMasterTable.uomId: item.uomId.toString(),
              ItemMasterTable.uomName: item.uomName.toString(),
              ItemMasterTable.uomCode: item.uomCode.toString(),
      /*               ItemMasterTable.totalAcceptedQty: item.totalAcceptedQty,
        ItemMasterTable.returnQty: item.returnQty,*/
        // ItemMasterTable.stockAdjustmentFlag: item.stockAdjustmentFlag,
                    ItemMasterTable.equipmentId: item.equipmentTypeID,
        ItemMasterTable.equipmentName: item.equipmentName,
        ItemMasterTable.equipmentFlag: item.equipmentCode,
              ItemMasterTable.activeFlag: item.isActive == true ? 'Y' : "N",
              ItemMasterTable.categoryId: item.categoryId.toString(),
              ItemMasterTable.sectionId: item.sectionId.toString(),
              ItemMasterTable.subSectionId: item.subSectionId.toString(),
              // ItemMasterTable.serialNo: item.serialNo,
              ItemMasterTable.ihm: item.isIhm == true ? 'Y' : "N",
              ItemMasterTable.groupId: item.groupId.toString(),
              ItemMasterTable.mdRequired: item.md == true ? 'Y' : "N",
              ItemMasterTable.sDocRequired: item.sdoc == true ? 'Y' : "N",
              //ItemMasterTable.zeroDeclaration: item.zeroDeclaration,
              ItemMasterTable.iMDGClassName: item.imdgClass,
              ItemMasterTable.packSize: item.packSize,
              ItemMasterTable.minStock: item.minStock,
              ItemMasterTable.maxStock: item.maxStock,
              ItemMasterTable.spareId: item.spareId
            },
            conflictAlgorithm: ConflictAlgorithm.replace
        );
      }

      await batch.commit(noResult: true);

      if (kDebugMode) {
        print("Updated ${itemMasterList.length} items in batch");
      }
    } catch (e) {
      debugPrint("Error updating itemMasterList: $e");
      rethrow;
    }
  }
  @override
  Future<void> clearItemMasterTable() async {
    await db.delete(ItemMasterTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllItemMasterList({
    required int offSet,
  }) async {
    if (kDebugMode) {
      print(
        "SELECT * FROM ${ItemMasterTable.tableName} LIMIT 20 offset $offSet",
      );
    }
    return db.rawQuery(
      "SELECT * FROM ${ItemMasterTable.tableName} LIMIT 20 offset $offSet",
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchSearchItemMasterList({
    required String searchText,
  }) async {
    if (kDebugMode) {
      print(
        "SELECT * FROM ${ItemMasterTable.tableName} WHERE itemName LIKE '%$searchText%' ",
      );
    }
    return db.rawQuery(
      "SELECT * FROM ${ItemMasterTable.tableName} WHERE itemName LIKE '%$searchText%' ",
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchFilterItemMasterList({
    required ItemMasterFilterModel itemMasterFilterModel,
  }) async {
    String mainQuery = "SELECT * FROM ${ItemMasterTable.tableName}";
    String secondaryQuery = " WHERE ${ItemMasterTable.activeFlag} <> '' ";
    //itemName query
    if (itemMasterFilterModel.itemName != null &&
        itemMasterFilterModel.itemName!.isNotEmpty &&
        itemMasterFilterModel.itemName != "") {
      secondaryQuery +=
          " AND ${ItemMasterTable.itemName} = '${itemMasterFilterModel.itemName}'";
    }
    //equipmentName query
    if (itemMasterFilterModel.equipmentName != null &&
        itemMasterFilterModel.equipmentName!.isNotEmpty &&
        itemMasterFilterModel.equipmentName != "") {
      secondaryQuery +=
          " AND ${ItemMasterTable.equipmentName} = '${itemMasterFilterModel.equipmentName}'";
    }
    //partNumber query
    if (itemMasterFilterModel.partNumber != null &&
        itemMasterFilterModel.partNumber!.isNotEmpty &&
        itemMasterFilterModel.partNumber != "") {
      secondaryQuery +=
          " AND ${ItemMasterTable.partNo} = '${itemMasterFilterModel.partNumber}'";
    }
    //articleNumber query
    if (itemMasterFilterModel.articleNumber != null &&
        itemMasterFilterModel.articleNumber!.isNotEmpty &&
        itemMasterFilterModel.articleNumber != "") {
      secondaryQuery +=
          " AND ${ItemMasterTable.articleNumber} = '${itemMasterFilterModel.articleNumber}'";
    }
    if (kDebugMode) {
      print('$mainQuery$secondaryQuery');
    }
    return db.rawQuery("$mainQuery$secondaryQuery");
  }

  ///RfidListing page

  @override
  Future<void> insertRfidListing({
    required List<RfidIdModel> rfidIdModelList,
  }) async {
    final Batch batch = db.batch();
    for (var item in rfidIdModelList) {
      batch.insert(RfIdListingTable.tableName, {
        RfIdListingTable.id: item.id,
        RfIdListingTable.itemId: item.itemId,
        RfIdListingTable.itemCode: item.itemCode,
        RfIdListingTable.groupId: item.groupId,
        RfIdListingTable.rfidId: item.rfidId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  @override
  Future<void> clearRfidListingData() async {
    db.delete(RfIdListingTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchItemMasterRfidList({required int itemId}) async {
    return db.rawQuery("SELECT * FROM ${RfIdListingTable.tableName} where itemId = $itemId" );
  }

  //commonTables

  @override
  Future<void> insertCommonSerialNumberList({
    required List<SerialNumberModel> serialNumberList,
  }) async {
    final Batch batch = db.batch();
    for (var item in serialNumberList) {
      batch.insert(SerialNumberTable.tableName, {
        SerialNumberTable.id: item.id,
        SerialNumberTable.itemId: item.itemId,
        SerialNumberTable.poId: item.poId,
        SerialNumberTable.transactionId: item.transactionId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  @override
  Future<void> insertCommonItemGroupList({
    required List<ItemGroupModel> itemGroupList,
  }) async {
    final Batch batch = db.batch();
    for (var item in itemGroupList) {
      batch.insert(ItemGroup.tableName, {
        ItemGroup.itemCode: item.itemCode,
        ItemGroup.rfid: item.rfid,
        ItemGroup.quantity: item.quantity,
        ItemGroup.canUpdateQuantity: item.canUpdateQuantity,
        ItemGroup.storageLocation: item.storageLocation,
      });
    }
    await batch.commit();
  }

  @override
  Future<void> insertRfidBasedOnItemId({required List<String> rfidList, required int itemId}) async {
    try {
      final Batch batch = db.batch();
      if (kDebugMode) {
        print("insertRfidBasedOnItemId rfidList : $rfidList, itemId: $itemId");
      }
      for (var rfid in rfidList) {
        // Check if the RFID already exists for the given itemId
        final List<Map<String, dynamic>> existingRfid = await db.query(
          RfIdListingTable.tableName,
          where: '${RfIdListingTable.rfidId} = ?',
          whereArgs: [rfid],
        );

        if (existingRfid.isEmpty) {
          batch.insert(
              RfIdListingTable.tableName,
              {
                RfIdListingTable.rfidId: rfid,
                RfIdListingTable.itemId: itemId,
              });
        }
      }
      await batch.commit(noResult: true);
      debugPrint("rfidList based on itemId Insert: Complete");
    } catch (e) {
      debugPrint("Error inserting rfidList based on itemId: $e");
    }
  }

  @override
  Future<List<String>> fetchAllRfidFromDb() async {
    final List<Map<String, dynamic>> result = await db.query(
      RfIdListingTable.tableName,
      columns: [RfIdListingTable.rfidId],
    );
    if (result.isEmpty) {
      return [];
    }
    return result.map((map) => map[RfIdListingTable.rfidId] as String).toList();
  }
}
