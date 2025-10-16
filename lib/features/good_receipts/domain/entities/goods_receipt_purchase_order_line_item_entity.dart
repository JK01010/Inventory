import 'package:equatable/equatable.dart';

class GoodsReceiptPurchaseOrderLineItemEntity extends Equatable {
  GoodsReceiptPurchaseOrderLineItemEntity({
    required this.poId,
    required this.poNo,
    required this.grnId,
    required this.grnNo,
    required this.itemId,
    required this.itemVersionId,
    required this.itemLinkId,
    required this.parentItemId,
    required this.parentItemVersionId,
    required this.parentItemLinkId,
    required this.receivedQty,
    required this.convertedStockQty,
    required this.newStock,
    required this.damagedOrWrongSupply,
    required this.reconditionedStock,
    required this.expiryDate,
    required this.uomId,
    required this.qualityId,
    required this.batchNo,
    required this.remarks,
    required this.isMd,
    required this.isSdoc,
    required this.zeroDeclaration,
    required this.ihmMaterialQty,
    required this.articleNo,
    required this.productName,
    required this.productDescription,
    required this.eccnNo,
    required this.hsCode,
    required this.countryName,
    required this.isAntiPiracy,
    required this.isPyroTechnics,
    required this.imdgClassId,
    required this.className,
    required this.partNo,
    required this.categoryName,
    required this.itemCategoryId,
    required this.itemSectionId,
    required this.sectionName,
    required this.itemSubSectionId,
    required this.subSectionName,
    required this.itemUom,
    required this.isExportControl,
    required this.isIhm,
    required this.isCritical,
    required this.isImdg,
    required this.vessel,
    this.isSelected = false,

    required this.poDtId,
    required this.slNo,
    required this.partNumber,
    required this.packSize,
    required this.quantity,
    required this.rob,
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
    required this.isSDoc,
    required this.entity,
    required this.entityId,
    required this.poHdId,
    required this.articleNumber,
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
    required this.parentId,
    required this.imdgCode,
    required this.imdgName,
    required this.exportControl,
    required this.drawingNumber,
  });

