import 'package:equatable/equatable.dart';

class ItemGroupCommonEntityModel {
  const ItemGroupCommonEntityModel({required this.itemGroupEntityList});

  final List<ItemGroupEntityModel> itemGroupEntityList;
}

class ItemGroupEntityModel extends Equatable {
  const ItemGroupEntityModel({
    required this.itemCode,
    required this.rfid,
    required this.quantity,
    required this.canUpdateQuantity,
    required this.storageLocation,
  });

  final String itemCode;
  final String rfid;
  final int quantity;
  final String canUpdateQuantity;
  final String storageLocation;


  @override
  List<Object?> get props => [
    itemCode,
    rfid,
    quantity,
    canUpdateQuantity,
    storageLocation,
  ];

  @override
  bool get stringify => true;
}
