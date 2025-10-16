import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domin/entities/item_master_filter_entity_model.dart';

class ItemMasterFilterModelList extends Equatable {
  const ItemMasterFilterModelList({
    required this.filters,
  });

  factory ItemMasterFilterModelList.fromMap(Map<String, dynamic> map) {
    return ItemMasterFilterModelList(
      filters: List<ItemMasterFilterModel>.from(
        (map['itemMasterFilters'] as List<dynamic>).map<ItemMasterFilterModel>(
              (x) => ItemMasterFilterModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory ItemMasterFilterModelList.fromJson(String source) =>
      ItemMasterFilterModelList.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  final List<ItemMasterFilterModel> filters;

  @override
  List<Object?> get props => [filters];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemMasterFilters': filters.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}


class ItemMasterFilterModel extends Equatable {

  const ItemMasterFilterModel({
    this.itemName,
    this.equipmentName,
    this.partNumber,
    this.articleNumber,
  });

  /// From DB (if needed, same as fromMap)
  factory ItemMasterFilterModel.fromDb(Map<String, dynamic> json) {
    return ItemMasterFilterModel.fromMap(json);
  }

  /// Convert Entity → Model
  factory ItemMasterFilterModel.fromEntity(ItemMasterFilterEntity entity) {
    return ItemMasterFilterModel(
      itemName: entity.itemName,
      equipmentName: entity.equipmentName,
      partNumber: entity.partNumber,
      articleNumber: entity.articleNumber,
    );
  }

  /// JSON deserialization
  factory ItemMasterFilterModel.fromMap(Map<String, dynamic> map) {
    return ItemMasterFilterModel(
      itemName: map['itemName'] != null ? map['itemName'] as String : null,
      equipmentName: map['equipmentName'] != null ? map['equipmentName'] as String : null,
      partNumber: map['partNumber'] != null ? map['partNumber'] as String : null,
      articleNumber: map['articleNumber'] != null ? map['articleNumber'] as String : null,
    );
  }

  factory ItemMasterFilterModel.fromJson(String source) =>
      ItemMasterFilterModel.fromMap(json.decode(source) as Map<String, dynamic>);
  final String? itemName;
  final String? equipmentName;
  final String? partNumber;
  final String? articleNumber;

  /// Convert Model → Entity
  ItemMasterFilterEntity toEntity() => ItemMasterFilterEntity(
    itemName: itemName ?? '',
    equipmentName: equipmentName ?? '',
    partNumber: partNumber ?? '',
    articleNumber: articleNumber ?? '',
  );

  /// JSON serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemName': itemName,
      'equipmentName': equipmentName,
      'partNumber': partNumber,
      'articleNumber': articleNumber,
    };
  }

  String toJson() => json.encode(toMap());

  /// CopyWith
  ItemMasterFilterModel copyWith({
    String? itemName,
    String? equipmentName,
    String? partNumber,
    String? articleNumber,
  }) {
    return ItemMasterFilterModel(
      itemName: itemName ?? this.itemName,
      equipmentName: equipmentName ?? this.equipmentName,
      partNumber: partNumber ?? this.partNumber,
      articleNumber: articleNumber ?? this.articleNumber,
    );
  }

  @override
  List<Object?> get props => [
    itemName,
    equipmentName,
    partNumber,
    articleNumber,
  ];

  @override
  bool? get stringify => true;
}

