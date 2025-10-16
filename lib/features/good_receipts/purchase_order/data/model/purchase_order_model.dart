import 'package:equatable/equatable.dart';

import '../../domain/entity/purchase_order_entity.dart';
import 'entity_validation_model.dart';

class PurchaseOrderResponseModel extends Equatable {
  const PurchaseOrderResponseModel({
    this.moduleCode,
    this.entityName,
    this.recordCount,
    this.reportData,
    this.entityValidation,
  });

  factory PurchaseOrderResponseModel.fromJson(Map<String, dynamic> map) {
    return PurchaseOrderResponseModel(
      moduleCode:
          map['moduleCode'] != null ? map['moduleCode'] as String : null,
      entityName:
          map['entityName'] != null ? map['entityName'] as String : null,
      recordCount:
          map['recordCount'] != null ? map['recordCount'] as int : null,
      reportData:
          map['reportData'] != null
              ? List<PurchaseOrderModel>.from(
                (map['reportData'] as List<dynamic>).map<PurchaseOrderModel?>(
                  (x) => PurchaseOrderModel.fromJson(x as Map<String, dynamic>),
                ),
              )
              : null,
      entityValidation:
          map['entityValidation'] != null
              ? EntityValidationModel.fromJson(
                map['entityValidation'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  final String? moduleCode;
  final String? entityName;
  final int? recordCount;
  final List<PurchaseOrderModel>? reportData;

  final EntityValidationModel? entityValidation;

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    reportData,
    recordCount,
    entityValidation,
  ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'entityValidation': entityValidation?.toJson(),
    };
  }
}

class PurchaseOrderModel extends Equatable {
  const PurchaseOrderModel({
    this.poCode,
    this.poHdId,
    this.requisitionCategory,
    this.vendorName,
    this.title,
    this.priority,
    this.vendorDeliveryDate,
    this.vendorReference,
    this.budgetDate,
    this.entity,
    this.currency,
    this.payment,
    this.paymentTerms,
    this.remarksToVendor,
    this.paymentDueAfterDays,
    this.createdBy,
    this.postInvoicePO,
    this.exportControl,
    this.exportControlBlock,
    this.remarksFromVendor,
    this.deliveryTo,
    this.placeOfProcurement,
    this.leadDays,
    this.deliveryTerms,
    this.deliveryPort,
    this.wareHouseName,
    this.poCreatedOn,
    this.vessel,
    this.portCode,
    this.portCountryName,
    this.portCountryCode,
    this.totalAmount,
    this.totalAmountBaseCurrency,
    this.totalAmountReportingCurrency,
    this.headerDiscount,
    this.vesselIMO,
    this.vesselCode,
    this.priorityCode,
    this.deliveryTermsCode,
    this.reqCategoryCode,
    this.currencyCode,
    this.vendorEmail,
    this.vendorShortName,
    this.shipservQuoteId,
    this.siteId,
    this.vendorID,
    this.supplierZipCode,
    this.referenceTypeID,
    this.referenceID,
    this.referenceSubID,
    this.requisitionCategoryId,
    this.buyerName,
    this.revisionNo,
    this.recSparesToBring,
    this.serviceDescription,
    this.roleCode,
    this.portID,
    this.deliveryToID,
    this.grnId,
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> map) {
    return PurchaseOrderModel(
      poCode: map['POCode'] != null ? map['POCode'] as String : null,
      poHdId: map['POHDID'] != null ? map['POHDID'] as int : null,
      requisitionCategory:
          map['RequisitionCategory'] != null
              ? map['RequisitionCategory'] as String
              : null,
      vendorName:
          map['VendorName'] != null ? map['VendorName'] as String : null,
      title: map['Title'] != null ? map['Title'] as String : null,
      priority: map['Priority'] != null ? map['Priority'] as String : null,
      vendorDeliveryDate:
          map['VendorDeliveryDate'] != null
              ? map['VendorDeliveryDate'] as String
              : null,
      vendorReference:
          map['VendorReference'] != null
              ? map['VendorReference'] as String
              : null,
      budgetDate:
          map['BudgetDate'] != null ? map['BudgetDate'] as String : null,
      entity: map['Entity'] != null ? map['Entity'] as String : null,
      currency: map['Currency'] != null ? map['Currency'] as String : null,
      payment: map['Payment'] != null ? map['Payment'] as String : null,
      paymentTerms:
          map['PaymentTerms'] != null ? map['PaymentTerms'] as String : null,
      remarksToVendor:
          map['RemarksToVendor'] != null
              ? map['RemarksToVendor'] as String
              : null,
      paymentDueAfterDays:
          map['PaymentDueAfterDays'] != null
              ? map['PaymentDueAfterDays'] as double
              : null,
      createdBy: map['CreatedBy'] != null ? map['CreatedBy'] as String : null,
      postInvoicePO:
          map["PostInvoicePO"] != null
              ? map["PostInvoicePO"].runtimeType == bool
                  ? map["PostInvoicePO"]
                  : map["PostInvoicePO"] == 1
                  ? true
                  : false
              : false,

      exportControl:
          map['ExportControl'] != null
              ? map["ExportControl"].runtimeType == bool
                  ? map["ExportControl"]
                  : map["ExportControl"] == 1
                  ? true
                  : false
              : false,
      exportControlBlock:
          map['ExportControlBlock'] != null
              ? map["ExportControlBlock"].runtimeType == bool
                  ? map["ExportControlBlock"]
                  : map["ExportControlBlock"] == 1
                  ? true
                  : false
              : false,
      remarksFromVendor:
          map['RemarksFromVendor'] != null
              ? map['RemarksFromVendor'] as String
              : null,
      deliveryTo:
          map['DeliveryTo'] != null ? map['DeliveryTo'] as String : null,
      placeOfProcurement:
          map['PlaceOfProcurement'] != null
              ? map['PlaceOfProcurement'] as String
              : null,
      leadDays: map['LeadDays'] != null ? map['LeadDays'] as double : null,
      deliveryTerms:
          map['DeliveryTerms'] != null ? map['DeliveryTerms'] as String : null,
      deliveryPort:
          map['DeliveryPort'] != null ? map['DeliveryPort'] as String : null,
      wareHouseName:
          map['WareHouseName'] != null ? map['WareHouseName'] as String : null,
      poCreatedOn:
          map['POCreatedOn'] != null ? map['POCreatedOn'] as String : null,
      vessel: map['Vessel'] != null ? map['Vessel'] as String : null,
      portCode: map['PortCode'] != null ? map['PortCode'] as String : null,
      portCountryName:
          map['PortCountryName'] != null
              ? map['PortCountryName'] as String
              : null,
      portCountryCode:
          map['PortCountryCode'] != null
              ? map['PortCountryCode'] as String
              : null,
      totalAmount:
          map['TotalAmount'] != null ? map['TotalAmount'] as double : null,
      totalAmountBaseCurrency:
          map['TotalAmountBaseCurrency'] != null
              ? map['TotalAmountBaseCurrency'] as double
              : null,
      totalAmountReportingCurrency:
          map['TotalAmountReportingCurrency'] != null
              ? map['TotalAmountReportingCurrency'] as double
              : null,
      headerDiscount:
          map['HeaderDiscount'] != null
              ? map['HeaderDiscount'] as double
              : null,
      vesselIMO: map['VesselIMO'] != null ? map['VesselIMO'] as String : null,
      vesselCode:
          map['VesselCode'] != null ? map['VesselCode'] as String : null,
      priorityCode:
          map['PriorityCode'] != null ? map['PriorityCode'] as String : null,
      deliveryTermsCode:
          map['DeliveryTermsCode'] != null
              ? map['DeliveryTermsCode'] as String
              : null,
      reqCategoryCode:
          map['ReqCategoryCode'] != null
              ? map['ReqCategoryCode'] as String
              : null,
      currencyCode:
          map['CurrencyCode'] != null ? map['CurrencyCode'] as String : null,
      vendorEmail:
          map['VendorEmail'] != null ? map['VendorEmail'] as String : null,
      vendorShortName:
          map['VendorShortName'] != null
              ? map['VendorShortName'] as String
              : null,
      shipservQuoteId:
          map['ShipservQuoteId'] != null ? map['ShipservQuoteId'] as int : null,
      siteId: map['SiteId'] != null ? map['SiteId'] as int : null,
      vendorID: map['VendorID'] != null ? map['VendorID'] as int : null,
      supplierZipCode:
          map['SupplierZipCode'] != null
              ? map['SupplierZipCode'] as String
              : null,
      referenceTypeID:
          map['ReferenceTypeID'] != null ? map['ReferenceTypeID'] as int : null,
      referenceID:
          map['ReferenceID'] != null ? map['ReferenceID'] as int : null,
      referenceSubID:
          map['ReferenceSubID'] != null ? map['ReferenceSubID'] as int : null,
      requisitionCategoryId:
          map['RequisitionCategoryId'] != null
              ? map['RequisitionCategoryId'] as int
              : null,
      buyerName: map['BuyerName'] != null ? map['BuyerName'] as String : null,
      revisionNo: map['RevisionNo'] != null ? map['RevisionNo'] as int : null,
      recSparesToBring:
          map['RecSparesToBring'] != null
              ? map['RecSparesToBring'] as String
              : null,
      serviceDescription:
          map['ServiceDescription'] != null
              ? map['ServiceDescription'] as String
              : null,
      roleCode: map['RoleCode'] != null ? map['RoleCode'] as String : null,
      portID: map['PortID'] != null ? map['PortID'] as int : null,
      deliveryToID:
          map['DeliveryToID'] != null ? map['DeliveryToID'] as int : null,
      grnId: map['GrnId'] != null ? map['GrnId'] as int : null,
    );
  }

  factory PurchaseOrderModel.fromEntity({required PurchaseOrderModel model}) {
    return PurchaseOrderModel(
      poCode: model.poCode,
      poHdId: model.poHdId,
      requisitionCategory: model.requisitionCategory,
      vendorName: model.vendorName,
      title: model.title,
      priority: model.priority,
      vendorDeliveryDate: model.vendorDeliveryDate,
      vendorReference: model.vendorReference,
      budgetDate: model.budgetDate,
      entity: model.entity,
      currency: model.currency,
      payment: model.payment,
      paymentTerms: model.paymentTerms,
      remarksToVendor: model.remarksFromVendor,
      paymentDueAfterDays: model.paymentDueAfterDays,
      createdBy: model.createdBy,
      postInvoicePO: model.postInvoicePO,
      exportControl: model.exportControl,
      exportControlBlock: model.exportControlBlock,
      remarksFromVendor: model.remarksFromVendor,
      deliveryTo: model.deliveryTo,
      placeOfProcurement: model.placeOfProcurement,
      leadDays: model.leadDays,
      deliveryTerms: model.deliveryTerms,
      deliveryPort: model.deliveryPort,
      wareHouseName: model.wareHouseName,
      poCreatedOn: model.poCreatedOn,
      vessel: model.vessel,
      portCode: model.portCode,
      portCountryName: model.portCountryName,
      portCountryCode: model.portCountryCode,
      totalAmount: model.totalAmount,
      totalAmountBaseCurrency: model.totalAmountBaseCurrency,
      totalAmountReportingCurrency: model.totalAmountReportingCurrency,
      headerDiscount: model.headerDiscount,
      vesselIMO: model.vesselIMO,
      vesselCode: model.vesselCode,
      priorityCode: model.priorityCode,
      deliveryTermsCode: model.deliveryTermsCode,
      reqCategoryCode: model.reqCategoryCode,
      currencyCode: model.currencyCode,
      vendorEmail: model.vendorEmail,
      vendorShortName: model.vendorShortName,
      shipservQuoteId: model.shipservQuoteId,
      siteId: model.siteId,
      vendorID: model.vendorID,
      supplierZipCode: model.supplierZipCode,
      referenceTypeID: model.referenceTypeID,
      referenceID: model.referenceID,
      referenceSubID: model.referenceSubID,
      requisitionCategoryId: model.requisitionCategoryId,
      buyerName: model.buyerName,
      revisionNo: model.revisionNo,
      recSparesToBring: model.recSparesToBring,
      serviceDescription: model.serviceDescription,
      roleCode: model.roleCode,
      portID: model.portID,
      deliveryToID: model.deliveryToID,
      grnId: model.grnId,
    );
  }

  final String? poCode;
  final int? poHdId;
  final String? requisitionCategory;
  final String? vendorName;
  final String? title;
  final String? priority;
  final String? vendorDeliveryDate;
  final String? vendorReference;
  final String? budgetDate;
  final String? entity;
  final String? currency;
  final String? payment;
  final String? paymentTerms;
  final String? remarksToVendor;
  final double? paymentDueAfterDays;
  final String? createdBy;
  final bool? postInvoicePO;
  final bool? exportControl;
  final bool? exportControlBlock;
  final String? remarksFromVendor;
  final String? deliveryTo;
  final String? placeOfProcurement;
  final double? leadDays;
  final String? deliveryTerms;
  final String? deliveryPort;
  final String? wareHouseName;
  final String? poCreatedOn;
  final String? vessel;
  final String? portCode;
  final String? portCountryName;
  final String? portCountryCode;
  final double? totalAmount;
  final double? totalAmountBaseCurrency;
  final double? totalAmountReportingCurrency;
  final double? headerDiscount;
  final String? vesselIMO;
  final String? vesselCode;
  final String? priorityCode;
  final String? deliveryTermsCode;
  final String? reqCategoryCode;
  final String? currencyCode;
  final String? vendorEmail;
  final String? vendorShortName;
  final int? shipservQuoteId;
  final int? siteId;
  final int? vendorID;
  final String? supplierZipCode;
  final int? referenceTypeID;
  final int? referenceID;
  final int? referenceSubID;
  final int? requisitionCategoryId;
  final String? buyerName;
  final int? revisionNo;
  final String? recSparesToBring;
  final String? serviceDescription;
  final String? roleCode;
  final int? portID;
  final int? deliveryToID;
  final int? grnId;

  @override
  List<Object?> get props => [
    poCode,
    poHdId,
    requisitionCategory,
    vendorName,
    title,
    priority,
    vendorDeliveryDate,
    vendorReference,
    budgetDate,
    entity,
    currency,
    payment,
    paymentTerms,
    remarksToVendor,
    paymentDueAfterDays,
    createdBy,
    postInvoicePO,
    exportControl,
    exportControlBlock,
    remarksFromVendor,
    deliveryTo,
    placeOfProcurement,
    leadDays,
    deliveryTerms,
    deliveryPort,
    wareHouseName,
    poCreatedOn,
    vessel,
    portCode,
    portCountryName,
    portCountryCode,
    totalAmount,
    totalAmountBaseCurrency,
    totalAmountReportingCurrency,
    headerDiscount,
    vesselIMO,
    vesselCode,
    priorityCode,
    deliveryTermsCode,
    reqCategoryCode,
    currencyCode,
    vendorEmail,
    vendorShortName,
    shipservQuoteId,
    siteId,
    vendorID,
    supplierZipCode,
    referenceTypeID,
    referenceID,
    referenceSubID,
    requisitionCategoryId,
    buyerName,
    revisionNo,
    recSparesToBring,
    serviceDescription,
    roleCode,
    portID,
    deliveryToID,
    grnId,
  ];

  @override
  bool? get stringify => true;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'POCode': poCode,
      'POHDID': poHdId,
      'RequisitionCategory': requisitionCategory,
      'VendorName': vendorName,
      'Title': title,
      'Priority': priority,
      'VendorDeliveryDate': vendorDeliveryDate,
      'VendorReference': vendorReference,
      'BudgetDate': budgetDate,
      'Entity': entity,
      'Currency': currency,
      'Payment': payment,
      'PaymentTerms': paymentTerms,
      'RemarksToVendor': remarksToVendor,
      'PaymentDueAfterDays': paymentDueAfterDays,
      'CreatedBy': createdBy,
      'PostInvoicePO': postInvoicePO == true ? 1 : 0,
      'ExportControl': exportControl == true ? 1 : 0,
      'ExportControlBlock': exportControlBlock == true ? 1 : 0,
      'RemarksFromVendor': remarksFromVendor,
      'DeliveryTo': deliveryTo,
      'PlaceOfProcurement': placeOfProcurement,
      'LeadDays': leadDays,
      'DeliveryTerms': deliveryTerms,
      'DeliveryPort': deliveryPort,
      'WareHouseName': wareHouseName,
      'POCreatedOn': poCreatedOn,
      'Vessel': vessel,
      'PortCode': portCode,
      'PortCountryName': portCountryName,
      'PortCountryCode': portCountryCode,
      'TotalAmount': totalAmount,
      'TotalAmountBaseCurrency': totalAmountBaseCurrency,
      'TotalAmountReportingCurrency': totalAmountReportingCurrency,
      'HeaderDiscount': headerDiscount,
      'VesselIMO': vesselIMO,
      'VesselCode': vesselCode,
      'PriorityCode': priorityCode,
      'DeliveryTermsCode': deliveryTermsCode,
      'ReqCategoryCode': reqCategoryCode,
      'CurrencyCode': currencyCode,
      'VendorEmail': vendorEmail,
      'VendorShortName': vendorShortName,
      'ShipservQuoteId': shipservQuoteId,
      'SiteId': siteId,
      'VendorID': vendorID,
      'SupplierZipCode': supplierZipCode,
      'ReferenceTypeID': referenceTypeID,
      'ReferenceID': referenceID,
      'ReferenceSubID': referenceSubID,
      'RequisitionCategoryId': requisitionCategoryId,
      'BuyerName': buyerName,
      'RevisionNo': revisionNo,
      'RecSparesToBring': recSparesToBring,
      'ServiceDescription': serviceDescription,
      'RoleCode': roleCode,
      'portID': portID,
      'DeliveryToID': deliveryToID,
      'GrnId': grnId,
    };
  }

  PurchaseOrderEntity toEntity() {
    return PurchaseOrderEntity(
      poCode: poCode ?? "",
      poHdId: poHdId ?? -1,
      requisitionCategory: requisitionCategory ?? "",
      vendorName: vendorName ?? "",
      title: title ?? "",
      priority: priority ?? "",
      vendorDeliveryDate: vendorDeliveryDate ?? "",
      vendorReference: vendorReference ?? "",
      budgetDate: budgetDate ?? "",
      entity: entity ?? "",
      currency: currency ?? "",
      payment: payment ?? "",
      paymentTerms: paymentTerms ?? "",
      remarksToVendor: remarksToVendor ?? "",
      paymentDueAfterDays: paymentDueAfterDays ?? -1,
      createdBy: createdBy ?? "",
      postInvoicePO: postInvoicePO ?? false,
      exportControl: exportControl ?? false,
      exportControlBlock: exportControlBlock ?? false,
      remarksFromVendor: remarksFromVendor ?? "",
      deliveryTo: deliveryTo ?? "",
      placeOfProcurement: placeOfProcurement ?? "",
      leadDays: leadDays ?? -1,
      deliveryTerms: deliveryTerms ?? "",
      deliveryPort: deliveryPort ?? "",
      wareHouseName: wareHouseName ?? "",
      poCreatedOn: poCreatedOn ?? "",
      vessel: vessel ?? "",
      portCode: portCode ?? "",
      portCountryName: portCountryName ?? "",
      portCountryCode: portCountryCode ?? "",
      totalAmount: totalAmount ?? -1,
      totalAmountBaseCurrency: totalAmountBaseCurrency ?? -1,
      totalAmountReportingCurrency: totalAmountReportingCurrency ?? -1,
      headerDiscount: headerDiscount ?? -1,
      vesselIMO: vesselIMO ?? "",
      vesselCode: vesselCode ?? "",
      priorityCode: priorityCode ?? "",
      deliveryTermsCode: deliveryTermsCode ?? "",
      reqCategoryCode: reqCategoryCode ?? "",
      currencyCode: currencyCode ?? "",
      vendorEmail: vendorEmail ?? "",
      vendorShortName: vendorShortName ?? "",
      shipservQuoteId: shipservQuoteId ?? -1,
      siteId: siteId ?? -1,
      vendorID: vendorID ?? -1,
      supplierZipCode: supplierZipCode ?? "",
      referenceTypeID: referenceTypeID ?? -1,
      referenceID: referenceID ?? -1,
      referenceSubID: referenceSubID ?? -1,
      requisitionCategoryId: requisitionCategoryId ?? -1,
      buyerName: buyerName ?? "",
      revisionNo: revisionNo ?? -1,
      recSparesToBring: recSparesToBring ?? "",
      serviceDescription: serviceDescription ?? "",
      roleCode: roleCode ?? "",
      portID: portID ?? -1,
      deliveryToID: deliveryToID ?? -1,
      grnId: grnId ?? -1,
      packets: [],
    );
  }
}
