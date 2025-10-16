import 'package:equatable/equatable.dart';

import '../../../common_feature/data/model/fetch_imdg_class_model.dart';


class ConsumptionTransactionFetchApiResponseModel extends Equatable {
  const ConsumptionTransactionFetchApiResponseModel({
    required this.moduleCode,
    required this.entityName,
    required this.recordCount,
    required this.reportData,
    required this.entityValidation,
  });

  factory ConsumptionTransactionFetchApiResponseModel.fromJson(Map<String, dynamic> map) {
    return ConsumptionTransactionFetchApiResponseModel(
      moduleCode: map['moduleCode'] ?? '',
      entityName: map['entityName'] ?? '',
      recordCount: map['recordCount'] ?? 0,
      reportData: List<ConsumptionTrnFetchApiModel>.from(
        (map['reportData'] as List).map(
              (x) => ConsumptionTrnFetchApiModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      entityValidation: EntityValidation.fromMap(map['entityValidation']),
    );
  }

  final String moduleCode;
  final String entityName;
  final int recordCount;
  final List<ConsumptionTrnFetchApiModel>? reportData;
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

class ConsumptionTrnFetchApiModel extends Equatable {
  const ConsumptionTrnFetchApiModel({
    required this.transactionDtId,
    required this.itemId,
    required this.quantity,
    required this.storageLocationId,
    required this.remarks,
    required this.modifiedOn,
    required this.syncStatus,
    required this.syncMerge,
    required this.transactionId,
    required this.tags,
    required this.locationId,
    required this.equipmentId,
    required this.totalRob,
    required this.totalNewStock,
    required this.totalReconditionStock,
    required this.currentRob,
    required this.newStock,
    required this.reconditionStock,

  });

  /// Factory to create model from JSON map
  factory ConsumptionTrnFetchApiModel.fromJson(Map<String, dynamic> map) {
    return ConsumptionTrnFetchApiModel(
      transactionDtId: map['TransactionDTID'] as int? ?? 0,
      itemId: map['ItemID'] as int? ?? 0,
      quantity: map['Quantity'] as double? ?? 0,
      storageLocationId: map['CurrentLocationID'] as int? ?? 0,
      remarks: map['Remarks'] as String? ?? '',
      modifiedOn: map['ModifiedOn'] as String? ?? '',
      syncStatus: map['SyncStatus'] as String? ?? '',
      syncMerge: map['SyncMerge'] as String? ?? '',
      transactionId: map['TransactionHdID'] as int? ?? 0,
      tags: map['Tags'] as String? ?? '',
      locationId: map['LocationID'] as int? ?? 0,
      equipmentId: map['EquipmentID'] as int? ?? 0,
      totalRob: map['totalRob'] as int? ?? 0,
      totalNewStock: map['totalNewStock'] as int? ?? 0,
      totalReconditionStock: map['totalReconditionStock'] as int? ?? 0,
      currentRob: map['currentRob'] as int? ?? 0,
      newStock: map['newStock'] as int? ?? 0,
      reconditionStock: map['reconditionStock'] as int? ?? 0,

    );
  }

  /// fromMap
  factory ConsumptionTrnFetchApiModel.fromMap(Map<String, dynamic> map) {
    return ConsumptionTrnFetchApiModel(
      transactionDtId: map['transactionDtId'] as int? ?? 0,
      itemId: map['itemId'] as int? ?? 0,
      quantity: map['quantity'] as double? ?? 0,
      storageLocationId: map['storageLocationId'] as int? ?? 0,
      remarks: map['remarks'] as String? ?? '',
      modifiedOn: map['modifiedOn'] as String? ?? '',
      syncStatus: map['syncStatus'] as String? ?? '',
      syncMerge: map['syncMerge'] as String? ?? '',
      transactionId: map['transactionId'] as int? ?? 0,
      tags: map['tags'] as String? ?? '',
      locationId: map['locationId'] as int? ?? 0,
      equipmentId: map['equipmentId'] as int? ?? 0,
      totalRob: map['totalRob'] as int? ?? 0,
      totalNewStock: map['totalNewStock'] as int? ?? 0,
      totalReconditionStock: map['totalReconditionStock'] as int? ?? 0,
      currentRob: map['currentRob'] as int? ?? 0,
      newStock: map['newStock'] as int? ?? 0,
      reconditionStock: map['reconditionStock'] as int? ?? 0,
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
      'Tags': tags,
      'LocationID': locationId,
      'EquipmentID': equipmentId,
      'totalRob': totalRob,
      'totalNewStock': totalNewStock,
      'totalReconditionStock': totalReconditionStock,
      'currentRob': currentRob,
      'newStock': newStock,
      'reconditionStock': reconditionStock
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
  final String tags;
  final int locationId;
  final int equipmentId;
  final int totalRob;
  final int totalNewStock;
  final int totalReconditionStock;
  final int currentRob;
  final int newStock;
  final int reconditionStock;

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
    tags,
    locationId,
    equipmentId,
    totalRob,
    totalNewStock,
    totalReconditionStock,
    currentRob,
    newStock,
    reconditionStock
  ];

  @override
  bool? get stringify => true;
}

