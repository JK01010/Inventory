import 'package:equatable/equatable.dart';

class TransactionItemDetailsEntity extends Equatable {
  const TransactionItemDetailsEntity({
    required this.poID,
    required this.poNo,
    required this.grnID,
    required this.grnNo,
    required this.itemID,
    required this.itemVersionID,
    required this.itemLinkID,
    required this.parentItemID,
    required this.parentItemVersionID,
    required this.parentItemLinkID,
    required this.receivedQty,
    required this.convertedStockQty,
    required this.newStock,
    required this.damagedOrwrongSupply,
    required this.reconditionedStock,
    required this.expiryDate,
    required this.uomid,
    required this.qualityID,
    required this.batchNo,
    required this.remarks,
    required this.isMD,
    required this.isSDOC,
    required this.zeroDeclaration,
    required this.iHMMaterialQty,
    required this.articleNo,
    required this.productName,
    required this.productDescription,
    required this.eccnNo,
    required this.hSCode,
    required this.countryName,
    required this.isAntiPiracy,
    required this.isPyroTechnics,
    required this.iMDGClassID,
    required this.className,
    required this.partNo,
    required this.categoryName,
    required this.itemCategoryID,
    required this.itemSectionID,
    required this.sectionName,
    required this.itemSubSectionID,
    required this.subSectionName,
    required this.itemUom,
    required this.isExportControl,
    required this.isIHM,
    required this.isCritical,
    required this.isIMDG,
    required this.vessel,
    required this.pOQuantity,
    required this.isBagTagItem,
    required this.drawingPositionNumber,
    required this.drawingNumber,
    required this.unitPrice,
    required this.equipmentID,
    required this.equipmentName,
    required this.pODTID,
  });

  final int poID;
  final String poNo;
  final int grnID;
  final String grnNo;
  final int itemID;
  final int itemVersionID;
  final int itemLinkID;
  final int parentItemID;
  final int parentItemVersionID;
  final int parentItemLinkID;
  final double receivedQty;
  final double convertedStockQty;
  final double newStock;
  final double damagedOrwrongSupply;
  final double reconditionedStock;
  final String expiryDate;
  final int uomid;
  final int qualityID;
  final String batchNo;
  final String remarks;
  final bool isMD;
  final bool isSDOC;
  final bool zeroDeclaration;
  final double iHMMaterialQty;
  final String articleNo;
  final String productName;
  final String productDescription;
  final String eccnNo;
  final String hSCode;
  final String countryName;
  final bool isAntiPiracy;
  final bool isPyroTechnics;
  final int iMDGClassID;
  final String className;
  final String partNo;
  final String categoryName;
  final int itemCategoryID;
  final int itemSectionID;
  final String sectionName;
  final int itemSubSectionID;
  final String subSectionName;
  final String itemUom;
  final bool isExportControl;
  final bool isIHM;
  final bool isCritical;
  final bool isIMDG;
  final String vessel;
  final double pOQuantity;
  final bool isBagTagItem;
  final String drawingPositionNumber;
  final String drawingNumber;
  final double unitPrice;
  final int equipmentID;
  final String equipmentName;
  final int pODTID;

  @override
  List<Object> get props => [
    poID,
    poNo,
    grnID,
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
