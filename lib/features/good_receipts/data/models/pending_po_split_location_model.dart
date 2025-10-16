import '../../domain/entities/split_location_entity.dart';

class PendingPoSplitLocationModel {
  PendingPoSplitLocationModel({
    this.id,
    this.poHdId,
    this.poDtId,
    this.storageLocationId,
    this.locationName,
    this.typeId,
    this.quantity,
    this.isActive,
    this.itemId,
  });

  factory PendingPoSplitLocationModel.fromJson(Map<String, dynamic> json) =>
      PendingPoSplitLocationModel(
        id: json["ID"],
        poHdId: json["poHdId"],
        poDtId: json["poDtId"],
        storageLocationId: json["StorageLocationID"],
        locationName: json["LocationName"],
        typeId: json["TypeID"],
        quantity: json["Quantity"],
        isActive:
            json["IsActive"] != null
                ? json["IsActive"].runtimeType == bool
                    ? json["IsActive"]
                    : json["IsActive"] == 1
                    ? true
                    : false
                : false,
        itemId: json["itemId"],
      );

  factory PendingPoSplitLocationModel.fromEntity(
    SplitLocationEntity splitLocationEntity,
  ) {
    return PendingPoSplitLocationModel(
      id: splitLocationEntity.id,
      poDtId: splitLocationEntity.poDtId,
      storageLocationId: splitLocationEntity.locationId,
      locationName: splitLocationEntity.locationName,
      typeId: splitLocationEntity.typeId,
      quantity: splitLocationEntity.quantity,
      isActive: splitLocationEntity.isActive,
      poHdId: splitLocationEntity.poId,
      itemId: splitLocationEntity.itemId,
    );
  }

  int? id;
  int? poHdId;
  int? poDtId;
  int? storageLocationId;
  String? locationName;
  int? typeId;
  double? quantity;
  bool? isActive;
  int? itemId;

  Map<String, dynamic> toJson() => {
    "ID": id,
    "StorageLocationID": storageLocationId,
    "LocationName": locationName,
    "TypeID": typeId,
    "Quantity": quantity,
    "IsActive": isActive == true ? 1 : 0,
    "poHdId": poHdId,
    "poDtId": poDtId,
    "itemId": itemId,
  };

  Map<String, dynamic> toJsonForSaveApi() => {
    "id": id,
    "itemID": itemId,
    'operationType': "INS",
    "quantity": quantity,
    "storageLocationID": storageLocationId,
    "typeId": typeId,
    "versionIdentifier": 0,
    "parentItemID": 0,
    "typeCode":
        typeId == 1
            ? "DAMSTK"
            : typeId == 2
            ? "NEWSTK"
            : 'RECSTK',
  };

  SplitLocationEntity toEntity() {
    return SplitLocationEntity(
      id: id ?? -1,
      itemId: itemId ?? -1,
      locationId: storageLocationId ?? -1,
      poId: poHdId ?? -1,
      robQty: 123,
      poDtId: poDtId ?? -1,
      quantityType: "quantityType",
      transactionId: "transactionId",
      locationName: locationName ?? '',
      grnDtId: poDtId ?? -1,
      code: '',
      description: '',
      parentItemId: -1,
      typeId: typeId ?? -1,
      quantity: quantity ?? -1,
      parentId: -1,
      isActive: isActive ?? false,
      locationHierarchy: '',
      grnHdId: -1,
      serialNumbers: [],
    );
  }
}
