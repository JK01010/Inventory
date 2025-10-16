import 'package:equatable/equatable.dart';

class PacketDetailsEntity extends Equatable {
  PacketDetailsEntity({
    required this.id,
    required this.poId,
    required this.poDtId,
    required this.width,
    required this.length,
    required this.height,
    required this.weight,
    required this.actualVolume,
    required this.packetName,
  });

  int id;
  String poId;
  int poDtId;
  double width;
  double length;
  double height;
  double weight;
  double actualVolume;
  String packetName;

  @override
  List<Object?> get props => [
    id,
    poId,
    poDtId,
    width,
    length,
    height,
    weight,
    actualVolume,
    packetName,
  ];
}
