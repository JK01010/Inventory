import 'dart:convert';

class GoodsReceiptHDModel {
  final int? id;
  final bool? isOfficeGrn;
  final int? categoryId;
  final int? referenceTypeId;
  final int? referenceId;
  final int? referenceSubId;
  final String? code;
  final int? deliveryTypeId;
  final dynamic deliveryToLocationId;
  final String? deliveryToName;
  final int? portId;
  final String? deliveryReference;
  final DateTime? receivedDate;
  final DateTime? generatedDate;
  final String? remarks;
  final bool? isPartial;
  final bool? isNoVesselGrn;
  final bool? isBaggingTagging;
  final int? workFlowId;
  final dynamic workFlowStatusId;
  final String? roleCode;
  final int? orderTypeId;
  final int? versionIdentifier;
  final String? operationType;
  final int? pohdid;
  final dynamic itemPropertyJson;
  final int? itemCount;
  final String? weight;
  final String? actualVolume;
  final int? noOfPackets;
  final int? orgId;
  final String? deliveryAddress;
  final bool? isBaggingTaggingApplicable;
  final bool? isLocked;

  GoodsReceiptHDModel({
    this.id,
    this.isOfficeGrn,
    this.categoryId,
    this.referenceTypeId,
    this.referenceId,
    this.referenceSubId,
    this.code,
    this.deliveryTypeId,
    this.deliveryToLocationId,
    this.deliveryToName,
    this.portId,
    this.deliveryReference,
    this.receivedDate,
    this.generatedDate,
    this.remarks,
    this.isPartial,
    this.isNoVesselGrn,
    this.isBaggingTagging,
    this.workFlowId,
    this.workFlowStatusId,
    this.roleCode,
    this.orderTypeId,
    this.versionIdentifier,
    this.operationType,
    this.pohdid,
    this.itemPropertyJson,
    this.itemCount,
    this.weight,
    this.actualVolume,
    this.noOfPackets,
    this.orgId,
    this.deliveryAddress,
    this.isBaggingTaggingApplicable,
    this.isLocked,
  });

  GoodsReceiptHDModel copyWith({
    int? id,
    bool? isOfficeGrn,
    int? categoryId,
    int? referenceTypeId,
    int? referenceId,
    int? referenceSubId,
    String? code,
    int? deliveryTypeId,
    dynamic deliveryToLocationId,
    String? deliveryToName,
    int? portId,
    String? deliveryReference,
    DateTime? receivedDate,
    DateTime? generatedDate,
    String? remarks,
    bool? isPartial,
    bool? isNoVesselGrn,
    bool? isBaggingTagging,
    int? workFlowId,
    dynamic workFlowStatusId,
    String? roleCode,
    int? orderTypeId,
    int? versionIdentifier,
    String? operationType,
    int? pohdid,
    dynamic itemPropertyJson,
    int? itemCount,
    String? weight,
    String? actualVolume,
    int? noOfPackets,
    int? orgId,
    String? deliveryAddress,
    bool? isBaggingTaggingApplicable,
    bool? isLocked,
  }) =>
      GoodsReceiptHDModel(
        id: id ?? this.id,
        isOfficeGrn: isOfficeGrn ?? this.isOfficeGrn,
        categoryId: categoryId ?? this.categoryId,
        referenceTypeId: referenceTypeId ?? this.referenceTypeId,
        referenceId: referenceId ?? this.referenceId,
        referenceSubId: referenceSubId ?? this.referenceSubId,
        code: code ?? this.code,
        deliveryTypeId: deliveryTypeId ?? this.deliveryTypeId,
        deliveryToLocationId: deliveryToLocationId ?? this.deliveryToLocationId,
        deliveryToName: deliveryToName ?? this.deliveryToName,
        portId: portId ?? this.portId,
        deliveryReference: deliveryReference ?? this.deliveryReference,
        receivedDate: receivedDate ?? this.receivedDate,
        generatedDate: generatedDate ?? this.generatedDate,
        remarks: remarks ?? this.remarks,
        isPartial: isPartial ?? this.isPartial,
        isNoVesselGrn: isNoVesselGrn ?? this.isNoVesselGrn,
        isBaggingTagging: isBaggingTagging ?? this.isBaggingTagging,
        workFlowId: workFlowId ?? this.workFlowId,
        workFlowStatusId: workFlowStatusId ?? this.workFlowStatusId,
        roleCode: roleCode ?? this.roleCode,
        orderTypeId: orderTypeId ?? this.orderTypeId,
        versionIdentifier: versionIdentifier ?? this.versionIdentifier,
        operationType: operationType ?? this.operationType,
        pohdid: pohdid ?? this.pohdid,
        itemPropertyJson: itemPropertyJson ?? this.itemPropertyJson,
        itemCount: itemCount ?? this.itemCount,
        weight: weight ?? this.weight,
        actualVolume: actualVolume ?? this.actualVolume,
        noOfPackets: noOfPackets ?? this.noOfPackets,
        orgId: orgId ?? this.orgId,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        isBaggingTaggingApplicable: isBaggingTaggingApplicable ?? this.isBaggingTaggingApplicable,
        isLocked: isLocked ?? this.isLocked,
      );

