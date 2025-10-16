import 'package:equatable/equatable.dart';



class EquipmentTypeEntity extends Equatable {
  const EquipmentTypeEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.code,
    required this.equipmentTypeId,
    this.equipmentSubTypes = const [],
  });

  final int id;
  final String parentId;
  final String name;
  final String code;
  final String equipmentTypeId;
  final List<EquipmentSubTypeEntity> equipmentSubTypes;

  @override
  List<Object?> get props => [
    id,
    parentId,
    name,
    code,
    equipmentTypeId,
    equipmentSubTypes,
  ];
}

class EquipmentSubTypeEntity extends Equatable {
  const EquipmentSubTypeEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.code,
    required this.equipmentTypeId,
    this.children = const [],
  });

  final int id;
  final String parentId;
  final String name;
  final String code;
  final String equipmentTypeId;
  final List<ChildEquipmentEntity> children;

  @override
  List<Object?> get props => [
    id,
    parentId,
    name,
    code,
    equipmentTypeId,
    children,
  ];
}

class ChildEquipmentEntity extends Equatable {
  const ChildEquipmentEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.code,
    required this.equipmentTypeId,
  });

  final int id;
  final String parentId;
  final String name;
  final String code;
  final String equipmentTypeId;

  @override
  List<Object?> get props => [
    id,
    parentId,
    name,
    code,
    equipmentTypeId,
  ];
}