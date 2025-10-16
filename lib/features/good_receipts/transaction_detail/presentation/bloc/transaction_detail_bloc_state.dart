import 'package:equatable/equatable.dart';

import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../../../transaction/domain/entity/transaction_entity.dart';

class TransactionDetailBlocState extends Equatable {
  const TransactionDetailBlocState({
    required this.isLoading,
    required this.transactionItems,
    required this.transactionEntity,
  });

  factory TransactionDetailBlocState.initial() {
    return TransactionDetailBlocState(
      isLoading: true,
      transactionItems: [],
      transactionEntity: TransactionEntity.initial(),
    );
  }

  final bool isLoading;
  final List<ItemEntity> transactionItems;
  final TransactionEntity transactionEntity;

  @override
  List<Object?> get props => [isLoading, transactionItems, transactionEntity];

  TransactionDetailBlocState copyWith({
    bool? isLoading,
    List<ItemEntity>? transactionItems,
    TransactionEntity? transactionEntity,
  }) {
    return TransactionDetailBlocState(
      isLoading: isLoading ?? this.isLoading,
      transactionItems: transactionItems ?? this.transactionItems,
      transactionEntity: transactionEntity ?? this.transactionEntity,
    );
  }
}
