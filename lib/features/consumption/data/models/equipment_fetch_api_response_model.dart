import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../common_feature/data/model/fetch_imdg_class_model.dart';
import '../../../common_feature/domain/entities/equipment_list_entity.dart';

class EquipmentFetchApiResponseModel extends Equatable {
  const EquipmentFetchApiResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory EquipmentFetchApiResponseModel.fromJson(Map<String, dynamic> map) {
    return EquipmentFetchApiResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<ConsumptionEquipmentListModel>.from(
        (map['reportData'] as List<dynamic>).map(
              (dynamic x) => ConsumptionEquipmentListModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<ConsumptionEquipmentListModel>? reportData;
  final EntityValidation entityValidation;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'entityValidation': entityValidation.toMap(),
    };
  }

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    recordCount,
    reportData,
    entityValidation,
  ];

  @override
  bool? get stringify => true;
}

class ConsumptionEquipmentListModel extends Equatable {
  const ConsumptionEquipmentListModel({
    required this.vesselStructureId,
    required this.vesselComponentId,
    required this.parentEquipmentId,
    required this.componentName,
    required this.code,
    required this.equipmentTypeId,
    required this.equipmentType
  });

  /// fromMap
  factory ConsumptionEquipmentListModel.fromMap(Map<String, dynamic> map) {
    return ConsumptionEquipmentListModel(
      vesselStructureId: map['vesselStructureId'] as int? ?? 0,
      vesselComponentId: map['vesselComponentId'] as int? ?? 0,
      parentEquipmentId: map['parentEquipmentId'] as int? ?? 0,
      componentName: map['componentName'] as String? ?? '',
      code: map['code'] as String? ?? '',
      equipmentTypeId: map['equipmentTypeID'] as int? ?? 0,
      equipmentType: map['equipmentType'] as String? ?? '',
    );
  }

  /// fromJson
  factory ConsumptionEquipmentListModel.fromJson(String source) =>
      ConsumptionEquipmentListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /*factory ConsumptionEquipmentListModel.fromEntity({
    required EquipmentListEntity entity,
  }) => ConsumptionEquipmentListModel(
    vesselStructureId: entity.id,
    vesselComponentId: entity.id, // Assuming vesselComponentId is same as id for now
    parentEquipmentId: entity.parentId,
    componentName: entity.name,
    code: entity.code,
    equipmentTypeId: entity.equipmentTypeId,
    equipmentType: entity.equipmentType,
  );*/

  final int vesselStructureId;//as equipmentId
  final int vesselComponentId;
  final int parentEquipmentId;
  final String componentName;
  final String code;
  final int equipmentTypeId;
  final String equipmentType;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': vesselStructureId,
      'vesselComponentId': vesselComponentId,
      'parentId': parentEquipmentId,
      'name': componentName,
      'code': code,
      'equipmentTypeId': equipmentTypeId,
      'equipmentType': equipmentType,
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  /// copyWith
  ConsumptionEquipmentListModel copyWith({
    int? id,
    int? vesselComponentId,
    int? parentId,
    String? name,
    String? code,
    int? equipmentTypeId,
    String? equipmentType,
  }) {
    return ConsumptionEquipmentListModel(
      vesselComponentId: vesselComponentId ?? this.vesselComponentId,
      vesselStructureId: id ?? this.vesselStructureId,
      parentEquipmentId: parentId ?? this.parentEquipmentId,
      componentName: name ?? this.componentName,
      code: code ?? this.code,
      equipmentTypeId: equipmentTypeId ?? this.equipmentTypeId,
      equipmentType: equipmentType ?? this.equipmentType,
    );
  }

  EquipmentListEntity toEntity() => EquipmentListEntity(
    id: vesselStructureId,
    parentId: parentEquipmentId,
    name: componentName,
    code: code,
    equipmentTypeId: equipmentTypeId,
  );



  @override
  List<Object?> get props => [
    vesselStructureId,
    vesselComponentId,
    parentEquipmentId,
    componentName,
    code,
    equipmentTypeId,
    equipmentType,
  ];

  @override
  bool? get stringify => true;
}

