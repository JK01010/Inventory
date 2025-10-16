import 'package:equatable/equatable.dart';

class StockUpdateResponse {
  StockUpdateResponse({required this.stockUpdate});

  final List<StockUpdateEntity> stockUpdate;
}

class StockUpdateEntity extends Equatable {
  const StockUpdateEntity({
    required this.id,
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
    required this.adjNewStock,
    required this.adjReconditionedStock,
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
  final int locationId;
  final int equipmentId;
  final int totalRob;
  final double adjNewStock;
  final double adjReconditionedStock;

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
    locationId,
    equipmentId,
    totalRob,
    adjNewStock,
    adjReconditionedStock,
  ];

  @override
  bool get stringify => true;
}