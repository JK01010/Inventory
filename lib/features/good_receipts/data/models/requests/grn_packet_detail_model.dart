import 'dart:convert';

class GrnPacketDetailModel {
  final int? id;
  final int? grnhdid;
  final int? packetNo;
  final String? packetName;
  final int? width;
  final int? length;
  final int? height;
  final int? weight;
  final int? actualVolume;
  final int? versionIdentifier;
  final String? operationType;

  GrnPacketDetailModel({
    this.id,
    this.grnhdid,
    this.packetNo,
    this.packetName,
    this.width,
    this.length,
    this.height,
    this.weight,
    this.actualVolume,
    this.versionIdentifier,
    this.operationType,
  });

  GrnPacketDetailModel copyWith({
    int? id,
    int? grnhdid,
    int? packetNo,
    String? packetName,
    int? width,
    int? length,
    int? height,
    int? weight,
    int? actualVolume,
    int? versionIdentifier,
    String? operationType,
  }) =>
      GrnPacketDetailModel(
        id: id ?? this.id,
        grnhdid: grnhdid ?? this.grnhdid,
        packetNo: packetNo ?? this.packetNo,
        packetName: packetName ?? this.packetName,
        width: width ?? this.width,
        length: length ?? this.length,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        actualVolume: actualVolume ?? this.actualVolume,
        versionIdentifier: versionIdentifier ?? this.versionIdentifier,
        operationType: operationType ?? this.operationType,
      );

  factory GrnPacketDetailModel.fromRawJson(String str) => GrnPacketDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrnPacketDetailModel.fromJson(Map<String, dynamic> json) => GrnPacketDetailModel(
    id: json["id"],
    grnhdid: json["grnhdid"],
    packetNo: json["packetNo"],
    packetName: json["packetName"],
    width: json["width"],
    length: json["length"],
    height: json["height"],
    weight: json["weight"],
    actualVolume: json["actualVolume"],
    versionIdentifier: json["versionIdentifier"],
    operationType: json["operationType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grnhdid": grnhdid,
    "packetNo": packetNo,
    "packetName": packetName,
    "width": width,
    "length": length,
    "height": height,
    "weight": weight,
    "actualVolume": actualVolume,
    "versionIdentifier": versionIdentifier,
    "operationType": operationType,
  };
}