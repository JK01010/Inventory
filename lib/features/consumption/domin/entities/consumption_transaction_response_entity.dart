// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_enum.dart';

class ConsumptionTransactionResponse {
  ConsumptionTransactionResponse({required this.consumptionTransactionEntity});

  final List<ConsumptionTransactionEntity> consumptionTransactionEntity;
}

class ConsumptionTransactionEntity extends Equatable {
  const ConsumptionTransactionEntity({
    required this.conTransactionItem,
    required this.consumedQty,
    required this.articleNumber,
    required this.storageLocation,
    required this.remarks,
    required this.isSync,
  });

  final String conTransactionItem;
  final String consumedQty;
  final String articleNumber;
  final String storageLocation;
  final String remarks;
  final String isSync;


  @override
  List<Object?> get props => [
    conTransactionItem,
    consumedQty,
    articleNumber,
    storageLocation,
    remarks,
    isSync
  ];

  @override
  bool get stringify => true;
}
