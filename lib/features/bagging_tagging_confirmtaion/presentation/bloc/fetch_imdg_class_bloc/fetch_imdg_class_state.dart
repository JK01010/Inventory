part of 'fetch_imdg_class_bloc.dart';

class FetchImdgClassState extends Equatable {
  const FetchImdgClassState({
    required this.fetchImdgClassList,
    required this.isLoading,
    required this.failureOption,
  });

  factory FetchImdgClassState.initial() => FetchImdgClassState(
    fetchImdgClassList: [],
    isLoading: false,
    failureOption: none(),
  );

  final List<ImdgClassEntity> fetchImdgClassList;
  final bool isLoading;
  final Option<ItemMasterFailures> failureOption;

  @override
  List<Object> get props => [
    fetchImdgClassList,
    isLoading,
    failureOption,
  ];

  FetchImdgClassState copyWith({
    List<ImdgClassEntity>? fetchImdgClassList,
    bool? isLoading,
    Option<ItemMasterFailures>? failureOption,
  }) {
    return FetchImdgClassState(
      fetchImdgClassList: fetchImdgClassList ?? this.fetchImdgClassList,
      isLoading: isLoading ?? this.isLoading,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}