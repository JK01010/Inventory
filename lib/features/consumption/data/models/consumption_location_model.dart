import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domin/entities/consumption_location_entity.dart';

class ConsumptionLocationResponseModel extends Equatable {
  const ConsumptionLocationResponseModel({required this.locationList});

  /// fromMap
  factory ConsumptionLocationResponseModel.fromMap(Map<String, dynamic> map) {
    return ConsumptionLocationResponseModel(
      locationList: List<ConsumptionLocationModel>.from(
        (map['locationListEntity'] as List).map(
              (x) => ConsumptionLocationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// fromJson
  factory ConsumptionLocationResponseModel.fromJson(String source) =>
      ConsumptionLocationResponseModel.fromMap(json.decode(source));

  final List<ConsumptionLocationModel> locationList;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationListEntity': locationList.map((x) => x.toMap()).toList(),
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [locationList];
}

class ConsumptionLocationModel extends Equatable {
  const ConsumptionLocationModel({
    required this.id,
    required this.parentId,
    required this.name,
    required this.code,
    required this.parentName,
    required this.activeFlag,
    required this.type,
    required this.sortOrder,
  });

  /// fromMap
  factory ConsumptionLocationModel.fromMap(Map<String, dynamic> map) {
    return ConsumptionLocationModel(
      id: map['id'] as int,
      parentId: map['parentId'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
      parentName: map['parentName'] as String,
      activeFlag: map['activeFlag'] as String,
      type: map['type'] as String,
      sortOrder: map['sortOrder'] as int,
    );
  }

  /// fromJson
  factory ConsumptionLocationModel.fromJson(String source) =>
      ConsumptionLocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ConsumptionLocationModel.fromEntity({
    required ConsumptionLocationEntity entity,
  }) => ConsumptionLocationModel(
    id: entity.id,
    parentId: entity.parentId,
    name: entity.name,
    code: entity.code,
    parentName: entity.parentName,
    activeFlag: entity.activeFlag,
    type: entity.type,
    sortOrder: entity.sortOrder,
  );

  final int id;
  final int parentId;
  final String name;
  final String code;
  final String parentName;
  final String activeFlag;
  final String type;
  final int sortOrder;

  /// toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'parentId': parentId,
      'name': name,
      'code': code,
      'parentName': parentName,
      'activeFlag': activeFlag,
      'type': type,
      'sortOrder': sortOrder,
    };
  }

  /// toJson
  String toJson() => json.encode(toMap());

  /// copyWith
  ConsumptionLocationModel copyWith({
    int? id,
    int? parentId,
    String? name,
    String? code,
    String? parentName,
  String? activeFlag,
    String? type,
  int? sortOrder,
  }) {
    return ConsumptionLocationModel(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      code: code ?? this.code,
      parentName: parentName ?? this.parentName,
      activeFlag: activeFlag ?? this.activeFlag,
      type: type ?? this.type,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  ConsumptionLocationEntity toEntity() => ConsumptionLocationEntity(
    id: id,
    parentId: parentId,
    name: name,
    code: code,
    parentName: parentName,
    activeFlag: activeFlag,
    type: type,
    sortOrder: sortOrder,
  );

  @override
  List<Object?> get props => [
    id,
    parentId,
    name,
    code,
    parentName,
    activeFlag,
    type,
    sortOrder
  ];

  @override
  bool? get stringify => true;
}

