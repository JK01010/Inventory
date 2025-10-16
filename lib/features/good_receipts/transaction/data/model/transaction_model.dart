import 'package:equatable/equatable.dart';
import '../../../../../core/constants/app_enum.dart';
import '../../domain/entity/transaction_entity.dart';

class TransactionResponseModel extends Equatable {
  const TransactionResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.reportData,
    required this.recordCount,
  });

  factory TransactionResponseModel.fromJson(Map<String, dynamic> map) {
    return TransactionResponseModel(
      moduleCode:
          map['moduleCode'] != null ? map['moduleCode'] as String : null,
      entityName:
          map['entityName'] != null ? map['entityName'] as String : null,
      reportData:
          map['reportData'] != null
              ? List<TransactionModel>.from(
                (map['reportData'] as List<dynamic>).map<TransactionModel?>(
                  (x) => TransactionModel.fromJson(x as Map<String, dynamic>),
                ),
              )
              : null,
      recordCount:
          map['recordCount'] != null ? map['recordCount'] as dynamic : null,
    );
  }

  final String? moduleCode;
  final String? entityName;
  final List<TransactionModel>? reportData;
  final int? recordCount;

  @override
  List<Object?> get props => [moduleCode, entityName, reportData, recordCount];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'recordCount': recordCount,
    };
  }
}

class EntityValidation extends Equatable {
  const EntityValidation({
    required this.status,
    required this.validationMessages,
  });

  factory EntityValidation.fromJson(Map<String, dynamic> map) {
    return EntityValidation(
      status: map['status'] != null ? map['status'] as bool : null,
      validationMessages:
          map['validationMessages'] != null
              ? List<String>.from((map['validationMessages'] as List<String>))
              : null,
    );
  }

  final bool? status;
  final List<String>? validationMessages;

  @override
  List<Object?> get props => [status, validationMessages];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'validationMessages': validationMessages,
    };
  }
}