  int poId;
  String poNo;
  int grnId;
  String grnNo;
  int itemId;
  int itemVersionId;
  int itemLinkId;
  int parentItemId;
  int parentItemVersionId;
  int parentItemLinkId;
  double receivedQty;
  double convertedStockQty;
  double newStock;
  double damagedOrWrongSupply;
  double reconditionedStock;
  String expiryDate;
  int qualityId;
  String batchNo;
  String remarks;
  bool isMd;
  bool isSdoc;
  bool zeroDeclaration;
  double ihmMaterialQty;
  String articleNo;
  String eccnNo;
  String hsCode;
  String countryName;
  bool isAntiPiracy;
  bool isPyroTechnics;
  int imdgClassId;
  String className;
  String partNo;
  String categoryName;
  int itemCategoryId;
  int itemSectionId;
  String sectionName;
  int itemSubSectionId;
  String subSectionName;
  String itemUom;
  bool isExportControl;
  bool isIhm;
  bool isCritical;
  bool isImdg;
  String vessel;
  bool isSelected;
  int? poDtId;
  int? slNo;
  String? partNumber;
  String? productName;
  int? uomId;
  double? packSize;
  double quantity;
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
  double? leadDays;
  String? vendorDeliveryDate;
  String? remarksToVendor;
  bool? isSDoc;
  String? entity;
  int? entityId;
  int? poHdId;
  String? articleNumber;
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
  int? parentId;
  String? imdgCode;
  String? imdgName;
  String? exportControl;
  String? drawingNumber;

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
    qualityId,
    batchNo,
    remarks,
    isMd,
    isSdoc,
    zeroDeclaration,
    ihmMaterialQty,
    articleNo,
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
    isSelected,
    uomId,
    productDescription,
    productName,
  ];

  @override
  bool get stringify => true;

  @override
  String toString() =>
      'goodsReceiptPurchaseOrderLineItemEntity{poHdId: $poHdId,damagedOrWrongSupply : $damagedOrWrongSupply, receivedQty : $receivedQty, newStock : $newStock, reconditionedStock : $reconditionedStock,className :$className, quantity: $quantity, poDtId:$poDtId}';

  GoodsReceiptPurchaseOrderLineItemEntity copyWith({
    int? poId,
    String? poNo,
    int? grnId,
    String? grnNo,
    int? itemId,
    int? itemVersionId,
    int? itemLinkId,
    int? parentItemId,
    int? parentItemVersionId,
    int? parentItemLinkId,
    double? receivedQty,
    double? convertedStockQty,
    double? newStock,
    double? damagedOrWrongSupply,
    double? reconditionedStock,
    String? expiryDate,
    int? qualityId,
    String? batchNo,
    String? remarks,
    bool? isMd,
    bool? isSdoc,
    bool? zeroDeclaration,
    double? ihmMaterialQty,
    String? articleNo,
    String? eccnNo,
    String? hsCode,
    String? countryName,
    bool? isAntiPiracy,
    bool? isPyroTechnics,
    int? imdgClassId,
    String? className,
    String? partNo,
    String? categoryName,
    int? itemCategoryId,
    int? itemSectionId,
    String? sectionName,
    int? itemSubSectionId,
    String? subSectionName,
    String? itemUom,
    bool? isExportControl,
    bool? isIhm,
    bool? isCritical,
    bool? isImdg,
    String? vessel,
    bool? isSelected,
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
    double? leadDays,
    String? vendorDeliveryDate,
    String? remarksToVendor,
    bool? isSDoc,
    String? entity,
    int? entityId,
    int? poHdId,
    String? articleNumber,
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
    int? parentId,
    String? imdgCode,
    String? imdgName,
    String? exportControl,
    String? drawingNumber,
  }) {
    return GoodsReceiptPurchaseOrderLineItemEntity(
      poId: poId ?? this.poId,
      poNo: poNo ?? this.poNo,
      grnId: grnId ?? this.grnId,
      grnNo: grnNo ?? this.grnNo,
      itemId: itemId ?? this.itemId,
      itemVersionId: itemVersionId ?? this.itemVersionId,
      itemLinkId: itemLinkId ?? this.itemLinkId,
      parentItemId: parentItemId ?? this.parentItemId,
      parentItemVersionId: parentItemVersionId ?? this.parentItemVersionId,
      parentItemLinkId: parentItemLinkId ?? this.parentItemLinkId,
      receivedQty: receivedQty ?? this.receivedQty,
      convertedStockQty: convertedStockQty ?? this.convertedStockQty,
      newStock: newStock ?? this.newStock,
      damagedOrWrongSupply: damagedOrWrongSupply ?? this.damagedOrWrongSupply,
      reconditionedStock: reconditionedStock ?? this.reconditionedStock,
      expiryDate: expiryDate ?? this.expiryDate,
      qualityId: qualityId ?? this.qualityId,
      batchNo: batchNo ?? this.batchNo,
      remarks: remarks ?? this.remarks,
      isMd: isMd ?? this.isMd,
      isSdoc: isSdoc ?? this.isSdoc,
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration,
      ihmMaterialQty: ihmMaterialQty ?? this.ihmMaterialQty,
      articleNo: articleNo ?? this.articleNo,
      eccnNo: eccnNo ?? this.eccnNo,
      hsCode: hsCode ?? this.hsCode,
      countryName: countryName ?? this.countryName,
      isAntiPiracy: isAntiPiracy ?? this.isAntiPiracy,
      isPyroTechnics: isPyroTechnics ?? this.isPyroTechnics,
      imdgClassId: imdgClassId ?? this.imdgClassId,
      className: className ?? this.className,
      partNo: partNo ?? this.partNo,
      categoryName: categoryName ?? this.categoryName,
      itemCategoryId: itemCategoryId ?? this.itemCategoryId,
      itemSectionId: itemSectionId ?? this.itemSectionId,
      sectionName: sectionName ?? this.sectionName,
      itemSubSectionId: itemSubSectionId ?? this.itemSubSectionId,
      subSectionName: subSectionName ?? this.subSectionName,
      itemUom: itemUom ?? this.itemUom,
      isExportControl: isExportControl ?? this.isExportControl,
      isIhm: isIhm ?? this.isIhm,
      isCritical: isCritical ?? this.isCritical,
      isImdg: isImdg ?? this.isImdg,
      vessel: vessel ?? this.vessel,
      isSelected: isSelected ?? this.isSelected,
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
      isSDoc: isSDoc ?? this.isSDoc,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      poHdId: poHdId ?? this.poHdId,
      articleNumber: articleNumber ?? this.articleNumber,
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
      parentId: parentId ?? this.parentId,
      imdgCode: imdgCode ?? this.imdgCode,
      imdgName: imdgName ?? this.imdgName,
      exportControl: exportControl ?? this.exportControl,
      drawingNumber: drawingNumber ?? this.drawingNumber,
    );
  }
}
