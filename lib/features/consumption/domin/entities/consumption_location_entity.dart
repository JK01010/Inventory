import 'package:equatable/equatable.dart';


class ConsumptionLocationResponse {
  ConsumptionLocationResponse({required this.consumptionLocationEntity});

  final List<ConsumptionLocationEntity> consumptionLocationEntity;
}

class ConsumptionLocationEntity extends Equatable{
  const ConsumptionLocationEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.code,
    required this.parentName,
    required this.activeFlag,
    required this.type,
    required this.sortOrder,
    this.isSelected = false,
  }
      );
  final int id;
  final int parentId;
  final String name;
  final String code;
  final String parentName;
  final String activeFlag;
  final String type;
  final int sortOrder;
  final bool? isSelected;

  @override
  List<Object?> get props =>[
    id,
    parentId,
    name,
    code,
    parentName,
    activeFlag,
    type,
    sortOrder,
    isSelected,
  ];
  bool? get stringify => true;

  ConsumptionLocationEntity copyWith({
    int? id,
    int? parentId,
    String? name,
    String? code,
    String? parentName,
    String? activeFlag,
    String? type,
    int? sortOrder,
    bool? isSelected,
  }) {
    return ConsumptionLocationEntity(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      code: code ?? this.code,
      parentName: parentName ?? this.parentName,
      activeFlag: activeFlag ?? this.activeFlag,
      type: type ?? this.type,
      sortOrder: sortOrder ?? this.sortOrder,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}




