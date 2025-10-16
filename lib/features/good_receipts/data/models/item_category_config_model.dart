import 'dart:convert';

class ItemCategoryConfigResponseModel {
  final String? moduleCode;
  final String? entityName;
  final List<ItemCategoryConfigModelData>? reportData;
  final int? recordCount;
  final EntityValidation? entityValidation;

  ItemCategoryConfigResponseModel({
    this.moduleCode,
    this.entityName,
    this.reportData,
    this.recordCount,
    this.entityValidation,
  });

  ItemCategoryConfigResponseModel copyWith({
    String? moduleCode,
    String? entityName,
    List<ItemCategoryConfigModelData>? reportData,
    int? recordCount,
    EntityValidation? entityValidation,
  }) =>
      ItemCategoryConfigResponseModel(
        moduleCode: moduleCode ?? this.moduleCode,
        entityName: entityName ?? this.entityName,
        reportData: reportData ?? this.reportData,
        recordCount: recordCount ?? this.recordCount,
        entityValidation: entityValidation ?? this.entityValidation,
      );

  factory ItemCategoryConfigResponseModel.fromRawJson(String str) => ItemCategoryConfigResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemCategoryConfigResponseModel.fromJson(Map<String, dynamic> json) => ItemCategoryConfigResponseModel(
    moduleCode: json["moduleCode"],
    entityName: json["entityName"],
    reportData: json["reportData"] == null ? [] : List<ItemCategoryConfigModelData>.from(json["reportData"]!.map((x) => ItemCategoryConfigModelData.fromJson(x))),
    recordCount: json["recordCount"],
    entityValidation: json["entityValidation"] == null ? null : EntityValidation.fromJson(json["entityValidation"]),
  );

  Map<String, dynamic> toJson() => {
    "moduleCode": moduleCode,
    "entityName": entityName,
    "reportData": reportData == null ? [] : List<dynamic>.from(reportData!.map((x) => x.toJson())),
    "recordCount": recordCount,
    "entityValidation": entityValidation?.toJson(),
  };
}

class EntityValidation {
  final bool? status;
  final List<dynamic>? validationMessages;

  EntityValidation({
    this.status,
    this.validationMessages,
  });

  EntityValidation copyWith({
    bool? status,
    List<dynamic>? validationMessages,
  }) =>
      EntityValidation(
        status: status ?? this.status,
        validationMessages: validationMessages ?? this.validationMessages,
      );

  factory EntityValidation.fromRawJson(String str) => EntityValidation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntityValidation.fromJson(Map<String, dynamic> json) => EntityValidation(
    status: json["status"],
    validationMessages: json["validationMessages"] == null ? [] : List<dynamic>.from(json["validationMessages"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "validationMessages": validationMessages == null ? [] : List<dynamic>.from(validationMessages!.map((x) => x)),
  };
}

class ItemCategoryConfigModelData {
  final String? propertyValue;
  final int? itemCategoryId;
  final int? propertyId;
  final String? propertyCode;

  ItemCategoryConfigModelData({
    this.propertyValue,
    this.itemCategoryId,
    this.propertyId,
    this.propertyCode,
  });

  ItemCategoryConfigModelData copyWith({
    String? propertyValue,
    int? itemCategoryId,
    int? propertyId,
    String? propertyCode,
  }) =>
      ItemCategoryConfigModelData(
        propertyValue: propertyValue ?? this.propertyValue,
        itemCategoryId: itemCategoryId ?? this.itemCategoryId,
        propertyId: propertyId ?? this.propertyId,
        propertyCode: propertyCode ?? this.propertyCode,
      );

  factory ItemCategoryConfigModelData.fromRawJson(String str) => ItemCategoryConfigModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemCategoryConfigModelData.fromJson(Map<String, dynamic> json) => ItemCategoryConfigModelData(
    propertyValue: json["PropertyValue"],
    itemCategoryId: json["ItemCategoryID"],
    propertyId: json["PropertyID"],
    propertyCode: json["PropertyCode"],
  );

  Map<String, dynamic> toJson() => {
    "PropertyValue": propertyValue,
    "ItemCategoryID": itemCategoryId,
    "PropertyID": propertyId,
    "PropertyCode": propertyCode,
  };
}
