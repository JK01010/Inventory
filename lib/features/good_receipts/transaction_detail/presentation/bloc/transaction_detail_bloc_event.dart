import 'package:equatable/equatable.dart';

import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../../../transaction/domain/entity/transaction_entity.dart';

sealed class TransactionDetailBlocEvent extends Equatable {
  const TransactionDetailBlocEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionItemsEvent extends TransactionDetailBlocEvent {
  const GetTransactionItemsEvent({required this.transactionEntity});

  final TransactionEntity transactionEntity;
}
