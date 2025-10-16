import 'package:equatable/equatable.dart';
import '../../domain/entities/default_location_entity.dart';

class DefaultLocationModel extends Equatable {
  const DefaultLocationModel({
    this.locationVesselMappingId,
    this.itemId,
    this.itemVersionId,
    this.itemLinkId,
    this.partNumber,
    this.code,
    this.uomQuantity,
    this.robCount,
    this.sectionName,
    this.subSectionName,
    this.description,
    this.itemName,
    this.categoryName,
    this.isActive,
  });

  /// Factory from JSON
  factory DefaultLocationModel.fromJson(Map<String, dynamic> json) {
    return DefaultLocationModel(
      locationVesselMappingId: json['LocationVesselMappingID'] as int?,
      itemId: json['ItemID'] as int?,
      itemVersionId: json['ItemVersionID'] as int?,
      itemLinkId: json['ItemLinkID'] as int?,
      partNumber: json['PartNumber'] as String?,
      code: json['Code'] as String?,
      uomQuantity: json['UomQuantity'] as num?,
      robCount: (json['ROBCount'] as num?)?.toDouble(),
      sectionName: json['SectionName'] as String?,
      subSectionName: json['SubSectionName'] as String?,
      description: json['Description'] as String?,
      itemName: json['ItemName'] as String?,
      categoryName: json['CategoryName'] as String?,
      isActive:
          json['IsActive'] != null
              ? json['IsActive'].runtimeType == bool
                  ? json['IsActive']
                  : json['IsActive'] == 1
                  ? true
                  : false
              : false,
    );
  }

  final int? locationVesselMappingId;
  final int? itemId;
  final int? itemVersionId;
  final int? itemLinkId;
  final String? partNumber;
  final String? code;
  final num? uomQuantity;
  final double? robCount;
  final String? sectionName;
  final String? subSectionName;
  final String? description;
  final String? itemName;
  final String? categoryName;
  final bool? isActive;

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'LocationVesselMappingID': locationVesselMappingId,
      'ItemID': itemId,
      'ItemVersionID': itemVersionId,
      'ItemLinkID': itemLinkId,
      'PartNumber': partNumber,
      'Code': code,
      'UomQuantity': uomQuantity,
      'ROBCount': robCount,
      'SectionName': sectionName,
      'SubSectionName': subSectionName,
      'Description': description,
      'ItemName': itemName,
      'CategoryName': categoryName,
      'IsActive': isActive == true ? 1 : 0,
    };
  }

  /// Convert Model -> Entity
  DefaultLocationEntity toEntity() {
    return DefaultLocationEntity(
      locationVesselMappingId: locationVesselMappingId ?? 0,
      itemId: itemId ?? 0,
      itemVersionId: itemVersionId ?? 0,
      itemLinkId: itemLinkId ?? 0,
      partNumber: partNumber ?? '',
      code: code ?? '',
      uomQuantity: uomQuantity,
      robCount: robCount ?? 0.0,
      sectionName: sectionName ?? '',
      subSectionName: subSectionName,
      code1: '',
      description: description,
      itemName: itemName ?? '',
      categoryName: categoryName ?? '',
      isActive: isActive ?? false,
    );
  }

  /// Convert list of models → list of entities
  static List<DefaultLocationEntity> toEntityList(
    List<DefaultLocationModel> modelList,
  ) {
    return modelList.map((e) => e.toEntity()).toList();
  }

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
    description,
    itemName,
    categoryName,
    isActive,
  ];
}
