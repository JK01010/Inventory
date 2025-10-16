import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {

  factory TransactionEntity.initial() {
    return TransactionEntity(
      grnId: -1,
      receiptNo: "",
      receiptDate: "",
      poNo: '',
      poId: -1,
      insights: '',
      reqCategoryID: -1,
      category: '',
      priorityID: -1,
      priority: '',
      vendorID: -1,
      vendorName: '',
      delivryDate: '',
      deliveryToID: -1,
      dlvryTO: '',
      pOtitle: '',
      totalNOofprudcts: -1,
      plannedNoOfPdcts: -1,
      entityID: -1,
      entity: '',
      remarksForVendor: '',
      pocost: -1,
      weight: -1,
      actualvolume: -1,
      currencyName: '',
      noOfPackets: -1,
      presentProperties: '',
      deliveryToLocationID: -1,
      deliveryToLocation: '',
      totalAmountReportingCurrency: -1,
      poRemarks: '',
      isBaggingCompleted: false,
      modifiedOn: '',
      portID: -1,
      isFull: false,
      syncStatus: false,
      deliveryReference: '',
      isBaggingTaggingApplicable: false,
      workFlowId: -1,
      workFlowStatusId: -1,
      podtid: -1,
      isConfirmed: false,
      damagedQty: -1,
      newStock: -1,
      receivedQty: -1,
      items: -1,
    );
  }
  const TransactionEntity({
    required this.grnId,
    required this.receiptNo,
    required this.receiptDate,
    required this.poNo,
    required this.poId,
    required this.insights,
    required this.reqCategoryID,
    required this.category,
    required this.priorityID,
    required this.priority,
    required this.vendorID,
    required this.vendorName,
    required this.delivryDate,
    required this.deliveryToID,
    required this.dlvryTO,
    required this.pOtitle,
    required this.totalNOofprudcts,
    required this.plannedNoOfPdcts,
    required this.entityID,
    required this.entity,
    required this.remarksForVendor,
    required this.pocost,
    required this.weight,
    required this.actualvolume,
    required this.currencyName,
    required this.noOfPackets,
    required this.presentProperties,
    required this.deliveryToLocationID,
    required this.deliveryToLocation,
    required this.totalAmountReportingCurrency,
    required this.poRemarks,
    required this.isBaggingCompleted,
    required this.modifiedOn,
    required this.portID,
    required this.isFull,
    required this.syncStatus,
    required this.deliveryReference,
    required this.isBaggingTaggingApplicable,
    required this.workFlowId,
    required this.workFlowStatusId,
    required this.podtid,
    required this.isConfirmed,
    required this.damagedQty,
    required this.newStock,
    required this.receivedQty,
    required this.items,
  });

  final int grnId;
  final String receiptNo;
  final String receiptDate;
  final String poNo;
  final int poId;
  final String insights;
  final int reqCategoryID;
  final String category;
  final int priorityID;
  final String priority;
  final int vendorID;
  final String vendorName;
  final String delivryDate;
  final int deliveryToID;
  final String dlvryTO;
  final String pOtitle;
  final int totalNOofprudcts;
  final int plannedNoOfPdcts;
  final int entityID;
  final String entity;
  final String remarksForVendor;
  final double pocost;
  final double weight;
  final double actualvolume;
  final String currencyName;
  final int noOfPackets;
  final String presentProperties;
  final int deliveryToLocationID;
  final String deliveryToLocation;
  final double totalAmountReportingCurrency;
  final String poRemarks;
  final bool isBaggingCompleted;
  final String modifiedOn;
  final int portID;
  final bool isFull;
  final bool syncStatus;
  final String deliveryReference;
  final bool isBaggingTaggingApplicable;
  final int workFlowId;
  final int workFlowStatusId;
  final int podtid;
  final bool isConfirmed;
  final double receivedQty;
  final double damagedQty;
  final double newStock;
  final double items;

  @override
  List<Object> get props => [
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
    items,
  ];

  @override
  bool get stringify => true;
}
