part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}


class GetAllTransactionFromDb extends TransactionEvent {
  const GetAllTransactionFromDb({this.transactionFilterEntity});

  final TransactionFilterEntity? transactionFilterEntity;
}
