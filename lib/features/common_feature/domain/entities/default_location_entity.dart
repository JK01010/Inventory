import 'package:equatable/equatable.dart';

class DefaultLocationEntity extends Equatable {

  const DefaultLocationEntity({
    required this.locationVesselMappingId,
    required this.itemId,
    required this.itemVersionId,
    required this.itemLinkId,
    required this.partNumber,
    required this.code,
    required this.uomQuantity,
    required this.robCount,
    required this.sectionName,
    required this.subSectionName,
    required this.code1,
    required this.description,
    required this.itemName,
    required this.categoryName,
    required this.isActive,
  });
  final int locationVesselMappingId;
  final int itemId;
  final int itemVersionId;
  final int itemLinkId;
  final String partNumber;
  final String code;
  final num? uomQuantity;
  final double robCount;
  final String sectionName;
  final String? subSectionName;
  final String code1;
  final String? description;
  final String itemName;
  final String categoryName;
  final bool isActive;

  @override
  List<Object?> get props => [
    locationVesselMappingId,
    itemId,
    itemVersionId,
    itemLinkId,
    partNumber,
    code,
    uomQuantity,
    robCount,
    sectionName,
    subSectionName,
    code1,
    description,
    itemName,
    categoryName,
    isActive,
  ];
}
