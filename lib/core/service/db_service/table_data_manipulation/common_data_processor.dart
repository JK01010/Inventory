import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/bagging_tagging_confirmtaion/domain/usecase/get_all_bagging_item_details_usecase.dart';
import '../../../../features/common_feature/data/model/fetch_imdg_class_model.dart';
import '../../../../features/common_feature/data/model/item_category_model.dart';
import '../../../../features/common_feature/data/model/item_section_model.dart';
import '../../../../features/common_feature/data/model/item_sub_section_model.dart';
import '../../../../features/common_feature/data/model/quality_list_model.dart';
import '../../../../features/common_feature/data/model/storage_location_model.dart';
import '../../../../features/good_receipts/data/models/goods_receipt_purchase_item_detail_model.dart';
import '../../../../features/good_receipts/data/models/goods_receipt_transaction_item_detail_model.dart';
import '../../../../features/good_receipts/data/models/pending_po_split_location_model.dart';
import '../../../../features/item_master/data/models/ports_list_common_response_model.dart';
import '../tables/equipment_list_table.dart';
import '../tables/fetch_imdg_class_table.dart';
import '../tables/goods_receipt_detail_label_table.dart';
import '../tables/transaction_dt_table.dart';
import '../tables/item_category_table.dart';
import '../tables/item_section_table.dart';
import '../tables/item_sub_section_table.dart';
import '../tables/pending_po_split_location_table.dart';
import '../tables/ports_table.dart';
import '../tables/quality_table.dart';
import '../tables/split_location_table.dart';
import '../tables/storage_location_table.dart';

abstract interface class CommonDatasource {
  //consumption/stock_update add page
  Future<List<Map<String, dynamic>>> fetchItemsBasedOnStorageLocationId({
    required int id,
  });

  Future<List<Map<String, dynamic>>> fetchItemsBasedOnItemId({required int id});

  Future<List<Map<String, dynamic>>> getAllEquipmentList();

  Future<void> clearEquipmentList();

  Future<List<Map<String, dynamic>>> fetchAllFetchImdgClassData();

  Future<List<Map<String, dynamic>>> getEquipmentChildrenList();

  Future<void> clearFetchImdgClassData();

  ///item category

  Future<void> insertItemCategory({
    required List<ItemCategoryModel> itemCategoryModel,
  });

  Future<List<Map<String, dynamic>>> fetchAllItemCategory();

  Future<void> clearItemCategoryData();

  ///item Section

  Future<void> insertItemSection({
    required List<ItemSectionModel> itemSectionModel,
  });

  Future<List<Map<String, dynamic>>> fetchAllItemSection();

  Future<void> clearItemSectionData();

  ///item Sub Section

  Future<void> insertItemSubSection({
    required List<ItemSubSectionModel> itemSubSectionModel,
  });

  Future<List<Map<String, dynamic>>> fetchAllItemSubSection();

  Future<void> clearItemSubSectionData();

  ///Storage Location

  Future<void> insertStorageLocationItems({
    required List<StorageLocationModel> storageLocationModelList,
  });

  Future<List<Map<String, dynamic>>> getStorageLocationsByParentId(
    int parentId,
  );

  Future<void> clearStorageLocationTable();

  ///Quality

  Future<void> clearQualityListTable();

  Future<void> insertQualityListItems({
    required List<QualityListData> qualityModelList,
  });

  Future<List<Map<String, dynamic>>> fetchQualityList();

  Future<void> insertCommonPortList({required List<PortModel> portList});

  Future<List<Map<String, Object?>>> getAllPorts({required String query});



  Future<void> clearPoItems();

  Future<void> insertPoItemsData({
    required List<GoodsReceiptPurchaseItemDetailModel> itemsData,
  });

  Future<void> insertPendingPoSplitLocationData({
    required List<PendingPoSplitLocationModel> pendingPoSplitLocationModelList,
  });
}

class CommonDatasourceImpl extends CommonDatasource {
  CommonDatasourceImpl({required this.db});

  final Database db;

