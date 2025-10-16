import 'package:equatable/equatable.dart';

class StockUpdateViewEntityModel {
  StockUpdateViewEntityModel({required this.stockUpdateView});

  final List<StockUpdateViewEntity> stockUpdateView;
}

class StockUpdateViewEntity extends Equatable {
  const StockUpdateViewEntity({
    required this.itemName,
    required this.quantity,
    required this.articleNumber,
    required this.remarks,
    required this.defaultStorageLocation,
    required this.syncStatus

  });

  final String itemName;
  final String quantity;
  final String articleNumber;
  final String remarks;
  final String defaultStorageLocation;
  final String syncStatus ;

  @override
  List<Object?> get props => [
    itemName,
    quantity,
    articleNumber,
    defaultStorageLocation,
    remarks,
    syncStatus,
  ];

  @override
  bool get stringify => true;
}