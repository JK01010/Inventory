import 'package:equatable/equatable.dart';

import '../../../good_receipts/data/models/goods_receipt_entity_validation.dart';
import '../../domain/entities/item_category_entity.dart';

class ItemCategoryResponseModel extends Equatable {
  const ItemCategoryResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory ItemCategoryResponseModel.fromJson(Map<String, dynamic> map) {
    return ItemCategoryResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<ItemCategoryModel>.from(
        (map['reportData'] as List).map(
          (x) => ItemCategoryModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<ItemCategoryModel> reportData;
  final EntityValidation entityValidation;

  Map<String, dynamic> toJson() {
    return {
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData.map((x) => x.toJson()).toList(),
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

class ItemCategoryModel extends Equatable {
  const ItemCategoryModel({this.id, this.code, this.categoryName});

  factory ItemCategoryModel.fromJson(Map<String, dynamic> map) {
    return ItemCategoryModel(
      id: map['ID'],
      code: map['Code'],
      categoryName: map['CategoryName'],
    );
  }

  factory ItemCategoryModel.fromEntity(ItemCategoryEntity entity) =>
      ItemCategoryModel(
        id: entity.id,
        code: entity.code,
        categoryName: entity.categoryName,
      );

  ItemCategoryEntity toEntity() {
    return ItemCategoryEntity(
      id: id ?? -1,
      code: code ?? "",
      categoryName: categoryName ?? "",
    );
  }

  final int? id;
  final String? code;
  final String? categoryName;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ID': id,
      'Code': code,
      'CategoryName': categoryName,
    };
  }

  @override
  List<Object?> get props => [id, code, categoryName];

  @override
  bool? get stringify => true;

  ItemCategoryModel copyWith({int? id, String? code, String? categoryName}) {
    return ItemCategoryModel(
      id: id ?? this.id,
      code: code ?? this.code,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}
