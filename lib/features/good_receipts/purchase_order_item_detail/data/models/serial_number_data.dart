
import 'dart:convert';

import '../../domain/entity/serial_number_entity.dart';

List<SerialNumberData> serialNumberDataFromJson(String str) =>
    List<SerialNumberData>.from(
      json.decode(str).map((x) => SerialNumberData.fromJson(x)),
    );

String serialNumberDataToJson(List<SerialNumberData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SerialNumberData {
  SerialNumberData({
    this.id,
    this.serialNumber,
    this.isDeleted,
    this.createdById,
    this.createdOn,
    this.modifiedById,
    this.modifiedOn,
    this.versionIdentifier,
    this.duplicateId,
    this.matchId,
    this.poHdId,
    this.poDtId,
    this.typeId,
    this.grnId,
    this.grnDtId,
    this.splitLocationId,
    this.isManuallyEdited,
  });

  factory SerialNumberData.fromJson(
    Map<dynamic, dynamic> json,
  ) => SerialNumberData(
    id: json["id"],
    serialNumber: json["serialNumber"],
    isDeleted: json["isDeleted"],
    createdById: json["createdByID"],
    createdOn:
        json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedById: json["modifiedById"],
    modifiedOn:
        json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    versionIdentifier: json["versionIdentifier"]?.toDouble(),
    duplicateId: json["duplicateID"],
    matchId: json["matchID"],
  );

  factory SerialNumberData.fromJsonForPurchaseOrderTable(
    Map<String, dynamic> json,
  ) => SerialNumberData(
    id: json["serialNumberId"],
    serialNumber: json["serialNumber"],
    poHdId: json["poDtId"],
    poDtId: json["poDtId"],
    typeId: json["typeId"],
    splitLocationId: json["splitLocationId"],
    isManuallyEdited:
        json["isManuallyEdited"] != null
            ? json["isManuallyEdited"].runtimeType == bool
                ? json["isManuallyEdited"]
                : json["isManuallyEdited"] == 1
                ? true
                : false
            : false,
  );

  factory SerialNumberData.fromEntity(SerialNumberEntity serialNumberEntity) {
    return SerialNumberData(
      id: serialNumberEntity.serialNumberId,
      serialNumber: serialNumberEntity.serialNumber,
      poHdId: serialNumberEntity.poHdId,
      grnId: serialNumberEntity.grnId,
      poDtId: serialNumberEntity.poDtId,
      grnDtId: serialNumberEntity.grnDtId,
      typeId: serialNumberEntity.typeId,
      splitLocationId: serialNumberEntity.splitLocationId,
      isManuallyEdited: serialNumberEntity.isManuallyEdited,
    );
  }

  SerialNumberEntity toEntity() {
    return SerialNumberEntity(
      poHdId: poHdId ?? -1,
      poDtId: poDtId ?? -1,
      typeId: typeId ?? -1,
      serialNumberId: id ?? -1,
      serialNumber: serialNumber ?? '',
      grnId: grnId ?? -1,
      grnDtId: grnDtId ?? -1,
      isManuallyEdited: isManuallyEdited ?? false,
      splitLocationId: splitLocationId ?? -1,
    );
  }

  int? id;
  String? serialNumber;
  bool? isDeleted;
  int? createdById;
  DateTime? createdOn;
  int? modifiedById;
  DateTime? modifiedOn;
  double? versionIdentifier;
  int? duplicateId;
  bool? matchId;
  int? poHdId;
  int? poDtId;
  int? typeId;
  int? grnId;
  int? grnDtId;
  int? splitLocationId;
  bool? isManuallyEdited;

  Map<String, dynamic> toJson() => {
    "id": id,
    "serialNumber": serialNumber,
    "isDeleted": isDeleted,
    "createdByID": createdById,
    "createdOn": createdOn?.toIso8601String(),
    "modifiedById": modifiedById,
    "modifiedOn": modifiedOn?.toIso8601String(),
    "versionIdentifier": versionIdentifier,
    "duplicateID": duplicateId,
    "matchID": matchId,
  };

  Map<String, dynamic> toJsonForPurchaseOrderTableSave() => {
    "serialNumberId": id,
    "poHdId": poHdId,
    "poDtId": poDtId,
    "serialNumber": serialNumber,
    "typeId": typeId,
    "splitLocationId": splitLocationId,
    "isManuallyEdited": isManuallyEdited == true ? 1 : 0,
  };
}
