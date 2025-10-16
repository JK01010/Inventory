// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class GoodsReceiptTransactionDetailEntity extends Equatable {
  const GoodsReceiptTransactionDetailEntity({
    required this.id,
    required this.itemId,
    required this.hdId,
    required this.poDtId,
    required this.receivedQty,
    required this.remarks,
    required this.qualityId,
    required this.flag,
    required this.reConditionedQty,
    required this.damagedQty,
    required this.newQty,
    required this.imdgClassId,
    required this.batchName,
    required this.remarksFromVendor,
    required this.expiryDate,
    required this.tags,
    required this.isSync,
  });

  final int id;
  final int itemId;
  final int hdId;
  final String poDtId;
  final int receivedQty;
  final String remarks;
  final int qualityId;
  final String flag;
  final int reConditionedQty;
  final int damagedQty;
  final int newQty;
  final int imdgClassId;
  final String batchName;
  final String remarksFromVendor;
  final String expiryDate;
  final String tags;
  final String isSync;

  @override
  List<Object?> get props => [
    id,
    itemId,
    hdId,
    poDtId,
    receivedQty,
    remarks,
    qualityId,
    flag,
    reConditionedQty,
    damagedQty,
    newQty,
    imdgClassId,
    batchName,
    remarksFromVendor,
    expiryDate,
    tags,
    isSync,
  ];
}
