import 'package:equatable/equatable.dart';

import '../../domain/entities/goods_receipt_po_header_list_api_entity.dart';
import 'goods_receipt_entity_validation.dart';

class GoodsReceiptPoHeaderListApiResponseModel extends Equatable {
  const GoodsReceiptPoHeaderListApiResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory GoodsReceiptPoHeaderListApiResponseModel.fromJson(
    Map<String, dynamic> map,
  ) {
    return GoodsReceiptPoHeaderListApiResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<GoodsReceiptPoHeaderListApiModel>.from(
        (map['reportData'] as List).map(
          (x) => GoodsReceiptPoHeaderListApiModel.fromJson(
            x as Map<String, dynamic>,
          ),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<GoodsReceiptPoHeaderListApiModel>? reportData;
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

class GoodsReceiptPoHeaderListApiModel extends Equatable {
  const GoodsReceiptPoHeaderListApiModel({
    required this.poCode,
    required this.poHdId,
    required this.requisitionCategory,
    required this.vendorName,
    required this.title,
    required this.priority,
    required this.vendorDeliveryDate,
    required this.vendorReference,
    required this.budgetDate,
    required this.entity,
    required this.currency,
    required this.payment,
    required this.paymentTerms,
    required this.remarksToVendor,
    required this.paymentDueAfterDays,
    required this.createdBy,
    required this.postInvoicePO,
    required this.exportControl,
    required this.exportControlBlock,
    required this.remarksFromVendor,
    required this.deliveryTo,
    required this.placeOfProcurement,
    required this.leadDays,
    required this.deliveryTerms,
    required this.deliveryPort,
    required this.wareHouseName,
    required this.poCreatedOn,
    required this.vessel,
    required this.portCode,
    required this.portCountryName,
    required this.portCountryCode,
    required this.totalAmount,
    required this.totalAmountBaseCurrency,
    required this.totalAmountReportingCurrency,
    required this.headerDiscount,
    required this.createdUserEmail,
    required this.vesselIMO,
    required this.vesselCode,
    required this.priorityCode,
    required this.deliveryTermsCode,
    required this.reqCategoryCode,
    required this.currencyCode,
    required this.vendorEmail,
    required this.vendorShortName,
    required this.shipServQuoteId,
    required this.siteId,
    required this.vendorID,
    required this.supplierZipCode,
    required this.referenceTypeID,
    required this.referenceID,
    required this.referenceSubID,
    required this.requisitionCategoryId,
    required this.buyerName,
    required this.revisionNo,
    required this.recSparesToBring,
    required this.serviceDescription,
    required this.roleCode,
    required this.portID,
    required this.deliveryToID,
  });

  factory GoodsReceiptPoHeaderListApiModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptPoHeaderListApiModel(
      poCode: json['POCode'] as String?,
      poHdId: json['POHDID'] as int?,
      requisitionCategory: json['RequisitionCategory'] as String?,
      vendorName: json['VendorName'] as String?,
      title: json['Title'] as String?,
      priority: json['Priority'] as String?,
      vendorDeliveryDate: json['VendorDeliveryDate'] as String?,
      vendorReference: json['VendorReference'] as String?,
      budgetDate: json['BudgetDate'] as String?,
      entity: json['Entity'] as String?,
      currency: json['Currency'] as String?,
      payment: json['Payment'] as String?,
      paymentTerms: json['PaymentTerms'] as String?,
      remarksToVendor: json['RemarksToVendor'] as String?,
      paymentDueAfterDays: json['PaymentDueAfterDays'] as String?,
      createdBy: json['CreatedBy'] as String?,
      postInvoicePO: json['PostInvoicePO'] as bool?,
      exportControl: json['ExportControl'] as bool?,
      exportControlBlock: json['ExportControlBlock'] as bool?,
      remarksFromVendor: json['RemarksFromVendor'] as String?,
      deliveryTo: json['DeliveryTo'] as String?,
      placeOfProcurement: json['PlaceOfProcurement'] as String?,
      leadDays: json['LeadDays'] as String?,
      deliveryTerms: json['DeliveryTerms'] as String?,
      deliveryPort: json['DeliveryPort'] as String?,
      wareHouseName: json['WareHouseName'] as String?,
      poCreatedOn: json['POCreatedOn'] as String?,
      vessel: json['Vessel'] as String?,
      portCode: json['PortCode'] as String?,
      portCountryName: json['PortCountryName'] as String?,
      portCountryCode: json['PortCountryCode'] as String?,
      totalAmount: json['TotalAmount'] as double?,
      totalAmountBaseCurrency: json['TotalAmountBaseCurrency'] as double?,
      totalAmountReportingCurrency:
          json['TotalAmountReportingCurrency'] as double?,
      headerDiscount: json['HeaderDiscount'] as double?,
      createdUserEmail: json['CreatedUserEmail'] as String?,
      vesselIMO: json['VesselIMO'] as String?,
      vesselCode: json['VesselCode'] as String?,
      priorityCode: json['PriorityCode'] as String?,
      deliveryTermsCode: json['DeliveryTermsCode'] as String?,
      reqCategoryCode: json['ReqCategoryCode'] as String?,
      currencyCode: json['CurrencyCode'] as String?,
      vendorEmail: json['VendorEmail'] as String?,
      vendorShortName: json['VendorShortName'] as String?,
      shipServQuoteId: json['ShipservQuoteId'] as String?,
      siteId: json['SiteId'] as int?,
      vendorID: json['VendorID'] as int?,
      supplierZipCode: json['SupplierZipCode'] as String?,
      referenceTypeID: json['ReferenceTypeID'] as int?,
      referenceID: json['ReferenceID'] as int?,
      referenceSubID: json['ReferenceSubID'] as int?,
      requisitionCategoryId: json['RequisitionCategoryId'] as int?,
      buyerName: json['BuyerName'] as String?,
      revisionNo: json['RevisionNo'] as int?,
      recSparesToBring: json['RecSparesToBring'] as String?,
      serviceDescription: json['ServiceDescription'] as String?,
      roleCode: json['RoleCode'] as String?,
      portID: json['PortID'] as int?,
      deliveryToID: json['DeliveryToID'] as int?,
    );
  }

  factory GoodsReceiptPoHeaderListApiModel.fromEntity(
    GoodsReceiptPoHeaderListApiEntity entity,
  ) {
    return GoodsReceiptPoHeaderListApiModel(
      poCode: entity.poCode,
      poHdId: entity.poHdId,
      requisitionCategory: entity.requisitionCategory,
      vendorName: entity.vendorName,
      title: entity.title,
      priority: entity.priority,
      vendorDeliveryDate: entity.vendorDeliveryDate,
      vendorReference: entity.vendorReference,
      budgetDate: entity.budgetDate,
      entity: entity.entity,
      currency: entity.currency,
      payment: entity.payment,
      paymentTerms: entity.paymentTerms,
      remarksToVendor: entity.remarksToVendor,
      paymentDueAfterDays: entity.paymentDueAfterDays,
      createdBy: entity.createdBy,
      postInvoicePO: entity.postInvoicePO,
      exportControl: entity.exportControl,
      exportControlBlock: entity.exportControlBlock,
      remarksFromVendor: entity.remarksFromVendor,
      deliveryTo: entity.deliveryTo,
      placeOfProcurement: entity.placeOfProcurement,
      leadDays: entity.leadDays,
      deliveryTerms: entity.deliveryTerms,
      deliveryPort: entity.deliveryPort,
      wareHouseName: entity.wareHouseName,
      poCreatedOn: entity.poCreatedOn,
      vessel: entity.vessel,
      portCode: entity.portCode,
      portCountryName: entity.portCountryName,
      portCountryCode: entity.portCountryCode,
      totalAmount: entity.totalAmount,
      totalAmountBaseCurrency: entity.totalAmountBaseCurrency,
      totalAmountReportingCurrency: entity.totalAmountReportingCurrency,
      headerDiscount: entity.headerDiscount,
      createdUserEmail: entity.createdUserEmail,
      vesselIMO: entity.vesselIMO,
      vesselCode: entity.vesselCode,
      priorityCode: entity.priorityCode,
      deliveryTermsCode: entity.deliveryTermsCode,
      reqCategoryCode: entity.reqCategoryCode,
      currencyCode: entity.currencyCode,
      vendorEmail: entity.vendorEmail,
      vendorShortName: entity.vendorShortName,
      shipServQuoteId: entity.shipServQuoteId,
      siteId: entity.siteId,
      vendorID: entity.vendorID,
      supplierZipCode: entity.supplierZipCode,
      referenceTypeID: entity.referenceTypeID,
      referenceID: entity.referenceID,
      referenceSubID: entity.referenceSubID,
      requisitionCategoryId: entity.requisitionCategoryId,
      buyerName: entity.buyerName,
      revisionNo: entity.revisionNo,
      recSparesToBring: entity.recSparesToBring,
      serviceDescription: entity.serviceDescription,
      roleCode: entity.roleCode,
      portID: entity.portID,
      deliveryToID: entity.deliveryToID,
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
  final String? paymentDueAfterDays;
  final String? createdBy;
  final bool? postInvoicePO;
  final bool? exportControl;
  final bool? exportControlBlock;
  final String? remarksFromVendor;
  final String? deliveryTo;
  final String? placeOfProcurement;
  final String? leadDays;
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
  final String? createdUserEmail;
  final String? vesselIMO;
  final String? vesselCode;
  final String? priorityCode;
  final String? deliveryTermsCode;
  final String? reqCategoryCode;
  final String? currencyCode;
  final String? vendorEmail;
  final String? vendorShortName;
  final String? shipServQuoteId;
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
      'PostInvoicePO': postInvoicePO,
      'ExportControl': exportControl,
      'ExportControlBlock': exportControlBlock,
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
      'CreatedUserEmail': createdUserEmail,
      'VesselIMO': vesselIMO,
      'VesselCode': vesselCode,
      'PriorityCode': priorityCode,
      'DeliveryTermsCode': deliveryTermsCode,
      'ReqCategoryCode': reqCategoryCode,
      'CurrencyCode': currencyCode,
      'VendorEmail': vendorEmail,
      'VendorShortName': vendorShortName,
      'ShipservQuoteId': shipServQuoteId,
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
      'PortID': portID,
      'DeliveryToID': deliveryToID,
    };
  }

  GoodsReceiptPoHeaderListApiEntity toEntity() =>
      GoodsReceiptPoHeaderListApiEntity(
        poCode: poCode ?? '',
        poHdId: poHdId ?? 0,
        requisitionCategory: requisitionCategory ?? '',
        vendorName: vendorName ?? '',
        title: title ?? '',
        priority: priority ?? '',
        vendorDeliveryDate: vendorDeliveryDate ?? '',
        vendorReference: vendorReference ?? '',
        budgetDate: budgetDate ?? '',
        entity: entity ?? '',
        currency: currency ?? '',
        payment: payment ?? '',
        paymentTerms: paymentTerms ?? '',
        remarksToVendor: remarksToVendor ?? '',
        paymentDueAfterDays: paymentDueAfterDays ?? '',
        createdBy: createdBy ?? '',
        postInvoicePO: postInvoicePO ?? false,
        exportControl: exportControl ?? false,
        exportControlBlock: exportControlBlock ?? false,
        remarksFromVendor: remarksFromVendor ?? '',
        deliveryTo: deliveryTo ?? '',
        placeOfProcurement: placeOfProcurement ?? '',
        leadDays: leadDays ?? '',
        deliveryTerms: deliveryTerms ?? '',
        deliveryPort: deliveryPort ?? '',
        wareHouseName: wareHouseName ?? '',
        poCreatedOn: poCreatedOn ?? '',
        vessel: vessel ?? '',
        portCode: portCode ?? '',
        portCountryName: portCountryName ?? '',
        portCountryCode: portCountryCode ?? '',
        totalAmount: totalAmount ?? 0.0,
        totalAmountBaseCurrency: totalAmountBaseCurrency ?? 0.0,
        totalAmountReportingCurrency: totalAmountReportingCurrency ?? 0.0,
        headerDiscount: headerDiscount ?? 0.0,
        createdUserEmail: createdUserEmail ?? '',
        vesselIMO: vesselIMO ?? '',
        vesselCode: vesselCode ?? '',
        priorityCode: priorityCode ?? '',
        deliveryTermsCode: deliveryTermsCode ?? '',
        reqCategoryCode: reqCategoryCode ?? '',
        currencyCode: currencyCode ?? '',
        vendorEmail: vendorEmail ?? '',
        vendorShortName: vendorShortName ?? '',
        shipServQuoteId: shipServQuoteId ?? '',
        siteId: siteId ?? 0,
        vendorID: vendorID ?? 0,
        supplierZipCode: supplierZipCode ?? '',
        referenceTypeID: referenceTypeID ?? 0,
        referenceID: referenceID ?? 0,
        referenceSubID: referenceSubID ?? 0,
        requisitionCategoryId: requisitionCategoryId ?? 0,
        buyerName: buyerName ?? '',
        revisionNo: revisionNo ?? 0,
        recSparesToBring: recSparesToBring ?? '',
        serviceDescription: serviceDescription ?? '',
        roleCode: roleCode ?? '',
        portID: portID ?? 0,
        deliveryToID: deliveryToID ?? 0,
      );

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
    createdUserEmail,
    vesselIMO,
    vesselCode,
    priorityCode,
    deliveryTermsCode,
    reqCategoryCode,
    currencyCode,
    vendorEmail,
    vendorShortName,
    shipServQuoteId,
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
  ];

  @override
  bool? get stringify => true;
}
