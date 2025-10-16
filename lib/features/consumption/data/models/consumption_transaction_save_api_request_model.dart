import 'package:equatable/equatable.dart';

class ConsumptionTransactionSaveRequestModel extends Equatable {
  const ConsumptionTransactionSaveRequestModel({
    this.grnID,
    required this.transactionType,
    required this.transactionTypeID,
    this.frequencyID,
    this.remarks,
    required this.fromLocationID,
    this.toLocationID,
    required this.vesselCode,
    required this.stockReqEntity,
  });

  factory ConsumptionTransactionSaveRequestModel.fromJson(Map<String, dynamic> map) {
    return ConsumptionTransactionSaveRequestModel(
      grnID: map['grnID'],
      transactionType: map['transactionType'] ?? '',
      transactionTypeID: map['transactionTypeID'] ?? 0,
      frequencyID: map['frequencyID'],
      remarks: map['remarks'],
      fromLocationID: map['fromLocationID'] ?? 0,
      toLocationID: map['toLocationID'],
      vesselCode: map['vesselCode'] ?? '',
      stockReqEntity: List<StockReqEntityModel>.from(
        (map['stockReqEntity'] as List).map(
              (x) => StockReqEntityModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  final int? grnID;
  final String transactionType;
  final int transactionTypeID;
  final int? frequencyID;
  final String? remarks;
  final int fromLocationID;
  final int? toLocationID;
  final String vesselCode;
  final List<StockReqEntityModel> stockReqEntity;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'grnID': grnID,
      'transactionType': transactionType,
      'transactionTypeID': transactionTypeID,
      'frequencyID': frequencyID,
      'remarks': remarks,
      'fromLocationID': fromLocationID,
      'toLocationID': toLocationID,
      'vesselCode': vesselCode,
      'stockReqEntity': stockReqEntity.map((x) => x.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    grnID,
    transactionType,
    transactionTypeID,
    frequencyID,
    remarks,
    fromLocationID,
    toLocationID,
    vesselCode,
    stockReqEntity,
  ];
}

class StockReqEntityModel extends Equatable {
  const StockReqEntityModel({
    this.stockID,
    required this.itemID,
    required this.itemLinkID,
    required this.storageLocationID,
    required this.referenceTypeID,
    required this.referenceID,
    required this.referenceSubID,
    this.expiryDate,
    required this.unitPrice,
    required this.totalNewStockRob,
    required this.totalRecondStockRob,
    required this.totalRob,
    required this.equipmentID,
    this.totalQuantity,
    this.remarks,
    required this.previousLocationID,
    required this.previousROB,
    required this.uomID,
    this.batchNo,
    required this.isIHM,
    required this.isNoStock,
    required this.storageLocationCode,
    required this.newStock,
    this.reconditionStock,
    this.damageStock,
    this.installationTypeID,
    this.installationRefID,
    required this.itemTransactionDate,
    required this.stockGrnList,
    required this.stockSerialList,
  });

  factory StockReqEntityModel.fromJson(Map<String, dynamic> map) {
    return StockReqEntityModel(
      stockID: map['stockID'],
      itemID: map['itemID'] ?? 0,
      itemLinkID: map['itemLinkID'] ?? 0,
      storageLocationID: map['storageLocationID'] ?? 0,
      referenceTypeID: map['referenceTypeID'] ?? 0,
      referenceID: map['referenceID'] ?? 0,
      referenceSubID: map['referenceSubID'] ?? 0,
      expiryDate: map['expiryDate'],
      unitPrice: (map['unitPrice'] as num?)?.toDouble() ?? 0.0,
      totalNewStockRob: map['totalNewStockRob'] ?? 0,
      totalRecondStockRob: map['totalRecondStockRob'] ?? 0,
      totalRob: map['totalRob'] ?? 0,
      equipmentID: map['equipmentID'] ?? 0,
      totalQuantity: (map['totalQuantity'] as num?)?.toDouble(),
      remarks: map['remarks'],
      previousLocationID: map['previousLocationID'] ?? 0,
      previousROB: map['previousROB'] ?? 0,
      uomID: map['uomID'] ?? 0,
      batchNo: map['batchNo'],
      isIHM: map['isIHM'] ?? false,
      isNoStock: map['isNoStock'] ?? false,
      storageLocationCode: map['storageLocationCode'] ?? '',
      newStock: map['newStock'] ?? 0,
      reconditionStock: map['reconditionStock'],
      damageStock: map['damageStock'],
      installationTypeID: map['installationTypeID'],
      installationRefID: map['installationRefID'],
      itemTransactionDate: map['itemTransactionDate'] ?? '',
      stockGrnList: List<dynamic>.from(map['stockGrnList'] ?? []),
      stockSerialList: List<dynamic>.from(map['stockSerialList'] ?? []),
    );
  }

  final int? stockID;
  final int itemID;
  final int itemLinkID;
  final int storageLocationID;
  final int referenceTypeID;
  final int referenceID;
  final int referenceSubID;
  final String? expiryDate;
  final double unitPrice;
  final int totalNewStockRob;
  final int totalRecondStockRob;
  final int totalRob;
  final int equipmentID;
  final double? totalQuantity;
  final String? remarks;
  final int previousLocationID;
  final int previousROB;
  final int uomID;
  final String? batchNo;
  final bool isIHM;
  final bool isNoStock;
  final String storageLocationCode;
  final int newStock;
  final int? reconditionStock;
  final int? damageStock;
  final int? installationTypeID;
  final int? installationRefID;
  final String itemTransactionDate;
  final List<dynamic> stockGrnList;
  final List<dynamic> stockSerialList;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'stockID': stockID,
      'itemID': itemID,
      'itemLinkID': itemLinkID,
      'storageLocationID': storageLocationID,
      'referenceTypeID': referenceTypeID,
      'referenceID': referenceID,
      'referenceSubID': referenceSubID,
      'expiryDate': expiryDate,
      'unitPrice': unitPrice,
      'totalNewStockRob': totalNewStockRob,
      'totalRecondStockRob': totalRecondStockRob,
      'totalRob': totalRob,
      'equipmentID': equipmentID,
      'totalQuantity': totalQuantity,
      'remarks': remarks,
      'previousLocationID': previousLocationID,
      'previousROB': previousROB,
      'uomID': uomID,
      'batchNo': batchNo,
      'isIHM': isIHM,
      'isNoStock': isNoStock,
      'storageLocationCode': storageLocationCode,
      'newStock': newStock,
      'reconditionStock': reconditionStock,
      'damageStock': damageStock,
      'installationTypeID': installationTypeID,
      'installationRefID': installationRefID,
      'itemTransactionDate': itemTransactionDate,
      'stockGrnList': stockGrnList,
      'stockSerialList': stockSerialList,
    };
  }

  @override
  List<Object?> get props => [
    stockID,
    itemID,
    itemLinkID,
    storageLocationID,
    referenceTypeID,
    referenceID,
    referenceSubID,
    expiryDate,
    unitPrice,
    totalNewStockRob,
    totalRecondStockRob,
    totalRob,
    equipmentID,
    totalQuantity,
    remarks,
    previousLocationID,
    previousROB,
    uomID,
    batchNo,
    isIHM,
    isNoStock,
    storageLocationCode,
    newStock,
    reconditionStock,
    damageStock,
    installationTypeID,
    installationRefID,
    itemTransactionDate,
    stockGrnList,
    stockSerialList,
  ];
}
