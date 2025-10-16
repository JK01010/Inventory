import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../../common_feature/domain/entities/equipment_list_entity.dart';


class EquipmentListResponseModel extends Equatable {
  const EquipmentListResponseModel({required this.equipmentList});

  /// fromMap
  factory EquipmentListResponseModel.fromMap(Map<String, dynamic> map) {
    return EquipmentListResponseModel(
      equipmentList: List<ConsumptionEquipmentListApiModel>.from(
        (map['equipmentListEntity'] as List).map(
              (x) => ConsumptionEquipmentListApiModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// fromJson
  factory EquipmentListResponseModel.fromJson(String source) =>
      EquipmentListResponseModel.fromMap(json.decode(source));

  final List<ConsumptionEquipmentListApiModel> equipmentList;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'equipmentListEntity': equipmentList.map((x) => x.toMap()).toList(),
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [equipmentList];
}

class ConsumptionEquipmentListApiModel extends Equatable {
  const ConsumptionEquipmentListApiModel({
    required this.vesselStructureId,
    required this.parentEquipmentId,
    required this.componentName,
    required this.code,
    required this.equipmentTypeId,
  });

  /// fromMap
  factory ConsumptionEquipmentListApiModel.fromMap(Map<String, dynamic> map) {
    return ConsumptionEquipmentListApiModel(
      vesselStructureId: map['id'] as int,
      parentEquipmentId: map['parentId'] as int,
      componentName: map['name'] as String,
      code: map['code'] as String,
      equipmentTypeId: map['equipmentTypeId'] as int,
    );
  }

  /// fromJson
  factory ConsumptionEquipmentListApiModel.fromJson(String source) =>
      ConsumptionEquipmentListApiModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ConsumptionEquipmentListApiModel.fromEntity({
    required EquipmentListEntity entity,
  }) => ConsumptionEquipmentListApiModel(
    vesselStructureId: entity.id,
    parentEquipmentId: entity.parentId,
    componentName: entity.name,
    code: entity.code,
    equipmentTypeId: entity.equipmentTypeId,
  );

  final int vesselStructureId;//as equipmentId
  final int parentEquipmentId;
  final String componentName;
  final String code;
  final int equipmentTypeId;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': vesselStructureId,
      'parentId': parentEquipmentId,
      'name': componentName,
      'code': code,
      'equipmentTypeId': equipmentTypeId,
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  /// copyWith
  ConsumptionEquipmentListApiModel copyWith({
    int? id,
    int? parentId,
    String? name,
    String? code,
    int? equipmentTypeId,
  }) {
    return ConsumptionEquipmentListApiModel(
      vesselStructureId: id ?? this.vesselStructureId,
      parentEquipmentId: parentId ?? this.parentEquipmentId,
      componentName: name ?? this.componentName,
      code: code ?? this.code,
      equipmentTypeId: equipmentTypeId ?? this.equipmentTypeId,
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
    parentEquipmentId,
    componentName,
    code,
    equipmentTypeId,
  ];

  @override
  bool? get stringify => true;
}

