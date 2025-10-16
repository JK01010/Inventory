import 'package:equatable/equatable.dart';

class VesselModelResponse extends Equatable {
  const VesselModelResponse({
    this.data,
    this.totalCount,
    this.pageOffset,
    this.pageNext,
  });

  factory VesselModelResponse.fromJson(Map<String, dynamic> map) {
    return VesselModelResponse(
      data:
          map['data'] != null
              ? List<VesselModel>.from(
                (map['data'] as List<dynamic>).map<VesselModel?>(
                  (x) => VesselModel.fromJson(x as Map<String, dynamic>),
                ),
              )
              : null,
      totalCount: map['totalCount'] != null ? map['totalCount'] as int : null,
      pageOffset: map['pageOffset'] != null ? map['pageOffset'] as int : null,
      pageNext: map['pageNext'] != null ? map['pageNext'] as int : null,
    );
  }
  final List<VesselModel>? data;
  final int? totalCount;
  final int? pageOffset;
  final int? pageNext;

  @override
  List<Object?> get props => [data, totalCount, pageOffset, pageNext];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data?.map((x) => x.toJson()).toList(),
      'totalCount': totalCount,
      'pageOffset': pageOffset,
      'pageNext': pageNext,
    };
  }
}

class VesselModel extends Equatable {
  const VesselModel({
     this.siteID,
    this.siteCode,
     this.siteTypeID,
     this.id,
     this.imoNo,
     this.vesselRegID,
     this.vesselName,
     this.code,
     this.maidenName,
     this.vesselStatusID,
     this.ultimateOwnerID,
     this.isVesselFromNewOwner,
     this.registredOwnerID,
     this.managementTypeID,
     this.isPartiallyCrewManaged,
     this.primaryManagerID,
     this.subManagerID,
     this.fleetID,
    this.vesselGroupID,
     this.vesselSubGroupID,
     this.vesselTypeID,
     this.vesselSubTypeID,
    this.vesselSizeID,
     this.classTypeID,
     this.classNo,
    this.classType2ID,
     this.classNo2,
     this.flagID,
     this.flagOfficialNo,
     this.flagRegPortID,
     this.callSign,
     this.dwt,
     this.grt,
     this.nrt,
     this.teu,
     this.cbm,
     this.isRovingTeam,
     this.mainEngineMakeID,
     this.mainEnginModelID,
     this.mainEngineOutput,
     this.mainEngineBuilderID,
     this.mainEngineNoOfUnits,
     this.vesselSpeed,
     this.recordStatus,
     this.validFrom,
    this.validTo,
     this.rejoinedVessel,
    this.rejoinedON,
     this.isSharedVessel,
     this.isDualClass,
     this.confirmedVesselID,
     this.serviceCycleCounter,
     this.previousRecordID,
     this.isHistoryExists,
     this.exVessel,
     this.realVessel,
     this.isAccountClosed,
     this.isActive,
     this.activeModifyByID,
     this.activeModifyOn,
     this.isDeleted,
     this.createdByID,
     this.createdOn,
     this.modifiedByID,
     this.modifiedOn,
     this.versionIdentifier,
     this.status,
     this.statusMessage,
    this.operationType,
  });

