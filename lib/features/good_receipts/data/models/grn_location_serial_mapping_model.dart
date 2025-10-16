import 'package:equatable/equatable.dart';
import '../../domain/entities/grn_location_serial_mapping_entity.dart';

class GRNLocationSerialMappingModel extends Equatable {

  const GRNLocationSerialMappingModel({
    required this.id,
    required this.serialNumberID,
    required this.serialNumber,
    required this.grnHdID,
    required this.grnDtID,
  });

  /// Factory to create model from JSON with null checks
  factory GRNLocationSerialMappingModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const GRNLocationSerialMappingModel(
        id: 0,
        serialNumberID: 0,
        serialNumber: '',
        grnHdID: 0,
        grnDtID: 0,
      );
    }

    return GRNLocationSerialMappingModel(
      id: json['ID'] is int
          ? json['ID'] as int
          : int.tryParse(json['ID']?.toString() ?? '') ?? 0,
      serialNumberID: json['SerialNumberID'] is int
          ? json['SerialNumberID'] as int
          : int.tryParse(json['SerialNumberID']?.toString() ?? '') ?? 0,
      serialNumber: json['SerialNumber']?.toString() ?? '',
      grnHdID: json['GRNHDID'] is int
          ? json['GRNHDID'] as int
          : int.tryParse(json['GRNHDID']?.toString() ?? '') ?? 0,
      grnDtID: json['GRNDTID'] is int
          ? json['GRNDTID'] as int
          : int.tryParse(json['GRNDTID']?.toString() ?? '') ?? 0,
    );
  }

  /// Convert Entity → Model
  factory GRNLocationSerialMappingModel.fromEntity(
      GRNLocationSerialMappingEntity entity) {
    return GRNLocationSerialMappingModel(
      id: entity.id,
      serialNumberID: entity.serialNumberID,
      serialNumber: entity.serialNumber,
      grnHdID: entity.grnHdID,
      grnDtID: entity.grnDtID,
    );
  }
  final int id;
  final int serialNumberID;
  final String serialNumber;
  final int grnHdID;
  final int grnDtID;

  /// Convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SerialNumberID': serialNumberID,
      'SerialNumber': serialNumber,
      'GRNHDID': grnHdID,
      'GRNDTID': grnDtID,
    };
  }

  /// Convert Model → Entity
  GRNLocationSerialMappingEntity toEntity() {
    return GRNLocationSerialMappingEntity(
      id: id,
      serialNumberID: serialNumberID,
      serialNumber: serialNumber,
      grnHdID: grnHdID,
      grnDtID: grnDtID,
    );
  }

  @override
  List<Object?> get props => [id, serialNumberID, serialNumber, grnHdID, grnDtID];
}
