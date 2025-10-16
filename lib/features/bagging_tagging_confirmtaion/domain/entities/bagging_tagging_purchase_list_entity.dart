import 'package:equatable/equatable.dart';

class BaggingTaggingPurchaseEntity extends Equatable {
  final int id;
  final int itemId;
  final int poHdId;
  final int receivedQty;
  final String remark;
  final int qualityId;
  final String flag;
  final String tags;
  final int imdgClassId;
  final String unitPrice;
  final String packetSize;
  final int poQty;
  final String remarksFromVendor;
  final int reconditionedQty;
  final int damagedQty;
  final int newQty;
  final String batchName;
  final String expiryDate;

  const BaggingTaggingPurchaseEntity({
    required this.id,
    required this.itemId,
    required this.poHdId,
    required this.receivedQty,
    required this.remark,
    required this.qualityId,
    required this.flag,
    required this.tags,
    required this.imdgClassId,
    required this.unitPrice,
    required this.packetSize,
    required this.poQty,
    required this.remarksFromVendor,
    required this.reconditionedQty,
    required this.damagedQty,
    required this.newQty,
    required this.batchName,
    required this.expiryDate,
  });

  @override
  List<Object?> get props => [
    id,
    itemId,
    poHdId,
    receivedQty,
    remark,
    qualityId,
    flag,
    tags,
    imdgClassId,
    unitPrice,
    packetSize,
    poQty,
    remarksFromVendor,
    reconditionedQty,
    damagedQty,
    newQty,
    batchName,
    expiryDate,
  ];

  @override
  bool? get stringify => true;
}
