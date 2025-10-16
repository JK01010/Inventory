import 'package:equatable/equatable.dart';

import '../../domain/entities/purchase_order_hd_entity.dart';
import 'goods_receipt_entity_validation.dart';

class PurchaseOrderHDResponseModel extends Equatable {
  const PurchaseOrderHDResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory PurchaseOrderHDResponseModel.fromJson(Map<String, dynamic> map) {
    return PurchaseOrderHDResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<PurchaseOrderHDModel>.from(
        (map['reportData'] as List).map(
          (x) => PurchaseOrderHDModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<PurchaseOrderHDModel>? reportData;
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

class PurchaseOrderHDModel extends Equatable {
  const PurchaseOrderHDModel({
    required this.poCode,
    required this.poHdId,
    required this.title,
    required this.vendorDeliveryDate,
    required this.remarksToVendor,
    required this.requisitionCategoryId,
    required this.reqCategoryCode,
    required this.requisitionCategory,
    required this.deliveryPort,
    required this.portCode,
    required this.vendorReference,

    required this.grnId,
    required this.receiptNo,
    required this.receiptDate,
    required this.poNo,
    required this.poId,
    required this.inSights,
    required this.reqCategoryId,
    required this.category,
    required this.priorityId,
    required this.priority,
    required this.vendorId,
    required this.vendorName,
    required this.deliveryDate,
    required this.deliveryToId,
    required this.deliveryTo,
    required this.poTitle,
    required this.totalNoOfProducts,
    required this.plannedNoOfProducts,
    required this.entityId,
    required this.entity,
    required this.remarksForVendor,
    required this.poCost,
    required this.weight,
    required this.actualVolume,
    required this.currencyName,
    required this.noOfPackets,
    required this.presentProperties,
    required this.deliveryToLocationId,
    required this.deliveryToLocation,
    required this.totalAmountReportingCurrency,
    required this.poRemarks,
    required this.isBaggingCompleted,
    required this.modifiedOn,
    required this.portId,
    required this.isFull,
    required this.isLocked,
    required this.referenceID,
    required this.referenceSubID,
    required this.referenceTypeID,
  });

  factory PurchaseOrderHDModel.fromJson(Map<String, dynamic> map) {
    return PurchaseOrderHDModel(
      poCode: map['POCode'] as String?,
      poHdId: map['POHDID'] as int?,
      title: map['Title'] as String?,
      vendorDeliveryDate: map['VendorDeliveryDate'] as String?,
      remarksToVendor: map['RemarksToVendor'] as String?,
      portCode: map['PortCode'] as String?,
      vendorReference: map['VendorReference'] as String?,
      deliveryPort: map['DeliveryPort'] as String?,
      reqCategoryCode: map['ReqCategoryCode'] as String?,
      requisitionCategory: map['RequisitionCategory'] as String?,
      requisitionCategoryId: map['RequisitionCategoryId'] as int?,

      grnId: map['GrnId'] as int?,
      receiptNo: map['ReceiptNo'] as String?,
      receiptDate: map['ReceiptDate'] as String?,
      poNo: map['PoNo'] as String?,
      poId: map['PoId'] as int?,
      inSights: map['Insights'] as String?,
      reqCategoryId: map['ReqCategoryID'] as int?,
      category: map['Category'] as String?,
      priorityId: map['PriorityID'] as int?,
      priority: map['Priority'] as String?,
      vendorId: map['VendorID'] as int?,
      vendorName: map['VendorName'] as String?,
      deliveryDate: map['DelivryDate'] as String?,
      deliveryToId: map['DeliveryToID'] as int?,
      deliveryTo: map['DlvryTO'] as String?,
      poTitle: map['POtitle'] as String?,
      totalNoOfProducts: map['TotalNOofprudcts'] as int?,
      plannedNoOfProducts: map['PlannedNoOfPdcts'] as int?,
      entityId: map['EntityID'] as int?,
      entity: map['Entity'] as String?,
      remarksForVendor: map['RemarksForVendor'] as String?,
      poCost: map['pocost'] as double?,
      weight: map['Weight'] as double?,
      actualVolume: map['Actualvolume'] as double?,
      currencyName: map['CurrencyName'] as String?,
      noOfPackets: map['NoOfPackets'] as int?,
      presentProperties: map['PresentProperties'] as String?,
      deliveryToLocationId: map['DeliveryToLocationID'] as int?,
      deliveryToLocation: map['DeliveryToLocation'] as String?,
      totalAmountReportingCurrency:
          map['TotalAmountReportingCurrency'] as double?,
      poRemarks: map['PoRemarks'] as String?,
      isBaggingCompleted: map['IsBaggingCompleted'] == "Yes" ? true : false,
      modifiedOn: map['ModifiedOn'] as String?,
      portId: map['PortID'] as int?,
      isFull: map['IsFull'] == "Yes" ? true : false,
      isLocked: map['isLocked'] == "Yes" ? true : false,
      referenceID: map['ReferenceID'] as int?,
      referenceSubID: map['ReferenceSubID'] as int?,
      referenceTypeID: map['ReferenceTypeID'] as int?,
    );
  }

  factory PurchaseOrderHDModel.fromEntity(PurchaseOrderHDEntity entity) {
    return PurchaseOrderHDModel(
      poCode: entity.poCode,
      poHdId: entity.poHdId,
      title: entity.title,
      vendorDeliveryDate: entity.vendorDeliveryDate,
      remarksToVendor: entity.remarksToVendor,
      requisitionCategoryId: entity.requisitionCategoryId,
      reqCategoryCode: entity.reqCategoryCode,
      requisitionCategory: entity.requisitionCategory,
      deliveryPort: entity.deliveryPort,
      portCode: entity.portCode,
      vendorReference: entity.vendorReference,

      grnId: entity.grnId,
      receiptNo: entity.receiptNo,
      receiptDate: entity.receiptDate,
      poNo: entity.poNo,
      poId: entity.poId,
      inSights: entity.inSights,
      reqCategoryId: entity.reqCategoryId,
      category: entity.category,
      priorityId: entity.priorityId,
      priority: entity.priority,
      vendorId: entity.vendorId,
      vendorName: entity.vendorName,
      deliveryDate: entity.deliveryDate,
      deliveryToId: entity.deliveryToId,
      deliveryTo: entity.deliveryTo,
      poTitle: entity.poTitle,
      totalNoOfProducts: entity.totalNoOfProducts,
      plannedNoOfProducts: entity.plannedNoOfProducts,
      entityId: entity.entityId,
      entity: entity.entity,
      remarksForVendor: entity.remarksForVendor,
      poCost: entity.poCost,
      weight: entity.weight,
      actualVolume: entity.actualVolume,
      currencyName: entity.currencyName,
      noOfPackets: entity.noOfPackets,
      presentProperties: entity.presentProperties,
      deliveryToLocationId: entity.deliveryToLocationId,
      deliveryToLocation: entity.deliveryToLocation,
      totalAmountReportingCurrency: entity.totalAmountReportingCurrency,
      poRemarks: entity.poRemarks,
      isBaggingCompleted: entity.isBaggingCompleted,
      modifiedOn: entity.modifiedOn,
      portId: entity.portId,
      isFull: entity.isFull,
      isLocked: entity.isLocked,
      referenceID: -1,
      referenceSubID: -1,
      referenceTypeID: -1,
    );
  }

  final String? poCode;
  final int? poHdId;
  final String? title;
  final String? vendorDeliveryDate;
  final String? remarksToVendor;
  final int? requisitionCategoryId;
  final String? reqCategoryCode;
  final String? requisitionCategory;
  final String? deliveryPort;
  final String? portCode;
  final String? vendorReference;

  final int? grnId;
  final String? receiptNo;
  final String? receiptDate;
  final String? poNo;
  final int? poId;
  final String? inSights;
  final int? reqCategoryId;
  final String? category;
  final int? priorityId;
  final String? priority;
  final int? vendorId;
  final String? vendorName;
  final String? deliveryDate;
  final int? deliveryToId;
  final String? deliveryTo;
  final String? poTitle;
  final int? totalNoOfProducts;
  final int? plannedNoOfProducts;
  final int? entityId;
  final String? entity;
  final String? remarksForVendor;
  final double? poCost;
  final double? weight;
  final double? actualVolume;
  final String? currencyName;
  final int? noOfPackets;
  final String? presentProperties;
  final int? deliveryToLocationId;
  final String? deliveryToLocation;
  final double? totalAmountReportingCurrency;
  final String? poRemarks;
  final bool? isBaggingCompleted;
  final String? modifiedOn;
  final int? portId;
  final bool? isFull;
  final bool? isLocked;
  final int? referenceTypeID;
  final int? referenceID;
  final int? referenceSubID;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'POCode': poCode,
      'grnId': grnId,
      'receiptNo': receiptNo,
      'receiptDate': receiptDate,
      'poNo': poNo,
      'poId': poId,
      'inSights': inSights,
      'reqCategoryID': reqCategoryId,
      'category': category,
      'priorityID': priorityId,
      'priority': priority,
      'vendorID': vendorId,
      'vendorName': vendorName,
      'deliveryDate': deliveryDate,
      'deliveryToID': deliveryToId,
      'deliveryTo': deliveryTo,
      'poTitle': poTitle,
      'totalNoOfProducts': totalNoOfProducts,
      'plannedNoOfProducts': plannedNoOfProducts,
      'entityID': entityId,
      'entity': entity,
      'remarksForVendor': remarksForVendor,
      'poCost': poCost,
      'weight': weight,
      'actualVolume': actualVolume,
      'currencyName': currencyName,
      'noOfPackets': noOfPackets,
      'presentProperties': presentProperties,
      'deliveryToLocationID': deliveryToLocationId,
      'deliveryToLocation': deliveryToLocation,
      'totalAmountReportingCurrency': totalAmountReportingCurrency,
      'poRemarks': poRemarks,
      'isBaggingCompleted': isBaggingCompleted == true ? "Y" : "N",
      'modifiedOn': modifiedOn,
      'portId': portId,
      'isFull': isFull == true ? "Y" : "N",
      'isLocked': isLocked == true ? "Y" : "N",
      'ReferenceTypeID': referenceTypeID,
      'ReferenceID': referenceID,
      'ReferenceSubID': referenceSubID,
    };
  }

  PurchaseOrderHDEntity toEntity() => PurchaseOrderHDEntity(
    poCode: poCode ?? '',
    poHdId: poHdId ?? 0,
    title: title ?? '',
    vendorDeliveryDate: vendorDeliveryDate ?? '',
    remarksToVendor: remarksToVendor ?? '',
    requisitionCategoryId: requisitionCategoryId ?? 0,
    reqCategoryCode: reqCategoryCode ?? '',
    requisitionCategory: requisitionCategory ?? '',
    deliveryPort: deliveryPort ?? '',
    portCode: portCode ?? '',
    vendorReference: vendorReference ?? '',

    grnId: grnId ?? 0,
    receiptNo: receiptNo ?? '',
    receiptDate: receiptDate ?? '',
    poNo: poNo ?? '',
    poId: poId ?? -1,
    inSights: inSights ?? '',
    reqCategoryId: reqCategoryId ?? -1,
    category: category ?? '',
    priorityId: priorityId ?? -1,
    priority: priority ?? '',
    vendorId: vendorId ?? -1,
    vendorName: vendorName ?? '',
    deliveryDate: deliveryDate ?? '',
    deliveryToId: deliveryToId ?? -1,
    deliveryTo: deliveryTo ?? '',
    poTitle: poTitle ?? '',
    totalNoOfProducts: totalNoOfProducts ?? -1,
    plannedNoOfProducts: plannedNoOfProducts ?? -1,
    entityId: entityId ?? -1,
    entity: entity ?? '',
    remarksForVendor: remarksForVendor ?? '',
    poCost: poCost ?? 0.0,
    weight: weight ?? 0.0,
    actualVolume: actualVolume ?? 0.0,
    currencyName: currencyName ?? '',
    noOfPackets: noOfPackets ?? 0,
    presentProperties: presentProperties ?? '',
    deliveryToLocationId: deliveryToLocationId ?? -1,
    deliveryToLocation: deliveryToLocation ?? '',
    totalAmountReportingCurrency: totalAmountReportingCurrency ?? 0.0,
    poRemarks: poRemarks ?? '',
    isBaggingCompleted: isBaggingCompleted == "Y" ? true : false,
    modifiedOn: modifiedOn ?? '',
    portId: portId ?? -1,
    isFull: isFull == "Y" ? true : false,
    isLocked: isLocked == "Y" ? true : false,
  );

  @override
  List<Object?> get props => [
    poCode,
    poHdId,
    title,
    vendorDeliveryDate,
    remarksToVendor,
    requisitionCategoryId,
    reqCategoryCode,
    requisitionCategory,
    deliveryPort,
    portCode,
    vendorReference,

    grnId,
    receiptNo,
    receiptDate,
    poNo,
    poId,
    inSights,
    reqCategoryId,
    category,
    priorityId,
    priority,
    vendorId,
    vendorName,
    deliveryDate,
    deliveryToId,
    deliveryTo,
    poTitle,
    totalNoOfProducts,
    plannedNoOfProducts,
    entityId,
    entity,
    remarksForVendor,
    poCost,
    weight,
    actualVolume,
    currencyName,
    noOfPackets,
    presentProperties,
    deliveryToLocationId,
    deliveryToLocation,
    totalAmountReportingCurrency,
    poRemarks,
    isBaggingCompleted,
    modifiedOn,
    portId,
    isFull,
    isLocked,
    referenceTypeID,
    referenceID,
    referenceSubID,
  ];

  @override
  bool? get stringify => true;

  Map<String, dynamic> toJsonForSaveApi() {
    return {
      "id": -1,
      "isOfficeGRN": false,
      "categoryID": requisitionCategoryId,
      "referenceTypeID": referenceTypeID,

      ///ToDo///
      "referenceID": referenceID,
      "referenceSubID": referenceSubID,
      "code": "",
      "deliveryTypeID": deliveryToId,
      "deliveryToLocationID": deliveryToLocationId,
      "deliveryToName": "",

      ///ToDo///
      "portID": portId,
      "deliveryReference": "delivery Reference",
      "receivedDate": "2025-09-16T00:00:00",
      "generatedDate": "0001-01-01T00:00:00",
      "remarks": remarksForVendor,
      "isPartial": false,
      "isNoVesselGRN": false,
      "isBaggingTagging": false,
      "workFlowID": 0,
      "workFlowStatusID": null,
      "roleCode": "",
      "orderTypeID": 0,
      "versionIdentifier": 0,
      "operationType": "INS",
      "pohdid": poHdId,
      "itemPropertyJson": null,
      "itemCount": 0,
      "weight": weight != null ? weight.toString() : "0.0",
      "actualVolume": actualVolume != null ? actualVolume.toString() : "0.0",
      "noOfPackets": noOfPackets,
      "orgID": 0,
      "deliveryAddress": deliveryTo ?? '',
      "isBaggingTaggingApplicable": true,
      "isLocked": false,
    };
  }
}
