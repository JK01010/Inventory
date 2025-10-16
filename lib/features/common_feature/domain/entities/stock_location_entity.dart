import 'package:equatable/equatable.dart';

class CommonStockLocationEntity extends Equatable {
  final int storageLocationID;
  final String storageLocation;
  final String storageLocationHierarchy;
  final int referenceID;
  final int referenceSubID;
  final int referenceTypeID;
  final int itemID;
  final int itemLinkID;
  final String? grnNo;
  final double totalROB;
  final double? receivedQty;
  final String? mDocReq;
  final String? sDocReq;
  final String? zeroDocReq;
  final int? ihmMaterialCount;
  final String? poAttachment;
  final String? ihmAttachment;
  final DateTime inventoryDate;
  final DateTime? expiryDate;
  final double unitPrice;
  final double newStock;
  final double reconditionedStock;

  const CommonStockLocationEntity({
    required this.storageLocationID,
    required this.storageLocation,
    required this.storageLocationHierarchy,
    required this.referenceID,
    required this.referenceSubID,
    required this.referenceTypeID,
    required this.itemID,
    required this.itemLinkID,
    this.grnNo,
    required this.totalROB,
    this.receivedQty,
    this.mDocReq,
    this.sDocReq,
    this.zeroDocReq,
    this.ihmMaterialCount,
    this.poAttachment,
    this.ihmAttachment,
    required this.inventoryDate,
    this.expiryDate,
    required this.unitPrice,
    required this.newStock,
    required this.reconditionedStock,
  });

  @override
  List<Object?> get props => [
    storageLocationID,
    storageLocation,
    storageLocationHierarchy,
    referenceID,
    referenceSubID,
    referenceTypeID,
    itemID,
    itemLinkID,
    grnNo,
    totalROB,
    receivedQty,
    mDocReq,
    sDocReq,
    zeroDocReq,
    ihmMaterialCount,
    poAttachment,
    ihmAttachment,
    inventoryDate,
    expiryDate,
    unitPrice,
    newStock,
    reconditionedStock,
  ];
}
