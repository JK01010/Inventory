import 'package:equatable/equatable.dart';

import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import 'goods_receipt_entity_validation.dart';

class GoodsReceiptPurchaseItemDetailResponseModel extends Equatable {
  const GoodsReceiptPurchaseItemDetailResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory GoodsReceiptPurchaseItemDetailResponseModel.fromJson(
    Map<String, dynamic> map,
  ) {
    return GoodsReceiptPurchaseItemDetailResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<GoodsReceiptPurchaseItemDetailModel>.from(
        (map['reportData'] as List).map(
          (x) => GoodsReceiptPurchaseItemDetailModel.fromMap(
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
  final List<GoodsReceiptPurchaseItemDetailModel>? reportData;
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

// This is the new, single class with all properties from A and B combined.
class GoodsReceiptPurchaseItemDetailModel extends Equatable {
  const GoodsReceiptPurchaseItemDetailModel({
    // --- Common Properties (from both A and B) ---
     this.itemId,
     this.itemVersionId,
     this.itemLinkId,
     this.uomId,
     this.productName,
     this.productDescription,
     this.partNo,
     this.isMd,
     this.zeroDeclaration,
     this.ihmMaterialQty,
     this.eccnNo,
     this.hsCode,
     this.countryName,
     this.categoryName,
     this.itemCategoryId,
     this.itemSectionId,
     this.sectionName,
     this.itemSubSectionId,
     this.subSectionName,
     this.itemUom,
     this.vessel,

    // --- Properties unique to Class A ---
    this.poDtId,
    this.slNo,
    this.partNumber, // A had 'partNumber', B had 'partNo'. Both included.
    this.packSize,
    this.quantity,
    this.rob,
    this.unitPrice,
    this.contractPrice,
    this.discountPercentage,
    this.discount,
    this.vatId,
    this.vatPercentage,
    this.accountId,
    this.accountCode,
    this.accountName,
    this.subAccountId,
    this.subAccountCode,
    this.subAccountName,
    this.analysisCodeId,
    this.analysisCode,
    this.analysisName,
    this.leadDays,
    this.vendorDeliveryDate,
    this.remarksToVendor,
    this.isSDoc, // Note: Class B had isSdoc (lowercase d)
    this.entity,
    this.entityId,
    this.poHdId,
    this.articleNumber,
    this.packUom,
    this.serviceDescription,
    this.equipmentName,
    this.equipmentDescription,
    this.equipmentModelNumber,
    this.equipmentSerialNo,
    this.equipmentManufacturer,
    this.deliveryCode,
    this.deliveryTypeName,
    this.uniqueItemReference,
    this.isDeleted,
    this.parentId, // A used this name
    this.parentItemLinkId,
    this.parentItemVersionId,
    this.imdgCode,
    this.imdgName,
    this.exportControl,
    this.drawingNumber,

    // --- Properties unique to Class B ---
    this.poId,
    this.poNo,
    this.grnId,
    this.grnNo,
    this.parentItemId, // B used this name
    this.receivedQty,
    this.convertedStockQty,
    this.newStock,
    this.damagedOrWrongSupply,
    this.reconditionedStock,
    this.expiryDate,
    this.qualityId,
    this.batchNo,
    this.remarks,
    this.isSdoc, // Note: Class A had isSDoc (uppercase D)
    this.articleNo,
    this.isAntiPiracy,
    this.isPyroTechnics,
    this.imdgClassId,
    this.className,
    this.isExportControl,
    this.isIhm,
    this.isCritical,
    this.isImdg,
  });

  // --- Common Properties ---
  final int? itemId;
  final int? itemVersionId;
  final int? itemLinkId;
  final int? uomId;
  final String? productName;
  final String? productDescription;
  final String? partNo;
  final bool? isMd;
  final bool? zeroDeclaration;
  final double? ihmMaterialQty;
  final String? eccnNo;
  final String? hsCode;
  final String? countryName;
  final String? categoryName;
  final int? itemCategoryId;
  final int? itemSectionId;
  final String? sectionName;
  final int? itemSubSectionId;
  final String? subSectionName;
  final String? itemUom;
  final String? vessel;

  // --- Properties unique to Class A ---
  final int? poDtId;
  final int? slNo;
  final String? partNumber;
  final double? packSize;
  final double? quantity;
  final int? rob;
  final double? unitPrice;
  final double? contractPrice;
  final double? discountPercentage;
  final double? discount;
  final int? vatId;
  final double? vatPercentage;
  final int? accountId;
  final String? accountCode;
  final String? accountName;
  final int? subAccountId;
  final String? subAccountCode;
  final String? subAccountName;
  final int? analysisCodeId;
  final String? analysisCode;
  final String? analysisName;
  final double? leadDays;
  final String? vendorDeliveryDate;
  final String? remarksToVendor;
  final bool? isSDoc;
  final String? entity;
  final int? entityId;
  final int? poHdId;
  final String? articleNumber;
  final String? packUom;
  final String? serviceDescription;
  final String? equipmentName;
  final String? equipmentDescription;
  final String? equipmentModelNumber;
  final String? equipmentSerialNo;
  final String? equipmentManufacturer;
  final String? deliveryCode;
  final String? deliveryTypeName;
  final String? uniqueItemReference;
  final bool? isDeleted;
  final int? parentId;
  final int? parentItemLinkId;
  final int? parentItemVersionId;
  final String? imdgCode;
  final String? imdgName;
  final String? exportControl;
  final String? drawingNumber;

  // --- Properties unique to Class B ---
  final int? poId;
  final String? poNo;
  final int? grnId;
  final String? grnNo;
  final int? parentItemId;
  final double? receivedQty;
  final double? convertedStockQty;
  final double? newStock;
  final double? damagedOrWrongSupply;
  final double? reconditionedStock;
  final String? expiryDate;
  final int? qualityId;
  final String? batchNo;
  final String? remarks;
  final bool? isSdoc;
  final String? articleNo;
  final bool? isAntiPiracy;
  final bool? isPyroTechnics;
  final int? imdgClassId;
  final String? className;
  final bool? isExportControl;
  final bool? isIhm;
  final bool? isCritical;
  final bool? isImdg;

  // Merged fromMap factory. It can now parse JSON meant for either Class A or B.
  factory GoodsReceiptPurchaseItemDetailModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return GoodsReceiptPurchaseItemDetailModel(
      // Parsing logic from both classes
      itemId: json['ItemId'] ?? json['ItemID'] as int?,
      itemVersionId: json['ItemVersionID'] as int?,
      itemLinkId: json['ItemLinkID'] as int?,
      uomId: json['UOMID'] as int?,
      productName: json['ProductName'] ?? json['productName'] as String?,
      productDescription: json['ProductDescription'] as String?,
      partNo: json['PARTNO'] as String?,
      isMd:
          (json['IsMD'] is bool? ? json['IsMD'] : json['IsMD'] == "Yes")
              as bool?,
      zeroDeclaration:
          (json['ZeroDeclaration'] is bool?
                  ? json['ZeroDeclaration']
                  : json['ZeroDeclaration'] == "Yes")
              as bool?,
      ihmMaterialQty: json['IHMMaterialQty'] as double?,
      eccnNo: json['EccnNo'] as String?,
      hsCode: json['HSCode'] as String?,
      countryName: json['CountryName'] as String?,
      categoryName: json['CategoryName'] as String?,
      itemCategoryId: json['ItemCategoryID'] as int?,
      itemSectionId: json['ItemSectionID'] as int?,
      sectionName: json['SectionName'] as String?,
      itemSubSectionId: json['ItemSubSectionID'] as int?,
      subSectionName: json['SubSectionName'] as String?,
      itemUom: json['ItemUom'] as String?,
      vessel: json['Vessel'] as String?,

      poDtId: json['PODTID'] as int?,
      slNo: json['SLNO'] as int?,
      partNumber: json['PartNumber'] as String?,
      packSize: json['PackSize'] as double?,
      quantity: json['Quantity'] as double?,
      rob: json['ROB'] as int?,
      unitPrice: json['UnitPrice'] as double?,
      contractPrice: json['ContractPrice'] as double?,
      discountPercentage: json['DiscountPercentage'] as double?,
      discount: json['Discount'] as double?,
      vatId: json['VATID'] as int?,
      vatPercentage: json['VATPercentage'] as double?,
      accountId: json['AccountID'] as int?,
      accountCode: json['AccountCode'] as String?,
      accountName: json['AccountName'] as String?,
      subAccountId: json['SubAccountID'] as int?,
      subAccountCode: json['SubAccountCode'] as String?,
      analysisCodeId: json['AnalysisCodeID'] as int?,
      analysisCode: json['AnalysisCode'] as String?,
      analysisName: json['AnalysisName'] as String?,
      leadDays: json['LeadDays'] as double?,
      vendorDeliveryDate: json['VendorDeliveryDate'] as String?,
      remarksToVendor: json['RemarksToVendor'] as String?,
      entity: json['Entity'] as String?,
      entityId: json['EntityID'] as int?,
      poHdId: json['POHDID'] as int?,
      articleNumber: json['ArticleNumber'] as String?,
      packUom: json['PackUOM'] as String?,
      serviceDescription: json['ServiceDescription'] as String?,
      equipmentName: json['EquipmentName'] as String?,
      equipmentDescription: json['EquipmentDescription'] as String?,
      equipmentModelNumber: json['EquipmentModelNumber'] as String?,
      equipmentSerialNo: json['EquimentSerialNo'] as String?,
      equipmentManufacturer: json['EquipmentManufacturer'] as String?,
      deliveryCode: json['DeliveryCode'] as String?,
      deliveryTypeName: json['DeliveryTypeName'] as String?,
      uniqueItemReference: json['UniqueItemReference'] as String?,
      isDeleted: json['IsDeleted'] as bool?,
      parentId: json['ParentID'] as int?,
      parentItemLinkId: json['ParentItemLinkID'] as int?,
      parentItemVersionId: json['ParentItemVersionID'] as int?,
      imdgCode: json['IMDGCode'] as String?,
      imdgName: json['IMDGName'] as String?,
      exportControl: json['ExportControl'] as String?,
      drawingNumber: json['DrawingNumber'] as String?,

      poId: json['poID'] as int?,
      poNo: json['poNo'] as String?,
      grnId: json['grnID'] as int?,
      grnNo: json['grnNo'] as String?,
      parentItemId: json['ParentItemID'] as int?,
      receivedQty: json['ReceivedQty'] as double?,
      convertedStockQty: json['ConvertedStockQty'] as double?,
      newStock: json['NewStock'] as double?,
      damagedOrWrongSupply: json['DamagedOrwrongSupply'] as double?,
      reconditionedStock: json['ReconditionedStock'] as double?,
      expiryDate: json['ExpiryDate'] as String?,
      qualityId: json['QualityID'] as int?,
      batchNo: json['BatchNo'] as String?,
      remarks: json['Remarks'] as String?,
      isSdoc: json['IsSDOC'] == "Yes" ? true : false,
      isSDoc: json['IsSDOC'] == "Yes" ? true : false,
      articleNo: json['articleNo'] as String?,
      isAntiPiracy: json['isAntiPiracy'] == "Yes" ? true : false,
      isPyroTechnics: json['isPyroTechnics'] == "Yes" ? true : false,
      imdgClassId: json['iMDGClassID'] as int?,
      className: json['className'] as String?,
      isExportControl: json['IsExportControl'] == "Yes" ? true : false,
      isIhm: json['IsIHM'] == "Yes" ? true : false,
      isCritical: json['IsCritical'] == "Yes" ? true : false,
      isImdg: json['IsIMDG'] == "Yes" ? true : false,
      subAccountName: json['SubAccountName'] as String?,
    );
  }

  // Merged toMap method. It includes all properties.
  Map<String, dynamic> toJson() {
    return {
      // Logic from both toMap methods
      'ItemId': itemId,
      'ItemVersionID': itemVersionId,
      'ItemLinkID': itemLinkId,
      'UOMID': uomId,
      'ProductName': productName,
      'ProductDescription': productDescription,
      'PARTNO': partNo,
      'IsMD': isMd,
      'ZeroDeclaration': zeroDeclaration,
      'IHMMaterialQty': ihmMaterialQty,
      'EccnNo': eccnNo,
      'HSCode': hsCode,
      'CountryName': countryName,
      'CategoryName': categoryName,
      'ItemCategoryID': itemCategoryId,
      'ItemSectionID': itemSectionId,
      'SectionName': sectionName,
      'ItemSubSectionID': itemSubSectionId,
      'SubSectionName': subSectionName,
      'ItemUom': itemUom,
      'Vessel': vessel,
      'PODTID': poDtId,
      'SLNO': slNo,
      'PartNumber': partNumber,
      'PackSize': packSize,
      'Quantity': quantity,
      'ROB': rob,
      'UnitPrice': unitPrice,
      'ContractPrice': contractPrice,
      'DiscountPercentage': discountPercentage,
      'Discount': discount,
      'VATID': vatId,
      'VATPercentage': vatPercentage,
      'AccountID': accountId,
      'AccountCode': accountCode,
      'AccountName': accountName,
      'SubAccountID': subAccountId,
      'SubAccountCode': subAccountCode,
      'SubAccountName': subAccountName,
      'AnalysisCodeID': analysisCodeId,
      'AnalysisCode': analysisCode,
      'AnalysisName': analysisName,
      'LeadDays': leadDays,
      'VendorDeliveryDate': vendorDeliveryDate,
      'RemarksToVendor': remarksToVendor,
      'IsSDOC': isSDoc,
      'Entity': entity,
      'EntityID': entityId,
      'POHDID': poHdId,
      'ArticleNumber': articleNumber,
      'PackUOM': packUom,
      'ServiceDescription': serviceDescription,
      'EquipmentName': equipmentName,
      'EquipmentDescription': equipmentDescription,
      'EquipmentModelNumber': equipmentModelNumber,
      'EquimentSerialNo': equipmentSerialNo,
      'EquipmentManufacturer': equipmentManufacturer,
      'DeliveryCode': deliveryCode,
      'DeliveryTypeName': deliveryTypeName,
      'UniqueItemReference': uniqueItemReference,
      'IsDeleted': isDeleted,
      'ParentID': parentId,
      'ParentItemLinkID': parentItemLinkId,
      'ParentItemVersionID': parentItemVersionId,
      'IMDGCode': imdgCode,
      'IMDGName': imdgName,
      'ExportControl': exportControl,
      'DrawingNumber': drawingNumber,
      'poId': poId,
      'poNo': poNo,
      'grnId': grnId,
      'grnNo': grnNo,
      'parentItemId': parentItemId,
      'receivedQty': receivedQty,
      'convertedStockQty': convertedStockQty,
      'newStock': newStock,
      'damagedOrWrongSupply': damagedOrWrongSupply,
      'reconditionedStock': reconditionedStock,
      'expiryDate': expiryDate,
      'qualityId': qualityId,
      'batchNo': batchNo,
      'remarks': remarks,
      'isSdoc': isSdoc,
      'articleNo': articleNo,
      'isAntiPiracy': isAntiPiracy,
      'isPyroTechnics': isPyroTechnics,
      'imdgClassId': imdgClassId,
      'className': className,
      'isExportControl': isExportControl,
      'isIhm': isIhm,
      'isCritical': isCritical,
      'isImdg': isImdg,
    };
  }

  @override
  List<Object?> get props => [
    // List all properties here for Equatable to work
    itemId,
    itemVersionId,
    itemLinkId,
    uomId,
    productName,
    productDescription,
    partNo,
    isMd,
    zeroDeclaration,
    ihmMaterialQty,
    eccnNo,
    hsCode,
    countryName,
    categoryName,
    itemCategoryId,
    itemSectionId,
    sectionName,
    itemSubSectionId,
    subSectionName,
    itemUom,
    vessel,
    poDtId,
    slNo,
    partNumber,
    packSize,
    quantity,
    rob,
    unitPrice,
    contractPrice,
    discountPercentage,
    discount,
    vatId,
    vatPercentage,
    accountId,
    accountCode,
    accountName,
    subAccountId,
    subAccountCode,
    subAccountName,
    analysisCodeId,
    analysisCode,
    analysisName,
    leadDays,
    vendorDeliveryDate,
    remarksToVendor,
    isSDoc,
    entity,
    entityId,
    poHdId,
    articleNumber,
    packUom,
    serviceDescription,
    equipmentName,
    equipmentDescription,
    equipmentModelNumber,
    equipmentSerialNo,
    equipmentManufacturer,
    deliveryCode,
    deliveryTypeName,
    uniqueItemReference,
    isDeleted,
    parentId,
    parentItemLinkId,
    parentItemVersionId,
    imdgCode,
    imdgName,
    exportControl,
    drawingNumber,
    poId,
    poNo,
    grnId,
    grnNo,
    parentItemId,
    receivedQty,
    convertedStockQty,
    newStock,
    damagedOrWrongSupply,
    reconditionedStock,
    expiryDate,
    qualityId,
    batchNo,
    remarks,
    isSdoc,
    articleNo,
    isAntiPiracy,
    isPyroTechnics,
    imdgClassId,
    className,
    isExportControl,
    isIhm,
    isCritical,
    isImdg,
  ];

  GoodsReceiptPurchaseOrderLineItemEntity toEntity() =>
      GoodsReceiptPurchaseOrderLineItemEntity(
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
        isMd: isMd == "Y" ? true : false,
        isSdoc: isSdoc == "Y" ? true : false,
        zeroDeclaration: zeroDeclaration == "Y" ? true : false,
        ihmMaterialQty: ihmMaterialQty ?? 0,
        articleNo: articleNo ?? "",
        productName: productName ?? "",
        productDescription: productDescription ?? "",
        eccnNo: eccnNo ?? "",
        hsCode: hsCode ?? "",
        countryName: countryName ?? "",
        isAntiPiracy: isAntiPiracy == "Y" ? true : false,
        isPyroTechnics: isPyroTechnics == "Y" ? true : false,
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
        isExportControl: isExportControl == "Y" ? true : false,
        isIhm: isIhm == "Y" ? true : false,
        isCritical: isCritical == "Y" ? true : false,
        isImdg: isImdg == "Y" ? true : false,
        vessel: vessel ?? "",
        accountCode: accountCode ?? '',
        accountId: accountId ?? -1,
        accountName: accountName ?? '',
        analysisCode: analysisCode ?? '',
        analysisCodeId: analysisCodeId ?? -1,
        analysisName: analysisName ?? '',
        articleNumber: articleNumber ?? '',
        contractPrice: contractPrice ?? 0,
        deliveryCode: deliveryCode ?? '',
        deliveryTypeName: deliveryTypeName ?? '',
        discount: discount ?? 0,
        discountPercentage: discountPercentage ?? 0,
        drawingNumber: drawingNumber,
        entity: entity ?? '',
        entityId: entityId ?? -1,
        equipmentDescription: equipmentDescription ?? '',
        equipmentManufacturer: equipmentManufacturer ?? '',
        equipmentModelNumber: equipmentModelNumber ?? '',
        equipmentName: equipmentName ?? '',
        equipmentSerialNo: equipmentSerialNo,
        exportControl: exportControl,
        imdgCode: imdgCode ?? '',
        imdgName: imdgName ?? '',
        isDeleted: isDeleted ?? false,
        poDtId: poDtId ?? 0,
        slNo: slNo ?? 0,
        partNumber: partNumber ?? '',
        packSize: packSize ?? 0.0,
        quantity: quantity ?? 0.0,
        rob: rob ?? 0,
        unitPrice: unitPrice ?? 0.0,
        vatId: vatId ?? 0,
        vatPercentage: vatPercentage ?? 0.0,
        subAccountId: subAccountId ?? 0,
        subAccountCode: subAccountCode ?? '',
        subAccountName: subAccountName ?? '',
        vendorDeliveryDate: vendorDeliveryDate ?? '',
        remarksToVendor: remarksToVendor ?? '',
        isSDoc: isSDoc ?? false,
        poHdId: poHdId ?? 0,
        serviceDescription: serviceDescription ?? '',
        uniqueItemReference: uniqueItemReference ?? '',
        parentId: parentId ?? 0,
        leadDays: leadDays ?? 0.0,
        packUom: packUom ?? '',
      );

  factory GoodsReceiptPurchaseItemDetailModel.fromEntity(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) {
    return GoodsReceiptPurchaseItemDetailModel(
      poId: goodsReceiptPurchaseOrderLineItemEntity.poId,
      poNo: goodsReceiptPurchaseOrderLineItemEntity.poNo,
      grnId: goodsReceiptPurchaseOrderLineItemEntity.grnId,
      grnNo: goodsReceiptPurchaseOrderLineItemEntity.grnNo,
      itemId: goodsReceiptPurchaseOrderLineItemEntity.itemId,
      itemVersionId: goodsReceiptPurchaseOrderLineItemEntity.itemVersionId,
      itemLinkId: goodsReceiptPurchaseOrderLineItemEntity.itemLinkId,
      parentItemId: goodsReceiptPurchaseOrderLineItemEntity.parentItemId,
      parentItemVersionId:
          goodsReceiptPurchaseOrderLineItemEntity.parentItemVersionId,
      parentItemLinkId:
          goodsReceiptPurchaseOrderLineItemEntity.parentItemLinkId,
      receivedQty: goodsReceiptPurchaseOrderLineItemEntity.receivedQty,
      convertedStockQty:
          goodsReceiptPurchaseOrderLineItemEntity.convertedStockQty,
      newStock: goodsReceiptPurchaseOrderLineItemEntity.newStock,
      damagedOrWrongSupply:
          goodsReceiptPurchaseOrderLineItemEntity.damagedOrWrongSupply,
      reconditionedStock:
          goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock,
      expiryDate: goodsReceiptPurchaseOrderLineItemEntity.expiryDate,
      uomId: goodsReceiptPurchaseOrderLineItemEntity.uomId,
      qualityId: goodsReceiptPurchaseOrderLineItemEntity.qualityId,
      batchNo: goodsReceiptPurchaseOrderLineItemEntity.batchNo,
      remarks: goodsReceiptPurchaseOrderLineItemEntity.remarks,
      isMd: goodsReceiptPurchaseOrderLineItemEntity.isMd,
      isSdoc: goodsReceiptPurchaseOrderLineItemEntity.isSdoc,
      zeroDeclaration: goodsReceiptPurchaseOrderLineItemEntity.zeroDeclaration,
      ihmMaterialQty: goodsReceiptPurchaseOrderLineItemEntity.ihmMaterialQty,
      articleNo: goodsReceiptPurchaseOrderLineItemEntity.articleNo,
      productName: goodsReceiptPurchaseOrderLineItemEntity.productName,
      productDescription:
          goodsReceiptPurchaseOrderLineItemEntity.productDescription,
      eccnNo: goodsReceiptPurchaseOrderLineItemEntity.eccnNo,
      hsCode: goodsReceiptPurchaseOrderLineItemEntity.hsCode,
      countryName: goodsReceiptPurchaseOrderLineItemEntity.countryName,
      isAntiPiracy: goodsReceiptPurchaseOrderLineItemEntity.isAntiPiracy,
      isPyroTechnics: goodsReceiptPurchaseOrderLineItemEntity.isPyroTechnics,
      imdgClassId: goodsReceiptPurchaseOrderLineItemEntity.imdgClassId,
      className: goodsReceiptPurchaseOrderLineItemEntity.className,
      partNo: goodsReceiptPurchaseOrderLineItemEntity.partNo,
      categoryName: goodsReceiptPurchaseOrderLineItemEntity.categoryName,
      itemCategoryId: goodsReceiptPurchaseOrderLineItemEntity.itemCategoryId,
      itemSectionId: goodsReceiptPurchaseOrderLineItemEntity.itemSectionId,
      sectionName: goodsReceiptPurchaseOrderLineItemEntity.sectionName,
      itemSubSectionId:
          goodsReceiptPurchaseOrderLineItemEntity.itemSubSectionId,
      subSectionName: goodsReceiptPurchaseOrderLineItemEntity.subSectionName,
      itemUom: goodsReceiptPurchaseOrderLineItemEntity.itemUom,
      isExportControl: goodsReceiptPurchaseOrderLineItemEntity.isExportControl,
      isIhm: goodsReceiptPurchaseOrderLineItemEntity.isIhm,
      isCritical: goodsReceiptPurchaseOrderLineItemEntity.isCritical,
      isImdg: goodsReceiptPurchaseOrderLineItemEntity.isImdg,
      vessel: goodsReceiptPurchaseOrderLineItemEntity.vessel,
      poDtId: goodsReceiptPurchaseOrderLineItemEntity.poDtId,
      slNo: goodsReceiptPurchaseOrderLineItemEntity.slNo,
      partNumber: goodsReceiptPurchaseOrderLineItemEntity.partNumber,
      packSize: goodsReceiptPurchaseOrderLineItemEntity.packSize,
      quantity: goodsReceiptPurchaseOrderLineItemEntity.quantity,
      rob: goodsReceiptPurchaseOrderLineItemEntity.rob,
      unitPrice: goodsReceiptPurchaseOrderLineItemEntity.unitPrice,
      contractPrice: goodsReceiptPurchaseOrderLineItemEntity.contractPrice,
      discountPercentage:
          goodsReceiptPurchaseOrderLineItemEntity.discountPercentage,
      discount: goodsReceiptPurchaseOrderLineItemEntity.discount,
      vatId: goodsReceiptPurchaseOrderLineItemEntity.vatId,
      vatPercentage: goodsReceiptPurchaseOrderLineItemEntity.vatPercentage,
      accountId: goodsReceiptPurchaseOrderLineItemEntity.accountId,
      accountCode: goodsReceiptPurchaseOrderLineItemEntity.accountCode,
      accountName: goodsReceiptPurchaseOrderLineItemEntity.accountName,
      subAccountId: goodsReceiptPurchaseOrderLineItemEntity.subAccountId,
      subAccountCode: goodsReceiptPurchaseOrderLineItemEntity.subAccountCode,
      subAccountName: goodsReceiptPurchaseOrderLineItemEntity.subAccountName,
      analysisCodeId: goodsReceiptPurchaseOrderLineItemEntity.analysisCodeId,
      analysisCode: goodsReceiptPurchaseOrderLineItemEntity.analysisCode,
      analysisName: goodsReceiptPurchaseOrderLineItemEntity.analysisName,
      leadDays: goodsReceiptPurchaseOrderLineItemEntity.leadDays,
      vendorDeliveryDate:
          goodsReceiptPurchaseOrderLineItemEntity.vendorDeliveryDate,
      remarksToVendor: goodsReceiptPurchaseOrderLineItemEntity.remarksToVendor,
      isSDoc: goodsReceiptPurchaseOrderLineItemEntity.isSDoc,
      entity: goodsReceiptPurchaseOrderLineItemEntity.entity,
      entityId: goodsReceiptPurchaseOrderLineItemEntity.entityId,
      poHdId: goodsReceiptPurchaseOrderLineItemEntity.poHdId,
      articleNumber: goodsReceiptPurchaseOrderLineItemEntity.articleNumber,
      packUom: goodsReceiptPurchaseOrderLineItemEntity.packUom,
      serviceDescription:
          goodsReceiptPurchaseOrderLineItemEntity.serviceDescription,
      equipmentName: goodsReceiptPurchaseOrderLineItemEntity.equipmentName,
      equipmentDescription:
          goodsReceiptPurchaseOrderLineItemEntity.equipmentDescription,
      equipmentModelNumber:
          goodsReceiptPurchaseOrderLineItemEntity.equipmentModelNumber,
      equipmentSerialNo:
          goodsReceiptPurchaseOrderLineItemEntity.equipmentSerialNo,
      equipmentManufacturer:
          goodsReceiptPurchaseOrderLineItemEntity.equipmentManufacturer,
      deliveryCode: goodsReceiptPurchaseOrderLineItemEntity.deliveryCode,
      deliveryTypeName:
          goodsReceiptPurchaseOrderLineItemEntity.deliveryTypeName,
      uniqueItemReference:
          goodsReceiptPurchaseOrderLineItemEntity.uniqueItemReference,
      isDeleted: goodsReceiptPurchaseOrderLineItemEntity.isDeleted,
      parentId: goodsReceiptPurchaseOrderLineItemEntity.parentId,
      imdgCode: goodsReceiptPurchaseOrderLineItemEntity.imdgCode,
      imdgName: goodsReceiptPurchaseOrderLineItemEntity.imdgName,
      exportControl: goodsReceiptPurchaseOrderLineItemEntity.exportControl,
      drawingNumber: goodsReceiptPurchaseOrderLineItemEntity.drawingNumber,
    );
  }

  static List<GoodsReceiptPurchaseItemDetailModel> fromEntityList(
    List<GoodsReceiptPurchaseOrderLineItemEntity>
    goodsReceiptDetailLabelEntityList,
  ) {
    List<GoodsReceiptPurchaseItemDetailModel> goodsReceiptLabelModelList = [];

    for (var entity in goodsReceiptDetailLabelEntityList) {
      goodsReceiptLabelModelList.add(
        GoodsReceiptPurchaseItemDetailModel.fromEntity(entity),
      );
    }

    return goodsReceiptLabelModelList;
  }

  @override
  bool? get stringify => true;

  Map<String, dynamic> toJsonForSaveApi() {
    return {
      "id": -1,
      "grnhdid": -1,
      "itemID": itemId,
      "itemVersionID": itemVersionId,
      "itemLinkID": itemLinkId,
      "parentItemID": parentItemId ?? 0,
      "parentItemVersionID": parentItemVersionId,
      "parentItemLinkID": parentItemLinkId,
      "receivedQty": receivedQty ?? 0,
      "convertedStockQty": convertedStockQty ?? 0,
      "newStock": newStock ?? 0,
      "damagedOrWrongSupply": damagedOrWrongSupply ?? 0,
      "reconditionedStock": reconditionedStock ?? 0,
      "expiryDate": '2025-09-25T00:00:00',
      "uomid": uomId,
      "qualityID": qualityId ?? 0,
      "batchNo": batchNo ?? '',
      "remarks": remarks ?? '',
      "versionIdentifier": 0,
      "orgID": 0,
      "operationType": "INS",
      "isIhm": isIhm,
      "bagTagLocationId": 123, ///ToDo///
      "isBagTagRequired": false, ///ToDo///,
      "isBagTagItem": false, ///ToDo///
      "podtid": poDtId,
      "defaultLocationId": null,///ToDo///
      "sortOrder": 1,///ToDo///
      "itemStatusCode": "CMP_VSL",///ToDo///
      "actualReceivedQty": 10,///ToDo///
      "conversionFactor": 1///ToDo///
    };
  }
}
