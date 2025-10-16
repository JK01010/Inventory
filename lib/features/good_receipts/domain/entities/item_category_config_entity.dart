import 'package:equatable/equatable.dart';

class ItemCategoryConfigEntity extends Equatable {
  final int? itemCategoryId;
  final int? propertyId;
  final String? propertyCode;
  final String? propertyValue;

  const ItemCategoryConfigEntity({
    this.itemCategoryId,
    this.propertyId,
    this.propertyCode,
    this.propertyValue,
  });

  @override
  List<Object?> get props => [
    itemCategoryId,
    propertyId,
    propertyCode,
    propertyValue,
  ];
}