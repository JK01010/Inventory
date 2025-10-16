// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class GoodsReceiptPoHeaderListApiResponse {
  GoodsReceiptPoHeaderListApiResponse({required this.goodsReceiptHDEntity});

  List<GoodsReceiptPoHeaderListApiEntity> goodsReceiptHDEntity;
}

class GoodsReceiptPoHeaderListApiEntity extends Equatable {
  GoodsReceiptPoHeaderListApiEntity({
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

  String? poCode;
  int? poHdId;
  String? requisitionCategory;
  String? vendorName;
  String? title;
  String? priority;
  String? vendorDeliveryDate;
  String? vendorReference;
  String? budgetDate;
  String? entity;
  String? currency;
  String? payment;
  String? paymentTerms;
  String? remarksToVendor;
  String? paymentDueAfterDays;
  String? createdBy;
  bool? postInvoicePO;
  bool? exportControl;
  bool? exportControlBlock;
  String? remarksFromVendor;
  String? deliveryTo;
  String? placeOfProcurement;
  String? leadDays;
  String? deliveryTerms;
  String? deliveryPort;
  String? wareHouseName;
  String? poCreatedOn;
  String? vessel;
  String? portCode;
  String? portCountryName;
  String? portCountryCode;
  double? totalAmount;
  double? totalAmountBaseCurrency;
  double? totalAmountReportingCurrency;
  double? headerDiscount;
  String? createdUserEmail;
  String? vesselIMO;
  String? vesselCode;
  String? priorityCode;
  String? deliveryTermsCode;
  String? reqCategoryCode;
  String? currencyCode;
  String? vendorEmail;
  String? vendorShortName;
  String? shipServQuoteId;
  int? siteId;
  int? vendorID;
  String? supplierZipCode;
  int? referenceTypeID;
  int? referenceID;
  int? referenceSubID;
  int? requisitionCategoryId;
  String? buyerName;
  int? revisionNo;
  String? recSparesToBring;
  String? serviceDescription;
  String? roleCode;
  int? portID;
  int? deliveryToID;

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

  GoodsReceiptPoHeaderListApiEntity copyWith({
    String? poCode,
    int? poHdId,
    String? requisitionCategory,
    String? vendorName,
    String? title,
    String? priority,
    String? vendorDeliveryDate,
    String? vendorReference,
    String? budgetDate,
    String? entity,
    String? currency,
    String? payment,
    String? paymentTerms,
    String? remarksToVendor,
    String? paymentDueAfterDays,
    String? createdBy,
    bool? postInvoicePO,
    bool? exportControl,
    bool? exportControlBlock,
    String? remarksFromVendor,
    String? deliveryTo,
    String? placeOfProcurement,
    String? leadDays,
    String? deliveryTerms,
    String? deliveryPort,
    String? wareHouseName,
    String? poCreatedOn,
    String? vessel,
    String? portCode,
    String? portCountryName,
    String? portCountryCode,
    double? totalAmount,
    double? totalAmountBaseCurrency,
    double? totalAmountReportingCurrency,
    double? headerDiscount,
    String? createdUserEmail,
    String? vesselIMO,
    String? vesselCode,
    String? priorityCode,
    String? deliveryTermsCode,
    String? reqCategoryCode,
    String? currencyCode,
    String? vendorEmail,
    String? vendorShortName,
    String? shipServQuoteId,
    int? siteId,
    int? vendorID,
    String? supplierZipCode,
    int? referenceTypeID,
    int? referenceID,
    int? referenceSubID,
    int? requisitionCategoryId,
    String? buyerName,
    int? revisionNo,
    String? recSparesToBring,
    String? serviceDescription,
    String? roleCode,
    int? portID,
    int? deliveryToID,
  }) {
    return GoodsReceiptPoHeaderListApiEntity(
      poCode: poCode ?? this.poCode,
      poHdId: poHdId ?? this.poHdId,
      requisitionCategory: requisitionCategory ?? this.requisitionCategory,
      vendorName: vendorName ?? this.vendorName,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      vendorDeliveryDate: vendorDeliveryDate ?? this.vendorDeliveryDate,
      vendorReference: vendorReference ?? this.vendorReference,
      budgetDate: budgetDate ?? this.budgetDate,
      entity: entity ?? this.entity,
      currency: currency ?? this.currency,
      payment: payment ?? this.payment,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      remarksToVendor: remarksToVendor ?? this.remarksToVendor,
      paymentDueAfterDays: paymentDueAfterDays ?? this.paymentDueAfterDays,
      createdBy: createdBy ?? this.createdBy,
      postInvoicePO: postInvoicePO ?? this.postInvoicePO,
      exportControl: exportControl ?? this.exportControl,
      exportControlBlock: exportControlBlock ?? this.exportControlBlock,
      remarksFromVendor: remarksFromVendor ?? this.remarksFromVendor,
      deliveryTo: deliveryTo ?? this.deliveryTo,
      placeOfProcurement: placeOfProcurement ?? this.placeOfProcurement,
      leadDays: leadDays ?? this.leadDays,
      deliveryTerms: deliveryTerms ?? this.deliveryTerms,
      deliveryPort: deliveryPort ?? this.deliveryPort,
      wareHouseName: wareHouseName ?? this.wareHouseName,
      poCreatedOn: poCreatedOn ?? this.poCreatedOn,
      vessel: vessel ?? this.vessel,
      portCode: portCode ?? this.portCode,
      portCountryName: portCountryName ?? this.portCountryName,
      portCountryCode: portCountryCode ?? this.portCountryCode,
      totalAmount: totalAmount ?? this.totalAmount,
      totalAmountBaseCurrency:
          totalAmountBaseCurrency ?? this.totalAmountBaseCurrency,
      totalAmountReportingCurrency:
          totalAmountReportingCurrency ?? this.totalAmountReportingCurrency,
      headerDiscount: headerDiscount ?? this.headerDiscount,
      createdUserEmail: createdUserEmail ?? this.createdUserEmail,
      vesselIMO: vesselIMO ?? this.vesselIMO,
      vesselCode: vesselCode ?? this.vesselCode,
      priorityCode: priorityCode ?? this.priorityCode,
      deliveryTermsCode: deliveryTermsCode ?? this.deliveryTermsCode,
      reqCategoryCode: reqCategoryCode ?? this.reqCategoryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      vendorEmail: vendorEmail ?? this.vendorEmail,
      vendorShortName: vendorShortName ?? this.vendorShortName,
      shipServQuoteId: shipServQuoteId ?? this.shipServQuoteId,
      siteId: siteId ?? this.siteId,
      vendorID: vendorID ?? this.vendorID,
      supplierZipCode: supplierZipCode ?? this.supplierZipCode,
      referenceTypeID: referenceTypeID ?? this.referenceTypeID,
      referenceID: referenceID ?? this.referenceID,
      referenceSubID: referenceSubID ?? this.referenceSubID,
      requisitionCategoryId:
          requisitionCategoryId ?? this.requisitionCategoryId,
      buyerName: buyerName ?? this.buyerName,
      revisionNo: revisionNo ?? this.revisionNo,
      recSparesToBring: recSparesToBring ?? this.recSparesToBring,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      roleCode: roleCode ?? this.roleCode,
      portID: portID ?? this.portID,
      deliveryToID: deliveryToID ?? this.deliveryToID,
    );
  }
}
