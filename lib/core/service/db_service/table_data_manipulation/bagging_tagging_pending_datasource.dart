import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../../../features/bagging_tagging_confirmtaion/data/model/bagging_tagging_pending_res.dart';
import '../../../../features/bagging_tagging_confirmtaion/data/model/bagging_tagging_purchase_list_model.dart';
import '../tables/bagging_tagging_pending_table.dart';
import '../tables/bagging_tagging_purchase_list_table.dart';
import '../tables/fetch_imdg_class_table.dart';
import '../tables/item_category_table.dart';
import '../tables/item_master_table.dart';
import '../tables/item_section_table.dart';
import '../tables/item_sub_section_table.dart';
import '../tables/quality_table.dart';
import '../tables/rfid_listing_table.dart';
import '../tables/storage_location_table.dart';

abstract interface class BaggingTaggingPendingDatasource {
  Future<void> insertBaggingTaggingPendingList({
    required List<BaggingTaggingPendingModel> baggingTaggingPendingList,
  });

  Future<List<Map<String, dynamic>>> getAllPendingList();

  Future<void> clearPendingListTable();

  Future<bool> changeSyncStatus({required int poId});

  //rfidListing\
  Future<List<String>> fetchRFIDListViewData({required int itemId});

  //Purchase DT
  Future<void> insertBaggingTaggingPurchaseList({
    required List<BaggingTaggingPurchaseListModel> baggingTaggingPurchaseList,
  });

  Future<List<Map<String, dynamic>>> getAllBaggingPurchaseList({
    required String poHDId,
  });

  Future<void> clearBaggingPurchaseList();

  //pending search

  Future<List<Map<String, dynamic>>> searchBaggingPurchaseOrder({
    required String query,
  });
}

