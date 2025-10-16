part of 'transaction_search_bloc.dart';

sealed class TransactionSearchState extends Equatable {
  const TransactionSearchState();

  @override
  List<Object> get props => [];
}

final class TransactionSearchInitial extends TransactionSearchState {}

final class TransactionSearchLoading extends TransactionSearchState {}

final class TransactionSearchLoaded extends TransactionSearchState {
  const TransactionSearchLoaded({required this.transactionList});

  final List<TransactionEntity> transactionList;
  @override
  List<Object> get props => [transactionList];
}

final class TransactionSearchError extends TransactionSearchState {
  const TransactionSearchError({required this.transactionFailures});

  final TransactionFailures transactionFailures;
  @override
  List<Object> get props => [transactionFailures];
}
