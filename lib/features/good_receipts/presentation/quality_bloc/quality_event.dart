part of 'quality_bloc.dart';

sealed class QualityEvent extends Equatable {
  const QualityEvent();

  @override
  List<Object> get props => [];
}

class FetchAllQualityListEvent extends QualityEvent {}
