import 'dart:convert';

import '../../domain/entities/fetch_imdg_class_entity.dart';

ImdgClassResponseModel imdgClassResponseModelFromJson(String str) =>
    ImdgClassResponseModel.fromJson(json.decode(str));

String imdgClassResponseModelToJson(ImdgClassResponseModel data) =>
    json.encode(data.toJson());

class ImdgClassResponseModel {
  ImdgClassResponseModel({
    this.moduleCode,
    this.entityName,
    this.reportData,
    this.recordCount,
    this.entityValidation,
  });

  factory ImdgClassResponseModel.fromJson(Map<String, dynamic> json) =>
      ImdgClassResponseModel(
        moduleCode: json["moduleCode"],
        entityName: json["entityName"],
        reportData:
            json["reportData"] == null
                ? []
                : List<ImdgClassData>.from(
                  json["reportData"]!.map((x) => ImdgClassData.fromJson(x)),
                ),
        recordCount: json["recordCount"],
        entityValidation:
            json["entityValidation"] == null
                ? null
                : EntityValidation.fromMap(json["entityValidation"]),
      );
  String? moduleCode;
  String? entityName;
  List<ImdgClassData>? reportData;
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
    "entityValidation": entityValidation?.toMap(),
  };
}

class EntityValidation {
  EntityValidation({this.status, this.validationMessages});

  factory EntityValidation.fromMap(Map<String, dynamic> json) =>
      EntityValidation(
        status: json["status"],
        validationMessages:
            json["validationMessages"] == null
                ? []
                : List<dynamic>.from(json["validationMessages"]!.map((x) => x)),
      );
  bool? status;
  List<dynamic>? validationMessages;

  Map<String, dynamic> toMap() => {
    "status": status,
    "validationMessages":
        validationMessages == null
            ? []
            : List<dynamic>.from(validationMessages!.map((x) => x)),
  };
}

class ImdgClassData {
  ImdgClassData({this.id, this.code, this.typeName, this.isActive});

  factory ImdgClassData.fromJson(Map<String, dynamic> json) => ImdgClassData(
    id: json["ID"],
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
  );
  int? id;
  String? code;
  String? typeName;
  bool? isActive;

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Code": code,
    "TypeName": typeName,
    "IsActive": isActive == true ? 1 : 0,
  };

  ImdgClassEntity toEntity() {
    return ImdgClassEntity(
      id: id ?? -1,
      code: code ?? '',
      isActive: isActive ?? false,
      typeName: typeName ?? '',
    );
  }
}