  factory GoodsReceiptHDModel.fromRawJson(String str) => GoodsReceiptHDModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodsReceiptHDModel.fromJson(Map<String, dynamic> json) => GoodsReceiptHDModel(
    id: json["id"],
    isOfficeGrn: json["isOfficeGRN"],
    categoryId: json["categoryID"],
    referenceTypeId: json["referenceTypeID"],
    referenceId: json["referenceID"],
    referenceSubId: json["referenceSubID"],
    code: json["code"],
    deliveryTypeId: json["deliveryTypeID"],
    deliveryToLocationId: json["deliveryToLocationID"],
    deliveryToName: json["deliveryToName"],
    portId: json["portID"],
    deliveryReference: json["deliveryReference"],
    receivedDate: json["receivedDate"] == null ? null : DateTime.parse(json["receivedDate"]),
    generatedDate: json["generatedDate"] == null ? null : DateTime.parse(json["generatedDate"]),
    remarks: json["remarks"],
    isPartial: json["isPartial"],
    isNoVesselGrn: json["isNoVesselGRN"],
    isBaggingTagging: json["isBaggingTagging"],
    workFlowId: json["workFlowID"],
    workFlowStatusId: json["workFlowStatusID"],
    roleCode: json["roleCode"],
    orderTypeId: json["orderTypeID"],
    versionIdentifier: json["versionIdentifier"],
    operationType: json["operationType"],
    pohdid: json["pohdid"],
    itemPropertyJson: json["itemPropertyJson"],
    itemCount: json["itemCount"],
    weight: json["weight"],
    actualVolume: json["actualVolume"],
    noOfPackets: json["noOfPackets"],
    orgId: json["orgID"],
    deliveryAddress: json["deliveryAddress"],
    isBaggingTaggingApplicable: json["isBaggingTaggingApplicable"],
    isLocked: json["isLocked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isOfficeGRN": isOfficeGrn,
    "categoryID": categoryId,
    "referenceTypeID": referenceTypeId,
    "referenceID": referenceId,
    "referenceSubID": referenceSubId,
    "code": code,
    "deliveryTypeID": deliveryTypeId,
    "deliveryToLocationID": deliveryToLocationId,
    "deliveryToName": deliveryToName,
    "portID": portId,
    "deliveryReference": deliveryReference,
    "receivedDate": receivedDate?.toIso8601String(),
    "generatedDate": generatedDate?.toIso8601String(),
    "remarks": remarks,
    "isPartial": isPartial,
    "isNoVesselGRN": isNoVesselGrn,
    "isBaggingTagging": isBaggingTagging,
    "workFlowID": workFlowId,
    "workFlowStatusID": workFlowStatusId,
    "roleCode": roleCode,
    "orderTypeID": orderTypeId,
    "versionIdentifier": versionIdentifier,
    "operationType": operationType,
    "pohdid": pohdid,
    "itemPropertyJson": itemPropertyJson,
    "itemCount": itemCount,
    "weight": weight,
    "actualVolume": actualVolume,
    "noOfPackets": noOfPackets,
    "orgID": orgId,
    "deliveryAddress": deliveryAddress,
    "isBaggingTaggingApplicable": isBaggingTaggingApplicable,
    "isLocked": isLocked,
  };
}