class TransactionModel extends Equatable {
  const TransactionModel({
    this.grnId,
    this.receiptNo,
    this.receiptDate,
    this.poNo,
    this.poId,
    this.insights,
    this.reqCategoryID,
    this.category,
    this.priorityID,
    this.priority,
    this.vendorID,
    this.vendorName,
    this.delivryDate,
    this.deliveryToID,
    this.dlvryTO,
    this.pOtitle,
    this.totalNOofprudcts,
    this.plannedNoOfPdcts,
    this.entityID,
    this.entity,
    this.remarksForVendor,
    this.pocost,
    this.weight,
    this.actualvolume,
    this.currencyName,
    this.noOfPackets,
    this.presentProperties,
    this.deliveryToLocationID,
    this.deliveryToLocation,
    this.totalAmountReportingCurrency,
    this.poRemarks,
    this.isBaggingCompleted,
    this.modifiedOn,
    this.portID,
    this.isFull,
    this.syncStatus,
    this.deliveryReference,
    this.isBaggingTaggingApplicable,
    this.workFlowId,
    this.workFlowStatusId,
    this.podtid,
    this.isConfirmed,
    this.damagedQty,
    this.newStock,
    this.receivedQty,
    this.itemCount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      grnId: map['GrnId'] != null ? map['GrnId'] as int : null,
      receiptNo: map['ReceiptNo'] != null ? map['ReceiptNo'] as String : null,
      receiptDate:
          map['ReceiptDate'] != null ? map['ReceiptDate'] as String : null,
      poNo: map['PoNo'] != null ? map['PoNo'] as String : null,
      poId: map['PoId'] != null ? map['PoId'] as int : null,
      insights: map['Insights'] != null ? map['Insights'] as String : null,
      reqCategoryID:
          map['ReqCategoryID'] != null ? map['ReqCategoryID'] as int : null,
      category: map['Category'] != null ? map['Category'] as String : null,
      priorityID: map['PriorityID'] != null ? map['PriorityID'] as int : null,
      priority: map['Priority'] != null ? map['Priority'] as String : null,
      vendorID: map['VendorID'] != null ? map['VendorID'] as int : null,
      vendorName:
          map['VendorName'] != null ? map['VendorName'] as String : null,
      delivryDate:
          map['DelivryDate'] != null ? map['DelivryDate'] as String : null,
      deliveryToID:
          map['DeliveryToID'] != null ? map['DeliveryToID'] as int : null,
      dlvryTO: map['DlvryTO'] != null ? map['DlvryTO'] as String : null,
      pOtitle: map['POtitle'] != null ? map['POtitle'] as String : null,
      totalNOofprudcts:
          map['TotalNOofprudcts'] != null
              ? map['TotalNOofprudcts'] as int
              : null,
      plannedNoOfPdcts:
          map['PlannedNoOfPdcts'] != null
              ? map['PlannedNoOfPdcts'] as int
              : null,
      entityID: map['EntityID'] != null ? map['EntityID'] as int : null,
      entity: map['Entity'] != null ? map['Entity'] as String : null,
      remarksForVendor:
          map['RemarksForVendor'] != null
              ? map['RemarksForVendor'] as String
              : null,
      pocost: map['pocost'] != null ? map['pocost'] as double : null,
      weight: map['Weight'] != null ? map['Weight'] as double : null,
      actualvolume:
          map['Actualvolume'] != null ? map['Actualvolume'] as double : null,
      currencyName:
          map['CurrencyName'] != null ? map['CurrencyName'] as String : null,
      noOfPackets:
          map['NoOfPackets'] != null ? map['NoOfPackets'] as int : null,
      presentProperties:
          map['PresentProperties'] != null
              ? map['PresentProperties'] as String
              : null,
      deliveryToLocationID:
          map['DeliveryToLocationID'] != null
              ? map['DeliveryToLocationID'] as int
              : null,
      deliveryToLocation:
          map['DeliveryToLocation'] != null
              ? map['DeliveryToLocation'] as String
              : null,
      totalAmountReportingCurrency:
          map['TotalAmountReportingCurrency'] != null
              ? map['TotalAmountReportingCurrency'] as double
              : null,
      poRemarks: map['PoRemarks'] != null ? map['PoRemarks'] as String : null,
      isBaggingCompleted:
          map['IsBaggingCompleted'] != null
              ? map['IsBaggingCompleted'] as bool
              : null,
      modifiedOn:
          map['ModifiedOn'] != null ? map['ModifiedOn'] as String : null,
      portID: map['PortID'] != null ? map['PortID'] as int : null,
      isFull: map['IsFull'] != null ? map['IsFull'] as bool : null,
      syncStatus: map['SyncStatus'] != null ? map['SyncStatus'] as bool : null,
      deliveryReference:
          map['DeliveryReference'] != null
              ? map['DeliveryReference'] as String
              : null,
      isBaggingTaggingApplicable:
          map['IsBaggingTaggingApplicable'] != null
              ? map['IsBaggingTaggingApplicable'] as bool
              : null,
      workFlowId: map['WorkFlowID'] != null ? map['WorkFlowID'] as int : null,
      workFlowStatusId:
          map['WorkFlowStatusID'] != null
              ? map['WorkFlowStatusID'] as int
              : null,
      podtid: map['PODTID'] != null ? map['PODTID'] as int : null,
      isConfirmed:
          map['isConfirmed'] != null ? map['isConfirmed'] as bool : null,
      damagedQty:
          map['DamagedOrwrongSupply'] != null
              ? (map['DamagedOrwrongSupply'] as num).toDouble()
              : null,

      newStock:
          map['NewStock'] != null ? (map['NewStock'] as num).toDouble() : null,
      receivedQty:
          map['ReceivedQty'] != null
              ? (map['ReceivedQty'] as num).toDouble()
              : null,
      itemCount:
          map['ItemCount'] != null
              ? (map['ItemCount'] as num).toDouble()
              : null,
    );
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      grnId: entity.grnId,
      receiptNo: entity.receiptNo,
      receiptDate: entity.receiptDate,
      poNo: entity.poNo,
      poId: entity.poId,
      insights: entity.insights,
      reqCategoryID: entity.reqCategoryID,
      category: entity.category,
      priorityID: entity.priorityID,
      priority: entity.priority,
      vendorID: entity.vendorID,
      vendorName: entity.vendorName,
      delivryDate: entity.delivryDate,
      deliveryToID: entity.deliveryToID,
      dlvryTO: entity.dlvryTO,
      pOtitle: entity.pOtitle,
      totalNOofprudcts: entity.totalNOofprudcts,
      plannedNoOfPdcts: entity.plannedNoOfPdcts,
      entityID: entity.entityID,
      entity: entity.entity,
      remarksForVendor: entity.remarksForVendor,
      pocost: entity.pocost,
      weight: entity.weight,
      actualvolume: entity.actualvolume,
      currencyName: entity.currencyName,
      noOfPackets: entity.noOfPackets,
      presentProperties: entity.presentProperties,
      deliveryToLocationID: entity.deliveryToLocationID,
      deliveryToLocation: entity.deliveryToLocation,
      totalAmountReportingCurrency: entity.totalAmountReportingCurrency,
      poRemarks: entity.poRemarks,
      isBaggingCompleted: entity.isBaggingCompleted,
      modifiedOn: entity.modifiedOn,
      portID: entity.portID,
      isFull: entity.isFull,
      deliveryReference: entity.deliveryReference,
      isBaggingTaggingApplicable: entity.isBaggingTaggingApplicable,
      isConfirmed: entity.isConfirmed,
    );
  }

  final int? grnId;
  final String? receiptNo;
  final String? receiptDate;
  final String? poNo;
  final int? poId;
  final String? insights;
  final int? reqCategoryID;
  final String? category;
  final int? priorityID;
  final String? priority;
  final int? vendorID;
  final String? vendorName;
  final String? delivryDate;
  final int? deliveryToID;
  final String? dlvryTO;
  final String? pOtitle;
  final int? totalNOofprudcts;
  final int? plannedNoOfPdcts;
  final int? entityID;
  final String? entity;
  final String? remarksForVendor;
  final double? pocost;
  final double? weight;
  final double? actualvolume;
  final String? currencyName;
  final int? noOfPackets;
  final String? presentProperties;
  final int? deliveryToLocationID;
  final String? deliveryToLocation;
  final double? totalAmountReportingCurrency;
  final String? poRemarks;
  final bool? isBaggingCompleted;
  final String? modifiedOn;
  final int? portID;
  final bool? isFull;
  final bool? syncStatus;
  final String? deliveryReference;
  final bool? isBaggingTaggingApplicable;
  final int? workFlowId;
  final int? workFlowStatusId;
  final int? podtid;
  final bool? isConfirmed;

  //this data for item detail another table
  final double? itemCount;
  final double? receivedQty;
  final double? damagedQty;
  final double? newStock;

  @override
  List<Object?> get props => [
    grnId,
    receiptNo,
    receiptDate,
    poNo,
    poId,
    insights,
    reqCategoryID,
    category,
    priorityID,
    priority,
    vendorID,
    vendorName,
    delivryDate,
    deliveryToID,
    dlvryTO,
    pOtitle,
    totalNOofprudcts,
    plannedNoOfPdcts,
    entityID,
    entity,
    remarksForVendor,
    pocost,
    weight,
    actualvolume,
    currencyName,
    noOfPackets,
    presentProperties,
    deliveryToLocationID,
    deliveryToLocation,
    totalAmountReportingCurrency,
    poRemarks,
    isBaggingCompleted,
    modifiedOn,
    portID,
    isFull,
    syncStatus,
    deliveryReference,
    isBaggingTaggingApplicable,
    workFlowId,
    workFlowStatusId,
    podtid,
    isConfirmed,
    receivedQty,
    damagedQty,
    newStock,
    itemCount,
  ];

  @override
  bool? get stringify => true;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'GrnId': grnId,
      'ReceiptNo': receiptNo,
      'ReceiptDate': receiptDate,
      'PoNo': poNo,
      'PoId': poId,
      'Insights': insights,
      'ReqCategoryID': reqCategoryID,
      'Category': category,
      'PriorityID': priorityID,
      'Priority': priority,
      'VendorID': vendorID,
      'VendorName': vendorName,
      'DelivryDate': delivryDate,
      'DeliveryToID': deliveryToID,
      'DlvryTO': dlvryTO,
      'POtitle': pOtitle,
      'TotalNOofprudcts': totalNOofprudcts,
      'PlannedNoOfPdcts': plannedNoOfPdcts,
      'EntityID': entityID,
      'Entity': entity,
      'RemarksForVendor': remarksForVendor,
      'pocost': pocost,
      'Weight': weight,
      'Actualvolume': actualvolume,
      'CurrencyName': currencyName,
      'NoOfPackets': noOfPackets,
      'PresentProperties': presentProperties,
      'DeliveryToLocationID': deliveryToLocationID,
      'DeliveryToLocation': deliveryToLocation,
      'TotalAmountReportingCurrency': totalAmountReportingCurrency,
      'PoRemarks': poRemarks,
      'IsBaggingCompleted': isBaggingCompleted == true ? 1 : 0,
      'ModifiedOn': modifiedOn,
      'PortID': portID,
      'IsFull': isFull == true ? 1 : 0,
      'SyncStatus': syncStatus == true ? 1 : 0,
      'DeliveryReference': deliveryReference,
      'IsBaggingTaggingApplicable': isBaggingTaggingApplicable == true ? 1 : 0,
      'WorkFlowID': workFlowId,
      'WorkFlowStatusID': workFlowStatusId,
      'isConfirmed': isConfirmed == true ? 1 : 0,
      'PODTID': podtid,
    };
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      grnId: grnId ?? -1,
      receiptNo: receiptNo ?? "",
      receiptDate: receiptDate ?? "",
      poNo: poNo ?? "",
      poId: poId ?? -1,
      insights: insights ?? "",
      reqCategoryID: reqCategoryID ?? -1,
      category: category ?? "",
      priorityID: priorityID ?? -1,
      priority: priority ?? "",
      vendorID: vendorID ?? -1,
      vendorName: vendorName ?? "",
      delivryDate: delivryDate ?? "",
      deliveryToID: deliveryToID ?? -1,
      dlvryTO: dlvryTO ?? "",
      pOtitle: pOtitle ?? "",
      totalNOofprudcts: totalNOofprudcts ?? -1,
      plannedNoOfPdcts: plannedNoOfPdcts ?? -1,
      entityID: entityID ?? -1,
      entity: entity ?? "",
      remarksForVendor: remarksForVendor ?? "",
      pocost: pocost ?? -1,
      weight: weight ?? -1,
      actualvolume: actualvolume ?? -1,
      currencyName: currencyName ?? "",
      noOfPackets: noOfPackets ?? -1,
      presentProperties: presentProperties ?? "",
      deliveryToLocationID: deliveryToLocationID ?? -1,
      deliveryToLocation: deliveryToLocation ?? "",
      totalAmountReportingCurrency: totalAmountReportingCurrency ?? -1,
      poRemarks: poRemarks ?? "",
      isBaggingCompleted: isBaggingCompleted ?? false,
      modifiedOn: modifiedOn ?? "",
      portID: portID ?? -1,
      isFull: false,
      syncStatus: syncStatus == SyncStatus.synced,
      deliveryReference: deliveryReference ?? '',
      isBaggingTaggingApplicable: isBaggingTaggingApplicable ?? false,
      isConfirmed: isConfirmed ?? false,
      podtid: podtid ?? -1,
      workFlowId: workFlowId ?? -1,
      workFlowStatusId: workFlowStatusId ?? -1,
      damagedQty: damagedQty ?? -1,
      newStock: newStock ?? -1,
      receivedQty: receivedQty ?? -1,
      items: itemCount ?? -1,
    );
  }

  TransactionModel copyWith({
    int? grnId,
    String? receiptNo,
    String? receiptDate,
    String? poNo,
    int? poId,
    String? insights,
    int? reqCategoryID,
    String? category,
    int? priorityID,
    String? priority,
    int? vendorID,
    String? vendorName,
    String? delivryDate,
    int? deliveryToID,
    String? dlvryTO,
    String? pOtitle,
    int? totalNOofprudcts,
    int? plannedNoOfPdcts,
    int? entityID,
    String? entity,
    String? remarksForVendor,
    double? pocost,
    double? weight,
    double? actualvolume,
    String? currencyName,
    int? noOfPackets,
    String? presentProperties,
    int? deliveryToLocationID,
    String? deliveryToLocation,
    double? totalAmountReportingCurrency,
    String? poRemarks,
    bool? isBaggingCompleted,
    String? modifiedOn,
    int? portID,
    bool? isFull,
    SyncStatus? syncStatus,
    String? deliveryReference,
    bool? isBaggingTaggingApplicable,
    bool? isConfirmed,
  }) {
    return TransactionModel(
      grnId: grnId ?? this.grnId,
      receiptNo: receiptNo ?? this.receiptNo,
      receiptDate: receiptDate ?? this.receiptDate,
      poNo: poNo ?? this.poNo,
      poId: poId ?? this.poId,
      insights: insights ?? this.insights,
      reqCategoryID: reqCategoryID ?? this.reqCategoryID,
      category: category ?? this.category,
      priorityID: priorityID ?? this.priorityID,
      priority: priority ?? this.priority,
      vendorID: vendorID ?? this.vendorID,
      vendorName: vendorName ?? this.vendorName,
      delivryDate: delivryDate ?? this.delivryDate,
      deliveryToID: deliveryToID ?? this.deliveryToID,
      dlvryTO: dlvryTO ?? this.dlvryTO,
      pOtitle: pOtitle ?? this.pOtitle,
      totalNOofprudcts: totalNOofprudcts ?? this.totalNOofprudcts,
      plannedNoOfPdcts: plannedNoOfPdcts ?? this.plannedNoOfPdcts,
      entityID: entityID ?? this.entityID,
      entity: entity ?? this.entity,
      remarksForVendor: remarksForVendor ?? this.remarksForVendor,
      pocost: pocost ?? this.pocost,
      weight: weight ?? this.weight,
      actualvolume: actualvolume ?? this.actualvolume,
      currencyName: currencyName ?? this.currencyName,
      noOfPackets: noOfPackets ?? this.noOfPackets,
      presentProperties: presentProperties ?? this.presentProperties,
      deliveryToLocationID: deliveryToLocationID ?? this.deliveryToLocationID,
      deliveryToLocation: deliveryToLocation ?? this.deliveryToLocation,
      totalAmountReportingCurrency:
          totalAmountReportingCurrency ?? this.totalAmountReportingCurrency,
      poRemarks: poRemarks ?? this.poRemarks,
      isBaggingCompleted: isBaggingCompleted ?? this.isBaggingCompleted,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      portID: portID ?? this.portID,
      isFull: isFull ?? this.isFull,
      // syncStatus: syncStatus ?? this.syncStatus,
      deliveryReference: deliveryReference ?? this.deliveryReference,
      isBaggingTaggingApplicable:
          isBaggingTaggingApplicable ?? this.isBaggingTaggingApplicable,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }

  // Map<String, dynamic> toJsonForSaveApi({
  //   required TransactionModel hdModel,
  //   required List<TransactionItemDetailModel> transactionModelList,
  // }) {
  //   return {
  //     "StatusCode": "FNL",
  //     "GoodsReceiptHD": {
  //       "id": hdModel.grnId,
  //       "isOfficeGRN": false,
  //       "categoryID": hdModel.reqCategoryID ?? -1,
  //       "referenceTypeID": 1,
  //       "referenceID": 1,
  //       "referenceSubID": 13,
  //       "code": hdModel.receiptNo ?? "",
  //       "deliveryTypeID": hdModel.deliveryToID,
  //       "deliveryToLocationID": null,
  //       "deliveryToName": "",
  //       "portID": hdModel.portID ?? -1,
  //       "deliveryReference": "",
  //       "receivedDate": "2025-09-23T00:00:00",
  //       "generatedDate": "0001-01-01T00:00:00",
  //       "remarks": "",
  //       "isPartial": false,
  //       "isNoVesselGRN": false,
  //       "isBaggingTagging": true,
  //       "workFlowID": hdModel.workFlowId,
  //       "workFlowStatusID": hdModel.workFlowStatusId,
  //       "roleCode": "",
  //       "orderTypeID": 387,
  //       "versionIdentifier": 0,
  //       "operationType": "UPD",
  //       "pohdid": hdModel.poId,
  //       "itemPropertyJson": null,
  //       "itemCount": 0,
  //       "weight": "0.00",
  //       "actualVolume": "0.00",
  //       "noOfPackets": 0,
  //       "orgID": 0,
  //       "deliveryAddress": "",
  //       "isBaggingTaggingApplicable": true,
  //       "isLocked": true,
  //     },
  //     "GoodsReceiptDT":
  //         transactionModelList
  //             .map(
  //               (e) => {
  //                 "id": e.poId,
  //                 "grnhdid": e.grnId,
  //                 "itemID": e.itemId,
  //                 "itemVersionID": e.itemVersionId,
  //                 "itemLinkID": e.itemLinkId,
  //                 "parentItemID": e.parentItemId,
  //                 "parentItemVersionID": e.parentItemVersionId,
  //                 "parentItemLinkID": e.parentItemLinkId,
  //                 "receivedQty": e.receivedQty,
  //                 "convertedStockQty": e.convertedStockQty,
  //                 "newStock": e.newStock,
  //                 "damagedOrWrongSupply": e.damagedOrWrongSupply ?? 0,
  //                 "reconditionedStock": e.reconditionedStock ?? 0,
  //                 "expiryDate": null,
  //                 "uomid": e.uomId,
  //                 "qualityID": e.qualityId,
  //                 "batchNo": e.batchNo,
  //                 "remarks": e.remarks,
  //                 "versionIdentifier": 0,
  //                 "orgID": 0,
  //                 "operationType": "",
  //                 "isIhm": false,
  //                 "bagTagLocationId": 5354,
  //                 "isBagTagRequired": true,
  //                 "isBagTagItem": true,
  //                 "podtid": e.podtid,
  //                 "defaultLocationId": 208,
  //                 "sortOrder": 1,
  //                 "itemStatusCode": "DELVD",
  //                 "actualReceivedQty": e.receivedQty,
  //                 "conversionFactor": 1,
  //               },
  //             )
  //             .toList(),
  //     "VesselOrOffice": "V",
  //     "VesselCode": "788",
  //     "OrderType": "PO",
  //     "IsUpdateStock": "Y",
  //     "isBaggingTaggingPendingTab": true,
  //     "isBagTagCompleted": true,
  //     "grnhdOtherMapping": [],
  //     "GRNItemUnitConversionFactorConfigMappers": [],
  //   };
  // }
}
