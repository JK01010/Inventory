// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../common_feature/domain/entities/port_entity.dart';

class PortListResponseModel extends Equatable {
  const PortListResponseModel({
    this.portList,
    this.totalCount,
    this.pageOffset,
    this.pageNext,
  });

  factory PortListResponseModel.fromJson(Map<String, dynamic> map) {
    return PortListResponseModel(
      portList:
          map['data'] != null
              ? List<PortModel>.from(
                (map['data'] as List<dynamic>).map<PortModel>(
                  (x) => PortModel.fromJson(x),
                ),
              )
              : null,
      totalCount: map['totalCount'] as int?,
      pageOffset: map['pageOffset'] as int?,
      pageNext: map['pageNext'] as int?,
    );
  }

  final List<PortModel>? portList;
  final int? totalCount;
  final int? pageOffset;
  final int? pageNext;

  @override
  List<Object?> get props => [portList, totalCount, pageOffset, pageNext];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': portList?.map((x) => x.toJson()).toList(),
      'totalCount': totalCount,
      'pageOffset': pageOffset,
      'pageNext': pageNext,
    };
  }
}

class PortModel extends Equatable {
  const PortModel({
    this.id,
    this.code,
    this.portName,
    this.countryID,
    this.countryName,
    this.airportID,
    this.timeZoneID,
    this.latitude,
    this.latDegree,
    this.latMinutes,
    this.latDirection,
    this.longitude,
    this.lonDegree,
    this.lonMinutes,
    this.lonDirection,
    this.unLoccode,
    this.isUnLoccodeRqd,
    this.subDevision,
    this.transhipmentHub,
    this.sortOrder,
    this.remarks,
    this.isActive,
    this.isDeleted,
    this.createdByID,
    this.createdOn,
    this.modifiedByID,
    this.modifiedOn,
    this.versionIdentifier,
    this.operationType,
  });

  factory PortModel.fromJson(Map<String, dynamic> map) {
    return PortModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      portName: map['portName'] != null ? map['portName'] as String : null,
      countryID: map['countryID'] != null ? map['countryID'] as int : null,
      countryName:
          map['countryName'] != null ? map['countryName'] as String : null,
      airportID: map['airportID'] != null ? map['airportID'] as int : null,
      timeZoneID: map['timeZoneID'] != null ? map['timeZoneID'] as int : null,
      latitude: map['latitude'] != null ? map['latitude'] as num : null,
      latDegree: map['latDegree'] != null ? map['latDegree'] as num : null,
      latMinutes: map['latMinutes'] != null ? map['latMinutes'] as num : null,
      latDirection:
          map['latDirection'] != null ? map['latDirection'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as num : null,
      lonDegree: map['lonDegree'] != null ? map['lonDegree'] as num : null,
      lonMinutes: map['lonMinutes'] != null ? map['lonMinutes'] as num : null,
      lonDirection:
          map['lonDirection'] != null ? map['lonDirection'] as String : null,
      unLoccode: map['unLoccode'] != null ? map['unLoccode'] as String : null,
      isUnLoccodeRqd:
          map['isUnLoccodeRqd'] != null ? map['isUnLoccodeRqd'] as bool : null,
      subDevision:
          map['subDevision'] != null ? map['subDevision'] as String : null,
      transhipmentHub:
          map['transhipmentHub'] != null
              ? map['transhipmentHub'] as String
              : null,
      sortOrder: map['sortOrder'] != null ? map['sortOrder'] as int : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      createdByID:
          map['createdByID'] != null ? map['createdByID'] as int : null,
      createdOn: map['createdOn'] != null ? map['createdOn'] as String : null,
      modifiedByID:
          map['modifiedByID'] != null ? map['modifiedByID'] as int : null,
      modifiedOn:
          map['modifiedOn'] != null ? map['modifiedOn'] as String : null,
      versionIdentifier:
          map['versionIdentifier'] != null
              ? map['versionIdentifier'] as int
              : null,
      operationType:
          map['operationType'] != null ? map['operationType'] as String : null,
    );
  }

  factory PortModel.fromEntity(PortEntity entity) {
    return PortModel(
      id: entity.id,
      code: entity.code,
      portName: entity.portName,
      countryID: entity.countryID,
      countryName: entity.countryName,
      airportID: entity.airportID,
      timeZoneID: entity.timeZoneID,
      latitude: entity.latitude,
      latDegree: entity.latDegree,
      latMinutes: entity.latMinutes,
      latDirection: entity.latDirection,
      longitude: entity.longitude,
      lonDegree: entity.lonDegree,
      lonMinutes: entity.lonMinutes,
      lonDirection: entity.lonDirection,
      unLoccode: entity.unLoccode,
      isUnLoccodeRqd: entity.isUnLoccodeRqd,
      subDevision: entity.subDevision,
      transhipmentHub: entity.transhipmentHub,
      sortOrder: entity.sortOrder,
      remarks: entity.remarks,
      isActive: entity.isActive,
      isDeleted: entity.isDeleted,
      createdByID: entity.createdByID,
      createdOn: entity.createdOn,
      modifiedByID: entity.modifiedByID,
      modifiedOn: entity.modifiedOn,
      versionIdentifier: entity.versionIdentifier,
      operationType: entity.operationType,
    );
  }

