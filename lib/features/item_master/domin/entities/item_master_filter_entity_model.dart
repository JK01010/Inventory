import 'package:equatable/equatable.dart';

class ItemMasterFilterEntityModel {
  ItemMasterFilterEntityModel({required this.itemMasterFilterEntity});

  final List<ItemMasterFilterEntity> itemMasterFilterEntity;
}

class ItemMasterFilterEntity extends Equatable{

  const ItemMasterFilterEntity({
    required this.itemName,
    required this.equipmentName,
    required this.partNumber,
    required this.articleNumber,
});

  final String itemName;
  final String equipmentName;
  final String partNumber;
  final String articleNumber;


  @override
  List<Object?> get props => [
    itemName,
    equipmentName,
    partNumber,
    articleNumber
  ];

  @override
  bool get stringify => true;

}