import 'package:equatable/equatable.dart';

class GRNLocationSerialMappingEntity extends Equatable {

  const GRNLocationSerialMappingEntity({
    required this.id,
    required this.serialNumberID,
    required this.serialNumber,
    required this.grnHdID,
    required this.grnDtID,
  });

  /// Factory to create entity from JSON
  factory GRNLocationSerialMappingEntity.fromJson(Map<String, dynamic> json) {
    return GRNLocationSerialMappingEntity(
      id: json['ID'] as int,
      serialNumberID: json['SerialNumberID'] as int,
      serialNumber: json['SerialNumber'] as String,
      grnHdID: json['GRNHDID'] as int,
      grnDtID: json['GRNDTID'] as int,
    );
  }
  final int id;
  final int serialNumberID;
  final String serialNumber;
  final int grnHdID;
  final int grnDtID;

  /// Convert entity to JSON
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SerialNumberID': serialNumberID,
      'SerialNumber': serialNumber,
      'GRNHDID': grnHdID,
      'GRNDTID': grnDtID,
    };
  }

  @override
  List<Object?> get props => [id, serialNumberID, serialNumber, grnHdID, grnDtID];
}
