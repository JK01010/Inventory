import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/good_receipts/data/models/goods_receipt_purchase_item_detail_model.dart';
import '../../../../features/good_receipts/data/models/grn_location_serial_mapping_model.dart';
import '../../../../features/good_receipts/domain/use_cases/get_po_item_details_usecase.dart';
import '../../../di/service_locator.dart';
import '../../../utils/app_logger.dart';
import '../app_database.dart';
import '../tables/goods_receipt_detail_label_table.dart';
import '../tables/transaction_dt_table.dart';
import '../tables/grn_location_serial_mapping_table.dart';
import '../tables/item_master_table.dart';
import '../tables/items_attachments_table.dart';
import '../tables/packet_details_table.dart';
import '../tables/split_location_table.dart';

abstract interface class GoodsReceiptDetailLabelDataProcessor {
  Future<void> insertGoodsReceiptsLabelItems({
    required List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList,
  });

  Future<List<Map<String, dynamic>>> getGoodsReceiptDetailLabelItems(
    String poId,
  );

  Future<void> clearGoodsReceiptLabelTable();

  Future<void> updateGoodsReceiptLabelList(
    List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList,
  );

  Future<List<Map<String, dynamic>>> goodsReceiptGetLabelDetailById(
    int dtId,
    int hdId,
    int itemId,
  );

  Future<void> goodsReceiptCreateLabelSaveLabel(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  );

  Future<List<Map<String, dynamic>>> getAllGoodsReceiptTransactionDetail();

  Future<List<Map<String, dynamic>>> getGoodsReceiptTransactionDetailById(
    int transactionId,
  );

  Future<void> deleteGoodsReceiptsLabelItemById(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  );

  Future<List<Map<String, dynamic>>> getAllGRLabelItemsToCreateNewLabel(
    int poId,
  );

  Future<void> insertGRNLocationSerialMappingData(
    List<GRNLocationSerialMappingModel> grnLocationSerialMappingModel,
  );

  Future<List<GRNLocationSerialMappingModel>> getGRNLocationSerialMappingList();

  Future<List<Map<String, dynamic>>> getGoodsReceiptPoLineItems();

  Future<GoodsReceiptPurchaseItemDetailModel?> getPoItemDetails({
    required GetPoItemDetailsParams getPoItemDetailsParams,
  });
}

