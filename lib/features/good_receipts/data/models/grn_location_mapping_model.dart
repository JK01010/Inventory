import 'package:equatable/equatable.dart';
import '../../domain/entities/grn_location_mapping_entity.dart';

class GRNLocationMappingModel extends Equatable {

  /// Convert Entity → Model
  factory GRNLocationMappingModel.fromEntity(GRNLocationMappingEntity entity) {
    return GRNLocationMappingModel(
      id: entity.id,
      grnHdID: entity.grnHdID,
      grnDtID: entity.grnDtID,
      storageLocationID: entity.storageLocationID,
      code: entity.code,
      locationName: entity.locationName,
      description: entity.description,
      itemID: entity.itemID,
      parentItemID: entity.parentItemID,
      typeID: entity.typeID,
      quantity: entity.quantity,
      parentID: entity.parentID,
      isActive: entity.isActive,
      locationHierarchy: entity.locationHierarchy,
    );
  }

  const GRNLocationMappingModel({
    this.id,
    this.grnHdID,
    this.grnDtID,
    this.storageLocationID,
    this.code,
    this.locationName,
    this.description,
    this.itemID,
    this.parentItemID,
    this.typeID,
    this.quantity,
    this.parentID,
    this.isActive,
    this.locationHierarchy,
  });

  /// From JSON
  factory GRNLocationMappingModel.fromJson(Map<String, dynamic> json) {
    return GRNLocationMappingModel(
      id: json['ID'] as int?,
      grnHdID: json['GRNHDID'] as int?,
      grnDtID: json['GRNDTID'] as int?,
      storageLocationID: json['StorageLocationID'] as int?,
      code: json['Code'] as String?,
      locationName: json['LocationName'] as String?,
      description: json['Description'] as String?,
      itemID: json['ItemID'] is int ? json['ItemID'] as int : int.tryParse(json['ItemID'].toString()),
      parentItemID: json['ParentItemID'] as int?,
      typeID: json['TypeID'] as int?,
      quantity: json['Quantity'] != null ? (json['Quantity'] as num).toDouble() : null,
      parentID: json['ParentID'] as int?,
      isActive: json['IsActive'] as bool?,
      locationHierarchy: json['LocationHierarchy'] as String?,
    );
  }
  final int? id;
  final int? grnHdID;
  final int? grnDtID;
  final int? storageLocationID;
  final String? code;
  final String? locationName;
  final String? description;
  final int? itemID;
  final int? parentItemID;
  final int? typeID;
  final double? quantity;
  final int? parentID;
  final bool? isActive;
  final String? locationHierarchy;

  /// To JSON
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

  /// Convert Model → Entity
  GRNLocationMappingEntity toEntity() {
    return GRNLocationMappingEntity(
      id: id ?? 0,
      grnHdID: grnHdID ?? 0,
      grnDtID: grnDtID ?? 0,
      storageLocationID: storageLocationID ?? 0,
      code: code ?? '',
      locationName: locationName ?? '',
      description: description ?? '',
      itemID: itemID ?? 0,
      parentItemID: parentItemID ?? 0,
      typeID: typeID ?? 0,
      quantity: quantity ?? 0.0,
      parentID: parentID,
      isActive: isActive ?? false,
      locationHierarchy: locationHierarchy ?? '',
    );
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
