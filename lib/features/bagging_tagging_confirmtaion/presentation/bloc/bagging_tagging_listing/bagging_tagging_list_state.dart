part of 'bagging_tagging_list_bloc.dart';


class BaggingTaggingListState extends Equatable {
  const BaggingTaggingListState({
    required this.baggingTaggingList,
    required this.isLoading,
    required this.failureOption,
  });

  factory BaggingTaggingListState.initial() => BaggingTaggingListState(
    baggingTaggingList: [],
    isLoading: false,
    failureOption: none(),
  );

  final List<BaggingTaggingPendingEntity> baggingTaggingList;
  final bool isLoading;
  final Option<BaggingAndTaggingFailures> failureOption;

  @override
  List<Object> get props => [
    baggingTaggingList,
    isLoading,
    failureOption,
  ];

  BaggingTaggingListState copyWith({
    List<BaggingTaggingPendingEntity>? baggingTaggingList,
    bool? isLoading,
    Option<BaggingAndTaggingFailures>? failureOption,
  }) {
    return BaggingTaggingListState(
      baggingTaggingList: baggingTaggingList ?? this.baggingTaggingList,
      isLoading: isLoading ?? this.isLoading,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}




