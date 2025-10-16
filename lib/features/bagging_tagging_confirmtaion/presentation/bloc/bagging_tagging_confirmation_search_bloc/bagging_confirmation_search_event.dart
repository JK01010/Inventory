part of 'bagging_confirmation_search_bloc.dart';


sealed class BaggingConfirmationSearchEvent extends Equatable {
  const BaggingConfirmationSearchEvent();

  @override
  List<Object> get props => [];
}

class BaggingTaggingConfirmationNoChangedEvent
    extends BaggingConfirmationSearchEvent {
  const BaggingTaggingConfirmationNoChangedEvent({required this.query});
  final String query;
  @override
  List<Object> get props => [query];
}