class BaggingTaggingPendingDatasourceImpl
    implements BaggingTaggingPendingDatasource {
  BaggingTaggingPendingDatasourceImpl({required this.db});

  final Database db;

  @override
  Future<void> insertBaggingTaggingPendingList({
    required List<BaggingTaggingPendingModel> baggingTaggingPendingList,
  }) async {
    final Batch batch = db.batch();

    for (var element in baggingTaggingPendingList) {
      batch.insert(BaggingTaggingPendingTable.tableName, {
        BaggingTaggingPendingTable.title: element.title,
        BaggingTaggingPendingTable.grnNo: element.grnNo,
        BaggingTaggingPendingTable.poId: element.poId,
        BaggingTaggingPendingTable.poCode: element.poCode,
        BaggingTaggingPendingTable.portId: element.portId,
        BaggingTaggingPendingTable.poRemark: element.poRemark,
        BaggingTaggingPendingTable.transactionMobRefId:
            element.transactionMobRefId,
        BaggingTaggingPendingTable.items: element.items,
        BaggingTaggingPendingTable.grnDate: element.grnDate,
        BaggingTaggingPendingTable.isFull: element.isFull,
        BaggingTaggingPendingTable.modifiedOn: element.modifiedOn,
        BaggingTaggingPendingTable.deliveryRef: element.deliveryRef,
        BaggingTaggingPendingTable.isBaggingComplete: element.isBaggingComplete,
        BaggingTaggingPendingTable.tag: element.tag,
        BaggingTaggingPendingTable.syncStatus: element.syncStatus,
        BaggingTaggingPendingTable.syncMessage: element.syncMessage,
        BaggingTaggingPendingTable.storageLocation: element.storageLocation,
        BaggingTaggingPendingTable.eta: element.eta,
        BaggingTaggingPendingTable.categoryId: element.categoryId,
        BaggingTaggingPendingTable.categoryName: element.categoryName,
        BaggingTaggingPendingTable.receivedDate: element.receivedDate,
        BaggingTaggingPendingTable.status: element.status,
        BaggingTaggingPendingTable.countryCode: element.countryCode,
        BaggingTaggingPendingTable.countryName: element.countryName,
        BaggingTaggingPendingTable.packetSize: element.packetSize,
        BaggingTaggingPendingTable.weight: element.weight,
        BaggingTaggingPendingTable.actualVolume: element.actualVolume,
        BaggingTaggingPendingTable.partial: element.partial,
      });
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllPendingList() async {
    return db.query(BaggingTaggingPendingTable.tableName);
  }

  @override
  Future<void> clearPendingListTable() async {
    await db.delete(BaggingTaggingPendingTable.tableName);
  }

  @override
  Future<bool> changeSyncStatus({required int poId}) async {
    final rowsAffected = await db.update(
      BaggingTaggingPendingTable.tableName,
      {BaggingTaggingPendingTable.syncStatus: "Y"},
      where: "${BaggingTaggingPendingTable.poId} = ?",
      whereArgs: [poId.toString()],
    );
    return rowsAffected > 0;
  }

  ///Purchase DT

  @override
  Future<void> insertBaggingTaggingPurchaseList({
    required List<BaggingTaggingPurchaseListModel> baggingTaggingPurchaseList,
  }) async {
    final Batch batch = db.batch();

    for (var element in baggingTaggingPurchaseList) {
      batch.insert(
        BaggingTaggingPurchaseListTable.tableName,
        {
          BaggingTaggingPurchaseListTable.id: element.id,
          BaggingTaggingPurchaseListTable.itemId: element.itemId,
          BaggingTaggingPurchaseListTable.poHdId: element.poHdId,
          BaggingTaggingPurchaseListTable.receivedQty: element.receivedQty,
          BaggingTaggingPurchaseListTable.remark: element.remark,
          BaggingTaggingPurchaseListTable.qualityId: element.qualityId,
          BaggingTaggingPurchaseListTable.flag: element.flag,
          BaggingTaggingPurchaseListTable.tags: element.tags,
          BaggingTaggingPurchaseListTable.imdgClassId: element.imdgClassId,
          BaggingTaggingPurchaseListTable.unitPrice: element.unitPrice,
          BaggingTaggingPurchaseListTable.packetSize: element.packetSize,
          BaggingTaggingPurchaseListTable.poQty: element.poQty,
          BaggingTaggingPurchaseListTable.remarksFromVendor:
              element.remarksFromVendor,
          BaggingTaggingPurchaseListTable.reconditionedQty:
              element.reconditionedQty,
          BaggingTaggingPurchaseListTable.damagedQty: element.damagedQty,
          BaggingTaggingPurchaseListTable.newQty: element.newQty,
          BaggingTaggingPurchaseListTable.batchName: element.batchName,
          BaggingTaggingPurchaseListTable.expiryDate: element.expiryDate,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<void> clearBaggingPurchaseList() async {
    await db.delete(BaggingTaggingPurchaseListTable.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllBaggingPurchaseList({
    required String poHDId,
  }) {
    return db.rawQuery('''
    Select
    BPDT.itemId,
      IM.articleNumber,
      IM.partNo,
      IM.itemName,
      IM.drawingNo,
      IM.uomId,
      BPDT.packetSize,
      BPDT.poQty,
      BPDT.unitPrice,
      IM.totalAcceptedQty,
      IM.returnQty,
      IMDG.typeName as imdgTypeName,
      BPDT.remarksFromVendor,
      IM.equipmentName,
      BPDT.receivedQty,
      BPDT.damagedQty,
      BPDT.newQty,
      BPDT.reconditionedQty,
      ITC.categoryName,
      ITS.sectionName,
      ITSS.subSectionName,
      QY.qualityName as quality,
      BPDT.expiryDate,
      BPDT.batchName,
      IM.serialNo,
      BPDT.remark,
      Sl.LocName,
      BPDT.tags,
      IM.mdRequired,
      IM.sDocRequired,
      IM.zeroDeclaration
     
      
  from  ${BaggingTaggingPurchaseListTable.tableName} as BPDT join ${ItemMasterTable.tableName} as IM 
  on BPDT.itemId = IM.itemId
  
join ${ItemCategoryTable.tableName} as ITC
on ITC.id = IM.categoryId
 
join ${ItemSectionTable.tableName} as ITS
on ITS.id = IM.sectionId
 
join ${ItemSubSectionTable.tableName} as ITSS
on ITSS.id = IM.subSectionId

join ${StorageLocationTable.tableName} as SL
on SL.id = IM.defaultStorageLocationId

join ${QualityTable.tableName} as QY
on BPDT.qualityId = QY.id

join ${IMDGClassTable.tableName} as IMDG
on BPDT.imdgClassId = IMDG.id

Where BPDT.poHdId = $poHDId  group by IM.itemId

    ''');
  }

  //rfid listing

  @override
  Future<List<String>> fetchRFIDListViewData({required int itemId}) async {
    final List<Map<String, dynamic>> data = await db.rawQuery('''
    SELECT rfidId FROM ${RfIdListingTable.tableName} WHERE itemId = $itemId
  ''');
    return data.map((e) => e['rfidId'] as String).toList();
  }


  //pending Search
  @override
  Future<List<Map<String, dynamic>>> searchBaggingPurchaseOrder({
    required String query,
  }) async {
    if (query.isNotEmpty) {
      final String trimmedText = query.trim();
      return db.query(
        BaggingTaggingPendingTable.tableName,
        where: '''
                ${BaggingTaggingPendingTable.poCode} LIKE ?
                OR ${BaggingTaggingPendingTable.grnNo} LIKE ?
                OR ${BaggingTaggingPendingTable.poId} LIKE ?
''',
        whereArgs: ['%$trimmedText%', '%$trimmedText%', '%$trimmedText%'],
      );
    } else {
      return [];
    }
  }
}
