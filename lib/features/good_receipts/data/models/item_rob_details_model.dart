import 'dart:convert';

import '../../domain/entities/item_rob_details_entity.dart';

class ItemRobDetailsResponseModel {
  final String? moduleCode;
  final String? entityName;
  final List<ItemRobDetailsModelData>? reportData;
  final int? recordCount;
  final EntityValidation? entityValidation;

  ItemRobDetailsResponseModel({
    this.moduleCode,
    this.entityName,
    this.reportData,
    this.recordCount,
    this.entityValidation,
  });

  ItemRobDetailsResponseModel copyWith({
    String? moduleCode,
    String? entityName,
    List<ItemRobDetailsModelData>? reportData,
    int? recordCount,
    EntityValidation? entityValidation,
  }) =>
      ItemRobDetailsResponseModel(
        moduleCode: moduleCode ?? this.moduleCode,
        entityName: entityName ?? this.entityName,
        reportData: reportData ?? this.reportData,
        recordCount: recordCount ?? this.recordCount,
        entityValidation: entityValidation ?? this.entityValidation,
      );

  factory ItemRobDetailsResponseModel.fromRawJson(String str) => ItemRobDetailsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemRobDetailsResponseModel.fromJson(Map<String, dynamic> json) => ItemRobDetailsResponseModel(
    moduleCode: json["moduleCode"],
    entityName: json["entityName"],
    reportData: json["reportData"] == null ? [] : List<ItemRobDetailsModelData>.from(json["reportData"]!.map((x) => ItemRobDetailsModelData.fromJson(x))),
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

class ItemRobDetailsModelData {
  final int? storageLocationId;
  final String? storageLocation;
  final String? storageLocationHierarchy;
  final int? referenceId;
  final int? referenceSubId;
  final int? referenceTypeId;
  final int? itemId;
  final int? itemLinkId;
  final String? inventoryDate;
  final String? expiryDate;
  final double? totalRob;
  final double? newStock;
  final double? reconditionedStock;
  final double? receivedQty;

  ItemRobDetailsModelData({
    this.storageLocationId,
    this.storageLocation,
    this.storageLocationHierarchy,
    this.referenceId,
    this.referenceSubId,
    this.referenceTypeId,
    this.itemId,
    this.itemLinkId,
    this.inventoryDate,
    this.expiryDate,
    this.totalRob,
    this.newStock,
    this.reconditionedStock,
    this.receivedQty,
  });

  ItemRobDetailsModelData copyWith({
    int? storageLocationId,
    String? storageLocation,
    String? storageLocationHierarchy,
    int? referenceId,
    int? referenceSubId,
    int? referenceTypeId,
    int? itemId,
    int? itemLinkId,
    String? inventoryDate,
    String? expiryDate,
    double? totalRob,
    double? newStock,
    double? reconditionedStock,
    double? receivedQty,
  }) =>
      ItemRobDetailsModelData(
        storageLocationId: storageLocationId ?? this.storageLocationId,
        storageLocation: storageLocation ?? this.storageLocation,
        storageLocationHierarchy: storageLocationHierarchy ?? this.storageLocationHierarchy,
        referenceId: referenceId ?? this.referenceId,
        referenceSubId: referenceSubId ?? this.referenceSubId,
        referenceTypeId: referenceTypeId ?? this.referenceTypeId,
        itemId: itemId ?? this.itemId,
        itemLinkId: itemLinkId ?? this.itemLinkId,
        inventoryDate: inventoryDate ?? this.inventoryDate,
        expiryDate: expiryDate ?? this.expiryDate,
        totalRob: totalRob ?? this.totalRob,
        newStock: newStock ?? this.newStock,
        reconditionedStock: reconditionedStock ?? this.reconditionedStock,
        receivedQty: receivedQty ?? this.receivedQty,
      );

  factory ItemRobDetailsModelData.fromRawJson(String str) => ItemRobDetailsModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemRobDetailsModelData.fromJson(Map<String, dynamic> json) => ItemRobDetailsModelData(
    storageLocationId: json["StorageLocationID"],
    storageLocation: json["StorageLocation"],
    storageLocationHierarchy: json["StorageLocationHierarchy"],
    referenceId: json["ReferenceID"],
    referenceSubId: json["ReferenceSubID"],
    referenceTypeId: json["ReferenceTypeID"],
    itemId: json["ItemID"],
    itemLinkId: json["ItemLinkID"],
    inventoryDate: json["InventoryDate"],
    expiryDate: json["ExpiryDate"],
    totalRob: json["TotalROB"],
    newStock: json["NewStock"],
    reconditionedStock: json["ReconditionedStock"],
    receivedQty: json["ReceivedQty"],
  );

  Map<String, dynamic> toJson() => {
    "StorageLocationID": storageLocationId,
    "StorageLocation": storageLocation,
    "StorageLocationHierarchy": storageLocationHierarchy,
    "ReferenceID": referenceId,
    "ReferenceSubID": referenceSubId,
    "ReferenceTypeID": referenceTypeId,
    "ItemID": itemId,
    "ItemLinkID": itemLinkId,
    "InventoryDate": inventoryDate?.toString(),
    "ExpiryDate": expiryDate?.toString(),
    "TotalROB": totalRob,
    "NewStock": newStock,
    "ReconditionedStock": reconditionedStock,
    "ReceivedQty": receivedQty,
  };

}
extension ItemRobDetailsMapper on ItemRobDetailsModelData {
  ItemRobDetailsEntity toEntity() {
    return ItemRobDetailsEntity(
      storageLocationId: storageLocationId,
      storageLocation: storageLocation,
      storageLocationHierarchy: storageLocationHierarchy,
      referenceId: referenceId,
      referenceSubId: referenceSubId,
      referenceTypeId: referenceTypeId,
      itemId: itemId,
      itemLinkId: itemLinkId,
      inventoryDate: inventoryDate,
      expiryDate: expiryDate,
      totalROB: totalRob,
      newStock: newStock,
      reconditionedStock: reconditionedStock,
      receivedQty: receivedQty,
    );
  }
}