  PortEntity toEntity() {
    return PortEntity(
      id: id ?? -1,
      code: code ?? "",
      portName: portName ?? "",
      countryID: countryID ?? -1,
      countryName: countryName ?? "",
      airportID: airportID ?? -1,
      timeZoneID: timeZoneID ?? -1,
      latitude: latitude ?? -1,
      latDegree: latDegree ?? -1,
      latMinutes: latMinutes ?? -1,
      latDirection: latDirection ?? "",
      longitude: longitude ?? -1,
      lonDegree: lonDegree ?? -1,
      lonMinutes: lonMinutes ?? -1,
      lonDirection: lonDirection ?? "",
      unLoccode: unLoccode ?? "",
      isUnLoccodeRqd: isUnLoccodeRqd ?? false,
      subDevision: subDevision ?? "",
      transhipmentHub: transhipmentHub ?? "",
      sortOrder: sortOrder ?? -1,
      remarks: remarks ?? "",
      isActive: isActive ?? false,
      isDeleted: isDeleted ?? false,
      createdByID: createdByID ?? -1,
      createdOn: createdOn ?? "",
      modifiedByID: modifiedByID ?? -1,
      modifiedOn: modifiedOn ?? "",
      versionIdentifier: versionIdentifier ?? -1,
      operationType: operationType ?? "",
    );
  }

  final int? id;
  final String? code;
  final String? portName;
  final int? countryID;
  final String? countryName;
  final int? airportID;
  final int? timeZoneID;
  final num? latitude;
  final num? latDegree;
  final num? latMinutes;
  final String? latDirection;
  final num? longitude;
  final num? lonDegree;
  final num? lonMinutes;
  final String? lonDirection;
  final String? unLoccode;
  final bool? isUnLoccodeRqd;
  final String? subDevision;
  final String? transhipmentHub;
  final int? sortOrder;
  final String? remarks;
  final bool? isActive;
  final bool? isDeleted;
  final int? createdByID;
  final String? createdOn;
  final int? modifiedByID;
  final String? modifiedOn;
  final int? versionIdentifier;
  final String? operationType;

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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'portName': portName,
      'countryID': countryID,
      'countryName': countryName,
      'airportID': airportID,
      'timeZoneID': timeZoneID,
      'latitude': latitude,
      'latDegree': latDegree,
      'latMinutes': latMinutes,
      'latDirection': latDirection,
      'longitude': longitude,
      'lonDegree': lonDegree,
      'lonMinutes': lonMinutes,
      'lonDirection': lonDirection,
      'unLoccode': unLoccode,
      'isUnLoccodeRqd': isUnLoccodeRqd == true ? 1 : 0,
      'subDevision': subDevision,
      'transhipmentHub': transhipmentHub,
      'sortOrder': sortOrder,
      'remarks': remarks,
      'isActive': isActive == true ? 1 : 0,
      'isDeleted': isDeleted == true ? 1 : 0,
      'createdByID': createdByID,
      'createdOn': createdOn,
      'modifiedByID': modifiedByID,
      'modifiedOn': modifiedOn,
      'versionIdentifier': versionIdentifier,
      'operationType': operationType,
    };
  }

  PortModel copyWith({
    int? id,
    String? code,
    String? portName,
    int? countryID,
    String? countryName,
    int? airportID,
    int? timeZoneID,
    num? latitude,
    num? latDegree,
    num? latMinutes,
    String? latDirection,
    num? longitude,
    num? lonDegree,
    num? lonMinutes,
    String? lonDirection,
    String? unLoccode,
    bool? isUnLoccodeRqd,
    String? subDevision,
    String? transhipmentHub,
    int? sortOrder,
    String? remarks,
    bool? isActive,
    bool? isDeleted,
    int? createdByID,
    String? createdOn,
    int? modifiedByID,
    String? modifiedOn,
    int? versionIdentifier,
    String? operationType,
  }) {
    return PortModel(
      id: id ?? this.id,
      code: code ?? this.code,
      portName: portName ?? this.portName,
      countryID: countryID ?? this.countryID,
      countryName: countryName ?? this.countryName,
      airportID: airportID ?? this.airportID,
      timeZoneID: timeZoneID ?? this.timeZoneID,
      latitude: latitude ?? this.latitude,
      latDegree: latDegree ?? this.latDegree,
      latMinutes: latMinutes ?? this.latMinutes,
      latDirection: latDirection ?? this.latDirection,
      longitude: longitude ?? this.longitude,
      lonDegree: lonDegree ?? this.lonDegree,
      lonMinutes: lonMinutes ?? this.lonMinutes,
      lonDirection: lonDirection ?? this.lonDirection,
      unLoccode: unLoccode ?? this.unLoccode,
      isUnLoccodeRqd: isUnLoccodeRqd ?? this.isUnLoccodeRqd,
      subDevision: subDevision ?? this.subDevision,
      transhipmentHub: transhipmentHub ?? this.transhipmentHub,
      sortOrder: sortOrder ?? this.sortOrder,
      remarks: remarks ?? this.remarks,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdByID: createdByID ?? this.createdByID,
      createdOn: createdOn ?? this.createdOn,
      modifiedByID: modifiedByID ?? this.modifiedByID,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      versionIdentifier: versionIdentifier ?? this.versionIdentifier,
      operationType: operationType ?? this.operationType,
    );
  }
}
