import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../common_feature/data/model/fetch_imdg_class_model.dart';
import '../../domain/entities/goods_receipt_purchase_item_detail_entity.dart';

class GoodsReceiptTransactionItemDetailResponseModel extends Equatable {
  const GoodsReceiptTransactionItemDetailResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory GoodsReceiptTransactionItemDetailResponseModel.fromJson(
    Map<String, dynamic> map,
  ) {
    return GoodsReceiptTransactionItemDetailResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<GoodsReceiptTransactionItemDetailModel>.from(
        (map['reportData'] as List).map(
          (x) => GoodsReceiptTransactionItemDetailModel.fromMap(
            x as Map<String, dynamic>,
          ),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<GoodsReceiptTransactionItemDetailModel>? reportData;
  final EntityValidation entityValidation;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'entityValidation': entityValidation.toMap(),
    };
  }

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    recordCount,
    reportData,
    entityValidation,
  ];

  @override
  bool? get stringify => true;
}

class GoodsReceiptTransactionItemDetailModel extends Equatable {
  factory GoodsReceiptTransactionItemDetailModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return GoodsReceiptTransactionItemDetailModel(
      poId: json['poID'] as int?,
      poNo: json['poNo'] as String?,
      grnId: json['grnID'] as int?,
      grnNo: json['grnNo'] as String?,
      itemId: json['ItemID'] as int?,
      itemVersionId: json['ItemVersionID'] as int?,
      itemLinkId: json['ItemLinkID'] as int?,
      parentItemId: json['ParentItemID'] as int?,
      parentItemVersionId: json['ParentItemVersionID'] as int?,
      parentItemLinkId: json['ParentItemLinkID'] as int?,
      receivedQty: json['ReceivedQty'] as double?,
      convertedStockQty: json['ConvertedStockQty'] as double?,
      newStock: json['NewStock'] as double?,
      damagedOrWrongSupply: json['DamagedOrwrongSupply'] as double?,
      reconditionedStock: json['ReconditionedStock'] as double?,
      expiryDate: json['ExpiryDate'] as String?,
      uomId: json['UOMID'] as int?,
      qualityId: json['QualityID'] as int?,
      batchNo: json['BatchNo'] as String?,
      remarks: json['Remarks'] as String?,
      isMd: json['IsMD'] == 1 ? true : false,
      isSdoc: json['IsSDOC'] == 1 ? true : false,
      zeroDeclaration: json['ZeroDeclaration'] == 1 ? true : false,
      ihmMaterialQty: json['IHMMaterialQty'] as double?,
      articleNo: json['articleNo'] as String?,
      productName: json['productName'] as String?,
      productDescription: json['ProductDescription'] as String?,
      eccnNo: json['EccnNo'] as String?,
      hsCode: json['HSCode'] as String?,
      countryName: json['CountryName'] as String?,
      isAntiPiracy: json['isAntiPiracy'] == 1 ? true : false,
      isPyroTechnics: json['isPyroTechnics'] == 1 ? true : false,
      imdgClassId: json['iMDGClassID'] as int?,
      className: json['className'] as String?,
      partNo: json['PARTNO'] as String?,
      categoryName: json['CategoryName'] as String?,
      itemCategoryId: json['ItemCategoryID'] as int?,
      itemSectionId: json['ItemSectionID'] as int?,
      sectionName: json['SectionName'] as String?,
      itemSubSectionId: json['ItemSubSectionID'] as int?,
      subSectionName: json['SubSectionName'] as String?,
      itemUom: json['ItemUom'] as String?,
      isExportControl: json['IsExportControl'] == 1 ? true : false,
      isIhm: json['IsIHM'] == 1 ? true : false,
      isCritical: json['IsCritical'] == 1 ? true : false,
      isImdg: json['IsIMDG'] == 1 ? true : false,
      vessel: json['Vessel'] as String?,
      poQuantity: json['POQuantity'] as double?,
      isBagTagItem: json['IsBagTagItem'] == 1 ? true : false,
      drawingPositionNumber: json['DrawingPositionNumber'] as String?,
      drawingNumber: json['DrawingNumber'] as String?,
      unitPrice: json['UnitPrice'] as double?,
      equipmentId: json['EquipmentID'] as int?,
      equipmentName: json['EquipmentName'] as String?,
      podtid: json['PODTID'] as int?,
      grnDtId: json['GRNDTID'] as int?,
      isConfirmed: json['isConfirmed'] == 1 ? true : false,
    );
  }

  factory GoodsReceiptTransactionItemDetailModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return GoodsReceiptTransactionItemDetailModel(
      poId: json['poID'] != null ? json['poID'] as int : null,
      poNo: json['poNo'] != null ? json['poNo'] as String : null,
      grnId: json['grnID'] != null ? json['grnID'] as int : null,
      grnNo: json['grnNo'] != null ? json['grnNo'] as String : null,
      itemId: json['ItemID'] != null ? json['ItemID'] as int : null,
      itemVersionId: json['ItemVersionID'] != null ? json['ItemVersionID'] as int : null,
      itemLinkId: json['ItemLinkID'] != null ? json['ItemLinkID'] as int : null,
      parentItemId: json['ParentItemID'] != null ? json['ParentItemID'] as int : null,
      parentItemVersionId: json['ParentItemVersionID'] != null ? json['ParentItemVersionID'] as int : null,
      parentItemLinkId: json['ParentItemLinkID'] != null ? json['ParentItemLinkID'] as int : null,
      receivedQty: json['ReceivedQty'] != null ? (json['ReceivedQty'] as num).toDouble() : null,
      convertedStockQty: json['ConvertedStockQty'] != null ? (json['ConvertedStockQty'] as num).toDouble() : null,
      newStock: json['NewStock'] != null ? (json['NewStock'] as num).toDouble() : null,
      damagedOrWrongSupply: json['DamagedOrwrongSupply'] != null ? (json['DamagedOrwrongSupply'] as num).toDouble() : null,
      reconditionedStock: json['ReconditionedStock'] != null ? (json['ReconditionedStock'] as num).toDouble() : null,
      expiryDate: json['ExpiryDate'] != null ? json['ExpiryDate'] as String : null,
      uomId: json['UOMID'] != null ? json['UOMID'] as int : null,
      qualityId: json['QualityID'] != null ? json['QualityID'] as int : null,
      batchNo: json['BatchNo'] != null ? json['BatchNo'] as String : null,
      remarks: json['Remarks'] != null ? json['Remarks'] as String : null,
      isMd: json['IsMD'] != null ? json['IsMD'] == 1 : null,
      isSdoc: json['IsSDOC'] != null ? json['IsSDOC'] == 1 : null,
      zeroDeclaration: json['ZeroDeclaration'] != null ? json['ZeroDeclaration'] == 1 : null,
      ihmMaterialQty: json['IHMMaterialQty'] != null ? (json['IHMMaterialQty'] as num).toDouble() : null,
      articleNo: json['articleNo'] != null ? json['articleNo'] as String : null,
      productName: json['productName'] != null ? json['productName'] as String : null,
      productDescription: json['ProductDescription'] != null ? json['ProductDescription'] as String : null,
      eccnNo: json['EccnNo'] != null ? json['EccnNo'] as String : null,
      hsCode: json['HSCode'] != null ? json['HSCode'] as String : null,
      countryName: json['CountryName'] != null ? json['CountryName'] as String : null,
      isAntiPiracy: json['isAntiPiracy'] != null ? json['isAntiPiracy'] == 1 : null,
      isPyroTechnics: json['isPyroTechnics'] != null ? json['isPyroTechnics'] == 1 : null,
      imdgClassId: json['iMDGClassID'] != null ? json['iMDGClassID'] as int : null,
      className: json['className'] != null ? json['className'] as String : null,
      partNo: json['PARTNO'] != null ? json['PARTNO'] as String : null,
      categoryName: json['CategoryName'] != null ? json['CategoryName'] as String : null,
      itemCategoryId: json['ItemCategoryID'] != null ? json['ItemCategoryID'] as int : null,
      itemSectionId: json['ItemSectionID'] != null ? json['ItemSectionID'] as int : null,
      sectionName: json['SectionName'] != null ? json['SectionName'] as String : null,
      itemSubSectionId: json['ItemSubSectionID'] != null ? json['ItemSubSectionID'] as int : null,
      subSectionName: json['SubSectionName'] != null ? json['SubSectionName'] as String : null,
      itemUom: json['ItemUom'] != null ? json['ItemUom'] as String : null,
      isExportControl: json['IsExportControl'] != null ? json['IsExportControl'] == 1 : null,
      isIhm: json['IsIHM'] != null ? json['IsIHM'] == 1 : null,
      isCritical: json['IsCritical'] != null ? json['IsCritical'] == 1 : null,
      isImdg: json['IsIMDG'] != null ? json['IsIMDG'] == 1 : null,
      vessel: json['Vessel'] != null ? json['Vessel'] as String : null,
      poQuantity: json['POQuantity'] != null ? (json['POQuantity'] as num).toDouble() : null,
      isBagTagItem: json['IsBagTagItem'] != null ? json['IsBagTagItem'] == 1 : null,
      drawingPositionNumber: json['DrawingPositionNumber'] != null ? json['DrawingPositionNumber'] as String : null,
      drawingNumber: json['DrawingNumber'] != null ? json['DrawingNumber'] as String : null,
      unitPrice: json['UnitPrice'] != null ? (json['UnitPrice'] as num).toDouble() : null,
      equipmentId: json['EquipmentID'] != null ? json['EquipmentID'] as int : null,
      equipmentName: json['EquipmentName'] != null ? json['EquipmentName'] as String : null,
      podtid: json['PODTID'] != null ? json['PODTID'] as int : null,
      grnDtId: json['GRNDTID'] != null ? json['GRNDTID'] as int : null,
      isConfirmed: json['isConfirmed'] != null ? (json['isConfirmed'] == 1) : null,
    );
  }


  factory GoodsReceiptTransactionItemDetailModel.fromEntity(
    GoodsReceiptPurchaseItemDetailEntity goodsReceiptDetailLabelEntity,
  ) {
    return GoodsReceiptTransactionItemDetailModel(
      poId: goodsReceiptDetailLabelEntity.poId,
      poNo: goodsReceiptDetailLabelEntity.poNo,
      grnId: goodsReceiptDetailLabelEntity.grnId,
      grnNo: goodsReceiptDetailLabelEntity.grnNo,
      itemId: goodsReceiptDetailLabelEntity.itemId,
      itemVersionId: goodsReceiptDetailLabelEntity.itemVersionId,
      itemLinkId: goodsReceiptDetailLabelEntity.itemLinkId,
      parentItemId: goodsReceiptDetailLabelEntity.parentItemId,
      parentItemVersionId: goodsReceiptDetailLabelEntity.parentItemVersionId,
      parentItemLinkId: goodsReceiptDetailLabelEntity.parentItemLinkId,
      receivedQty: goodsReceiptDetailLabelEntity.receivedQty,
      convertedStockQty: goodsReceiptDetailLabelEntity.convertedStockQty,
      newStock: goodsReceiptDetailLabelEntity.newStock,
      damagedOrWrongSupply: goodsReceiptDetailLabelEntity.damagedOrWrongSupply,
      reconditionedStock: goodsReceiptDetailLabelEntity.reconditionedStock,
      expiryDate: goodsReceiptDetailLabelEntity.expiryDate,
      uomId: goodsReceiptDetailLabelEntity.uomId,
      qualityId: goodsReceiptDetailLabelEntity.qualityId,
      batchNo: goodsReceiptDetailLabelEntity.batchNo,
      remarks: goodsReceiptDetailLabelEntity.remarks,
      isMd: goodsReceiptDetailLabelEntity.isMd,
      isSdoc: goodsReceiptDetailLabelEntity.isSdoc,
      zeroDeclaration: goodsReceiptDetailLabelEntity.zeroDeclaration,
      ihmMaterialQty: goodsReceiptDetailLabelEntity.ihmMaterialQty,
      articleNo: goodsReceiptDetailLabelEntity.articleNo,
      productName: goodsReceiptDetailLabelEntity.productName,
      productDescription: goodsReceiptDetailLabelEntity.productDescription,
      eccnNo: goodsReceiptDetailLabelEntity.eccnNo,
      hsCode: goodsReceiptDetailLabelEntity.hsCode,
      countryName: goodsReceiptDetailLabelEntity.countryName,
      isAntiPiracy: goodsReceiptDetailLabelEntity.isAntiPiracy,
      isPyroTechnics: goodsReceiptDetailLabelEntity.isPyroTechnics,
      imdgClassId: goodsReceiptDetailLabelEntity.imdgClassId,
      className: goodsReceiptDetailLabelEntity.className,
      partNo: goodsReceiptDetailLabelEntity.partNo,
      categoryName: goodsReceiptDetailLabelEntity.categoryName,
      itemCategoryId: goodsReceiptDetailLabelEntity.itemCategoryId,
      itemSectionId: goodsReceiptDetailLabelEntity.itemSectionId,
      sectionName: goodsReceiptDetailLabelEntity.sectionName,
      itemSubSectionId: goodsReceiptDetailLabelEntity.itemSubSectionId,
      subSectionName: goodsReceiptDetailLabelEntity.subSectionName,
      itemUom: goodsReceiptDetailLabelEntity.itemUom,
      isExportControl: goodsReceiptDetailLabelEntity.isExportControl,
      isIhm: goodsReceiptDetailLabelEntity.isIhm,
      isCritical: goodsReceiptDetailLabelEntity.isCritical,
      isImdg: goodsReceiptDetailLabelEntity.isImdg,
      vessel: goodsReceiptDetailLabelEntity.vessel,
      poQuantity: goodsReceiptDetailLabelEntity.poQuantity,
      isBagTagItem: goodsReceiptDetailLabelEntity.isBagTagItem,
      drawingPositionNumber:
          goodsReceiptDetailLabelEntity.drawingPositionNumber,
      drawingNumber: goodsReceiptDetailLabelEntity.drawingNumber,
      unitPrice: goodsReceiptDetailLabelEntity.unitPrice,
      equipmentId: goodsReceiptDetailLabelEntity.equipmentId,
      equipmentName: goodsReceiptDetailLabelEntity.equipmentName,
      podtid: -1,
      isConfirmed: goodsReceiptDetailLabelEntity.isConfirmed,
    );
  }

  GoodsReceiptTransactionItemDetailModel({
    this.poId,
    this.poNo,
    this.grnId,
    this.grnNo,
    this.itemId,
    this.itemVersionId,
    this.itemLinkId,
    this.parentItemId,
    this.parentItemVersionId,
    this.parentItemLinkId,
    this.receivedQty,
    this.convertedStockQty,
    this.newStock,
    this.damagedOrWrongSupply,
    this.reconditionedStock,
    this.expiryDate,
    this.uomId,
    this.qualityId,
    this.batchNo,
    this.remarks,
    this.isMd,
    this.isSdoc,
    this.zeroDeclaration,
    this.ihmMaterialQty,
    this.articleNo,
    this.productName,
    this.productDescription,
    this.eccnNo,
    this.hsCode,
    this.countryName,
    this.isAntiPiracy,
    this.isPyroTechnics,
    this.imdgClassId,
    this.className,
    this.partNo,
    this.categoryName,
    this.itemCategoryId,
    this.itemSectionId,
    this.sectionName,
    this.itemSubSectionId,
    this.subSectionName,
    this.itemUom,
    this.isExportControl,
    this.isIhm,
    this.isCritical,
    this.isImdg,
    this.vessel,
    this.poQuantity,
    this.isBagTagItem,
    this.drawingPositionNumber,
    this.drawingNumber,
    this.unitPrice,
    this.equipmentId,
    this.equipmentName,
    this.grnDtId,
    this.podtid,
    this.isConfirmed
  });

  final int? poId;
  final String? poNo;
  final int? grnId;
  final String? grnNo;
  final int? itemId;
  final int? itemVersionId;
  final int? itemLinkId;
  final int? parentItemId;
  final int? parentItemVersionId;
  final int? parentItemLinkId;
  final double? receivedQty;
  final double? convertedStockQty;
  final double? newStock;
  final double? damagedOrWrongSupply;
  final double? reconditionedStock;
  final String? expiryDate;
  final int? uomId;
  final int? qualityId;
  final String? batchNo;
  final String? remarks;
  final bool? isMd;
  final bool? isSdoc;
  final bool? zeroDeclaration;
  final double? ihmMaterialQty;
  final String? articleNo;
  final String? productName;
  final String? productDescription;
  final String? eccnNo;
  final String? hsCode;
  final String? countryName;
  final bool? isAntiPiracy;
  final bool? isPyroTechnics;
  final int? imdgClassId;
  final String? className;
  final String? partNo;
  final String? categoryName;
  final int? itemCategoryId;
  final int? itemSectionId;
  final String? sectionName;
  final int? itemSubSectionId;
  final String? subSectionName;
  final String? itemUom;
  final bool? isExportControl;
  final bool? isIhm;
  final bool? isCritical;
  final bool? isImdg;
  final String? vessel;
  final double? poQuantity;
  final bool? isBagTagItem;
  final String? drawingPositionNumber;
  final String? drawingNumber;
  final double? unitPrice;
  final int? equipmentId;
  final String? equipmentName;
  final int? podtid;
  final int? grnDtId;
  final bool? isConfirmed;

  Map<String, dynamic> toJson() {
    return {
      'poID': poId ?? -1,
      'poNo': poNo ?? '',
      'grnID': grnId ?? -1,
      'grnNo': grnNo ?? '',
      'ItemID': itemId ?? -1,
      'ItemVersionID': itemVersionId ?? -1,
      'ItemLinkID': itemLinkId ?? -1,
      'ParentItemID': parentItemId ?? -1,
      'ParentItemVersionID': parentItemVersionId ?? -1,
      'ParentItemLinkID': parentItemLinkId ?? -1,
      'ReceivedQty': receivedQty ?? -1,
      'ConvertedStockQty': convertedStockQty ?? -1,
      'NewStock': newStock ?? -1,
      'DamagedOrwrongSupply': damagedOrWrongSupply ?? -1,
      'ReconditionedStock': reconditionedStock ?? -1,
      'ExpiryDate': expiryDate ?? '',
      'UOMID': uomId ?? -1,
      'QualityID': qualityId ?? -1,
      'BatchNo': batchNo ?? '',
      'Remarks': remarks ?? '',
      'IsMD': isMd == true ? 1 : 0,
      'IsSDOC': isSdoc == true ? 1 : 0,
      'ZeroDeclaration': zeroDeclaration == true ? 1 : 0,
      'IHMMaterialQty': ihmMaterialQty ?? -1,
      'articleNo': articleNo ?? '',
      'productName': productName ?? '',
      'ProductDescription': productDescription,
      'EccnNo': eccnNo,
      'HSCode': hsCode,
      'CountryName': countryName,
      'isAntiPiracy': isAntiPiracy == true ? 1 : 0,
      'isPyroTechnics': isPyroTechnics == true ? 1 : 0,
      'iMDGClassID': imdgClassId,
      'className': className,
      'PARTNO': partNo,
      'CategoryName': categoryName,
      'ItemCategoryID': itemCategoryId,
      'ItemSectionID': itemSectionId,
      'SectionName': sectionName,
      'ItemSubSectionID': itemSubSectionId,
      'SubSectionName': subSectionName,
      'ItemUom': itemUom,
      'IsExportControl': isExportControl == true ? 1 : 0,
      'IsIHM': isIhm == true ? 1 : 0,
      'IsCritical': isCritical == true ? 1 : 0,
      'IsIMDG': isImdg == true ? 1 : 0,
      'Vessel': vessel,
      'POQuantity': poQuantity,
      'isBagTagItem': isBagTagItem == true ? 1 : 0,
      'DrawingPositionNumber': drawingPositionNumber,
      'DrawingNumber': drawingNumber,
      'UnitPrice': unitPrice,
      'EquipmentID': equipmentId,
      'EquipmentName': equipmentName,
      'GRNDTID': grnDtId,
      'PODTID': podtid,
      'isConfirmed': isConfirmed == true ? 1 : 0,
    };
  }

  GoodsReceiptPurchaseItemDetailEntity toEntity() {
    return GoodsReceiptPurchaseItemDetailEntity(
      poId: poId ?? 0,
      poNo: poNo ?? "",
      grnId: grnId ?? 0,
      grnNo: grnNo ?? "",
      itemId: itemId ?? 0,
      itemVersionId: itemVersionId ?? 0,
      itemLinkId: itemLinkId ?? 0,
      parentItemId: parentItemId ?? 0,
      parentItemVersionId: parentItemVersionId ?? 0,
      parentItemLinkId: parentItemLinkId ?? 0,
      receivedQty: receivedQty ?? 0,
      convertedStockQty: convertedStockQty ?? 0,
      newStock: newStock ?? 0,
      damagedOrWrongSupply: damagedOrWrongSupply ?? 0,
      reconditionedStock: reconditionedStock ?? 0,
      expiryDate: expiryDate ?? "",
      uomId: uomId ?? 0,
      qualityId: qualityId ?? 0,
      batchNo: batchNo ?? "",
      remarks: remarks ?? "",
      isMd: isMd ?? false,
      isSdoc: isSdoc ?? false,
      zeroDeclaration: zeroDeclaration ?? false,
      ihmMaterialQty: ihmMaterialQty ?? 0,
      articleNo: articleNo ?? "",
      productName: productName ?? "",
      productDescription: productDescription ?? "",
      eccnNo: eccnNo ?? "",
      hsCode: hsCode ?? "",
      countryName: countryName ?? "",
      isAntiPiracy: isAntiPiracy ?? false,
      isPyroTechnics: isPyroTechnics ?? false,
      imdgClassId: imdgClassId ?? 0,
      className: className ?? "",
      partNo: partNo ?? "",
      categoryName: categoryName ?? "",
      itemCategoryId: itemCategoryId ?? 0,
      itemSectionId: itemSectionId ?? 0,
      sectionName: sectionName ?? "",
      itemSubSectionId: itemSubSectionId ?? 0,
      subSectionName: subSectionName ?? "",
      itemUom: itemUom ?? "",
      isExportControl: isExportControl ?? false,
      isIhm: isIhm ?? false,
      isCritical: isCritical ?? false,
      isImdg: isImdg ?? false,
      vessel: vessel ?? "",
      poQuantity: poQuantity ?? 0,
      isBagTagItem: isBagTagItem ?? false,
      drawingPositionNumber: drawingPositionNumber ?? "",
      drawingNumber: drawingNumber ?? "",
      unitPrice: unitPrice ?? 0,
      equipmentId: equipmentId ?? 0,
      equipmentName: equipmentName ?? "",
      grnDtId: grnDtId ?? -1,
      isConfirmed: isConfirmed ?? false,
    );
  }

  static List<GoodsReceiptTransactionItemDetailModel> fromEntityList(
    List<GoodsReceiptPurchaseItemDetailEntity>
    goodsReceiptDetailLabelEntityList,
  ) {
    List<GoodsReceiptTransactionItemDetailModel> goodsReceiptLabelModelList =
        [];
    for (var entity in goodsReceiptDetailLabelEntityList) {
      goodsReceiptLabelModelList.add(
        GoodsReceiptTransactionItemDetailModel.fromEntity(entity),
      );
    }
    return goodsReceiptLabelModelList;
  }

  @override
  List<Object?> get props => [
    poId,
    poNo,
    grnId,
    grnNo,
    itemId,
    itemVersionId,
    itemLinkId,
    parentItemId,
    parentItemVersionId,
    parentItemLinkId,
    receivedQty,
    convertedStockQty,
    newStock,
    damagedOrWrongSupply,
    reconditionedStock,
    expiryDate,
    uomId,
    qualityId,
    batchNo,
    remarks,
    isMd,
    isSdoc,
    zeroDeclaration,
    ihmMaterialQty,
    articleNo,
    productName,
    productDescription,
    eccnNo,
    hsCode,
    countryName,
    isAntiPiracy,
    isPyroTechnics,
    imdgClassId,
    className,
    partNo,
    categoryName,
    itemCategoryId,
    itemSectionId,
    sectionName,
    itemSubSectionId,
    subSectionName,
    itemUom,
    isExportControl,
    isIhm,
    isCritical,
    isImdg,
    vessel,
    poQuantity,
    isBagTagItem,
    drawingPositionNumber,
    drawingNumber,
    unitPrice,
    equipmentId,
    equipmentName,
    podtid,
    isConfirmed
  ];
}
