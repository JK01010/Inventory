import 'package:equatable/equatable.dart';

class PortEntity extends Equatable {
  const PortEntity({
    required this.id,
    required this.code,
    required this.portName,
    required this.countryID,
    required this.countryName,
    required this.airportID,
    required this.timeZoneID,
    required this.latitude,
    required this.latDegree,
    required this.latMinutes,
    required this.latDirection,
    required this.longitude,
    required this.lonDegree,
    required this.lonMinutes,
    required this.lonDirection,
    required this.unLoccode,
    required this.isUnLoccodeRqd,
    required this.subDevision,
    required this.transhipmentHub,
    required this.sortOrder,
    required this.remarks,
    required this.isActive,
    required this.isDeleted,
    required this.createdByID,
    required this.createdOn,
    required this.modifiedByID,
    required this.modifiedOn,
    required this.versionIdentifier,
    required this.operationType,
  });

  final int id;
  final String code;
  final String portName;
  final int countryID;
  final String countryName;
  final int airportID;
  final int timeZoneID;
  final num latitude;
  final num latDegree;
  final num latMinutes;
  final String latDirection;
  final num longitude;
  final num lonDegree;
  final num lonMinutes;
  final String lonDirection;
  final String unLoccode;
  final bool isUnLoccodeRqd;
  final String subDevision;
  final String transhipmentHub;
  final int sortOrder;
  final String remarks;
  final bool isActive;
  final bool isDeleted;
  final int createdByID;
  final String createdOn;
  final int modifiedByID;
  final String modifiedOn;
  final int versionIdentifier;
  final String operationType;

  @override
  List<Object?> get props => [
    id,
    code,
    portName,
    countryID,
    countryName,
    airportID,
    timeZoneID,
    latitude,
    latDegree,
    latMinutes,
    latDirection,
    longitude,
    lonDegree,
    lonMinutes,
    lonDirection,
    unLoccode,
    isUnLoccodeRqd,
    subDevision,
    transhipmentHub,
    sortOrder,
    remarks,
    isActive,
    isDeleted,
    createdByID,
    createdOn,
    modifiedByID,
    modifiedOn,
    versionIdentifier,
    operationType,
  ];
}
