import 'package:equatable/equatable.dart';

class GoodsReceiptPoLineItemListApiEntity extends Equatable {
  GoodsReceiptPoLineItemListApiEntity({
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

  int? poDtId;
  int? slNo;
  String? partNumber;
  String? productName;
  int? uomId;
  double? packSize;
  double? quantity;
  int? rob;
  String? productDescription;
  double? unitPrice;
  double? contractPrice;
  double? discountPercentage;
  double? discount;
  int? vatId;
  double? vatPercentage;
  int? accountId;
  String? accountCode;
  String? accountName;
  int? subAccountId;
  String? subAccountCode;
  String? subAccountName;
  int? analysisCodeId;
  String? analysisCode;
  String? analysisName;
  int? leadDays;
  String? vendorDeliveryDate;
  String? remarksToVendor;
  bool? isMd;
  bool? isSDoc;
  bool? zeroDeclaration;
  double? ihmMaterialQty;
  String? eccnNo;
  String? hsCode;
  String? countryName;
  String? partNo;
  String? categoryName;
  int? itemCategoryId;
  int? itemSectionId;
  String? sectionName;
  int? itemSubSectionId;
  String? subSectionName;
  String? vessel;
  String? entity;
  int? entityId;
  int? poHdId;
  int? itemId;
  String? articleNumber;
  String? itemUom;
  String? packUom;
  String? serviceDescription;
  String? equipmentName;
  String? equipmentDescription;
  String? equipmentModelNumber;
  String? equipmentSerialNo;
  String? equipmentManufacturer;
  String? deliveryCode;
  String? deliveryTypeName;
  String? uniqueItemReference;
  bool? isDeleted;
  int? itemLinkId;
  int? itemVersionId;
  int? parentId;
  int? parentItemLinkId;
  int? parentItemVersionId;
  String? imdgCode;
  String? imdgName;
  String? exportControl;
  String? drawingNumber;

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

  GoodsReceiptPoLineItemListApiEntity copyWith({
    int? poDtId,
    int? slNo,
    String? partNumber,
    String? productName,
    int? uomId,
    double? packSize,
    double? quantity,
    int? rob,
    String? productDescription,
    double? unitPrice,
    double? contractPrice,
    double? discountPercentage,
    double? discount,
    int? vatId,
    double? vatPercentage,
    int? accountId,
    String? accountCode,
    String? accountName,
    int? subAccountId,
    String? subAccountCode,
    String? subAccountName,
    int? analysisCodeId,
    String? analysisCode,
    String? analysisName,
    int? leadDays,
    String? vendorDeliveryDate,
    String? remarksToVendor,
    bool? isMd,
    bool? isSDoc,
    bool? zeroDeclaration,
    double? ihmMaterialQty,
    String? eccnNo,
    String? hsCode,
    String? countryName,
    String? partNo,
    String? categoryName,
    int? itemCategoryId,
    int? itemSectionId,
    String? sectionName,
    int? itemSubSectionId,
    String? subSectionName,
    String? vessel,
    String? entity,
    int? entityId,
    int? poHdId,
    int? itemId,
    String? articleNumber,
    String? itemUom,
    String? packUom,
    String? serviceDescription,
    String? equipmentName,
    String? equipmentDescription,
    String? equipmentModelNumber,
    String? equipmentSerialNo,
    String? equipmentManufacturer,
    String? deliveryCode,
    String? deliveryTypeName,
    String? uniqueItemReference,
    bool? isDeleted,
    int? itemLinkId,
    int? itemVersionId,
    int? parentId,
    int? parentItemLinkId,
    int? parentItemVersionId,
    String? imdgCode,
    String? imdgName,
    String? exportControl,
    String? drawingNumber,
  }) {
    return GoodsReceiptPoLineItemListApiEntity(
      poDtId: poDtId ?? this.poDtId,
      slNo: slNo ?? this.slNo,
      partNumber: partNumber ?? this.partNumber,
      productName: productName ?? this.productName,
      uomId: uomId ?? this.uomId,
      packSize: packSize ?? this.packSize,
      quantity: quantity ?? this.quantity,
      rob: rob ?? this.rob,
      productDescription: productDescription ?? this.productDescription,
      unitPrice: unitPrice ?? this.unitPrice,
      contractPrice: contractPrice ?? this.contractPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discount: discount ?? this.discount,
      vatId: vatId ?? this.vatId,
      vatPercentage: vatPercentage ?? this.vatPercentage,
      accountId: accountId ?? this.accountId,
      accountCode: accountCode ?? this.accountCode,
      accountName: accountName ?? this.accountName,
      subAccountId: subAccountId ?? this.subAccountId,
      subAccountCode: subAccountCode ?? this.subAccountCode,
      subAccountName: subAccountName ?? this.subAccountName,
      analysisCodeId: analysisCodeId ?? this.analysisCodeId,
      analysisCode: analysisCode ?? this.analysisCode,
      analysisName: analysisName ?? this.analysisName,
      leadDays: leadDays ?? this.leadDays,
      vendorDeliveryDate: vendorDeliveryDate ?? this.vendorDeliveryDate,
      remarksToVendor: remarksToVendor ?? this.remarksToVendor,
      isMd: isMd ?? this.isMd,
      isSDoc: isSDoc ?? this.isSDoc,
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration,
      ihmMaterialQty: ihmMaterialQty ?? this.ihmMaterialQty,
      eccnNo: eccnNo ?? this.eccnNo,
      hsCode: hsCode ?? this.hsCode,
      countryName: countryName ?? this.countryName,
      partNo: partNo ?? this.partNo,
      categoryName: categoryName ?? this.categoryName,
      itemCategoryId: itemCategoryId ?? this.itemCategoryId,
      itemSectionId: itemSectionId ?? this.itemSectionId,
      sectionName: sectionName ?? this.sectionName,
      itemSubSectionId: itemSubSectionId ?? this.itemSubSectionId,
      subSectionName: subSectionName ?? this.subSectionName,
      vessel: vessel ?? this.vessel,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      poHdId: poHdId ?? this.poHdId,
      itemId: itemId ?? this.itemId,
      articleNumber: articleNumber ?? this.articleNumber,
      itemUom: itemUom ?? this.itemUom,
      packUom: packUom ?? this.packUom,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      equipmentName: equipmentName ?? this.equipmentName,
      equipmentDescription: equipmentDescription ?? this.equipmentDescription,
      equipmentModelNumber: equipmentModelNumber ?? this.equipmentModelNumber,
      equipmentSerialNo: equipmentSerialNo ?? this.equipmentSerialNo,
      equipmentManufacturer:
          equipmentManufacturer ?? this.equipmentManufacturer,
      deliveryCode: deliveryCode ?? this.deliveryCode,
      deliveryTypeName: deliveryTypeName ?? this.deliveryTypeName,
      uniqueItemReference: uniqueItemReference ?? this.uniqueItemReference,
      isDeleted: isDeleted ?? this.isDeleted,
      itemLinkId: itemLinkId ?? this.itemLinkId,
      itemVersionId: itemVersionId ?? this.itemVersionId,
      parentId: parentId ?? this.parentId,
      parentItemLinkId: parentItemLinkId ?? this.parentItemLinkId,
      parentItemVersionId: parentItemVersionId ?? this.parentItemVersionId,
      imdgCode: imdgCode ?? this.imdgCode,
      imdgName: imdgName ?? this.imdgName,
      exportControl: exportControl ?? this.exportControl,
      drawingNumber: drawingNumber ?? this.drawingNumber,
    );
  }
}
