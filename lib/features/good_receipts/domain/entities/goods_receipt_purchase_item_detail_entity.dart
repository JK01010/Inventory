import 'package:equatable/equatable.dart';

class GoodsReceiptPurchaseItemDetailEntity extends Equatable {
  GoodsReceiptPurchaseItemDetailEntity({
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
    required this.poQuantity,
    required this.isBagTagItem,
    this.isSelected = false,
    required this.drawingPositionNumber,
    required this.drawingNumber,
    required this.unitPrice,
    required this.equipmentId,
    required this.equipmentName,
    required this.grnDtId,
     this.isConfirmed = false
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
  int uomId;
  int qualityId;
  String batchNo;
  String remarks;
  bool isMd;
  bool isSdoc;
  bool zeroDeclaration;
  double ihmMaterialQty;
  String articleNo;
  String productName;
  String productDescription;
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
  double poQuantity;
  bool isBagTagItem;
  bool isSelected;
String drawingPositionNumber;
String drawingNumber;
double unitPrice;
int equipmentId;
String equipmentName;
int grnDtId;
  bool isConfirmed;


  @override
  List<Object> get props => [
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
    isSelected,
    drawingPositionNumber,
    drawingNumber,
    unitPrice,
    equipmentId,
    equipmentName,
    grnDtId,
    isConfirmed
  ];

  @override
  bool get stringify => true;

  GoodsReceiptPurchaseItemDetailEntity copyWith({
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
    int? uomId,
    int? qualityId,
    String? batchNo,
    String? remarks,
    bool? isMd,
    bool? isSdoc,
    bool? zeroDeclaration,
    double? ihmMaterialQty,
    String? articleNo,
    String? productName,
    String? productDescription,
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
    double? poQuantity,
    bool? isBagTagItem,
    bool? isSelected,
    String? drawingPositionNumber,
    String? drawingNumber,
    double? unitPrice,
    int? equipmentId,
    String? equipmentName,
    int? grnDtId,
    bool? isConfirmed,
  }) {
    return GoodsReceiptPurchaseItemDetailEntity(
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
      uomId: uomId ?? this.uomId,
      qualityId: qualityId ?? this.qualityId,
      batchNo: batchNo ?? this.batchNo,
      remarks: remarks ?? this.remarks,
      isMd: isMd ?? this.isMd,
      isSdoc: isSdoc ?? this.isSdoc,
      zeroDeclaration: zeroDeclaration ?? this.zeroDeclaration,
      ihmMaterialQty: ihmMaterialQty ?? this.ihmMaterialQty,
      articleNo: articleNo ?? this.articleNo,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
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
      poQuantity: poQuantity ?? this.poQuantity,
      isBagTagItem: isBagTagItem ?? this.isBagTagItem,
      isSelected: isSelected ?? this.isSelected,
      drawingPositionNumber: drawingPositionNumber ?? this.drawingPositionNumber,
      drawingNumber: drawingNumber ?? this.drawingNumber,
      unitPrice: unitPrice ?? this.unitPrice,
      equipmentId: equipmentId ?? this.equipmentId,
      equipmentName: equipmentName ?? this.equipmentName,
      grnDtId: grnDtId ?? this.grnDtId,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}