class GoodsReceiptDetailLabelDataProcessorImpl
    implements GoodsReceiptDetailLabelDataProcessor {
  GoodsReceiptDetailLabelDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertGoodsReceiptsLabelItems({
    required List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList,
  }) async {
    try {
      final Batch batch = db.batch();

      // for (var goodsReceiptPurchaseItemDetailModel
      //     in goodsReceiptPurchaseItemDetailModelList) {
      //   batch.insert(
      //     GoodsReceiptDetailLabelTable.tableName,
      //     {
      //       GoodsReceiptDetailLabelTable.poDtId:
      //           goodsReceiptPurchaseItemDetailModel.poDtId,
      //       GoodsReceiptDetailLabelTable.slNo:
      //           goodsReceiptPurchaseItemDetailModel.slNo,
      //       GoodsReceiptDetailLabelTable.partNumber:
      //           goodsReceiptPurchaseItemDetailModel.partNumber,
      //       GoodsReceiptDetailLabelTable.quantity:
      //           goodsReceiptPurchaseItemDetailModel.quantity,
      //       GoodsReceiptDetailLabelTable.articleNumber:
      //           goodsReceiptPurchaseItemDetailModel.articleNumber,
      //       GoodsReceiptDetailLabelTable.drawingNumber:
      //           goodsReceiptPurchaseItemDetailModel.drawingNumber,
      //       GoodsReceiptDetailLabelTable.itemUom:
      //           goodsReceiptPurchaseItemDetailModel.itemUom,
      //       GoodsReceiptDetailLabelTable.packSize:
      //           goodsReceiptPurchaseItemDetailModel.packSize,
      //       GoodsReceiptDetailLabelTable.unitPrice:
      //           goodsReceiptPurchaseItemDetailModel.unitPrice,
      //       GoodsReceiptDetailLabelTable.imdgCode:
      //           goodsReceiptPurchaseItemDetailModel.imdgCode,
      //       GoodsReceiptDetailLabelTable.imdgName:
      //           goodsReceiptPurchaseItemDetailModel.imdgName,
      //       GoodsReceiptDetailLabelTable.remarksToVendor:
      //           goodsReceiptPurchaseItemDetailModel.remarksToVendor,
      //       GoodsReceiptDetailLabelTable.equipmentName:
      //           goodsReceiptPurchaseItemDetailModel.equipmentName,
      //       GoodsReceiptDetailLabelTable.rob:
      //           goodsReceiptPurchaseItemDetailModel.rob,
      //       GoodsReceiptDetailLabelTable.poHdId:
      //           goodsReceiptPurchaseItemDetailModel.poHdId,
      //
      //       GoodsReceiptDetailLabelTable.poId:
      //           goodsReceiptPurchaseItemDetailModel.poId,
      //       GoodsReceiptDetailLabelTable.poNo:
      //           goodsReceiptPurchaseItemDetailModel.poNo,
      //       GoodsReceiptDetailLabelTable.grnId:
      //           goodsReceiptPurchaseItemDetailModel.grnId,
      //       GoodsReceiptDetailLabelTable.grnNo:
      //           goodsReceiptPurchaseItemDetailModel.grnNo,
      //       GoodsReceiptDetailLabelTable.itemId:
      //           goodsReceiptPurchaseItemDetailModel.itemId,
      //       GoodsReceiptDetailLabelTable.itemVersionId:
      //           goodsReceiptPurchaseItemDetailModel.itemVersionId,
      //       GoodsReceiptDetailLabelTable.itemLinkId:
      //           goodsReceiptPurchaseItemDetailModel.itemLinkId,
      //       GoodsReceiptDetailLabelTable.parentItemId:
      //           goodsReceiptPurchaseItemDetailModel.parentItemId,
      //       GoodsReceiptDetailLabelTable.parentItemVersionId:
      //           goodsReceiptPurchaseItemDetailModel.parentItemVersionId,
      //       GoodsReceiptDetailLabelTable.parentItemLinkId:
      //           goodsReceiptPurchaseItemDetailModel.parentItemLinkId,
      //       GoodsReceiptDetailLabelTable.receivedQty:
      //           goodsReceiptPurchaseItemDetailModel.receivedQty,
      //       GoodsReceiptDetailLabelTable.convertedStockQty:
      //           goodsReceiptPurchaseItemDetailModel.convertedStockQty,
      //       GoodsReceiptDetailLabelTable.newStock:
      //           goodsReceiptPurchaseItemDetailModel.newStock,
      //       GoodsReceiptDetailLabelTable.damagedOrWrongSupply:
      //           goodsReceiptPurchaseItemDetailModel.damagedOrWrongSupply,
      //       GoodsReceiptDetailLabelTable.reconditionedStock:
      //           goodsReceiptPurchaseItemDetailModel.reconditionedStock,
      //       GoodsReceiptDetailLabelTable.expiryDate:
      //           goodsReceiptPurchaseItemDetailModel.expiryDate,
      //       GoodsReceiptDetailLabelTable.uomId:
      //           goodsReceiptPurchaseItemDetailModel.uomId,
      //       GoodsReceiptDetailLabelTable.qualityId:
      //           goodsReceiptPurchaseItemDetailModel.qualityId,
      //       GoodsReceiptDetailLabelTable.batchNo:
      //           goodsReceiptPurchaseItemDetailModel.batchNo,
      //       GoodsReceiptDetailLabelTable.remarks:
      //           goodsReceiptPurchaseItemDetailModel.remarks,
      //       GoodsReceiptDetailLabelTable.isMd:
      //           goodsReceiptPurchaseItemDetailModel.isMd == true ? "Yes" : "No",
      //       GoodsReceiptDetailLabelTable.isSDoc:
      //           goodsReceiptPurchaseItemDetailModel.isSDoc == true
      //               ? "Yes"
      //               : "No",
      //       GoodsReceiptDetailLabelTable.zeroDeclaration:
      //           goodsReceiptPurchaseItemDetailModel.zeroDeclaration == true
      //               ? "Yes"
      //               : "No",
      //       GoodsReceiptDetailLabelTable.ihmMaterialQty:
      //           goodsReceiptPurchaseItemDetailModel.ihmMaterialQty,
      //       GoodsReceiptDetailLabelTable.articleNo:
      //           goodsReceiptPurchaseItemDetailModel.articleNo,
      //       GoodsReceiptDetailLabelTable.productName:
      //           goodsReceiptPurchaseItemDetailModel.productName,
      //       GoodsReceiptDetailLabelTable.productDescription:
      //           goodsReceiptPurchaseItemDetailModel.productDescription,
      //       GoodsReceiptDetailLabelTable.eccnNo:
      //           goodsReceiptPurchaseItemDetailModel.eccnNo,
      //       GoodsReceiptDetailLabelTable.hsCode:
      //           goodsReceiptPurchaseItemDetailModel.hsCode,
      //       GoodsReceiptDetailLabelTable.countryName:
      //           goodsReceiptPurchaseItemDetailModel.countryName,
      //       GoodsReceiptDetailLabelTable.isAntiPiracy:
      //           goodsReceiptPurchaseItemDetailModel.isAntiPiracy == true
      //               ? "Yes"
      //               : "No",
      //       GoodsReceiptDetailLabelTable.isPyroTechnics:
      //           goodsReceiptPurchaseItemDetailModel.isPyroTechnics == true
      //               ? "Yes"
      //               : "No",
      //       GoodsReceiptDetailLabelTable.imdgClassId:
      //           goodsReceiptPurchaseItemDetailModel.imdgClassId,
      //       GoodsReceiptDetailLabelTable.className:
      //           goodsReceiptPurchaseItemDetailModel.className,
      //       GoodsReceiptDetailLabelTable.partNo:
      //           goodsReceiptPurchaseItemDetailModel.partNo,
      //       GoodsReceiptDetailLabelTable.categoryName:
      //           goodsReceiptPurchaseItemDetailModel.categoryName,
      //       GoodsReceiptDetailLabelTable.itemCategoryId:
      //           goodsReceiptPurchaseItemDetailModel.itemCategoryId,
      //       GoodsReceiptDetailLabelTable.itemSectionId:
      //           goodsReceiptPurchaseItemDetailModel.itemSectionId,
      //       GoodsReceiptDetailLabelTable.sectionName:
      //           goodsReceiptPurchaseItemDetailModel.sectionName,
      //       GoodsReceiptDetailLabelTable.itemSubSectionId:
      //           goodsReceiptPurchaseItemDetailModel.itemSubSectionId,
      //       GoodsReceiptDetailLabelTable.subSectionName:
      //           goodsReceiptPurchaseItemDetailModel.subSectionName,
      //       GoodsReceiptDetailLabelTable.isExportControl:
      //           goodsReceiptPurchaseItemDetailModel.isExportControl == true
      //               ? "Yes"
      //               : "No",
      //       GoodsReceiptDetailLabelTable.isIhm:
      //           goodsReceiptPurchaseItemDetailModel.isIhm == true
      //               ? "Yes"
      //               : "No",
      //       GoodsReceiptDetailLabelTable.isCritical:
      //           goodsReceiptPurchaseItemDetailModel.isCritical == true
      //               ? "Yes"
      //               : "No",
      //       GoodsReceiptDetailLabelTable.isImdg:
      //           goodsReceiptPurchaseItemDetailModel.isImdg == true
      //               ? "Yes"
      //               : "No",
      //       GoodsReceiptDetailLabelTable.vessel:
      //           goodsReceiptPurchaseItemDetailModel.vessel,
      //     },
      //     conflictAlgorithm: ConflictAlgorithm.replace,
      //   );
      // }
      await batch.commit();
    } catch (e) {}
  }

  @override
  Future<List<Map<String, dynamic>>> getGoodsReceiptDetailLabelItems(
    String poId,
  ) async {
    final db = await AppDatabase.getInstance();
    if (poId == "0") {
      return db.query(
        GoodsReceiptDetailLabelTable.tableName,
        orderBy: GoodsReceiptDetailLabelTable.productName,
      );
    } else {
      return db.query(
        GoodsReceiptDetailLabelTable.tableName,
        where: '${GoodsReceiptDetailLabelTable.poHdId} = ?',
        whereArgs: [poId],
        orderBy: GoodsReceiptDetailLabelTable.productName,
      );
    }
  }

  @override
  Future<void> clearGoodsReceiptLabelTable() async {
    await db.delete(GoodsReceiptDetailLabelTable.tableName);
  }

  @override
  Future<void> updateGoodsReceiptLabelList(
    List<GoodsReceiptPurchaseItemDetailModel>
    goodsReceiptPurchaseItemDetailModelList,
  ) async {
    final batch = db.batch();
    for (var goodsReceiptPurchaseItemDetailEntity
        in goodsReceiptPurchaseItemDetailModelList) {
      batch.update(
        GoodsReceiptDetailLabelTable.tableName,
        {
          GoodsReceiptDetailLabelTable.receivedQty:
              goodsReceiptPurchaseItemDetailEntity.receivedQty,
          // GoodsReceiptDetailLabelTable.damagedOrWrongSupply:
          //     goodsReceiptPurchaseItemDetailEntity.damagedOrWrongSupply,
        },
        where: '${GoodsReceiptDetailLabelTable.poDtId} =?',
        whereArgs: ['${goodsReceiptPurchaseItemDetailEntity.poDtId}'],
      );
    }
    await batch.commit(noResult: true);
  }

  //Method to get the Create Label selected item details to bind in Create Label page
  @override
  Future<List<Map<String, dynamic>>> goodsReceiptGetLabelDetailById(
    int dtId,
    int hdId,
    int itemId,
  ) async {
    final db = await AppDatabase.getInstance();
    return db.rawQuery(
      '''
    SELECT 
    gr.articleNo, gr.PARTNO, gr.ItemUom, 
    gr.grnID, gr.poID, gr.ItemID, gr.productName, gr.ReceivedQty, gr.ReceivedQty as packetSize, gr.ReceivedQty as unitPrice, gr.ItemCategoryID as iMDGClassID,
    gr.DamagedOrwrongSupply, gr.NewStock, gr.ReconditionedStock, gr.QualityID, gr.ExpiryDate, gr.BatchNo, gr.Remarks, gr.className,
    gr.Remarks as remarksFromVendor, gr.IsIHM as flag, gr.IsIHM as isPartial,gr.ExpiryDate, gr.Remarks as tags,
    im.*
    FROM purchase_DT AS gr
    JOIN item_master AS im ON gr.itemId = im.itemId
    JOIN GR_Transaction_DT AS grt ON grt.grnID = gr.grnID
    WHERE gr.grnID = ? AND gr.poID = ? AND gr.itemId = ?
    ''',
      [dtId, hdId, itemId],
    );
  }

  @override
  Future<void> goodsReceiptCreateLabelSaveLabel(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) async {
    debugPrint(
      "goodsReceiptPurchaseItemDetailModel.poDtId : ${goodsReceiptPurchaseItemDetailModel.poDtId}",
    );
    debugPrint(
      "goodsReceiptPurchaseItemDetailModel.poHdId : ${goodsReceiptPurchaseItemDetailModel.poHdId}",
    );
    Map<String, dynamic> grLabelFields = {};
    grLabelFields[GoodsReceiptDetailLabelTable.expiryDate] =
        goodsReceiptPurchaseItemDetailModel.expiryDate;
    // grLabelFields[GoodsReceiptDetailLabelTable.damagedOrWrongSupply] =
    //     goodsReceiptPurchaseItemDetailModel.damagedOrWrongSupply;
    grLabelFields[GoodsReceiptDetailLabelTable.receivedQty] =
        goodsReceiptPurchaseItemDetailModel.receivedQty;
    // grLabelFields[GoodsReceiptDetailLabelTable.newStock] =
    //     goodsReceiptPurchaseItemDetailModel.newStock;
    // grLabelFields[GoodsReceiptDetailLabelTable.reconditionedStock] =
    goodsReceiptPurchaseItemDetailModel.reconditionedStock;
    grLabelFields[GoodsReceiptDetailLabelTable.qualityId] =
        goodsReceiptPurchaseItemDetailModel.qualityId;
    grLabelFields[GoodsReceiptDetailLabelTable.batchNo] =
        goodsReceiptPurchaseItemDetailModel.batchNo;
    grLabelFields[GoodsReceiptDetailLabelTable.remarks] =
        goodsReceiptPurchaseItemDetailModel.remarks;

    debugPrint("grLabelFields : $grLabelFields");

    Map<String, dynamic> itemMasterFields = {};
    itemMasterFields[ItemMasterTable.serialNo] =
        goodsReceiptPurchaseItemDetailModel.articleNo;
    itemMasterFields[ItemMasterTable.defaultStorageLocationId] =
        goodsReceiptPurchaseItemDetailModel.className; //R.L GR Label Changes

    try {
      debugPrint(
        "inside the try of goodsReceiptCreateLabelSaveLabel *****************",
      );
      await db.update(
        GoodsReceiptDetailLabelTable.tableName,
        grLabelFields,
        where:
            '${GoodsReceiptDetailLabelTable.poDtId} = ? AND ${GoodsReceiptDetailLabelTable.poHdId} = ?',
        whereArgs: [
          goodsReceiptPurchaseItemDetailModel.poDtId,
          goodsReceiptPurchaseItemDetailModel.poHdId,
        ],
      );
      await db.update(
        ItemMasterTable.tableName,
        itemMasterFields,
        where: 'itemId = ?',
        whereArgs: [goodsReceiptPurchaseItemDetailModel.itemId],
      );
      // await db.transaction((transaction) async {
      //   await transaction.update(
      //     GoodsReceiptDetailLabelTable.tableName,
      //     grLabelFields,
      //     where: '${GoodsReceiptDetailLabelTable.poDtId} = ? AND ${GoodsReceiptDetailLabelTable.poHdId} = ?',
      //     whereArgs: [
      //       goodsReceiptPurchaseItemDetailModel.poDtId,
      //       goodsReceiptPurchaseItemDetailModel.poHdId,
      //     ],
      //   );
      //   await transaction.update(
      //     ItemMasterTable.tableName,
      //     itemMasterFields,
      //     where: 'itemId = ?',
      //     whereArgs: [goodsReceiptPurchaseItemDetailModel.itemId],
      //   );
      // });
    } catch (e) {
      debugPrint(
        "inside the catch of goodsReceiptCreateLabelSaveLabel *****************",
      );
      debugPrint("$e");
      debugPrint(
        "inside the catch of goodsReceiptCreateLabelSaveLabel *****************",
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>>
  getAllGoodsReceiptTransactionDetail() async {
    final db = await AppDatabase.getInstance();
    return db.rawQuery('''
    SELECT 
    gr.dtId, gr.hdId, gr.itemId, gr.qty, gr.uomId, gr.imdgClassId,
    gr.flag, gr.isPartial, gr.isSync,
    grt.receivedQty, grt.damagedQty, grt.newQty, grt.reConditionedQty, grt.batchName, grt.remarks,
    grt.remarksFromVendor, grt.expiryDate, grt.tags,
    im.*,
    qlty.qualityName
    FROM purchase_DT AS gr
    JOIN item_master AS im ON gr.itemId = im.itemId
    JOIN GR_Transaction_DT AS grt ON grt.hdId = gr.dtId
    JOIN quality As qlty ON grt.qualityId = qlty.id
    ''');
  }

  @override
  Future<List<Map<String, dynamic>>> getGoodsReceiptTransactionDetailById(
    int transactionId,
  ) async {
    final db = await AppDatabase.getInstance();
    return db.rawQuery(
      '''
    SELECT 
    gr.dtId, gr.hdId, gr.itemId, gr.qty, gr.uomId, gr.imdgClassId,
    gr.flag, gr.isPartial, gr.isSync,
    grt.ReceivedQty, grt.DamagedOrwrongSupply, grt.NewStock, grt.ReconditionedStock, grt.ReconditionedStock, grt.Remarks, grt.ExpiryDate, grt.tags,
    grt.articleNo, grt.productName, grt.ItemUom,grt.SectionName, grt.SubSectionName, 
    im.*,
    qlty.qualityName
    FROM purchase_DT AS gr
    JOIN item_master AS im ON gr.itemId = im.itemId
    JOIN GR_Transaction_DT AS grt ON grt.poID = gr.PoId
    JOIN quality As qlty ON grt.qualityId = qlty.id
    WHERE gr.PoId = ?
    ''',
      [transactionId],
    );
  }

  @override
  Future<void> deleteGoodsReceiptsLabelItemById(
    GoodsReceiptPurchaseItemDetailModel goodsReceiptPurchaseItemDetailModel,
  ) async {
    final db = await AppDatabase.getInstance();

    await db.transaction((txn) async {
      await txn.delete(
        TransactionItemsTable.tableName,
        where: '${TransactionItemsTable.poId} =?',
        whereArgs: [goodsReceiptPurchaseItemDetailModel.poId],
      );
      await txn.delete(
        ItemsAttachmentsTable.tableName,
        where:
            '${ItemsAttachmentsTable.poId}=? AND ${ItemsAttachmentsTable.dtId}=?',
        whereArgs: [
          goodsReceiptPurchaseItemDetailModel.poId,
          goodsReceiptPurchaseItemDetailModel.grnId,
        ],
      );
      await txn.delete(
        PacketDetailsTable.tableName,
        where:
            '${PacketDetailsTable.poId}=? AND ${PacketDetailsTable.poDtId}=?',
        whereArgs: [
          goodsReceiptPurchaseItemDetailModel.poId,
          goodsReceiptPurchaseItemDetailModel.grnId,
        ],
      );
      await txn.delete(
        SplitLocationTable.tableName,
        where:
            '${SplitLocationTable.grnhdId}=? AND ${SplitLocationTable.grnDtId}=? ',
        whereArgs: [
          goodsReceiptPurchaseItemDetailModel.poId,
          goodsReceiptPurchaseItemDetailModel.grnId,
        ],
      );
      // await txn.delete(
      //   GoodsReceiptDetailLabelTable.tableName,
      //   where:
      //       '${GoodsReceiptDetailLabelTable.poId}=? AND ${GoodsReceiptDetailLabelTable.grnId}=?',
      //   whereArgs: [
      //     goodsReceiptPurchaseItemDetailModel.poId,
      //     goodsReceiptPurchaseItemDetailModel.grnId,
      //   ],
      // );
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getAllGRLabelItemsToCreateNewLabel(
    int poId,
  ) async {
    final db = await AppDatabase.getInstance();
    /*    return db.rawQuery(
      '''
    SELECT
    gr.grnID, gr.poID, gr.itemID, gr.ReceivedQty, gr.ReceivedQty as packetSize, gr.ReceivedQty as unitPrice, gr.ItemCategoryID as iMDGClassID,
    gr.remarksFromVendor, gr.flag, gr.isPartial,gr.ExpiryDate, gr.tags,
    grt.receivedQty, grt.damagedQty, grt.qualityId, grt.newQty, grt.reConditionedQty, grt.batchName, grt.remarks,
    im.*
    FROM purchase_DT AS gr
    JOIN item_master AS im ON gr.itemId = im.itemId
    JOIN GR_Transaction_DT AS grt ON grt.grnID = gr.dtId
    where gr.poID = ?
    ''',
      [poId],
    );*/

    return db.rawQuery(
      '''
    SELECT 
    gr.grnID, gr.poID, gr.itemID, gr.ReceivedQty, gr.ReceivedQty as packetSize, gr.ReceivedQty as unitPrice, gr.ItemCategoryID as iMDGClassID, gr.ExpiryDate
    FROM purchase_DT AS gr
    where gr.poID = ?
    ''',
      [poId],
    );
  }

  @override
  Future<void> insertGRNLocationSerialMappingData(
    List<GRNLocationSerialMappingModel> grnLocationSerialMappingModel,
  ) async {
    try {
      final Batch batch = db.batch();

      for (var model in grnLocationSerialMappingModel) {
        batch.insert(
          GRNLocationSerialMappingTable.tableName,
          {
            GRNLocationSerialMappingTable.id: model.id,
            GRNLocationSerialMappingTable.serialNumberId: model.serialNumberID,
            GRNLocationSerialMappingTable.serialNumber: model.serialNumber,
            GRNLocationSerialMappingTable.grnHdId: model.grnHdID,
            GRNLocationSerialMappingTable.grnDtId: model.grnDtID,
          },
          conflictAlgorithm:
              ConflictAlgorithm.replace, // update if already exists
        );
      }

      await batch.commit(noResult: true);
      debugPrint(
        "GRNLocationSerialMapping inserted: ${grnLocationSerialMappingModel.length}",
      );
    } catch (e) {
      debugPrint(
        "Exception in inserting GRNLocationSerialMapping: ${e.toString()}",
      );
    }
  }

  @override
  Future<List<GRNLocationSerialMappingModel>>
  getGRNLocationSerialMappingList() async {
    final dbData = await db.query(GRNLocationSerialMappingTable.tableName);

    return dbData.map(GRNLocationSerialMappingModel.fromJson).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getGoodsReceiptPoLineItems() async {
    final db = await AppDatabase.getInstance();
    return db.rawQuery('''
    SELECT 
    gr.PODTID, gr.poID, gr.ItemId, gr.Quantity, gr.QualityId, gr.ReceivedQty as packetSize, gr.ReceivedQty as unitPrice, gr.ItemCategoryID as iMDGClassID,
    gr.Remarks, gr.ExpiryDate,
    im.*
    FROM purchase_DT AS gr
    JOIN item_master AS im ON gr.itemId = im.itemId
    ''');
  }

  @override
  Future<GoodsReceiptPurchaseItemDetailModel?> getPoItemDetails({
    required GetPoItemDetailsParams getPoItemDetailsParams,
  }) async {
    final dbData = await db.query(
      GoodsReceiptDetailLabelTable.tableName,
      where:
          '${GoodsReceiptDetailLabelTable.poHdId} = ? AND ${GoodsReceiptDetailLabelTable.poDtId} = ?',
      whereArgs: [getPoItemDetailsParams.poHdId, getPoItemDetailsParams.poDtId],
    );
    return null;
  }
}
