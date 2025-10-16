import 'package:equatable/equatable.dart';

import '../../domain/entities/goods_receipt_po_line_item_list_api_entity.dart';
import 'goods_receipt_entity_validation.dart';

class GoodsReceiptPoHeaderLineItemListApiResponseModel extends Equatable {
  const GoodsReceiptPoHeaderLineItemListApiResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory GoodsReceiptPoHeaderLineItemListApiResponseModel.fromJson(
    Map<String, dynamic> map,
  ) {
    return GoodsReceiptPoHeaderLineItemListApiResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<GoodsReceiptPoHeaderLineItemListApiModel>.from(
        (map['reportData'] as List).map(
          (x) => GoodsReceiptPoHeaderLineItemListApiModel.fromMap(
            x as Map<String, dynamic>,
          ),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String? moduleCode;
  final String? entityName;
  final int? recordCount;
  final List<GoodsReceiptPoHeaderLineItemListApiModel>? reportData;
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

class GoodsReceiptPoHeaderLineItemListApiModel extends Equatable {
  GoodsReceiptPoHeaderLineItemListApiModel({
    required this.poDtId,
    required this.slNo,
    required this.partNumber,
    required this.productName,
    required this.uomId,
    required this.packSize,
    required this.quantity,
    required this.rob,
    required this.productDescription,
    required this.unitPrice,
    required this.contractPrice,
    required this.discountPercentage,
    required this.discount,
    required this.vatId,
    required this.vatPercentage,
    required this.accountId,
    required this.accountCode,
    required this.accountName,
    required this.subAccountId,
    required this.subAccountCode,
    required this.subAccountName,
    required this.analysisCodeId,
    required this.analysisCode,
    required this.analysisName,
    required this.leadDays,
    required this.vendorDeliveryDate,
    required this.remarksToVendor,
    required this.isMd,
    required this.isSDoc,
    required this.zeroDeclaration,
    required this.ihmMaterialQty,
    required this.eccnNo,
    required this.hsCode,
    required this.countryName,
    required this.partNo,
    required this.categoryName,
    required this.itemCategoryId,
    required this.itemSectionId,
    required this.sectionName,
    required this.itemSubSectionId,
    required this.subSectionName,
    required this.vessel,
    required this.entity,
    required this.entityId,
    required this.poHdId,
    required this.itemId,
    required this.articleNumber,
    required this.itemUom,
    required this.packUom,
    required this.serviceDescription,
    required this.equipmentName,
    required this.equipmentDescription,
    required this.equipmentModelNumber,
    required this.equipmentSerialNo,
    required this.equipmentManufacturer,
    required this.deliveryCode,
    required this.deliveryTypeName,
    required this.uniqueItemReference,
    required this.isDeleted,
    required this.itemLinkId,
    required this.itemVersionId,
    required this.parentId,
    required this.parentItemLinkId,
    required this.parentItemVersionId,
    required this.imdgCode,
    required this.imdgName,
    required this.exportControl,
    required this.drawingNumber,
  });

  final int? poDtId;
  final int? slNo;
  final String? partNumber;
  final String? productName;
  final int? uomId;
  final double? packSize;
  final double? quantity;
  final int? rob;
  final String? productDescription;
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
  final int? leadDays;
  final String? vendorDeliveryDate;
  final String? remarksToVendor;
  final bool? isMd;
  final bool? isSDoc;
  final bool? zeroDeclaration;
  final double? ihmMaterialQty;
  final String? eccnNo;
  final String? hsCode;
  final String? countryName;
  final String? partNo;
  final String? categoryName;
  final int? itemCategoryId;
  final int? itemSectionId;
  final String? sectionName;
  final int? itemSubSectionId;
  final String? subSectionName;
  final String? vessel;
  final String? entity;
  final int? entityId;
  final int? poHdId;
  final int? itemId;
  final String? articleNumber;
  final String? itemUom;
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
  final int? itemLinkId;
  final int? itemVersionId;
  final int? parentId;
  final int? parentItemLinkId;
  final int? parentItemVersionId;
  final String? imdgCode;
  final String? imdgName;
  final String? exportControl;
  final String? drawingNumber;

  factory GoodsReceiptPoHeaderLineItemListApiModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return GoodsReceiptPoHeaderLineItemListApiModel(
      poDtId: json['PODTID'] as int?,
      slNo: json['SLNO'] as int?,
      partNumber: json['PartNumber'] as String?,
      productName: json['ProductName'] as String?,
      uomId: json['UOMID'] as int?,
      packSize: json['PackSize'] as double?,
      quantity: json['Quantity'] as double?,
      rob: json['ROB'] as int?,
      productDescription: json['ProductDescription'] as String?,
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
      subAccountName: json['SubAccountName'] as String?,
      analysisCodeId: json['AnalysisCodeID'] as int?,
      analysisCode: json['AnalysisCode'] as String?,
      analysisName: json['AnalysisName'] as String?,
      leadDays: json['LeadDays'] as int?,
      vendorDeliveryDate: json['VendorDeliveryDate'] as String?,
      remarksToVendor: json['RemarksToVendor'] as String?,
      isMd: json['IsMD'] as bool?,
      isSDoc: json['IsSDOC'] as bool?,
      zeroDeclaration: json['ZeroDeclaration'] as bool?,
      ihmMaterialQty: json['IHMMaterialQty'] as double?,
      eccnNo: json['EccnNo'] as String?,
      hsCode: json['HSCode'] as String?,
      countryName: json['CountryName'] as String?,
      partNo: json['PARTNO'] as String?,
      categoryName: json['CategoryName'] as String?,
      itemCategoryId: json['ItemCategoryID'] as int?,
      itemSectionId: json['ItemSectionID'] as int?,
      sectionName: json['SectionName'] as String?,
      itemSubSectionId: json['ItemSubSectionID'] as int?,
      subSectionName: json['SubSectionName'] as String?,
      vessel: json['Vessel'] as String?,
      entity: json['Entity'] as String?,
      entityId: json['EntityID'] as int?,
      poHdId: json['POHDID'] as int?,
      itemId: json['ItemId'] as int?,
      articleNumber: json['ArticleNumber'] as String?,
      itemUom: json['ItemUom'] as String?,
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
      itemLinkId: json['ItemLinkID'] as int?,
      itemVersionId: json['ItemVersionID'] as int?,
      parentId: json['ParentID'] as int?,
      parentItemLinkId: json['ParentItemLinkID'] as int?,
      parentItemVersionId: json['ParentItemVersionID'] as int?,
      imdgCode: json['IMDGCode'] as String?,
      imdgName: json['IMDGName'] as String?,
      exportControl: json['ExportControl'] as String?,
      drawingNumber: json['DrawingNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PODTID': poDtId,
      'SLNO': slNo,
      'PartNumber': partNumber,
      'ProductName': productName,
      'UOMID': uomId,
      'PackSize': packSize,
      'Quantity': quantity,
      'ROB': rob,
      'ProductDescription': productDescription,
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
      'IsMD': isMd,
      'IsSDOC': isSDoc,
      'ZeroDeclaration': zeroDeclaration,
      'IHMMaterialQty': ihmMaterialQty,
      'EccnNo': eccnNo,
      'HSCode': hsCode,
      'CountryName': countryName,
      'PARTNO': partNo,
      'CategoryName': categoryName,
      'ItemCategoryID': itemCategoryId,
      'ItemSectionID': itemSectionId,
      'SectionName': sectionName,
      'ItemSubSectionID': itemSubSectionId,
      'SubSectionName': subSectionName,
      'Vessel': vessel,
      'Entity': entity,
      'EntityID': entityId,
      'POHDID': poHdId,
      'ItemId': itemId,
      'ArticleNumber': articleNumber,
      'ItemUom': itemUom,
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
      'ItemLinkID': itemLinkId,
      'ItemVersionID': itemVersionId,
      'ParentID': parentId,
      'ParentItemLinkID': parentItemLinkId,
      'ParentItemVersionID': parentItemVersionId,
      'IMDGCode': imdgCode,
      'IMDGName': imdgName,
      'ExportControl': exportControl,
      'DrawingNumber': drawingNumber,
    };
  }

  GoodsReceiptPoLineItemListApiEntity toEntity() =>
      GoodsReceiptPoLineItemListApiEntity(
        poDtId: poDtId ?? 0,
        slNo: slNo ?? 0,
        partNumber: partNumber ?? '',
        productName: productName ?? '',
        uomId: uomId ?? 0,
        packSize: packSize ?? 0.0,
        quantity: quantity ?? 0.0,
        rob: rob ?? 0,
        productDescription: productDescription ?? '',
        unitPrice: unitPrice ?? 0.0,
        contractPrice: contractPrice ?? 0.0,
        discountPercentage: discountPercentage ?? 0.0,
        discount: discount ?? 0.0,
        vatId: vatId ?? 0,
        vatPercentage: vatPercentage ?? 0.0,
        accountId: accountId ?? 0,
        accountCode: accountCode ?? '',
        accountName: accountName ?? '',
        subAccountId: subAccountId ?? 0,
        subAccountCode: subAccountCode ?? '',
        subAccountName: subAccountName ?? '',
        analysisCodeId: analysisCodeId ?? 0,
        analysisCode: analysisCode ?? '',
        analysisName: analysisName ?? '',
        vendorDeliveryDate: vendorDeliveryDate ?? '',
        remarksToVendor: remarksToVendor ?? '',
        isMd: isMd ?? false,
        isSDoc: isSDoc ?? false,
        zeroDeclaration: zeroDeclaration ?? false,
        ihmMaterialQty: ihmMaterialQty ?? 0.0,
        countryName: countryName ?? '',
        partNo: partNo ?? '',
        categoryName: categoryName ?? '',
        itemCategoryId: itemCategoryId ?? 0,
        itemSectionId: itemSectionId ?? 0,
        sectionName: sectionName ?? '',
        vessel: vessel ?? '',
        entity: entity ?? '',
        entityId: entityId ?? 0,
        poHdId: poHdId ?? 0,
        itemId: itemId ?? 0,
        articleNumber: articleNumber ?? '',
        itemUom: itemUom ?? '',
        serviceDescription: serviceDescription ?? '',
        uniqueItemReference: uniqueItemReference ?? '',
        isDeleted: isDeleted ?? false,
        itemLinkId: itemLinkId ?? 0,
        itemVersionId: itemVersionId ?? 0,
        parentId: parentId ?? 0,
        parentItemLinkId: parentItemLinkId ?? 0,
        parentItemVersionId: parentItemVersionId ?? 0,
        exportControl: exportControl ?? '',
        leadDays: leadDays ?? 0,
        eccnNo: eccnNo ?? '',
        hsCode: hsCode ?? '',
        itemSubSectionId: itemSubSectionId ?? 0,
        subSectionName: subAccountName ?? '',
        packUom: packUom ?? '',
        equipmentName: equipmentName ?? '',
        equipmentDescription: equipmentDescription ?? '',
        equipmentModelNumber: equipmentModelNumber ?? '',
        equipmentSerialNo: equipmentSerialNo ?? '',
        equipmentManufacturer: equipmentManufacturer ?? '',
        deliveryCode: deliveryCode ?? '',
        deliveryTypeName: deliveryTypeName ?? '',
        imdgCode: imdgCode ?? '',
        imdgName: imdgName ?? '',
        drawingNumber: drawingNumber ?? '',
      );

  factory GoodsReceiptPoHeaderLineItemListApiModel.fromEntity(
    GoodsReceiptPoLineItemListApiEntity goodsReceiptPoLineItemListApiEntity,
  ) {
    return GoodsReceiptPoHeaderLineItemListApiModel(
      poDtId: goodsReceiptPoLineItemListApiEntity.poDtId,
      slNo: goodsReceiptPoLineItemListApiEntity.slNo,
      partNumber: goodsReceiptPoLineItemListApiEntity.partNumber,
      productName: goodsReceiptPoLineItemListApiEntity.productName,
      uomId: goodsReceiptPoLineItemListApiEntity.uomId,
      packSize: goodsReceiptPoLineItemListApiEntity.packSize,
      quantity: goodsReceiptPoLineItemListApiEntity.quantity,
      rob: goodsReceiptPoLineItemListApiEntity.rob,
      productDescription:
          goodsReceiptPoLineItemListApiEntity.productDescription,
      unitPrice: goodsReceiptPoLineItemListApiEntity.unitPrice,
      contractPrice: goodsReceiptPoLineItemListApiEntity.contractPrice,
      discountPercentage:
          goodsReceiptPoLineItemListApiEntity.discountPercentage,
      discount: goodsReceiptPoLineItemListApiEntity.discount,
      vatId: goodsReceiptPoLineItemListApiEntity.vatId,
      vatPercentage: goodsReceiptPoLineItemListApiEntity.vatPercentage,
      accountId: goodsReceiptPoLineItemListApiEntity.accountId,
      accountCode: goodsReceiptPoLineItemListApiEntity.accountCode,
      accountName: goodsReceiptPoLineItemListApiEntity.accountName,
      subAccountId: goodsReceiptPoLineItemListApiEntity.subAccountId,
      subAccountCode: goodsReceiptPoLineItemListApiEntity.subAccountCode,
      subAccountName: goodsReceiptPoLineItemListApiEntity.subAccountName,
      analysisCodeId: goodsReceiptPoLineItemListApiEntity.analysisCodeId,
      analysisCode: goodsReceiptPoLineItemListApiEntity.analysisCode,
      analysisName: goodsReceiptPoLineItemListApiEntity.analysisName,
      leadDays: goodsReceiptPoLineItemListApiEntity.leadDays,
      vendorDeliveryDate:
          goodsReceiptPoLineItemListApiEntity.vendorDeliveryDate,
      remarksToVendor: goodsReceiptPoLineItemListApiEntity.remarksToVendor,
      isMd: goodsReceiptPoLineItemListApiEntity.isMd,
      isSDoc: goodsReceiptPoLineItemListApiEntity.isSDoc,
      zeroDeclaration: goodsReceiptPoLineItemListApiEntity.zeroDeclaration,
      ihmMaterialQty: goodsReceiptPoLineItemListApiEntity.ihmMaterialQty,
      eccnNo: goodsReceiptPoLineItemListApiEntity.eccnNo,
      hsCode: goodsReceiptPoLineItemListApiEntity.hsCode,
      countryName: goodsReceiptPoLineItemListApiEntity.countryName,
      partNo: goodsReceiptPoLineItemListApiEntity.partNo,
      categoryName: goodsReceiptPoLineItemListApiEntity.categoryName,
      itemCategoryId: goodsReceiptPoLineItemListApiEntity.itemCategoryId,
      itemSectionId: goodsReceiptPoLineItemListApiEntity.itemSectionId,
      sectionName: goodsReceiptPoLineItemListApiEntity.sectionName,
      itemSubSectionId: goodsReceiptPoLineItemListApiEntity.itemSubSectionId,
      subSectionName: goodsReceiptPoLineItemListApiEntity.subSectionName,
      vessel: goodsReceiptPoLineItemListApiEntity.vessel,
      entity: goodsReceiptPoLineItemListApiEntity.entity,
      entityId: goodsReceiptPoLineItemListApiEntity.entityId,
      poHdId: goodsReceiptPoLineItemListApiEntity.poHdId,
      itemId: goodsReceiptPoLineItemListApiEntity.itemId,
      articleNumber: goodsReceiptPoLineItemListApiEntity.articleNumber,
      itemUom: goodsReceiptPoLineItemListApiEntity.itemUom,
      packUom: goodsReceiptPoLineItemListApiEntity.packUom,
      serviceDescription:
          goodsReceiptPoLineItemListApiEntity.serviceDescription,
      equipmentName: goodsReceiptPoLineItemListApiEntity.equipmentName,
      equipmentDescription:
          goodsReceiptPoLineItemListApiEntity.equipmentDescription,
      equipmentModelNumber:
          goodsReceiptPoLineItemListApiEntity.equipmentModelNumber,
      equipmentSerialNo: goodsReceiptPoLineItemListApiEntity.equipmentSerialNo,
      equipmentManufacturer:
          goodsReceiptPoLineItemListApiEntity.equipmentManufacturer,
      deliveryCode: goodsReceiptPoLineItemListApiEntity.deliveryCode,
      deliveryTypeName: goodsReceiptPoLineItemListApiEntity.deliveryTypeName,
      uniqueItemReference:
          goodsReceiptPoLineItemListApiEntity.uniqueItemReference,
      isDeleted: goodsReceiptPoLineItemListApiEntity.isDeleted,
      itemLinkId: goodsReceiptPoLineItemListApiEntity.itemLinkId,
      itemVersionId: goodsReceiptPoLineItemListApiEntity.itemVersionId,
      parentId: goodsReceiptPoLineItemListApiEntity.parentId,
      parentItemLinkId: goodsReceiptPoLineItemListApiEntity.parentItemLinkId,
      parentItemVersionId:
          goodsReceiptPoLineItemListApiEntity.parentItemVersionId,
      imdgCode: goodsReceiptPoLineItemListApiEntity.imdgCode,
      imdgName: goodsReceiptPoLineItemListApiEntity.imdgName,
      exportControl: goodsReceiptPoLineItemListApiEntity.exportControl,
      drawingNumber: goodsReceiptPoLineItemListApiEntity.drawingNumber,
    );
  }

  static List<GoodsReceiptPoHeaderLineItemListApiModel> fromEntityList(
    List<GoodsReceiptPoLineItemListApiEntity> goodsReceiptDetailLabelEntityList,
  ) {
    List<GoodsReceiptPoHeaderLineItemListApiModel> goodsReceiptLabelModelList =
        [];
    for (var entity in goodsReceiptDetailLabelEntityList) {
      goodsReceiptLabelModelList.add(
        GoodsReceiptPoHeaderLineItemListApiModel.fromEntity(entity),
      );
    }
    return goodsReceiptLabelModelList;
  }

  Map<String, dynamic> toMap() {
    return {
      'PODTID': poDtId,
      'SLNO': slNo,
      'PartNumber': partNumber,
      'ProductName': productName,
      'UOMID': uomId,
      'PackSize': packSize,
      'Quantity': quantity,
      'ROB': rob,
      'ProductDescription': productDescription,
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
      'IsMD': isMd,
      'IsSDOC': isSDoc,
      'ZeroDeclaration': zeroDeclaration,
      'IHMMaterialQty': ihmMaterialQty,
      'EccnNo': eccnNo,
      'HSCode': hsCode,
      'CountryName': countryName,
      'PARTNO': partNo,
      'CategoryName': categoryName,
      'ItemCategoryID': itemCategoryId,
      'ItemSectionID': itemSectionId,
      'SectionName': sectionName,
      'ItemSubSectionID': itemSubSectionId,
      'SubSectionName': subSectionName,
      'Vessel': vessel,
      'Entity': entity,
      'EntityID': entityId,
      'POHDID': poHdId,
      'ItemId': itemId,
      'ArticleNumber': articleNumber,
      'ItemUom': itemUom,
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
      'ItemLinkID': itemLinkId,
      'ItemVersionID': itemVersionId,
      'ParentID': parentId,
      'ParentItemLinkID': parentItemLinkId,
      'ParentItemVersionID': parentItemVersionId,
      'IMDGCode': imdgCode,
      'IMDGName': imdgName,
      'ExportControl': exportControl,
      'DrawingNumber': drawingNumber,
    };
  }

  @override
  List<Object?> get props => [
    poDtId,
    slNo,
    partNumber,
    productName,
    uomId,
    packSize,
    quantity,
    rob,
    productDescription,
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
    isMd,
    isSDoc,
    zeroDeclaration,
    ihmMaterialQty,
    eccnNo,
    hsCode,
    countryName,
    partNo,
    categoryName,
    itemCategoryId,
    itemSectionId,
    sectionName,
    itemSubSectionId,
    subSectionName,
    vessel,
    entity,
    entityId,
    poHdId,
    itemId,
    articleNumber,
    itemUom,
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
    itemLinkId,
    itemVersionId,
    parentId,
    parentItemLinkId,
    parentItemVersionId,
    imdgCode,
    imdgName,
    exportControl,
    drawingNumber,
  ];

  @override
  bool? get stringify => true;
}
