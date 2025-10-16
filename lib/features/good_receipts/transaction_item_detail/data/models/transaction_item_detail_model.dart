import 'package:equatable/equatable.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../purchase_order/data/model/entity_validation_model.dart';

class TransactionItemDetailResponseModel extends Equatable {
  const TransactionItemDetailResponseModel({
    this.moduleCode,
    this.entityName,
    this.recordCount,
    this.reportData,
    this.entityValidation,
  });

  factory TransactionItemDetailResponseModel.fromJson(
    Map<String, dynamic> map,
  ) {
    return TransactionItemDetailResponseModel(
      moduleCode:
          map['moduleCode'] != null ? map['moduleCode'] as String : null,
      entityName:
          map['entityName'] != null ? map['entityName'] as String : null,
      recordCount:
          map['recordCount'] != null ? map['recordCount'] as int : null,
      reportData:
          map['reportData'] != null
              ? List<TransactionItemDetailsModel>.from(
                (map['reportData'] as List<dynamic>)
                    .map<TransactionItemDetailsModel?>(
                      (x) => TransactionItemDetailsModel.fromJson(
                        x as Map<String, dynamic>,
                      ),
                    ),
              )
              : null,
      entityValidation:
          map['entityValidation'] != null
              ? EntityValidationModel.fromJson(
                map['entityValidation'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  final String? moduleCode;
  final String? entityName;
  final int? recordCount;
  final List<TransactionItemDetailsModel>? reportData;

  final EntityValidationModel? entityValidation;

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    reportData,
    recordCount,
    entityValidation,
  ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'entityValidation': entityValidation?.toJson(),
    };
  }
}

class TransactionItemDetailsModel extends Equatable {
  const TransactionItemDetailsModel({
    this.poID,
    this.poNo,
    this.grnID,
    this.grnDtId,
    this.grnNo,
    this.itemID,
    this.itemVersionID,
    this.itemLinkID,
    this.parentItemID,
    this.parentItemVersionID,
    this.parentItemLinkID,
    this.receivedQty,
    this.convertedStockQty,
    this.newStock,
    this.damagedOrwrongSupply,
    this.reconditionedStock,
    this.expiryDate,
    this.uomid,
    this.qualityID,
    this.batchNo,
    this.remarks,
    this.isMD,
    this.isSDOC,
    this.zeroDeclaration,
    this.iHMMaterialQty,
    this.articleNo,
    this.productName,
    this.productDescription,
    this.eccnNo,
    this.hSCode,
    this.countryName,
    this.isAntiPiracy,
    this.isPyroTechnics,
    this.iMDGClassID,
    this.className,
    this.partNo,
    this.categoryName,
    this.itemCategoryID,
    this.itemSectionID,
    this.sectionName,
    this.itemSubSectionID,
    this.subSectionName,
    this.itemUom,
    this.isExportControl,
    this.isIHM,
    this.isCritical,
    this.isIMDG,
    this.vessel,
    this.pOQuantity,
    this.isBagTagItem,
    this.drawingPositionNumber,
    this.drawingNumber,
    this.unitPrice,
    this.equipmentID,
    this.equipmentName,
    this.pODTID,
    this.defaultLocationId,
    this.defaultLocation,
    this.packSize,
    this.serialNumber,
  });

  factory TransactionItemDetailsModel.fromJson(Map<String, dynamic> json) {
    return TransactionItemDetailsModel(
      poID: json['poID'],
      poNo: json['poNo'],
      grnID: json['grnID'],
      grnDtId: json['GRNDTID'],
      grnNo: json['grnNo'],
      itemID: json['ItemID'],
      itemVersionID: json['ItemVersionID'],
      itemLinkID: json['ItemLinkID'],
      parentItemID: json['ParentItemID'],
      parentItemVersionID: json['ParentItemVersionID'],
      parentItemLinkID: json['ParentItemLinkID'],
      receivedQty: (json['ReceivedQty'] as num?)?.toDouble(),
      convertedStockQty: (json['ConvertedStockQty'] as num?)?.toDouble(),
      newStock: (json['NewStock'] as num?)?.toDouble(),
      damagedOrwrongSupply: (json['DamagedOrwrongSupply'] as num?)?.toDouble(),
      reconditionedStock: (json['ReconditionedStock'] as num?)?.toDouble(),
      expiryDate: json['ExpiryDate'],
      uomid: json['UOMID'],
      qualityID: json['QualityID'],
      batchNo: json['BatchNo'],
      remarks: json['Remarks'],
      isMD:
          json['IsMD'] != null
              ? json['IsMD'].runtimeType == bool
                  ? json['IsMD']
                  : json['IsMD'] == 1
                  ? true
                  : false
              : false,
      isSDOC:
          json['IsSDOC'] != null
              ? json['IsSDOC'].runtimeType == bool
                  ? json['IsSDOC']
                  : json['IsSDOC'] == 1
                  ? true
                  : false
              : false,
      zeroDeclaration:
          json['ZeroDeclaration'] != null
              ? json['ZeroDeclaration'].runtimeType == bool
                  ? json['ZeroDeclaration']
                  : json['ZeroDeclaration'] == 1
                  ? true
                  : false
              : false,
      iHMMaterialQty: (json['IHMMaterialQty'] as num?)?.toDouble(),
      articleNo: json['articleNo'],
      productName: json['productName'],
      productDescription: json['ProductDescription'],
      eccnNo: json['EccnNo'],
      hSCode: json['HSCode'],
      countryName: json['CountryName'],
      isAntiPiracy:
          json['isAntiPiracy'] != null
              ? json['isAntiPiracy'].runtimeType == bool
                  ? json['isAntiPiracy']
                  : json['isAntiPiracy'] == 1
                  ? true
                  : false
              : false,
      isPyroTechnics:
          json['isPyroTechnics'] != null
              ? json['isPyroTechnics'].runtimeType == bool
                  ? json['isPyroTechnics']
                  : json['isPyroTechnics'] == 1
                  ? true
                  : false
              : false,
      iMDGClassID: json['iMDGClassID'],
      className: json['className'],
      partNo: json['PARTNO'],
      categoryName: json['CategoryName'],
      itemCategoryID: json['ItemCategoryID'],
      itemSectionID: json['ItemSectionID'],
      sectionName: json['SectionName'],
      itemSubSectionID: json['ItemSubSectionID'],
      subSectionName: json['SubSectionName'],
      itemUom: json['ItemUom'],
      isExportControl:
          json['IsExportControl'] != null
              ? json['IsExportControl'].runtimeType == bool
                  ? json['IsExportControl']
                  : json['IsExportControl'] == 1
                  ? true
                  : false
              : false,
      isIHM:
          json['IsIHM'] != null
              ? json['IsIHM'].runtimeType == bool
                  ? json['IsIHM']
                  : json['IsIHM'] == 1
                  ? true
                  : false
              : false,
      isCritical:
          json['IsCritical'] != null
              ? json['IsCritical'].runtimeType == bool
                  ? json['IsCritical']
                  : json['IsCritical'] == 1
                  ? true
                  : false
              : false,
      isIMDG:
          json['IsIMDG'] != null
              ? json['IsIMDG'].runtimeType == bool
                  ? json['IsIMDG']
                  : json['IsIMDG'] == 1
                  ? true
                  : false
              : false,
      vessel: json['Vessel'],
      pOQuantity: (json['POQuantity'] as num?)?.toDouble(),
      isBagTagItem:
          json['IsBagTagItem'] != null
              ? json['IsBagTagItem'].runtimeType == bool
                  ? json['IsBagTagItem']
                  : json['IsBagTagItem'] == 1
                  ? true
                  : false
              : false,
      drawingPositionNumber: json['DrawingPositionNumber'],
      drawingNumber: json['DrawingNumber'],
      unitPrice: (json['UnitPrice'] as num?)?.toDouble(),
      equipmentID: json['EquipmentID'],
      equipmentName: json['EquipmentName'],
      pODTID: json['PODTID'],
      defaultLocationId: json['default_location_id'],
      defaultLocation: json['default_location'],
      serialNumber: json["serialNo"],
      packSize: json["packSize"],
    );
  }

  ItemEntity toEntity() {
    return ItemEntity.initial().copyWith(
      poHdId: poID,
      grnId: grnID,
      grnDtId: grnDtId,
      itemId: itemID,
      itemVersionId: itemVersionID,
      itemLinkId: itemLinkID,
      parentItemId: parentItemID,
      parentItemVersionId: parentItemVersionID,
      parentItemLinkId: parentItemLinkID,
      receivedQuantity: receivedQty,
      // convertedStockQty: convertedStockQty, //ToDo
      newStockQuantity: newStock,
      damagedQuantity: damagedOrwrongSupply,
      reconditionedStock: reconditionedStock,
      expiryDate: expiryDate,
      uomId: uomid,
      qualityId: qualityID,
      batchNumber: batchNo,
      remarks: remarks,
      isMd: isMD,
      isSDoc: isSDOC,
      zeroDeclaration: zeroDeclaration,
      ihmMaterialQty: iHMMaterialQty,
      articleNumber: articleNo,
      productName: productName,
      productDescription: productDescription,
      eccnNo: eccnNo,
      hsCode: hSCode,
      countryName: countryName,
      isAntiPiracy: isAntiPiracy ?? false,
      isPyroTechnics: isPyroTechnics ?? false,
      imdgClass: className,
      imdgClassId: iMDGClassID,
      partNumber: partNo,
      itemCategory: categoryName,
      itemCategoryId: itemCategoryID ?? -1,
      itemSectionId: itemSectionID ?? -1,
      itemSection: sectionName ?? "",
      itemSubSection: subSectionName ?? '',
      itemSubSectionId: itemSubSectionID ?? -1,
      uom: itemUom ?? "",
      isExportControl: isExportControl ?? false,
      isIhm: isIHM ?? false,
      isCritical: isCritical ?? false,
      isImdg: isIMDG ?? false,
      vessel: vessel ?? "",
      poQuantity: pOQuantity ?? -1,
      isBagTagItem: isBagTagItem ?? false,
      drawingPositionNumber: drawingPositionNumber ?? "",
      drawingNumber: drawingNumber ?? "",
      unitPrice: unitPrice ?? -1,
      equipmentId: equipmentID ?? -1,
      equipment: equipmentName ?? "",
      poDtId: pODTID ?? -1,
      defaultStorageLocation: defaultLocation ?? "",
      serialNumber: int.parse(serialNumber ?? "0"),
      packSize: double.parse(packSize ?? "0"),
    );
  }

  final int? poID;
  final String? poNo;
  final int? grnID;
  final int? grnDtId;
  final String? grnNo;
  final int? itemID;
  final int? itemVersionID;
  final int? itemLinkID;
  final int? parentItemID;
  final int? parentItemVersionID;
  final int? parentItemLinkID;
  final double? receivedQty;
  final double? convertedStockQty;
  final double? newStock;
  final double? damagedOrwrongSupply;
  final double? reconditionedStock;
  final String? expiryDate;
  final int? uomid;
  final int? qualityID;
  final String? batchNo;
  final String? remarks;
  final bool? isMD;
  final bool? isSDOC;
  final bool? zeroDeclaration;
  final double? iHMMaterialQty;
  final String? articleNo;
  final String? productName;
  final String? productDescription;
  final String? eccnNo;
  final String? hSCode;
  final String? countryName;
  final bool? isAntiPiracy;
  final bool? isPyroTechnics;
  final int? iMDGClassID;
  final String? className;
  final String? partNo;
  final String? categoryName;
  final int? itemCategoryID;
  final int? itemSectionID;
  final String? sectionName;
  final int? itemSubSectionID;
  final String? subSectionName;
  final String? itemUom;
  final bool? isExportControl;
  final bool? isIHM;
  final bool? isCritical;
  final bool? isIMDG;
  final String? vessel;
  final double? pOQuantity;
  final bool? isBagTagItem;
  final String? drawingPositionNumber;
  final String? drawingNumber;
  final double? unitPrice;
  final int? equipmentID;
  final String? equipmentName;
  final int? pODTID;
  final int? defaultLocationId;
  final String? defaultLocation;
  final String? packSize;
  final String? serialNumber;

  Map<String, dynamic> toJson() {
    return {
      'poID': poID,
      'poNo': poNo,
      'grnID': grnID,
      'GRNDTID': grnDtId,
      'grnNo': grnNo,
      'ItemID': itemID,
      'ItemVersionID': itemVersionID,
      'ItemLinkID': itemLinkID,
      'ParentItemID': parentItemID,
      'ParentItemVersionID': parentItemVersionID,
      'ParentItemLinkID': parentItemLinkID,
      'ReceivedQty': receivedQty,
      'ConvertedStockQty': convertedStockQty,
      'NewStock': newStock,
      'DamagedOrwrongSupply': damagedOrwrongSupply,
      'ReconditionedStock': reconditionedStock,
      'ExpiryDate': expiryDate,
      'UOMID': uomid,
      'QualityID': qualityID,
      'BatchNo': batchNo,
      'Remarks': remarks,
      'IsMD': isMD == true ? 1 : 0,
      'IsSDOC': isSDOC == true ? 1 : 0,
      'ZeroDeclaration': zeroDeclaration == true ? 1 : 0,
      'IHMMaterialQty': iHMMaterialQty,
      'articleNo': articleNo,
      'productName': productName,
      'ProductDescription': productDescription,
      'EccnNo': eccnNo,
      'HSCode': hSCode,
      'CountryName': countryName,
      'isAntiPiracy': isAntiPiracy == true ? 1 : 0,
      'isPyroTechnics': isPyroTechnics == true ? 1 : 0,
      'iMDGClassID': iMDGClassID,
      'className': className,
      'PARTNO': partNo,
      'CategoryName': categoryName,
      'ItemCategoryID': itemCategoryID,
      'ItemSectionID': itemSectionID,
      'SectionName': sectionName,
      'ItemSubSectionID': itemSubSectionID,
      'SubSectionName': subSectionName,
      'ItemUom': itemUom,
      'IsExportControl': isExportControl == true ? 1 : 0,
      'IsIHM': isIHM == true ? 1 : 0,
      'IsCritical': isCritical == true ? 1 : 0,
      'IsIMDG': isIMDG == true ? 1 : 0,
      'Vessel': vessel,
      'POQuantity': pOQuantity,
      'IsBagTagItem': isBagTagItem == true ? 1 : 0,
      'DrawingPositionNumber': drawingPositionNumber,
      'DrawingNumber': drawingNumber,
      'UnitPrice': unitPrice,
      'EquipmentID': equipmentID,
      'EquipmentName': equipmentName,
      'PODTID': pODTID,
    };
  }

  @override
  List<Object?> get props => [
    poID,
    poNo,
    grnID,
    grnDtId,
    grnNo,
    itemID,
    itemVersionID,
    itemLinkID,
    parentItemID,
    parentItemVersionID,
    parentItemLinkID,
    receivedQty,
    convertedStockQty,
    newStock,
    damagedOrwrongSupply,
    reconditionedStock,
    expiryDate,
    uomid,
    qualityID,
    batchNo,
    remarks,
    isMD,
    isSDOC,
    zeroDeclaration,
    iHMMaterialQty,
    articleNo,
    productName,
    productDescription,
    eccnNo,
    hSCode,
    countryName,
    isAntiPiracy,
    isPyroTechnics,
    iMDGClassID,
    className,
    partNo,
    categoryName,
    itemCategoryID,
    itemSectionID,
    sectionName,
    itemSubSectionID,
    subSectionName,
    itemUom,
    isExportControl,
    isIHM,
    isCritical,
    isIMDG,
    vessel,
    pOQuantity,
    isBagTagItem,
    drawingPositionNumber,
    drawingNumber,
    unitPrice,
    equipmentID,
    equipmentName,
    pODTID,
  ];
}