  @override
  Future<List<Map<String, dynamic>>> fetchItemsBasedOnStorageLocationId({
    required int id,
  }) {
    log("id : $id");
    return db.rawQuery('''
      select  
  IM.itemId ,
  IM.itemName ,
  IM.uomName ,
  IRD.TotalROB ,
  IRD.NewStock ,
  IRD.ReconditionedStock
      
  from item_master as IM
      join ItemRobDetails as IRD 
      on IRD.ItemID = IM.itemId 
  where IRD.storageLocationId = $id 
  group by  IM.itemId
  '''); //--WHERE defaultStorageLocationId = $id
  }

  @override
  Future<List<Map<String, dynamic>>> fetchItemsBasedOnItemId({
    required int id,
  }) {
    return db.rawQuery('''
    SELECT * FROM item_master WHERE itemId = $id
  ''');
  } //--WHERE defaultStorageLocationId = $id

  @override
  Future<void> clearEquipmentList() async {
    await db.delete(EquipmentListTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllEquipmentList() async {
    return db.query(EquipmentListTable.tableName);
  }


  @override
  Future<List<Map<String, dynamic>>> fetchAllFetchImdgClassData() {
    return db.query(IMDGClassTable.tableName);
  }

  @override
  Future<void> clearFetchImdgClassData() async {
    await db.delete(IMDGClassTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getEquipmentChildrenList() {
    return db.query(IMDGClassTable.tableName);
  }

  ///ItemCategory
  @override
  Future<void> insertItemCategory({
    required List<ItemCategoryModel> itemCategoryModel,
  }) async {
    final Batch batch = db.batch();
    for (var element in itemCategoryModel) {
      batch.insert(ItemCategoryTable.tableName, {
        ItemCategoryTable.id: element.id,
        ItemCategoryTable.code: element.code,
        ItemCategoryTable.categoryName: element.categoryName,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllItemCategory() {
    return db.query(ItemCategoryTable.tableName);
  }

  @override
  Future<void> clearItemCategoryData() {
    return db.delete(ItemCategoryTable.tableName);
  }

  ///ItemSection
  @override
  Future<void> insertItemSection({
    required List<ItemSectionModel> itemSectionModel,
  }) async {
    final Batch batch = db.batch();
    for (var element in itemSectionModel) {
      batch.insert(ItemSectionTable.tableName, {
        ItemSectionTable.id: element.id,
        ItemSectionTable.categoryId: element.categoryId,
        ItemSectionTable.code: element.code,
        ItemSectionTable.sectionName: element.sectionName,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllItemSection() {
    return db.query(ItemSectionTable.tableName);
  }

  @override
  Future<void> clearItemSectionData() {
    return db.delete(ItemSectionTable.tableName);
  }

  /// Item Sub Section

  @override
  Future<void> insertItemSubSection({
    required List<ItemSubSectionModel> itemSubSectionModel,
  }) async {
    final Batch batch = db.batch();
    for (var element in itemSubSectionModel) {
      batch.insert(
        ItemSubSectionTable.tableName,
        {
          ItemSubSectionTable.id: element.id,
          ItemSubSectionTable.sectionId: element.sectionId,
          ItemSubSectionTable.code: element.code,
          ItemSubSectionTable.subSectionName: element.subSectionName,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllItemSubSection() {
    return db.query(ItemSubSectionTable.tableName);
  }

  @override
  Future<void> clearItemSubSectionData() {
    return db.delete(ItemSubSectionTable.tableName);
  }

  @override
  Future<void> insertStorageLocationItems({
    required List<StorageLocationModel> storageLocationModelList,
  }) async {
    final Batch batch = db.batch();

    for (var storageLocationModelItem in storageLocationModelList) {
      batch.insert(
        StorageLocationTable.tableName,
        {
          StorageLocationTable.id: storageLocationModelItem.id,
          StorageLocationTable.parentId: storageLocationModelItem.parentId,
          StorageLocationTable.code: storageLocationModelItem.code,
          StorageLocationTable.locName: storageLocationModelItem.locName,
          StorageLocationTable.description:
              storageLocationModelItem.description,
          StorageLocationTable.vesselLocationID:
              storageLocationModelItem.vesselLocationID,
          StorageLocationTable.isActive:
              storageLocationModelItem.isActive == true ? "Yes" : "No",
          StorageLocationTable.referenceTypeID:
              storageLocationModelItem.referenceTypeID,
          StorageLocationTable.referenceID:
              storageLocationModelItem.referenceID,
          StorageLocationTable.referenceSubID:
              storageLocationModelItem.referenceSubID,
          StorageLocationTable.parentLocName:
              storageLocationModelItem.parentLocName,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<void> clearStorageLocationTable() async {
    await db.delete(StorageLocationTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getStorageLocationsByParentId(
    int parentId,
  ) async {
    if (parentId > 0) {
      return db.rawQuery(
        '''
    SELECT * FROM ${StorageLocationTable.tableName} 
    WHERE ${StorageLocationTable.parentId} = ?
    ''',
        [parentId],
      );
    } else {
      return db.rawQuery('''SELECT * FROM ${StorageLocationTable.tableName}''');
    }
  }

  @override
  Future<void> clearQualityListTable() async {
    await db.delete(QualityTable.tableName);
  }

  @override
  Future<void> insertQualityListItems({
    required List<QualityListData> qualityModelList,
  }) async {
    final Batch batch = db.batch();
    for (var element in qualityModelList) {
      final existing = await db.query(
        QualityTable.tableName,
        where: '${QualityTable.id} = ?',
        whereArgs: [element.id],
        limit: 1,
      );
      if (existing.isEmpty) {
        batch.insert(
          QualityTable.tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        batch.rawQuery(
          """
        UPDATE ${QualityTable.tableName} SET ${QualityTable.isActive} = ? WHERE ${QualityTable.id} = ?
        """,
          [element.isActive == true ? 1 : 0],
        );
      }
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchQualityList() {
    return db.query(
      QualityTable.tableName,
      where: '${QualityTable.isActive} = ?',
      whereArgs: [1],
    );
  }

  @override
  Future<void> insertCommonPortList({required List<PortModel> portList}) async {
    final Batch batch = db.batch();
    for (var item in portList) {
      batch.insert(
        PortsTable.tableName,
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, Object?>>> getAllPorts({
    required String query,
  }) async {
    if (query.isNotEmpty) {
      final String trimmedText = query.trim();
      return db.query(
        PortsTable.tableName,
        where: '''
              ${PortsTable.portName} LIKE ?
              ''',
        whereArgs: ['%$trimmedText%'],
      );
    } else {
      return [];
    }
  }



  @override
  Future<void> clearPoItems() async {
    await db.delete(GoodsReceiptDetailLabelTable.tableName);
  }

  @override
  Future<void> insertPoItemsData({
    required List<GoodsReceiptPurchaseItemDetailModel> itemsData,
  }) async {
    final Batch batch = db.batch();
    for (var goodsReceiptPurchaseItemDetailModel in itemsData) {
      // batch.insert(
      //   GoodsReceiptDetailLabelTable.tableName,
      //   {
      //     GoodsReceiptDetailLabelTable.poDtId:
      //         goodsReceiptPurchaseItemDetailModel.poDtId,
      //     GoodsReceiptDetailLabelTable.slNo:
      //         goodsReceiptPurchaseItemDetailModel.slNo,
      //     GoodsReceiptDetailLabelTable.partNumber:
      //         goodsReceiptPurchaseItemDetailModel.partNumber,
      //     GoodsReceiptDetailLabelTable.quantity:
      //         goodsReceiptPurchaseItemDetailModel.quantity,
      //     GoodsReceiptDetailLabelTable.articleNumber:
      //         goodsReceiptPurchaseItemDetailModel.articleNumber,
      //     GoodsReceiptDetailLabelTable.drawingNumber:
      //         goodsReceiptPurchaseItemDetailModel.drawingNumber,
      //     GoodsReceiptDetailLabelTable.itemUom:
      //         goodsReceiptPurchaseItemDetailModel.itemUom,
      //     GoodsReceiptDetailLabelTable.packSize:
      //         goodsReceiptPurchaseItemDetailModel.packSize,
      //     GoodsReceiptDetailLabelTable.unitPrice:
      //         goodsReceiptPurchaseItemDetailModel.unitPrice,
      //     GoodsReceiptDetailLabelTable.imdgCode:
      //         goodsReceiptPurchaseItemDetailModel.imdgCode,
      //     GoodsReceiptDetailLabelTable.imdgName:
      //         goodsReceiptPurchaseItemDetailModel.imdgName,
      //     GoodsReceiptDetailLabelTable.remarksToVendor:
      //         goodsReceiptPurchaseItemDetailModel.remarksToVendor,
      //     GoodsReceiptDetailLabelTable.equipmentName:
      //         goodsReceiptPurchaseItemDetailModel.equipmentName,
      //     GoodsReceiptDetailLabelTable.rob:
      //         goodsReceiptPurchaseItemDetailModel.rob,
      //     GoodsReceiptDetailLabelTable.poHdId:
      //         goodsReceiptPurchaseItemDetailModel.poHdId,
      //
      //     GoodsReceiptDetailLabelTable.poId:
      //         goodsReceiptPurchaseItemDetailModel.poId,
      //     GoodsReceiptDetailLabelTable.poNo:
      //         goodsReceiptPurchaseItemDetailModel.poNo,
      //     GoodsReceiptDetailLabelTable.grnId:
      //         goodsReceiptPurchaseItemDetailModel.grnId,
      //     GoodsReceiptDetailLabelTable.grnNo:
      //         goodsReceiptPurchaseItemDetailModel.grnNo,
      //     GoodsReceiptDetailLabelTable.itemId:
      //         goodsReceiptPurchaseItemDetailModel.itemId,
      //     GoodsReceiptDetailLabelTable.itemVersionId:
      //         goodsReceiptPurchaseItemDetailModel.itemVersionId,
      //     GoodsReceiptDetailLabelTable.itemLinkId:
      //         goodsReceiptPurchaseItemDetailModel.itemLinkId,
      //     GoodsReceiptDetailLabelTable.parentItemId:
      //         goodsReceiptPurchaseItemDetailModel.parentItemId,
      //     GoodsReceiptDetailLabelTable.parentItemVersionId:
      //         goodsReceiptPurchaseItemDetailModel.parentItemVersionId,
      //     GoodsReceiptDetailLabelTable.parentItemLinkId:
      //         goodsReceiptPurchaseItemDetailModel.parentItemLinkId,
      //     GoodsReceiptDetailLabelTable.receivedQty:
      //         goodsReceiptPurchaseItemDetailModel.receivedQty,
      //     GoodsReceiptDetailLabelTable.convertedStockQty:
      //         goodsReceiptPurchaseItemDetailModel.convertedStockQty,
      //     GoodsReceiptDetailLabelTable.newStock:
      //         goodsReceiptPurchaseItemDetailModel.newStock,
      //     GoodsReceiptDetailLabelTable.damagedOrWrongSupply:
      //         goodsReceiptPurchaseItemDetailModel.damagedOrWrongSupply,
      //     GoodsReceiptDetailLabelTable.reconditionedStock:
      //         goodsReceiptPurchaseItemDetailModel.reconditionedStock,
      //     GoodsReceiptDetailLabelTable.expiryDate:
      //         goodsReceiptPurchaseItemDetailModel.expiryDate,
      //     GoodsReceiptDetailLabelTable.uomId:
      //         goodsReceiptPurchaseItemDetailModel.uomId,
      //     GoodsReceiptDetailLabelTable.qualityId:
      //         goodsReceiptPurchaseItemDetailModel.qualityId,
      //     GoodsReceiptDetailLabelTable.batchNo:
      //         goodsReceiptPurchaseItemDetailModel.batchNo,
      //     GoodsReceiptDetailLabelTable.remarks:
      //         goodsReceiptPurchaseItemDetailModel.remarks,
      //     GoodsReceiptDetailLabelTable.isMd:
      //         goodsReceiptPurchaseItemDetailModel.isMd == true ? "Yes" : "No",
      //     GoodsReceiptDetailLabelTable.isSDoc:
      //         goodsReceiptPurchaseItemDetailModel.isSDoc == true ? "Yes" : "No",
      //     GoodsReceiptDetailLabelTable.zeroDeclaration:
      //         goodsReceiptPurchaseItemDetailModel.zeroDeclaration == true
      //             ? "Yes"
      //             : "No",
      //     GoodsReceiptDetailLabelTable.ihmMaterialQty:
      //         goodsReceiptPurchaseItemDetailModel.ihmMaterialQty,
      //     GoodsReceiptDetailLabelTable.articleNo:
      //         goodsReceiptPurchaseItemDetailModel.articleNo,
      //     GoodsReceiptDetailLabelTable.productName:
      //         goodsReceiptPurchaseItemDetailModel.productName,
      //     GoodsReceiptDetailLabelTable.productDescription:
      //         goodsReceiptPurchaseItemDetailModel.productDescription,
      //     GoodsReceiptDetailLabelTable.eccnNo:
      //         goodsReceiptPurchaseItemDetailModel.eccnNo,
      //     GoodsReceiptDetailLabelTable.hsCode:
      //         goodsReceiptPurchaseItemDetailModel.hsCode,
      //     GoodsReceiptDetailLabelTable.countryName:
      //         goodsReceiptPurchaseItemDetailModel.countryName,
      //     GoodsReceiptDetailLabelTable.isAntiPiracy:
      //         goodsReceiptPurchaseItemDetailModel.isAntiPiracy == true
      //             ? "Yes"
      //             : "No",
      //     GoodsReceiptDetailLabelTable.isPyroTechnics:
      //         goodsReceiptPurchaseItemDetailModel.isPyroTechnics == true
      //             ? "Yes"
      //             : "No",
      //     GoodsReceiptDetailLabelTable.imdgClassId:
      //         goodsReceiptPurchaseItemDetailModel.imdgClassId,
      //     GoodsReceiptDetailLabelTable.className:
      //         goodsReceiptPurchaseItemDetailModel.className,
      //     GoodsReceiptDetailLabelTable.partNo:
      //         goodsReceiptPurchaseItemDetailModel.partNo,
      //     GoodsReceiptDetailLabelTable.categoryName:
      //         goodsReceiptPurchaseItemDetailModel.categoryName,
      //     GoodsReceiptDetailLabelTable.itemCategoryId:
      //         goodsReceiptPurchaseItemDetailModel.itemCategoryId,
      //     GoodsReceiptDetailLabelTable.itemSectionId:
      //         goodsReceiptPurchaseItemDetailModel.itemSectionId,
      //     GoodsReceiptDetailLabelTable.sectionName:
      //         goodsReceiptPurchaseItemDetailModel.sectionName,
      //     GoodsReceiptDetailLabelTable.itemSubSectionId:
      //         goodsReceiptPurchaseItemDetailModel.itemSubSectionId,
      //     GoodsReceiptDetailLabelTable.subSectionName:
      //         goodsReceiptPurchaseItemDetailModel.subSectionName,
      //     GoodsReceiptDetailLabelTable.isExportControl:
      //         goodsReceiptPurchaseItemDetailModel.isExportControl == true
      //             ? "Yes"
      //             : "No",
      //     GoodsReceiptDetailLabelTable.isIhm:
      //         goodsReceiptPurchaseItemDetailModel.isIhm == true ? "Yes" : "No",
      //     GoodsReceiptDetailLabelTable.isCritical:
      //         goodsReceiptPurchaseItemDetailModel.isCritical == true
      //             ? "Yes"
      //             : "No",
      //     GoodsReceiptDetailLabelTable.isImdg:
      //         goodsReceiptPurchaseItemDetailModel.isImdg == true ? "Yes" : "No",
      //     GoodsReceiptDetailLabelTable.vessel:
      //         goodsReceiptPurchaseItemDetailModel.vessel,
      //   },
      //
      //   conflictAlgorithm: ConflictAlgorithm.replace,
      // );
    }
    await batch.commit();
  }

  @override
  Future<void> insertPendingPoSplitLocationData({
    required List<PendingPoSplitLocationModel> pendingPoSplitLocationModelList,
  }) async {
    final Batch batch = db.batch();
    for (final element in pendingPoSplitLocationModelList) {
      // Check if the record already exists
      final List<Map<String, dynamic>> existingRecords = await db.query(
        PendingPoSplitLocationTable.tableName,
        where: '${PendingPoSplitLocationTable.id} = ?',
        whereArgs: [element.id],
      );
      debugPrint("existingRecords : $existingRecords");
      if (existingRecords.isEmpty) {
        batch.insert(
          PendingPoSplitLocationTable.tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        batch.update(
          PendingPoSplitLocationTable.tableName,
          element.toJson(),
          where: '${PendingPoSplitLocationTable.id} = ?',
          whereArgs: [element.id],
        );
      }
    }
    await batch.commit();
  }
}
