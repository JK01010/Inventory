// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PurchaseOrderHDResponse {
  PurchaseOrderHDResponse({required this.goodsReceiptHDEntity});

  final List<PurchaseOrderHDEntity> goodsReceiptHDEntity;
}

class PurchaseOrderHDEntity extends Equatable {
  PurchaseOrderHDEntity({
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
    this.qrCode,
    this.barCode,
    this.selectedLabelType,
    this.printingPosition,
    this.numberOfLabels,
  });

  String? poCode;
  int? poHdId;
  String? title;
  String? vendorDeliveryDate;
  String? remarksToVendor;
  int? requisitionCategoryId;
  String? reqCategoryCode;
  String? requisitionCategory;
  String? deliveryPort;
  String? portCode;
  String? vendorReference;

  int? grnId;
  String? receiptNo;
  String? receiptDate;
  String? poNo;
  int? poId;
  String? inSights;
  int? reqCategoryId;
  String? category;
  int? priorityId;
  String? priority;
  int? vendorId;
  String? vendorName;
  String? deliveryDate;
  int? deliveryToId;
  String? deliveryTo;
  String? poTitle;
  int? totalNoOfProducts;
  int? plannedNoOfProducts;
  int? entityId;
  String? entity;
  String? remarksForVendor;
  double? poCost;
  double? weight;
  double? actualVolume;
  String? currencyName;
  int? noOfPackets;
  String? presentProperties;
  int? deliveryToLocationId;
  String? deliveryToLocation;
  double? totalAmountReportingCurrency;
  String? poRemarks;
  bool? isBaggingCompleted;
  String? modifiedOn;
  int? portId;
  bool? isFull;
  bool? isLocked;
  bool? qrCode = false;
  bool? barCode = false;
  String? selectedLabelType = 'Select Type';
  String? printingPosition = '';
  int? numberOfLabels = 0;
  List<String> barCodeLabelTypeList = [
    '1.5in*3.5in',
    '1in*3in'
  ];

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
  ];

  @override
  bool? get stringify => true;

  PurchaseOrderHDEntity copyWith({
    String? poCode,

    int? grnId,
    String? receiptNo,
    String? receiptDate,
    String? poNo,
    int? poId,
    String? inSights,
    int? reqCategoryID,
    String? category,
    int? priorityId,
    String? priority,
    int? vendorID,
    String? vendorName,
    String? deliveryDate,
    int? deliveryToID,
    String? deliveryTo,
    String? poTitle,
    int? totalNoOfProducts,
    int? plannedNoOfProducts,
    int? entityID,
    String? entity,
    String? remarksForVendor,
    double? poCost,
    double? weight,
    double? actualVolume,
    String? currencyName,
    int? noOfPackets,
    String? presentProperties,
    int? deliveryToLocationID,
    String? deliveryToLocation,
    double? totalAmountReportingCurrency,
    String? poRemarks,
    bool? isBaggingCompleted,
    String? modifiedOn,
    int? portId,
    bool? isFull,
    bool? isLocked,
    bool? qrCode,
    bool? barCode,
    String? selectedLabelType,
    String? printingPosition,
    int? numberOfLabels,
  }) {
    return PurchaseOrderHDEntity(
      poCode: poCode ?? this.poCode,
      poHdId: poHdId ?? this.poHdId,
      title: title ?? this.title,
      vendorDeliveryDate: vendorDeliveryDate ?? this.vendorDeliveryDate,
      remarksToVendor: remarksForVendor ?? this.remarksToVendor,
      requisitionCategoryId:
          requisitionCategoryId ?? this.requisitionCategoryId,
      reqCategoryCode: reqCategoryCode ?? this.reqCategoryCode,
      requisitionCategory: requisitionCategory ?? this.requisitionCategory,
      deliveryPort: deliveryPort ?? this.deliveryPort,
      portCode: portCode ?? this.portCode,
      vendorReference: vendorReference ?? this.vendorReference,

      grnId: grnId ?? this.grnId,
      receiptNo: receiptNo ?? this.receiptNo,
      receiptDate: receiptDate ?? this.receiptDate,
      poNo: poNo ?? this.poNo,
      poId: poId ?? this.poId,
      inSights: inSights ?? this.inSights,
      reqCategoryId: reqCategoryID ?? this.reqCategoryId,
      category: category ?? this.category,
      priorityId: priorityId ?? this.priorityId,
      priority: priority ?? this.priority,
      vendorId: vendorID ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryToId: deliveryToID ?? this.deliveryToId,
      deliveryTo: deliveryTo ?? this.deliveryTo,
      poTitle: poTitle ?? this.poTitle,
      totalNoOfProducts: totalNoOfProducts ?? this.totalNoOfProducts,
      plannedNoOfProducts: plannedNoOfProducts ?? this.plannedNoOfProducts,
      entityId: entityID ?? this.entityId,
      entity: entity ?? this.entity,
      remarksForVendor: remarksForVendor ?? this.remarksForVendor,
      poCost: poCost ?? this.poCost,
      weight: weight ?? this.weight,
      actualVolume: actualVolume ?? this.actualVolume,
      currencyName: currencyName ?? this.currencyName,
      noOfPackets: noOfPackets ?? this.noOfPackets,
      presentProperties: presentProperties ?? this.presentProperties,
      deliveryToLocationId: deliveryToLocationId ?? this.deliveryToLocationId,
      deliveryToLocation: deliveryToLocation ?? this.deliveryToLocation,
      totalAmountReportingCurrency:
          totalAmountReportingCurrency ?? this.totalAmountReportingCurrency,
      poRemarks: poRemarks ?? this.poRemarks,
      isBaggingCompleted: isBaggingCompleted ?? this.isBaggingCompleted,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      portId: portId ?? this.portId,
      isFull: isFull ?? this.isFull,
      isLocked: isLocked ?? this.isLocked,
      qrCode: qrCode ?? this.qrCode,
      barCode: barCode ?? this.barCode,
      selectedLabelType: selectedLabelType ?? this.selectedLabelType,
      printingPosition: printingPosition ?? this.printingPosition,
      numberOfLabels: numberOfLabels ?? this.numberOfLabels,
    );
  }
}
