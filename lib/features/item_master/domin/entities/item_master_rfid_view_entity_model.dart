import 'package:equatable/equatable.dart';

class ItemMasterRfidViewEntityModel {
  const ItemMasterRfidViewEntityModel({required this.itemMasterRfidViewEntity});

  final List<ItemMasterRfidViewEntity> itemMasterRfidViewEntity;
}

class ItemMasterRfidViewEntity extends Equatable {
  const ItemMasterRfidViewEntity({
    required this.id,
    required this.rfidId,
    required this.itemId,
    required this.groupId,
    required this.itemCode,
  });

  final int id;
  final int itemId;
  final String rfidId;
  final String groupId;
  final String itemCode;


  @override
  List<Object?> get props => [
    id,
    rfidId,
    itemId,
    groupId,
    itemCode
  ];

  @override
  bool get stringify => true;
}
