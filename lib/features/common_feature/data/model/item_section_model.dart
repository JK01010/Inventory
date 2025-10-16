import 'package:equatable/equatable.dart';
import '../../../good_receipts/data/models/goods_receipt_entity_validation.dart';
import '../../domain/entities/item_section_entity.dart';

class ItemSectionResponseModel extends Equatable {
  const ItemSectionResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<ItemSectionModel> reportData;
  final EntityValidation entityValidation;

  factory ItemSectionResponseModel.fromJson(Map<String, dynamic> map) {
    return ItemSectionResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<ItemSectionModel>.from(
        (map['reportData'] as List).map(
          (x) => ItemSectionModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

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

class ItemSectionModel extends Equatable {
  const ItemSectionModel({
    this.id,
    this.categoryId,
    this.code,
    this.sectionName,
  });

  final int? id;
  final int? categoryId;
  final String? code;
  final String? sectionName;

  factory ItemSectionModel.fromJson(Map<String, dynamic> map) {
    return ItemSectionModel(
      id: map['ID'],
      categoryId: map['CategoryID'],
      code: map['Code'],
      sectionName: map['SectionName'],
    );
  }

  factory ItemSectionModel.fromEntity(ItemSectionEntity entity) =>
      ItemSectionModel(
        id: entity.id,
        categoryId: entity.categoryId,
        code: entity.code,
        sectionName: entity.sectionName,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'code': code,
      'sectionName': sectionName,
    };
  }

  ItemSectionEntity toEntity() => ItemSectionEntity(
    id: id ?? -1,
    categoryId: categoryId ?? -1,
    code: code ?? '',
    sectionName: sectionName ?? '',
  );

  @override
  List<Object?> get props => [id, categoryId, code, sectionName];

  @override
  bool? get stringify => true;

  ItemSectionModel copyWith({
    int? id,
    int? categoryId,
    String? code,
    String? sectionName,
  }) {
    return ItemSectionModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      code: code ?? this.code,
      sectionName: sectionName ?? this.sectionName,
    );
  }
}
