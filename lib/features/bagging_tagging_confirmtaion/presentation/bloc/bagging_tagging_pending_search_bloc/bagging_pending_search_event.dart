part of 'bagging_pending_search_bloc.dart';


sealed class BaggingPendingSearchEvent extends Equatable {
  const BaggingPendingSearchEvent();

  @override
  List<Object> get props => [];
}

class BaggingTaggingPendingNoChangedEvent
    extends BaggingPendingSearchEvent {
  const BaggingTaggingPendingNoChangedEvent({required this.query});
  final String query;
  @override
  List<Object> get props => [query];
}