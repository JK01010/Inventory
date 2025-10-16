import 'dart:convert';

import '../../../domain/entities/split_location_entity.dart';

SplitLocationModel splitLocationModelFromJson(String str) =>
    SplitLocationModel.fromJson(json.decode(str));

String splitLocationModelToJson(SplitLocationModel data) =>
    json.encode(data.toJson());

class SplitLocationModel {
  SplitLocationModel({
    required this.moduleCode,
    required this.entityName,
    required this.reportData,
    required this.recordCount,
    required this.entityValidation,
  });

  factory SplitLocationModel.fromJson(Map<String, dynamic> json) =>
      SplitLocationModel(
        moduleCode: json["moduleCode"],
        entityName: json["entityName"],
        reportData: List<SplitLocationData>.from(
          json["reportData"].map((x) => SplitLocationData.fromJson(x)),
        ),
        recordCount: json["recordCount"],
        entityValidation: EntityValidation.fromJson(json["entityValidation"]),
      );
  String? moduleCode;
  String? entityName;
  List<SplitLocationData>? reportData;
  int? recordCount;
  EntityValidation? entityValidation;

  Map<String, dynamic> toJson() => {
    "moduleCode": moduleCode,
    "entityName": entityName,
    "reportData":
        reportData != null
            ? List<dynamic>.from(reportData!.map((x) => x.toJson()))
            : [],
    "recordCount": recordCount,
    "entityValidation": entityValidation?.toJson(),
  };
}

class EntityValidation {
  EntityValidation({required this.status, required this.validationMessages});

  factory EntityValidation.fromJson(Map<String, dynamic> json) =>
      EntityValidation(
        status: json["status"],
        validationMessages: List<dynamic>.from(
          json["validationMessages"].map((x) => x),
        ),
      );
  bool status;
  List<dynamic> validationMessages;

  Map<String, dynamic> toJson() => {
    "status": status,
    "validationMessages": List<dynamic>.from(validationMessages.map((x) => x)),
  };
}

class SplitLocationData {
  SplitLocationData({
    this.id,
    this.grnhdid,
    this.grndtid,
    this.storageLocationId,
    this.code,
    this.locationName,
    this.description,
    this.itemId,
    this.parentItemId,
    this.typeId,
    this.quantity,
    this.parentId,
    this.isActive,
    this.locationHierarchy,
  });

  factory SplitLocationData.fromJson(Map<String, dynamic> json) =>
      SplitLocationData(
        id: json["ID"],
        grnhdid: json["GRNHDID"],
        grndtid: json["GRNDTID"],
        storageLocationId: json["StorageLocationID"],
        code: json["Code"],
        locationName: json["LocationName"],
        description: json["Description"],
        itemId: json["ItemID"],
        parentItemId: json["ParentItemID"],
        typeId: json["TypeID"],
        quantity: json["Quantity"],
        parentId: json["ParentID"],
        isActive:
            json["IsActive"] != null
                ? json["IsActive"].runtimeType == bool
                    ? json["IsActive"]
                    : json["IsActive"] == 1
                    ? true
                    : false
                : false,
        locationHierarchy: json["LocationHierarchy"],
      );

  factory SplitLocationData.fromEntity(
    SplitLocationEntity splitLocationEntity,
  ) {
    return SplitLocationData(
      id: splitLocationEntity.id,
      itemId: splitLocationEntity.itemId,
      // locationId: splitLocationEntity.locationId,
      // poId: splitLocationEntity.poId,
      // robQty: splitLocationEntity.robQty,
      // poDtId: splitLocationEntity.poDtId,
      // quantityType: splitLocationEntity.quantityType,
      // transactionId: splitLocationEntity.transactionId,
      locationName: splitLocationEntity.locationName,
    );
  }

  int? id;
  int? grnhdid;
  int? grndtid;
  int? storageLocationId;
  String? code;
  String? locationName;
  String? description;
  int? itemId;
  int? parentItemId;
  int? typeId;
  double? quantity;
  int? parentId;
  bool? isActive;
  String? locationHierarchy;

  Map<String, dynamic> toJson() => {
    "ID": id,
    "GRNHDID": grnhdid,
    "GRNDTID": grndtid,
    "StorageLocationID": storageLocationId,
    "Code": code,
    "LocationName": locationName,
    "Description": description,
    "ItemID": itemId,
    "ParentItemID": parentItemId,
    "TypeID": typeId,
    "Quantity": quantity,
    "ParentID": parentId,
    "IsActive": isActive == true ? 1 : 0,
    "LocationHierarchy": locationHierarchy,
  };

  static List<SplitLocationData> fromEntityList(
    List<SplitLocationEntity> splitLocationEntityList,
  ) {
    List<SplitLocationData> splitLocationData = [];
    for (var entity in splitLocationEntityList) {
      splitLocationData.add(SplitLocationData.fromEntity(entity));
    }
    return splitLocationData;
  }

  SplitLocationEntity toEntity() {
    return SplitLocationEntity(
      id: id ?? 0,
      itemId: itemId ?? 0,
      locationId: storageLocationId ?? -1,
      poId: -1,
      robQty: 123,
      poDtId: -1,
      quantityType: "quantityType",
      transactionId: "transactionId",
      locationName: locationName ?? '',
      grnDtId: grndtid ?? -1,
      code: code ?? '',
      description: description ?? '',
      parentItemId: parentItemId ?? -1,
      typeId: typeId ?? -1,
      quantity: quantity ?? -1,
      parentId: parentId ?? -1,
      isActive: isActive ?? false,
      locationHierarchy: locationHierarchy ?? '',
      grnHdId: grnhdid ?? -1,
        serialNumbers: []
    );
  }
}
