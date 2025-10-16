part of 'bagging_pending_search_bloc.dart';

sealed class BaggingPendingSearchState extends Equatable {
  const BaggingPendingSearchState();

  @override
  List<Object> get props => [];
}

final class BaggingTaggingPendingPoSearchInitial
    extends BaggingPendingSearchState {}

final class BaggingTaggingPendingPoSearchLoading
    extends BaggingPendingSearchState {}

final class BaggingTaggingPendingPoSearchLoaded
    extends BaggingPendingSearchState {
  const BaggingTaggingPendingPoSearchLoaded({
    required this.baggingPendingPoList,
    required this.searchKeyword,
  });

  final List<BaggingTaggingPendingEntity> baggingPendingPoList;
  final String searchKeyword;

  @override
  List<Object> get props => [baggingPendingPoList,searchKeyword];
}

final class BaggingTaggingPendingPoSearchError
    extends BaggingPendingSearchState {
  const BaggingTaggingPendingPoSearchError({
    required this.baggingAndTaggingFailures,
  });

  final BaggingAndTaggingFailures baggingAndTaggingFailures;

  @override
  List<Object> get props => [baggingAndTaggingFailures];
}
