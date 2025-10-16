import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/packet_details_entity.dart';

class PacketDetailsResponseModel extends Equatable {
  const PacketDetailsResponseModel({required this.packetDetails});

  factory PacketDetailsResponseModel.fromMap(Map<String, dynamic> map) {
    return PacketDetailsResponseModel(
      packetDetails: List<PacketDetailsModel>.from(
        (map['packetDetails'] as List).map(
          (x) => PacketDetailsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory PacketDetailsResponseModel.fromJson(String source) =>
      PacketDetailsResponseModel.fromMap(json.decode(source));

  final List<PacketDetailsModel> packetDetails;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packetDetails': packetDetails.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [packetDetails];
}

class PacketDetailsModel extends Equatable {
  const PacketDetailsModel({
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

  factory PacketDetailsModel.fromMap(Map<String, dynamic> map) {
    return PacketDetailsModel(
      id: map['id'] as int,
      poId: map['poId'] as String,
      poDtId: map['poDtId'] as int,
      width: map['width'] as double,
      length: map['length'] as double,
      height: map['height'] as double,
      weight: map['weight'] as double,
      actualVolume: map['actualVolume'] as double,
      packetName: map['packetName'] as String,
    );
  }

  factory PacketDetailsModel.fromJson(String source) =>
      PacketDetailsModel.fromMap(json.decode(source));

  factory PacketDetailsModel.fromEntity(PacketDetailsEntity entity) =>
      PacketDetailsModel(
        id: entity.id,
        poId: entity.poId,
        poDtId: entity.poDtId,
        width: entity.width,
        length: entity.length,
        height: entity.height,
        weight: entity.weight,
        actualVolume: entity.actualVolume,
        packetName: entity.packetName,
      );
  final int id;
  final String poId;
  final int poDtId;
  final double width;
  final double length;
  final double height;
  final double weight;
  final double actualVolume;
  final String packetName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'poId': poId,
      'poDtId': poDtId,
      'width': width,
      'length': length,
      'height': height,
      'weight': weight,
      'actualVolume': actualVolume,
      'packetName': packetName,
    };
  }

  static List<PacketDetailsModel> fromEntityList(
    List<PacketDetailsEntity> packetDetailsEntityList,
  ) {
    List<PacketDetailsModel> packetDetailsModelList = [];
    for (var entity in packetDetailsEntityList) {
      packetDetailsModelList.add(PacketDetailsModel.fromEntity(entity));
    }
    return packetDetailsModelList;
  }

  String toJson() => json.encode(toMap());

  PacketDetailsModel copyWith({
    int? id,
    String? poId,
    int? poDtId,
    double? width,
    double? length,
    double? height,
    double? weight,
    double? actualVolume,
    String? packetName,
  }) {
    return PacketDetailsModel(
      id: id ?? this.id,
      poId: poId ?? this.poId,
      poDtId: poDtId ?? this.poDtId,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      actualVolume: actualVolume ?? this.actualVolume,
      packetName: packetName ?? this.packetName,
    );
  }

  PacketDetailsEntity toEntity() => PacketDetailsEntity(
    id: id,
    poId: poId,
    poDtId: poDtId,
    width: width,
    length: length,
    height: height,
    weight: weight,
    actualVolume: actualVolume,
    packetName: packetName,
  );

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

  @override
  bool? get stringify => true;
}
