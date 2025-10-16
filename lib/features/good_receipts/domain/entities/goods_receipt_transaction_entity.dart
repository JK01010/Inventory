// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class GoodsReceiptsTransactionEntity extends Equatable {
  GoodsReceiptsTransactionEntity({
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
    required this.isConfirmed,
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
  double receivedQty = 0;
  double damagedQty = 0;
  double newStock = 0;
  final String deliveryReference;
  final bool isBaggingTaggingApplicable;
  final bool isConfirmed;

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
    //not required
    syncStatus,
    receivedQty,
    damagedQty,
    newStock,
    //not required
    deliveryReference,
    isBaggingTaggingApplicable,
    isConfirmed,
  ];

  factory GoodsReceiptsTransactionEntity.initial() {
    return GoodsReceiptsTransactionEntity(
      grnId: 0,
      receiptNo: '',
      receiptDate: '',
      poNo: '',
      poId: 0,
      insights: '',
      reqCategoryID: 0,
      category: '',
      priorityID: 0,
      priority: '',
      vendorID: 0,
      vendorName: '',
      delivryDate: '',
      deliveryToID: 0,
      dlvryTO: '',
      pOtitle: '',
      totalNOofprudcts: 0,
      plannedNoOfPdcts: 0,
      entityID: 0,
      entity: '',
      remarksForVendor: '',
      pocost: 0.0,
      weight: 0.0,
      actualvolume: 0.0,
      currencyName: '',
      noOfPackets: 0,
      presentProperties: '',
      deliveryToLocationID: 0,
      deliveryToLocation: '',
      totalAmountReportingCurrency: 0.0,
      poRemarks: '',
      isBaggingCompleted: false,
      modifiedOn: '',
      portID: 0,
      isFull: false,
      syncStatus: false,
      deliveryReference: '',
      isBaggingTaggingApplicable: false,
      isConfirmed: false,
    );
  }

}