  factory VesselModel.fromJson(Map<String, dynamic> json) {
    return VesselModel(
      siteID: json['siteID'],
      siteCode: json['siteCode'],
      siteTypeID: json['siteTypeID'],
      id: json['id'],
      imoNo: json['imoNo'],
      vesselRegID: json['vesselRegID'],
      vesselName: json['vesselName'],
      code: json['code'],
      maidenName: json['maidenName'],
      vesselStatusID: json['vesselStatusID'],
      ultimateOwnerID: json['ultimateOwnerID'],
      isVesselFromNewOwner: json['isVesselFromNewOwner'],
      registredOwnerID: json['registredOwnerID'],
      managementTypeID: json['managementTypeID'],
      isPartiallyCrewManaged: json['isPartiallyCrewManaged'],
      primaryManagerID: json['primaryManagerID'],
      subManagerID: json['subManagerID'],
      fleetID: json['fleetID'],
      vesselGroupID: json['vesselGroupID'],
      vesselSubGroupID: json['vesselSubGroupID'],
      vesselTypeID: json['vesselTypeID'],
      vesselSubTypeID: json['vesselSubTypeID'],
      vesselSizeID: json['vesselSizeID'],
      classTypeID: json['classTypeID'],
      classNo: json['classNo'],
      classType2ID: json['classType2ID'],
      classNo2: json['classNo2'] ?? '',
      flagID: json['flagID'],
      flagOfficialNo: json['flagOfficialNo'],
      flagRegPortID: json['flagRegPortID'],
      callSign: json['callSign'],
      dwt: json['dwt'],
      grt: json['grt'],
      nrt: json['nrt'],
      teu: json['teu'],
      cbm: json['cbm'],
      isRovingTeam: json['isRovingTeam'],
      mainEngineMakeID: json['mainEngineMakeID'],
      mainEnginModelID: json['mainEnginModelID'],
      mainEngineOutput: json['mainEngineOutput'],
      mainEngineBuilderID: json['mainEngineBuilderID'],
      mainEngineNoOfUnits: json['mainEngineNoOfUnits'],
      vesselSpeed: json['vesselSpeed'],
      recordStatus: json['recordStatus'],
      validFrom: DateTime.parse(json['validFrom']),
      validTo:
          json['validTo'] != null ? DateTime.tryParse(json['validTo']) : null,
      rejoinedVessel: json['rejoinedVessel'],
      rejoinedON:
          json['rejoinedON'] != null
              ? DateTime.tryParse(json['rejoinedON'])
              : null,
      isSharedVessel: json['isSharedVessel'],
      isDualClass: json['isDualClass'],
      confirmedVesselID: json['confirmedVesselID'],
      serviceCycleCounter: json['serviceCycleCounter'],
      previousRecordID: json['previousRecordID'],
      isHistoryExists: json['isHistoryExists'],
      exVessel: json['exVessel'],
      realVessel: json['realVessel'],
      isAccountClosed: json['isAccountClosed'],
      isActive: json['isActive'],
      activeModifyByID: json['activeModifyByID'],
      activeModifyOn: DateTime.parse(json['activeModifyOn']),
      isDeleted: json['isDeleted'],
      createdByID: json['createdByID'],
      createdOn: DateTime.parse(json['createdOn']),
      modifiedByID: json['modifiedByID'],
      modifiedOn: DateTime.parse(json['modifiedOn']),
      versionIdentifier: json['versionIdentifier'],
      status: json['status'],
      statusMessage: json['statusMessage'],
      operationType: json['operationType'],
    );
  }
  final int? siteID;
  final String? siteCode;
  final int? siteTypeID;
  final int? id;
  final String? imoNo;
  final int? vesselRegID;
  final String? vesselName;
  final String? code;
  final String? maidenName;
  final int? vesselStatusID;
  final int? ultimateOwnerID;
  final bool? isVesselFromNewOwner;
  final int? registredOwnerID;
  final int? managementTypeID;
  final bool? isPartiallyCrewManaged;
  final int? primaryManagerID;
  final int? subManagerID;
  final int? fleetID;
  final int? vesselGroupID;
  final int? vesselSubGroupID;
  final int? vesselTypeID;
  final int? vesselSubTypeID;
  final int? vesselSizeID;
  final int? classTypeID;
  final String? classNo;
  final int? classType2ID;
  final String? classNo2;
  final int? flagID;
  final String? flagOfficialNo;
  final int? flagRegPortID;
  final String? callSign;
  final int? dwt;
  final int? grt;
  final int? nrt;
  final int? teu;
  final int? cbm;
  final bool? isRovingTeam;
  final int? mainEngineMakeID;
  final int? mainEnginModelID;
  final int? mainEngineOutput;
  final int? mainEngineBuilderID;
  final int? mainEngineNoOfUnits;
  final String? vesselSpeed;
  final String? recordStatus;
  final DateTime? validFrom;
  final DateTime? validTo;
  final bool? rejoinedVessel;
  final DateTime? rejoinedON;
  final bool? isSharedVessel;
  final bool? isDualClass;
  final int? confirmedVesselID;
  final int? serviceCycleCounter;
  final int? previousRecordID;
  final bool? isHistoryExists;
  final bool? exVessel;
  final bool? realVessel;
  final bool? isAccountClosed;
  final bool? isActive;
  final int? activeModifyByID;
  final DateTime? activeModifyOn;
  final bool? isDeleted;
  final int? createdByID;
  final DateTime? createdOn;
  final int? modifiedByID;
  final DateTime? modifiedOn;
  final int? versionIdentifier;
  final String? status;
  final String? statusMessage;
  final String? operationType;

