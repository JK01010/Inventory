import 'package:equatable/equatable.dart';

import '../../../common_feature/data/model/fetch_imdg_class_model.dart';
import '../../domain/entities/packet_details_entity.dart';
import 'packet_details_model.dart';

class GrnPacketDetailsResponseModel extends Equatable {
  const GrnPacketDetailsResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory GrnPacketDetailsResponseModel.fromJson(Map<String, dynamic> map) {
    return GrnPacketDetailsResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<GRNPacketDetailsModel>.from(
        (map['reportData'] as List).map(
              (x) => GRNPacketDetailsModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<GRNPacketDetailsModel>? reportData;
  final EntityValidation entityValidation;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'entityValidation': entityValidation.toMap(),
    };
  }

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    recordCount,
    reportData,
    entityValidation,
  ];

  @override
  bool? get stringify => true;
}

class GRNPacketDetailsModel extends Equatable {
  const GRNPacketDetailsModel({
    required this.id,
    required this.packetNo,
    required this.weight,
    required this.height,
    required this.width,
    required this.actualVolume,
    required this.length,
    required this.grnHdId,
    required this.packetName,
  });

  factory GRNPacketDetailsModel.fromJson(Map<String, dynamic> map) {
    return GRNPacketDetailsModel(
      id: map['ID'] != null ? map['ID'] as int : null,
      packetNo: map['PacketNo'] != null ? map['PacketNo'] as int : null,
      weight: map['Weight'] != null ? map['Weight'] as double : null,
      height: map['Height'] != null ? map['Height'] as double : null,
      width: map['Width'] != null ? map['Width'] as double : null,
      actualVolume: map['ActualVolume'] != null ? map['ActualVolume'] as double : null,
      length: map['Length'] != null ? map['Length'] as double : null,
      grnHdId: map['GRNHDID'] != null ? map['GRNHDID'] as int : null,
      packetName: map['PacketName'] != null ? map['PacketName'] as String : null,
    );
  }

  factory GRNPacketDetailsModel.fromEntity(PacketDetailsEntity entity) {
    return GRNPacketDetailsModel(
      id: entity.id,
      packetNo: 0,
      weight: entity.weight,
      height: entity.height,
      width: entity.width,
      actualVolume: entity.actualVolume,
      length: entity.length,
      grnHdId: 0,
      packetName: entity.packetName,
    );
  }

  final int? id;
  final int? packetNo;
  final double? weight;
  final double? height;
  final double? width;
  final double? actualVolume;
  final double? length;
  final int? grnHdId;
  final String? packetName;


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ID': id,
      'PacketNo': packetNo,
      'Weight': weight,
      'Height': height,
      'Width': width,
      'ActualVolume': actualVolume,
      'Length': length,
      'GRNHDID': grnHdId,
      'PacketName': packetName,
    };
  }

  PacketDetailsModel toEntity() => PacketDetailsModel(
        id: id ?? 0,
        weight: weight ?? 0.0,
        height: height ?? 0.0,
        width: width ?? 0.0,
        actualVolume: actualVolume ?? 0.0,
        length: length ?? 0.0,
        packetName: packetName ?? '',
        poId: '',
        poDtId: 0,
      );

  @override
  List<Object?> get props => [
        id,
        packetNo,
        weight,
        height,
        width,
        actualVolume,
        length,
        grnHdId,
        packetName,
      ];

  @override
  bool? get stringify => true;
}
