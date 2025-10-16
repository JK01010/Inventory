part of 'bagging_tagging_confirmation_bloc.dart';

sealed class BaggingTaggingConfirmationEvent extends Equatable {
  const BaggingTaggingConfirmationEvent();

  @override
  List<Object> get props => [];
}

class FetchAllConfirmationTransactionFromDb extends BaggingTaggingConfirmationEvent {
  const FetchAllConfirmationTransactionFromDb({this.transactionFilterEntity});

  final TransactionFilterEntity? transactionFilterEntity;
}
