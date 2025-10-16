import 'package:equatable/equatable.dart';

class ConsumptionTransactionResponse {
  ConsumptionTransactionResponse({required this.consumptionTransaction});

  final List<ConsumptionTransactionEntityModel> consumptionTransaction;
}

class ConsumptionTransactionEntityModel extends Equatable {
  const ConsumptionTransactionEntityModel({
    required this.id,
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
    required this.reconditionStock
  });

  final String id;
  final int itemId;
  final int quantity;
  final int storageLocationId;
  final String remarks;
  final String modifiedOn;
  final String syncStatus;
  final String syncMerge;
  final String transactionId;
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
    id,
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
    newStock,
    reconditionStock,
    currentRob,
    totalNewStock,
    totalReconditionStock
  ];

  @override
  bool get stringify => true;
}