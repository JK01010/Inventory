import 'package:equatable/equatable.dart';

class GoodsReceiptLabelEntity extends Equatable {
  GoodsReceiptLabelEntity({
    required this.dtId,
    required this.hdId,
    required this.itemId,
    required this.qty,
    required this.packetSize,
    required this.unitPrice,
    required this.imdgClassId,
    required this.remarksFromVendor,
    required this.flag,
    required this.expiryDate,
    required this.tags,
    required this.isPartial,
    required this.isSync,
  });

  int dtId;
  int hdId;
  int itemId;
  int qty;
  String packetSize;
  String unitPrice;
  int imdgClassId;
  String remarksFromVendor;
  String flag;
  String expiryDate;
  String tags;
  String isPartial;
  String isSync;

  @override
  // TODO: implement props
  List<Object?> get props => [
    dtId,
    hdId,
    itemId,
    qty,
    packetSize,
    unitPrice,
    imdgClassId,
    remarksFromVendor,
    flag,
    expiryDate,
    tags,
    isPartial,
    isSync,
  ];
}
