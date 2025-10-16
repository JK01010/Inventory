import 'dart:convert';

class GrnLocationSerialMappingModel {
  final int? grnDtId;
  final int? gRnItemLocationMappingId;
  final int? iD;
  final String? operationType;
  final int? quantity;
  final String? serialNumber;
  final int? serialNumberId;
  final int? versionIdentifier;

  GrnLocationSerialMappingModel({
    this.grnDtId,
    this.gRnItemLocationMappingId,
    this.iD,
    this.operationType,
    this.quantity,
    this.serialNumber,
    this.serialNumberId,
    this.versionIdentifier,
  });

  GrnLocationSerialMappingModel copyWith({
    int? grnDtId,
    int? gRnItemLocationMappingId,
    int? iD,
    String? operationType,
    int? quantity,
    String? serialNumber,
    int? serialNumberId,
    int? versionIdentifier,
  }) =>
      GrnLocationSerialMappingModel(
        grnDtId: grnDtId ?? this.grnDtId,
        gRnItemLocationMappingId: gRnItemLocationMappingId ?? this.gRnItemLocationMappingId,
        iD: iD ?? this.iD,
        operationType: operationType ?? this.operationType,
        quantity: quantity ?? this.quantity,
        serialNumber: serialNumber ?? this.serialNumber,
        serialNumberId: serialNumberId ?? this.serialNumberId,
        versionIdentifier: versionIdentifier ?? this.versionIdentifier,
      );

  factory GrnLocationSerialMappingModel.fromRawJson(String str) => GrnLocationSerialMappingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrnLocationSerialMappingModel.fromJson(Map<String, dynamic> json) => GrnLocationSerialMappingModel(
    grnDtId: json["grnDtId"],
    gRnItemLocationMappingId: json["gRNItemLocationMappingID"],
    iD: json["iD"],
    operationType: json["operationType"],
    quantity: json["quantity"],
    serialNumber: json["serialNumber"],
    serialNumberId: json["serialNumberID"],
    versionIdentifier: json["versionIdentifier"],
  );

  Map<String, dynamic> toJson() => {
    "grnDtId": grnDtId,
    "gRNItemLocationMappingID": gRnItemLocationMappingId,
    "iD": iD,
    "operationType": operationType,
    "quantity": quantity,
    "serialNumber": serialNumber,
    "serialNumberID": serialNumberId,
    "versionIdentifier": versionIdentifier,
  };
}