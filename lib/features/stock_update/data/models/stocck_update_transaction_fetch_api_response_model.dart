import 'package:equatable/equatable.dart';

import '../../../common_feature/data/model/fetch_imdg_class_model.dart';


class StockUpdateTransactionFetchApiResponseModel extends Equatable {
  const StockUpdateTransactionFetchApiResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory StockUpdateTransactionFetchApiResponseModel.fromJson(Map<String, dynamic> map) {
    return StockUpdateTransactionFetchApiResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<StockUpdateTrnFetchApiModel>.from(
        (map['reportData'] as List).map(
              (x) => StockUpdateTrnFetchApiModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<StockUpdateTrnFetchApiModel>? reportData;
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

class StockUpdateTrnFetchApiModel extends Equatable {
  const StockUpdateTrnFetchApiModel({
    required this.transactionDtId,
    required this.itemId,
    required this.quantity,
    required this.storageLocationId,
    required this.remarks,
    required this.modifiedOn,
    required this.syncStatus,
    required this.syncMerge,
    required this.transactionId,
    required this.locationId,
    required this.equipmentId,
    required this.totalRob,
    this.newStock,
    this.reconditionStock
  });

  /// fromMap
  factory StockUpdateTrnFetchApiModel.fromMap(Map<String, dynamic> map) {
    return StockUpdateTrnFetchApiModel(
      transactionDtId: map['transactionDtId'] as int? ?? 0,
      itemId: map['itemId'] as int? ?? 0,
      quantity: map['quantity'] as double? ?? 0,
      storageLocationId: map['storageLocationId'] as int? ?? 0,
      remarks: map['remarks'] as String? ?? '',
      modifiedOn: map['modifiedOn'] as String? ?? '',
      syncStatus: map['syncStatus'] as String? ?? '',
      syncMerge: map['syncMerge'] as String? ?? '',
      transactionId: map['transactionId'] as int? ?? 0,
      locationId: map['locationId'] as int? ?? 0,
      equipmentId: map['equipmentId'] as int? ?? 0,
      totalRob: map['totalRob'] as int? ?? 0,
      newStock: map['newStock'] as double? ?? 0,
      reconditionStock: map['reconditionStock'] as double? ?? 0,
    );
  }

  /// Factory to create model from JSON map
  factory StockUpdateTrnFetchApiModel.fromJson(Map<String, dynamic> map) {
    return StockUpdateTrnFetchApiModel(
      transactionDtId: map['TransactionDTID'] as int? ?? 0,
      itemId: map['ItemID'] as int? ?? 0,
      quantity: map['Quantity'] as double? ?? 0,
      storageLocationId: map['CurrentLocationID'] as int? ?? 0,
      remarks: map['Remarks'] as String? ?? '',
      modifiedOn: map['ModifiedOn'] as String? ?? '',
      syncStatus: map['SyncStatus'] as String? ?? '',
      syncMerge: map['SyncMerge'] as String? ?? '',
      transactionId: map['TransactionHdID'] as int? ?? 0,
      locationId: map['LocationID'] as int? ?? 0,
      equipmentId: map['EquipmentID'] as int? ?? 0,
      totalRob: map['TotalROB'] as int? ?? 0,
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'TransactionDTID': transactionDtId,
      'ItemID': itemId,
      'Quantity': quantity,
      'CurrentLocationID': storageLocationId,
      'Remarks': remarks,
      'ModifiedOn': modifiedOn,
      'SyncStatus': syncStatus,
      'SyncMerge': syncMerge,
      'TransactionHdID': transactionId,
      'LocationID': locationId,
      'EquipmentID': equipmentId,
      'TotalROB': totalRob,
    };
  }

  /// Fields
  final int transactionDtId;
  final int itemId;
  final double quantity;
  final int storageLocationId;
  final String remarks;
  final String modifiedOn;
  final String syncStatus;
  final String syncMerge;
  final int transactionId;

  final int locationId;
  final int equipmentId;
  final int totalRob;
  final double? newStock;
  final double? reconditionStock;


  @override
  List<Object?> get props => [
    transactionDtId,
    itemId,
    quantity,
    storageLocationId,
    remarks,
    modifiedOn,
    syncStatus,
    syncMerge,
    transactionId,
    locationId,
    equipmentId,
    totalRob,
  ];

  @override
  bool? get stringify => true;
}