  Map<String, dynamic> toJson() {
    return {
      'siteID': siteID,
      'siteCode': siteCode,
      'siteTypeID': siteTypeID,
      'id': id,
      'imoNo': imoNo,
      'vesselRegID': vesselRegID,
      'vesselName': vesselName,
      'code': code,
      'maidenName': maidenName,
      'vesselStatusID': vesselStatusID,
      'ultimateOwnerID': ultimateOwnerID,
      'isVesselFromNewOwner': isVesselFromNewOwner == true ? 1 : 0,
      'registredOwnerID': registredOwnerID,
      'managementTypeID': managementTypeID,
      'isPartiallyCrewManaged': isPartiallyCrewManaged == true ? 1 : 0,
      'primaryManagerID': primaryManagerID,
      'subManagerID': subManagerID,
      'fleetID': fleetID,
      'vesselGroupID': vesselGroupID,
      'vesselSubGroupID': vesselSubGroupID,
      'vesselTypeID': vesselTypeID,
      'vesselSubTypeID': vesselSubTypeID,
      'vesselSizeID': vesselSizeID,
      'classTypeID': classTypeID,
      'classNo': classNo,
      'classType2ID': classType2ID,
      'classNo2': classNo2,
      'flagID': flagID,
      'flagOfficialNo': flagOfficialNo,
      'flagRegPortID': flagRegPortID,
      'callSign': callSign,
      'dwt': dwt,
      'grt': grt,
      'nrt': nrt,
      'teu': teu,
      'cbm': cbm,
      'isRovingTeam': isRovingTeam == true ? 1 : 0,
      'mainEngineMakeID': mainEngineMakeID,
      'mainEnginModelID': mainEnginModelID,
      'mainEngineOutput': mainEngineOutput,
      'mainEngineBuilderID': mainEngineBuilderID,
      'mainEngineNoOfUnits': mainEngineNoOfUnits,
      'vesselSpeed': vesselSpeed,
      'recordStatus': recordStatus,
      'validFrom': validFrom?.toIso8601String(),
      'validTo': validTo?.toIso8601String(),
      'rejoinedVessel': rejoinedVessel == true ? 1 : 0,
      'rejoinedON': rejoinedON?.toIso8601String(),
      'isSharedVessel': isSharedVessel == true ? 1 : 0,
      'isDualClass': isDualClass == true ? 1 : 0,
      'confirmedVesselID': confirmedVesselID,
      'serviceCycleCounter': serviceCycleCounter,
      'previousRecordID': previousRecordID,
      'isHistoryExists': isHistoryExists == true ? 1 : 0,
      'exVessel': exVessel == true ? 1 : 0,
      'realVessel': realVessel == true ? 1 : 0,
      'isAccountClosed': isAccountClosed == true ? 1 : 0,
      'isActive': isActive == true ? 1 : 0,
      'activeModifyByID': activeModifyByID ,
      'activeModifyOn': activeModifyOn?.toIso8601String(),
      'isDeleted': isDeleted == true ? 1 : 0,
      'createdByID': createdByID,
      'createdOn': createdOn?.toIso8601String(),
      'modifiedByID': modifiedByID ,
      'modifiedOn': modifiedOn?.toIso8601String(),
      'versionIdentifier': versionIdentifier,
      'status': status,
      'statusMessage': statusMessage,
      'operationType': operationType,
    };
  }

  @override
  List<Object?> get props => [
    siteID,
    siteCode,
    siteTypeID,
    id,
    imoNo,
    vesselRegID,
    vesselName,
    code,
    maidenName,
    vesselStatusID,
    ultimateOwnerID,
    isVesselFromNewOwner,
    registredOwnerID,
    managementTypeID,
    isPartiallyCrewManaged,
    primaryManagerID,
    subManagerID,
    fleetID,
    vesselGroupID,
    vesselSubGroupID,
    vesselTypeID,
    vesselSubTypeID,
    vesselSizeID,
    classTypeID,
    classNo,
    classType2ID,
    classNo2,
    flagID,
    flagOfficialNo,
    flagRegPortID,
    callSign,
    dwt,
    grt,
    nrt,
    teu,
    cbm,
    isRovingTeam,
    mainEngineMakeID,
    mainEnginModelID,
    mainEngineOutput,
    mainEngineBuilderID,
    mainEngineNoOfUnits,
    vesselSpeed,
    recordStatus,
    validFrom,
    validTo,
    rejoinedVessel,
    rejoinedON,
    isSharedVessel,
    isDualClass,
    confirmedVesselID,
    serviceCycleCounter,
    previousRecordID,
    isHistoryExists,
    exVessel,
    realVessel,
    isAccountClosed,
    isActive,
    activeModifyByID,
    activeModifyOn,
    isDeleted,
    createdByID,
    createdOn,
    modifiedByID,
    modifiedOn,
    versionIdentifier,
    status,
    statusMessage,
    operationType,
  ];
}
