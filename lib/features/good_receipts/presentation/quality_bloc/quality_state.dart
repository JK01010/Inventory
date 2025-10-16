// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quality_bloc.dart';

class QualityState extends Equatable {
  const QualityState({
    required this.fetchQualityList,
    required this.failureOption,
    required this.isLoading,
  });

  factory QualityState.initial() => QualityState(
    fetchQualityList: [],
    isLoading: false,
    failureOption: none(),
  );

  final List<QualityEntity> fetchQualityList;
  final bool isLoading;
  final Option<CommonFailures> failureOption;

  @override
  List<Object?> get props => [fetchQualityList, failureOption, isLoading];

  QualityState copyWith({
    List<QualityEntity>? fetchQualityList,
    bool? isLoading,
    Option<CommonFailures>? failureOption,
  }) {
    return QualityState(
      fetchQualityList: fetchQualityList ?? this.fetchQualityList,
      isLoading: isLoading ?? this.isLoading,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}
