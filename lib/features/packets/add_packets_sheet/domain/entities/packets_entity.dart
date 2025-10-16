import 'package:equatable/equatable.dart';

class PacketEntity extends Equatable {
  const PacketEntity({
    required this.id,
    required this.poHdId,
    required this.width,
    required this.length,
    required this.height,
    required this.weight,
    required this.actualVolume,
    required this.packetName,
  });

  factory PacketEntity.initial() {
    return PacketEntity(
      id: -1,
      poHdId: -1,
      width: 0,
      length: 0,
      height: 0,
      weight: 0,
      actualVolume: 0,
      packetName: "",
    );
  }

  final int id;
  final int poHdId;
  final double width;
  final double length;
  final double height;
  final double weight;
  final double actualVolume;
  final String packetName;

  @override
  List<Object?> get props => [
    id,
    poHdId,
    width,
    length,
    height,
    weight,
    actualVolume,
    packetName,
  ];

  PacketEntity copyWith({
    int? id,
    int? poHdId,
    double? width,
    double? length,
    double? height,
    double? weight,
    double? actualVolume,
    String? packetName,
  }) {
    return PacketEntity(
      id: id ?? this.id,
      poHdId: poHdId ?? this.poHdId,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      actualVolume: actualVolume ?? this.actualVolume,
      packetName: packetName ?? this.packetName,
    );
  }
}
