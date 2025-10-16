part of 'bagging_confirmation_search_bloc.dart';

sealed class BaggingConfirmationSearchState extends Equatable {
  const BaggingConfirmationSearchState();

  @override
  List<Object> get props => [];
}

final class BaggingTaggingConfirmationPoSearchInitial
    extends BaggingConfirmationSearchState {}

final class BaggingTaggingConfirmationPoSearchLoading
    extends BaggingConfirmationSearchState {}

final class BaggingTaggingConfirmationPoSearchLoaded
    extends BaggingConfirmationSearchState {
  const BaggingTaggingConfirmationPoSearchLoaded({
    required this.baggingConfirmationPoList,
    required this.searchKeyword,
  });

  final List<BaggingConfirmationListEntity> baggingConfirmationPoList;
  final String searchKeyword;

  @override
  List<Object> get props => [baggingConfirmationPoList, searchKeyword];
}

final class BaggingTaggingConfirmationPoSearchError
    extends BaggingConfirmationSearchState {
  const BaggingTaggingConfirmationPoSearchError({
    required this.baggingAndTaggingFailures,
  });

  final BaggingAndTaggingFailures baggingAndTaggingFailures;

  @override
  List<Object> get props => [baggingAndTaggingFailures];
}

///test

// class BaggingConfirmationSearchState extends Equatable{
//   const BaggingConfirmationSearchState({
//     required this.isLoading,
//     required this.baggingAndTaggingFailures,
//     required this.baggingConfirmationPoList
//   });
//
//   factory BaggingConfirmationSearchState.initial() => BaggingConfirmationSearchState(
//     isLoading: false,
//     baggingConfirmationPoList: [],
//       baggingAndTaggingFailures: none(),
//   );
//
//   final bool isLoading;
//   final List<BaggingConfirmationListEntity> baggingConfirmationPoList;
//   final Option<BaggingAndTaggingFailures> baggingAndTaggingFailures;
//
//   @override
//   List<Object?> get props =>[
//     baggingConfirmationPoList,
//     isLoading,
//     baggingAndTaggingFailures,
//   ];
//
//   BaggingConfirmationSearchState copyWith({
//     List<BaggingConfirmationListEntity>? baggingConfirmationPoList,
//     bool? isLoading,
//     Option<BaggingAndTaggingFailures>? baggingAndTaggingFailures
//   }) {
//     return BaggingConfirmationSearchState(
//         isLoading: isLoading ?? this.isLoading,
//         baggingAndTaggingFailures:
//         baggingAndTaggingFailures ?? this.baggingAndTaggingFailures,
//         baggingConfirmationPoList: baggingConfirmationPoList ?? this.baggingConfirmationPoList
//     );
//   }
// }
