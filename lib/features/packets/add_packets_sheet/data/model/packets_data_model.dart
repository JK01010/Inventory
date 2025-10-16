import '../../domain/entities/packets_entity.dart';

class PacketsDataModel {
  PacketsDataModel({
    this.id,
    this.poHdId,
    this.width,
    this.length,
    this.height,
    this.weight,
    this.actualVolume,
    this.packetName,
  });

  factory PacketsDataModel.fromEntity(PacketEntity packetEntity) {
    return PacketsDataModel(
      id: packetEntity.id,
      poHdId: packetEntity.poHdId,
      width: packetEntity.width,
      length: packetEntity.length,
      height: packetEntity.height,
      weight: packetEntity.weight,
      actualVolume: packetEntity.actualVolume,
      packetName: packetEntity.packetName,
    );
  }

  PacketEntity toEntity() {
    return PacketEntity(
      id: id ?? -1,
      poHdId: poHdId ?? -1,
      width: width ?? 0,
      length: length ?? 0,
      height: height ?? 0,
      weight: weight ?? 0,
      actualVolume: actualVolume ?? 0,
      packetName: packetName ?? "",
    );
  }

  factory PacketsDataModel.fromJson(Map<String, dynamic> json) =>
      PacketsDataModel(
        id: json["id"],
        poHdId: json["poHdId"],
        width: json["width"],
        length: json["length"],
        height: json["height"],
        weight: json["weight"],
        actualVolume: json["actualVolume"],
        packetName: json["packetName"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "poHdId": poHdId,
    "width": width,
    "length": length,
    "height": height,
    "weight": weight,
    "actualVolume": actualVolume,
    "packetName": packetName,
  };

  final int? id;
  final int? poHdId;
  final double? width;
  final double? length;
  final double? height;
  final double? weight;
  final double? actualVolume;
  final String? packetName;
}
