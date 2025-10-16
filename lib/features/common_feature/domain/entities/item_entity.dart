import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  const ItemEntity({
    required this.poHdId,
    required this.grnId,
    required this.poDtId,
    required this.grnDtId,
    required this.itemId,
    required this.itemLinkId,
    required this.articleNumber,
    required this.partNumber,
    required this.productName,
    required this.drawingNumber,
    required this.uom,
    required this.packSize,
    required this.poQuantity,
    required this.unitPrice,
    required this.totalAcceptedQuantity,
    required this.returnQuantity,
    required this.imdgClass,
    required this.remarksFromVendor,
    required this.equipment,
    required this.itemCategory,
    required this.itemSection,
    required this.itemSubSection,
    required this.serialNumber,
    required this.damagedQuantity,
    required this.newStockQuantity,
    required this.reconditionedStock,
    required this.quality,
    required this.expiryDate,
    required this.batchNumber,
    required this.remarks,
    required this.defaultStorageLocation,
    required this.receivedQuantity,
    required this.qualityId,
    required this.isMd,
    required this.isSDoc,
    required this.zeroDeclaration,
    required this.ihmMaterialQty,
    required this.rob,
    required this.itemVersionId,
    required this.parentItemId,
    required this.parentItemVersionId,
    required this.parentItemLinkId,
    required this.uomId,
    required this.productDescription,
    required this.eccnNo,
    required this.hsCode,
    required this.countryName,
    required this.isAntiPiracy,
    required this.isPyroTechnics,
    required this.imdgClassId,
    required this.itemCategoryId,
    required this.itemSectionId,
    required this.itemSubSectionId,
    required this.itemUom,
    required this.isExportControl,
    required this.isIhm,
    required this.isCritical,
    required this.isImdg,
    required this.vessel,
    required this.isBagTagItem,
    required this.drawingPositionNumber,
    required this.equipmentId,
  });

  factory ItemEntity.initial() {
    return ItemEntity(
      drawingNumber: '',
      equipment: '',
      expiryDate: '',
      grnDtId: -1,
      grnId: -1,
      imdgClass: '',
      itemCategory: '',
      itemLinkId: -1,
      itemSection: '',
      itemSubSection: '',
      itemId: -1,
      newStockQuantity: -1,
      partNumber: '',
      poDtId: -1,
      poHdId: -1,
      poQuantity: -1,
      packSize: -1,
      productName: '',
      quality: '',
      remarks: '',
      remarksFromVendor: '',
      reconditionedStock: -1,
      returnQuantity: -1,
      serialNumber: -1,
      articleNumber: '',
      batchNumber: '',
      defaultStorageLocation: '',
      uom: '',
      totalAcceptedQuantity: -1,
      unitPrice: -1,
      damagedQuantity: -1,
      receivedQuantity: -1,
      qualityId: -1,
      isMd: false,
      isSDoc: false,
      zeroDeclaration: false,
      ihmMaterialQty: -1,
      rob: -1,
      itemVersionId: -1,
      parentItemId: -1,
      parentItemVersionId: -1,
      parentItemLinkId: -1,
      uomId: -1,
      productDescription: '',
      eccnNo: '',
      hsCode: '',
      countryName: '',
      isAntiPiracy: false,
      isPyroTechnics: false,
      imdgClassId: -1,
      itemCategoryId: -1,
      itemSectionId: -1,
      itemSubSectionId: -1,
      itemUom: '',
      isExportControl: false,
      isIhm: false,
      isCritical: false,
      isImdg: false,
      vessel: '',
      isBagTagItem: false,
      drawingPositionNumber: '',
      equipmentId: -1,
    );
  }

  final int poHdId;
  final int grnId;
  final int poDtId;
  final int grnDtId;
  final int itemId;
  final int itemLinkId;
  final String articleNumber;
  final String partNumber;
  final String productName;
  final String drawingNumber;
  final String uom;
  final double packSize;
  final double poQuantity;
  final double unitPrice;
  final double totalAcceptedQuantity;
  final double returnQuantity;
  final String imdgClass;
  final String remarksFromVendor;
  final String equipment;
  final String itemCategory;
  final String itemSection;
  final String itemSubSection;
  final int serialNumber;
  final double damagedQuantity;
  final double newStockQuantity;
  final double reconditionedStock;
  final String quality;
  final String expiryDate;
  final String batchNumber;
  final String remarks;
  final String defaultStorageLocation;
  final double receivedQuantity;
  final int qualityId;
  final bool isMd;
  final bool isSDoc;
  final bool zeroDeclaration;
  final double ihmMaterialQty;
  final int rob;
  final int itemVersionId;
  final int parentItemId;
  final int parentItemVersionId;
  final int parentItemLinkId;
  final int uomId;
  final String productDescription;
  final String eccnNo;
  final String hsCode;
  final String countryName;
  final bool isAntiPiracy;
  final bool isPyroTechnics;
  final int imdgClassId;
  final int itemCategoryId;
  final int itemSectionId;
  final int itemSubSectionId;
  final String itemUom;
  final bool isExportControl;
  final bool isIhm;
  final bool isCritical;
  final bool isImdg;
  final String vessel;
  final bool isBagTagItem;
  final String drawingPositionNumber;
  final int equipmentId;

  @override
  List<Object?> get props => [
    poHdId,
    grnId,
    poDtId,
    grnDtId,
    itemId,
    itemLinkId,
    articleNumber,
    partNumber,
    productName,
    drawingNumber,
    uom,
    packSize,
    poQuantity,
    unitPrice,
    totalAcceptedQuantity,
    returnQuantity,
    imdgClass,
    remarksFromVendor,
    equipment,
    itemCategory,
    itemSection,
    itemSubSection,
    serialNumber,
    damagedQuantity,
    newStockQuantity,
    reconditionedStock,
    quality,
    expiryDate,
    batchNumber,
    remarks,
    defaultStorageLocation,
    receivedQuantity,
    qualityId,
    isMd,
    isSDoc,
    zeroDeclaration,
    ihmMaterialQty,
    rob,
    itemVersionId,
    parentItemId,
    parentItemVersionId,
    parentItemLinkId,
    uomId,
    productDescription,
    eccnNo,
    hsCode,
    countryName,
    isAntiPiracy,
    isPyroTechnics,
    imdgClassId,
    itemCategoryId,
    itemSectionId,
    itemSubSectionId,
    itemUom,
    isExportControl,
    isIhm,
    isCritical,
    isImdg,
    vessel,
    isBagTagItem,
    drawingPositionNumber,
    equipmentId,
  ];

  ItemEntity copyWith({
    int? poHdId,
    int? grnId,
    int? poDtId,
    int? grnDtId,
    int? itemId,
    int? itemLinkId,
    String? articleNumber,
    String? partNumber,
    String? productName,
    String? drawingNumber,
    String? uom,
    double? packSize,
    double? poQuantity,
    double? unitPrice,
    double? totalAcceptedQuantity,
    double? returnQuantity,
    String? imdgClass,
    String? remarksFromVendor,
    String? equipment,
    String? itemCategory,
    String? itemSection,
    String? itemSubSection,
    int? serialNumber,
    double? damagedQuantity,
    double? newStockQuantity,
    double? reconditionedStock,
    String? quality,
    String? expiryDate,
    String? batchNumber,
    String? remarks,
    String? defaultStorageLocation,
    double? receivedQuantity,
    int? qualityId,
    bool? isMd,
    bool? isSDoc,
    bool? zeroDeclaration,
    double? ihmMaterialQty,
    int? rob,
    int? itemVersionId,
    int? parentItemId,
    int? parentItemVersionId,
    int? parentItemLinkId,
    int? uomId,
    String? productDescription,
    String? eccnNo,
    String? hsCode,
    String? countryName,
    bool? isAntiPiracy,
    bool? isPyroTechnics,
    int? imdgClassId,
    int? itemCategoryId,
    int? itemSectionId,
    int? itemSubSectionId,
    String? itemUom,
    bool? isExportControl,
    bool? isIhm,
    bool? isCritical,
    bool? isImdg,
    String? vessel,
    bool? isBagTagItem,
    String? drawingPositionNumber,
    int? equipmentId,
  }) {
    return ItemEntity(
      poHdId: poHdId ?? this.poHdId,
      grnId: grnId ?? this.grnId,
      poDtId: poDtId ?? this.poDtId,
      grnDtId: grnDtId ?? this.grnDtId,
      itemId: itemId ?? this.itemId,
      itemLinkId: itemLinkId ?? this.itemLinkId,
      articleNumber: articleNumber ?? this.articleNumber,
      partNumber: partNumber ?? this.partNumber,
      productName: productName ?? this.productName,
      drawingNumber: drawingNumber ?? this.drawingNumber,
      uom: uom ?? this.uom,
      packSize: packSize ?? this.packSize,
      poQuantity: poQuantity ?? this.poQuantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalAcceptedQuantity:
          totalAcceptedQuantity ?? this.totalAcceptedQuantity,
      returnQuantity: returnQuantity ?? this.returnQuantity,
      imdgClass: imdgClass ?? this.imdgClass,
      remarksFromVendor: remarksFromVendor ?? this.remarksFromVendor,
      equipment: equipment ?? this.equipment,
      itemCategory: itemCategory ?? this.itemCategory,
      itemSection: itemSection ?? this.itemSection,
      itemSubSection: itemSubSection ?? this.itemSubSection,
      serialNumber: serialNumber ?? this.serialNumber,
      damagedQuantity: damagedQuantity ?? this.damagedQuantity,
      newStockQuantity: newStockQuantity ?? this.newStockQuantity,
      reconditionedStock: reconditionedStock ?? this.reconditionedStock,
      quality: quality ?? this.quality,
      expiryDate: expiryDate ?? this.expiryDate,
      batchNumber: batchNumber ?? this.batchNumber,
      remarks: remarks ?? this.remarks,
      defaultStorageLocation:
          defaultStorageLocation ?? this.defaultStorageLocation,
      receivedQuantity: receivedQuantity ?? this.receivedQuantity,
      qualityId: qualityId ?? this.qualityId,
      isMd: isMd ?? this.isMd,
      isSDoc: isSDoc ?? this.isSDoc,
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration,
      ihmMaterialQty: ihmMaterialQty ?? this.ihmMaterialQty,
      rob: rob ?? this.rob,
      itemVersionId: itemVersionId ?? this.itemVersionId,
      parentItemId: parentItemId ?? this.parentItemId,
      parentItemVersionId: parentItemVersionId ?? this.parentItemVersionId,
      parentItemLinkId: parentItemLinkId ?? this.parentItemLinkId,
      uomId: uomId ?? this.uomId,
      productDescription: productDescription ?? this.productDescription,
      eccnNo: eccnNo ?? this.eccnNo,
      hsCode: hsCode ?? this.hsCode,
      countryName: countryName ?? this.countryName,
      isAntiPiracy: isAntiPiracy ?? this.isAntiPiracy,
      isPyroTechnics: isPyroTechnics ?? this.isPyroTechnics,
      imdgClassId: imdgClassId ?? this.imdgClassId,
      itemCategoryId: itemCategoryId ?? this.itemCategoryId,
      itemSectionId: itemSectionId ?? this.itemSectionId,
      itemSubSectionId: itemSubSectionId ?? this.itemSubSectionId,
      itemUom: itemUom ?? this.itemUom,
      isExportControl: isExportControl ?? this.isExportControl,
      isIhm: isIhm ?? this.isIhm,
      isCritical: isCritical ?? this.isCritical,
      isImdg: isImdg ?? this.isImdg,
      vessel: vessel ?? this.vessel,
      isBagTagItem: isBagTagItem ?? this.isBagTagItem,
      drawingPositionNumber:
          drawingPositionNumber ?? this.drawingPositionNumber,
      equipmentId: equipmentId ?? this.equipmentId,
    );
  }
}
