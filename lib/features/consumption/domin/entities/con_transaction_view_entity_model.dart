import 'package:equatable/equatable.dart';

class ConTransactionViewEntityModel {
  ConTransactionViewEntityModel({required this.conTransactionViewEntityModel});

  final List<ConTransactionViewEntity> conTransactionViewEntityModel;
}

class ConTransactionViewEntity extends Equatable {
  const ConTransactionViewEntity({
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