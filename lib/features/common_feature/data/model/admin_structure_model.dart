import 'package:equatable/equatable.dart';

class AdminStructureModelResponse extends Equatable {

  const AdminStructureModelResponse({
    required this.data,
    required this.totalCount,
    required this.pageOffset,
    required this.pageNext,
  });

  factory AdminStructureModelResponse.fromJson(Map<String, dynamic> json) {
    return AdminStructureModelResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => AdminStructureModel.fromJson(e))
          .toList(),
      totalCount: json['totalCount'] ?? 0,
      pageOffset: json['pageOffset'] ?? 0,
      pageNext: json['pageNext'] ?? 0,
    );
  }
  final List<AdminStructureModel> data;
  final int totalCount;
  final int pageOffset;
  final int pageNext;

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'pageOffset': pageOffset,
    'pageNext': pageNext,
  };

  @override
  List<Object?> get props => [data, totalCount, pageOffset, pageNext];
}

class AdminStructureModel extends Equatable {

  const AdminStructureModel({
    required this.id,
    required this.hdid,
    required this.code,
    required this.typeName,
    required this.isActive,
    required this.sortOrder,
    this.remarks,
    required this.isDeleted,
    required this.createdByID,
    required this.createdOn,
    required this.modifiedByID,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.versionIdentifier,
    this.operationType,
  });

  factory AdminStructureModel.fromJson(Map<String, dynamic> json) {
    return AdminStructureModel(
      id: json['id'] ?? 0,
      hdid: json['hdid'] ?? 0,
      code: json['code'] ?? '',
      typeName: json['typeName'] ?? '',
      isActive: json['isActive'],
      sortOrder: json['sortOrder'] ?? 0,
      remarks: json['remarks'],
      isDeleted: json['isDeleted'],
      createdByID: json['createdByID'] ?? 0,
      createdOn: json['createdOn'] ?? '',
      modifiedByID: json['modifiedByID'] ?? 0,
      modifiedBy: json['modifiedBy'] ?? '',
      modifiedOn: json['modifiedOn'] ?? '',
      versionIdentifier: json['versionIdentifier'] ?? 0,
      operationType: json['operationType'],
    );
  }
  final int id;
  final int hdid;
  final String code;
  final String typeName;
  final bool isActive;
  final int sortOrder;
  final String? remarks;
  final bool isDeleted;
  final int createdByID;
  final String createdOn;
  final int modifiedByID;
  final String modifiedBy;
  final String modifiedOn;
  final int versionIdentifier;
  final String? operationType;

  Map<String, dynamic> toJson() => {
    'id': id,
    // 'hdid': hdid,
    'code': code,
    'typeName': typeName,
    'isActive': isActive == true ? 1 : 0,
    // 'sortOrder': sortOrder,
    // 'remarks': remarks,
    // 'isDeleted': isDeleted,
    // 'createdByID': createdByID,
    // 'createdOn': createdOn,
    // 'modifiedByID': modifiedByID,
    // 'modifiedBy': modifiedBy,
    // 'modifiedOn': modifiedOn,
    // 'versionIdentifier': versionIdentifier,
    // 'operationType': operationType,
  };

  @override
  List<Object?> get props => [
    id,
    hdid,
    code,
    typeName,
    isActive,
    sortOrder,
    remarks,
    isDeleted,
    createdByID,
    createdOn,
    modifiedByID,
    modifiedBy,
    modifiedOn,
    versionIdentifier,
    operationType,
  ];
}
