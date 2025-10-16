import 'package:equatable/equatable.dart';


class EquipmentListResponse {
  EquipmentListResponse({required this.equipmentListEntity});

  final List<EquipmentListEntity> equipmentListEntity;
}

class EquipmentListEntity extends Equatable {
  EquipmentListEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.code,
    required this.equipmentTypeId,
    this.isSelected = false,
  });

  final int id;
  final int parentId;
  final String name;
  final String code;
  final int equipmentTypeId;
  final bool? isSelected;

  EquipmentListEntity copyWith({
    int? id,
    int? parentId,
    String? name,
    String? code,
    int? equipmentTypeId,
    bool? isSelected,
  }) {
    return EquipmentListEntity(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      code: code ?? this.code,
      equipmentTypeId: equipmentTypeId ?? this.equipmentTypeId,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
    id,
    parentId,
    name,
    code,
    equipmentTypeId,
    isSelected,
  ];

  @override
  bool? get stringify => true;
}

