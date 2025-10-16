import 'package:equatable/equatable.dart';

class GRNLocationMappingEntity extends Equatable {

  const GRNLocationMappingEntity({
    required this.id,
    required this.grnHdID,
    required this.grnDtID,
    required this.storageLocationID,
    required this.code,
    required this.locationName,
    required this.description,
    required this.itemID,
    required this.parentItemID,
    required this.typeID,
    required this.quantity,
    required this.parentID,
    required this.isActive,
    required this.locationHierarchy,
  });

  /// Factory to create entity from JSON
  factory GRNLocationMappingEntity.fromJson(Map<String, dynamic> json) {
    return GRNLocationMappingEntity(
      id: json['ID'] as int,
      grnHdID: json['GRNHDID'] as int,
      grnDtID: json['GRNDTID'] as int,
      storageLocationID: json['StorageLocationID'] as int,
      code: json['Code'] as String,
      locationName: json['LocationName'] as String,
      description: json['Description'] as String,
      itemID: json['ItemID'] as int,
      parentItemID: json['ParentItemID'] as int,
      typeID: json['TypeID'] as int,
      quantity: (json['Quantity'] as num).toDouble(),
      parentID: json['ParentID'] != null ? json['ParentID'] as int : null,
      isActive: json['IsActive'] as bool,
      locationHierarchy: json['LocationHierarchy'] as String,
    );
  }
  final int id;
  final int grnHdID;
  final int grnDtID;
  final int storageLocationID;
  final String code;
  final String locationName;
  final String description;
  final int itemID;
  final int parentItemID;
  final int typeID;
  final double quantity;
  final int? parentID;
  final bool isActive;
  final String locationHierarchy;

  /// Convert entity to JSON
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'GRNHDID': grnHdID,
      'GRNDTID': grnDtID,
      'StorageLocationID': storageLocationID,
      'Code': code,
      'LocationName': locationName,
      'Description': description,
      'ItemID': itemID,
      'ParentItemID': parentItemID,
      'TypeID': typeID,
      'Quantity': quantity,
      'ParentID': parentID,
      'IsActive': isActive,
      'LocationHierarchy': locationHierarchy,
    };
  }

  @override
  List<Object?> get props => [
    id,
    grnHdID,
    grnDtID,
    storageLocationID,
    code,
    locationName,
    description,
    itemID,
    parentItemID,
    typeID,
    quantity,
    parentID,
    isActive,
    locationHierarchy,
  ];
}
