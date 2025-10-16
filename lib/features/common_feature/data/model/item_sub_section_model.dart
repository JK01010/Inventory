import 'package:equatable/equatable.dart';
import '../../../good_receipts/data/models/goods_receipt_entity_validation.dart';
import '../../domain/entities/item_sub_section_entity.dart';

class ItemSubSectionResponseModel extends Equatable {
  const ItemSubSectionResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<ItemSubSectionModel> reportData;
  final EntityValidation entityValidation;

  factory ItemSubSectionResponseModel.fromJson(Map<String, dynamic> map) {
    return ItemSubSectionResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<ItemSubSectionModel>.from(
        (map['reportData'] as List).map(
          (x) => ItemSubSectionModel.fromJson(x as Map<String, dynamic>),
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

class ItemSubSectionModel extends Equatable {
  const ItemSubSectionModel({
    required this.id,
    required this.sectionId,
    required this.code,
    required this.subSectionName,
  });

  final int? id;
  final int? sectionId;
  final String? code;
  final String? subSectionName;

  factory ItemSubSectionModel.fromJson(Map<String, dynamic> map) {
    return ItemSubSectionModel(
      id: map['ID'],
      sectionId: map['SectionID'],
      code: map['Code'],
      subSectionName: map['SubSectionName'],
    );
  }

  factory ItemSubSectionModel.fromEntity(ItemSubSectionEntity entity) =>
      ItemSubSectionModel(
        id: entity.id,
        sectionId: entity.sectionId,
        code: entity.code,
        subSectionName: entity.subSectionName,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'sectionId': sectionId,
      'code': code,
      'subSectionName': subSectionName,
    };
  }

  ItemSubSectionEntity toEntity() => ItemSubSectionEntity(
    id: id ?? -1,
    sectionId: sectionId ?? -1,
    code: code ?? '',
    subSectionName: subSectionName ?? '',
  );

  @override
  List<Object?> get props => [id, sectionId, code, subSectionName];

  @override
  bool? get stringify => true;

  ItemSubSectionModel copyWith({
    int? id,
    int? sectionId,
    String? code,
    String? subSectionName,
  }) {
    return ItemSubSectionModel(
      id: id ?? this.id,
      sectionId: sectionId ?? this.sectionId,
      code: code ?? this.code,
      subSectionName: subSectionName ?? this.subSectionName,
    );
  }
}
