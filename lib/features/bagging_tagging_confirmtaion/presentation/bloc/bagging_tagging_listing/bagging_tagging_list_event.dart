part of 'bagging_tagging_list_bloc.dart';

sealed class BaggingTaggingListEvent extends Equatable {
  const BaggingTaggingListEvent();

  @override
  List<Object> get props => [];
}
class BaggingTaggingListInsertDataEvent extends BaggingTaggingListEvent{}
class BaggingTaggingListGetAllDataEvent extends BaggingTaggingListEvent{}