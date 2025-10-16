part of 'fetch_imdg_class_bloc.dart';

sealed class FetchImdgClassEvent extends Equatable {
  const FetchImdgClassEvent();

  @override
  List<Object> get props => [];
}
class ImdgClassEventInsertDataEvent extends FetchImdgClassEvent{}
class ImdgClassEventGetAllDataEvent extends FetchImdgClassEvent{}