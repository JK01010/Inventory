import 'package:equatable/equatable.dart';

import '../../../good_receipts/data/models/goods_receipt_entity_validation.dart';
import '../../domain/entities/storage_location_entity.dart';

class StorageLocationResponseModel extends Equatable {
  StorageLocationResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory StorageLocationResponseModel.fromJson(Map<String, dynamic> map) {
    return StorageLocationResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<StorageLocationModel>.from(
        (map['reportData'] as List).map(
          (x) => StorageLocationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<StorageLocationModel>? reportData;
  final EntityValidation entityValidation;

  Map<String, dynamic> toJson() {
    return {
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

class StorageLocationModel extends Equatable {
  const StorageLocationModel({
    required this.id,
    required this.parentId,
    required this.code,
    required this.locName,
    required this.description,
    required this.vesselLocationID,
    required this.isActive,
    required this.referenceTypeID,
    required this.referenceID,
    required this.referenceSubID,
    required this.parentLocName,
  });

  factory StorageLocationModel.fromMap(Map<String, dynamic> json) {
    return StorageLocationModel(
      id: json['ID'] as int? ?? 0,
      parentId: json['ParentID'] as int? ?? 0,
      code: json['Code'] as String? ?? '',
      locName: json['LocName'] as String? ?? '',
      description: json['Description'] as String? ?? '',
      vesselLocationID: json['VesselLocationID'] as int? ?? 0,
      isActive: json['IsActive'] == "Yes" ? true : false,
      referenceTypeID: json['ReferenceTypeID'] as int? ?? 0,
      referenceID: json['ReferenceID'] as int? ?? 0,
      referenceSubID: json['ReferenceSubID'] as int? ?? 0,
      parentLocName: json['ParentLocName'] as String? ?? '',
    );
  }

  factory StorageLocationModel.fromEntity(
    StorageLocationEntity storageLocationEntity,
  ) {
    return StorageLocationModel(
      id: storageLocationEntity.id,
      parentId: storageLocationEntity.parentId,
      code: storageLocationEntity.code,
      locName: storageLocationEntity.locName,
      description: storageLocationEntity.description,
      vesselLocationID: storageLocationEntity.vesselLocationID,
      isActive: storageLocationEntity.isActive,
      referenceTypeID: storageLocationEntity.referenceTypeID,
      referenceID: storageLocationEntity.referenceID,
      referenceSubID: storageLocationEntity.referenceSubID,
      parentLocName: storageLocationEntity.parentLocName,
    );
  }

  final int id;
  final int parentId;
  final String code;
  final String locName;
  final String description;
  final int vesselLocationID;
  final bool isActive;
  final int referenceTypeID;
  final int referenceID;
  final int referenceSubID;
  final String parentLocName;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'code': code,
      'locName': locName,
      'description': description,
      'vesselLocationID': vesselLocationID,
      'isActive': isActive,
      'referenceTypeID': referenceTypeID,
      'referenceID': referenceID,
      'referenceSubID': referenceSubID,
      'parentLocName': parentLocName,
    };
  }

  StorageLocationEntity toEntity() {
    return StorageLocationEntity(
      id: id ?? 0,
      parentId: parentId ?? 0,
      code: code ?? '',
      locName: locName ?? '',
      description: description ?? '',
      vesselLocationID: vesselLocationID ?? 0,
      isActive: isActive ?? true,
      referenceTypeID: referenceTypeID ?? 0,
      referenceID: referenceID ?? 0,
      referenceSubID: referenceSubID ?? 0,
      parentLocName: parentLocName ?? '',
    );
  }

  static List<StorageLocationModel> fromEntityList(
    List<StorageLocationEntity> storageLocationEntityList,
  ) {
    List<StorageLocationModel> storageLocationModelList = [];
    for (var entity in storageLocationEntityList) {
      storageLocationModelList.add(StorageLocationModel.fromEntity(entity));
    }
    return storageLocationModelList;
  }

  Map<String, dynamic> toMap() => toJson();

  @override
  List<Object?> get props => [
    id,
    parentId,
    code,
    locName,
    description,
    vesselLocationID,
    isActive,
    referenceTypeID,
    referenceID,
    referenceSubID,
    parentLocName,
  ];
}
