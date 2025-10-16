part of 'transaction_search_bloc.dart';

sealed class TransactionSearchEvent extends Equatable {
  const TransactionSearchEvent();

  @override
  List<Object> get props => [];
}

class TransactionOnChangedEvent extends TransactionSearchEvent {
  const TransactionOnChangedEvent({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}
