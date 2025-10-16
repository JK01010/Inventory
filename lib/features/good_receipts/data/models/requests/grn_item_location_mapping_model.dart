import 'dart:convert';

class GrnItemLocationMappingModel {
  final int? grndtid;
  final int? id;
  final int? itemId;
  final String? operationType;
  final int? quantity;
  final int? storageLocationId;
  final int? typeId;
  final int? versionIdentifier;
  final int? parentItemId;
  final String? typeCode;

  GrnItemLocationMappingModel({
    this.grndtid,
    this.id,
    this.itemId,
    this.operationType,
    this.quantity,
    this.storageLocationId,
    this.typeId,
    this.versionIdentifier,
    this.parentItemId,
    this.typeCode,
  });

  GrnItemLocationMappingModel copyWith({
    int? grndtid,
    int? id,
    int? itemId,
    String? operationType,
    int? quantity,
    int? storageLocationId,
    int? typeId,
    int? versionIdentifier,
    int? parentItemId,
    String? typeCode,
  }) =>
      GrnItemLocationMappingModel(
        grndtid: grndtid ?? this.grndtid,
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        operationType: operationType ?? this.operationType,
        quantity: quantity ?? this.quantity,
        storageLocationId: storageLocationId ?? this.storageLocationId,
        typeId: typeId ?? this.typeId,
        versionIdentifier: versionIdentifier ?? this.versionIdentifier,
        parentItemId: parentItemId ?? this.parentItemId,
        typeCode: typeCode ?? this.typeCode,
      );

  factory GrnItemLocationMappingModel.fromRawJson(String str) => GrnItemLocationMappingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrnItemLocationMappingModel.fromJson(Map<String, dynamic> json) => GrnItemLocationMappingModel(
    grndtid: json["grndtid"],
    id: json["id"],
    itemId: json["itemID"],
    operationType: json["operationType"],
    quantity: json["quantity"],
    storageLocationId: json["storageLocationID"],
    typeId: json["typeId"],
    versionIdentifier: json["versionIdentifier"],
    parentItemId: json["parentItemID"],
    typeCode: json["typeCode"],
  );

  Map<String, dynamic> toJson() => {
    "grndtid": grndtid,
    "id": id,
    "itemID": itemId,
    "operationType": operationType,
    "quantity": quantity,
    "storageLocationID": storageLocationId,
    "typeId": typeId,
    "versionIdentifier": versionIdentifier,
    "parentItemID": parentItemId,
    "typeCode": typeCode,
  };
}