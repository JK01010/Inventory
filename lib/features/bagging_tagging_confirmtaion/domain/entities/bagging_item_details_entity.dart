import 'package:equatable/equatable.dart';

class BaggingItemDetailsResponse {
  BaggingItemDetailsResponse({required this.baggingItemDetailsEntity});

  final List<BaggingItemDetailsEntity> baggingItemDetailsEntity;
}

class BaggingItemDetailsEntity extends Equatable {
  const BaggingItemDetailsEntity({
    required this.itemId,
    required this.roughItemId,
    required this.articleNo,
    required this.partNo,
    required this.productName,
    required this.plateDrawingNo,
    required this.uom,
    required this.packSize,
    required this.poQty,
    required this.unitPrize,
    required this.totalAcceptedQty,
    required this.returnQty,
    required this.imdgClass,
    required this.remarksFromVendor,
    required this.equipment,
    required this.itemCategory,
    required this.itemSection,
    required this.itemSubSection,
    required this.receivedQty,
    required this.damageWrongQty,
    required this.newStock,
    required this.reconditionStock,
    required this.quality,
    required this.expiryDate,
    required this.batchNo,
    required this.serialNo,
    required this.remarks,
    required this.defaultStorageLocation,
    this.attachment,
    required this.mdRequired,
    required this.sDocRequired,
    required this.zeroDeclaration,
    required this.iHMMaterialQty,
    this.iHMAttachment,
  });

  final int itemId;
  final int roughItemId;
  final String articleNo;
  final String partNo;
  final String productName;
  final String plateDrawingNo;
  final String uom;
  final int packSize;
  final int poQty;
  final int unitPrize;
  final int totalAcceptedQty;
  final int returnQty;
  final String imdgClass;
  final String remarksFromVendor;
  final String equipment;
  final String itemCategory;
  final String itemSection;
  final String itemSubSection;
  final int receivedQty;
  final int damageWrongQty;
  final int newStock;
  final int reconditionStock;
  final String quality;
  final String expiryDate;
  final String batchNo;
  final String serialNo;
  final String remarks;
  final String defaultStorageLocation;
  final String? attachment;
  final String mdRequired;
  final String sDocRequired;
  final String zeroDeclaration;
  final String iHMMaterialQty;
  final String? iHMAttachment;

  @override
  List<Object?> get props => [
    itemId,
    roughItemId,
    articleNo,
    partNo,
    productName,
    plateDrawingNo,
    uom,
    packSize,
    poQty,
    unitPrize,
    totalAcceptedQty,
    returnQty,
    imdgClass,
    remarksFromVendor,
    equipment,
    itemCategory,
    itemSection,
    itemSubSection,
    receivedQty,
    damageWrongQty,
    newStock,
    reconditionStock,
    quality,
    expiryDate,
    batchNo,
    serialNo,
    remarks,
    defaultStorageLocation,
    attachment,
    mdRequired,
    sDocRequired,
    zeroDeclaration,
    iHMMaterialQty,
    iHMAttachment
  ];
  bool? get stringify => true;
}
