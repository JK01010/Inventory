// To parse this JSON data, do
//
//     final qualityListResponseModel = qualityListResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/quality_entity.dart';

QualityListResponseModel qualityListResponseModelFromJson(String str) =>
    QualityListResponseModel.fromJson(json.decode(str));

String qualityListResponseModelToJson(QualityListResponseModel data) =>
    json.encode(data.toJson());

class QualityListResponseModel {
  factory QualityListResponseModel.fromJson(Map<String, dynamic> json) =>
      QualityListResponseModel(
        moduleCode: json["moduleCode"],
        entityName: json["entityName"],
        reportData:
            json["reportData"] == null
                ? []
                : List<QualityListData>.from(
                  json["reportData"]!.map((x) => QualityListData.fromJson(x)),
                ),
        recordCount: json["recordCount"],
        entityValidation:
            json["entityValidation"] == null
                ? null
                : EntityValidation.fromJson(json["entityValidation"]),
      );

  QualityListResponseModel({
    this.moduleCode,
    this.entityName,
    this.reportData,
    this.recordCount,
    this.entityValidation,
  });

  String? moduleCode;
  String? entityName;
  List<QualityListData>? reportData;
  int? recordCount;
  EntityValidation? entityValidation;

  Map<String, dynamic> toJson() => {
    "moduleCode": moduleCode,
    "entityName": entityName,
    "reportData":
        reportData == null
            ? []
            : List<dynamic>.from(reportData!.map((x) => x.toJson())),
    "recordCount": recordCount,
    "entityValidation": entityValidation?.toJson(),
  };
}

class EntityValidation {
  EntityValidation({this.status, this.validationMessages});

  factory EntityValidation.fromJson(Map<String, dynamic> json) =>
      EntityValidation(
        status: json["status"],
        validationMessages:
            json["validationMessages"] == null
                ? []
                : List<dynamic>.from(json["validationMessages"]!.map((x) => x)),
      );
  bool? status;
  List<dynamic>? validationMessages;

  Map<String, dynamic> toJson() => {
    "status": status,
    "validationMessages":
        validationMessages == null
            ? []
            : List<dynamic>.from(validationMessages!.map((x) => x)),
  };
}

class QualityListData {
  QualityListData({
    this.id,
    this.hdId,
    this.hdCode,
    this.code,
    this.typeName,
    this.isActive,
    this.sortOrder,
    this.remarks,
    this.createdById,
    this.createdOn,
    this.modifiedById,
    this.modifiedOn,
  });

  factory QualityListData.fromJson(
    Map<String, dynamic> json,
  ) => QualityListData(
    id: json["ID"],
    hdId: json["HDID"],
    hdCode: json["HDCode"],
    code: json["Code"],
    typeName: json["TypeName"],
    isActive:
        json["IsActive"] != null
            ? json["IsActive"].runtimeType == bool
                ? json["IsActive"]
                : json["IsActive"] == 1
                ? true
                : false
            : false,
    sortOrder: json["SortOrder"],
    remarks: json["Remarks"],
    createdById: json["CreatedByID"],
    createdOn:
        json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    modifiedById: json["ModifiedByID"],
    modifiedOn:
        json["ModifiedOn"] == null ? null : DateTime.parse(json["ModifiedOn"]),
  );
  int? id;
  int? hdId;
  String? hdCode;
  String? code;
  String? typeName;
  bool? isActive;
  int? sortOrder;
  String? remarks;
  int? createdById;
  DateTime? createdOn;
  int? modifiedById;
  DateTime? modifiedOn;

  Map<String, dynamic> toJson() => {
    "ID": id,
    "HDID": hdId,
    "HDCode": hdCode,
    "Code": code,
    "TypeName": typeName,
    "IsActive": isActive == true ? 1 : 0,
    "SortOrder": sortOrder,
    "Remarks": remarks,
    "CreatedByID": createdById,
    "CreatedOn": createdOn?.toIso8601String(),
    "ModifiedByID": modifiedById,
    "ModifiedOn": modifiedOn?.toIso8601String(),
  };

  QualityEntity toEntity() {
    return QualityEntity(
      id: id ?? -1,
      code: code ?? '',
      qualityName: typeName ?? '',
    );
  }
}
