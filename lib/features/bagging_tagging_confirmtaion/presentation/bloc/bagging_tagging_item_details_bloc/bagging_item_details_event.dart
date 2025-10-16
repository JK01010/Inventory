part of 'bagging_item_details_bloc.dart';

sealed class BaggingItemDetailsEvent extends Equatable {
  const BaggingItemDetailsEvent();

  @override
  List<Object> get props => [];
}

//insert all
class BaggingItemDetailsInsertDataEvent extends BaggingItemDetailsEvent {}

//get all
class BaggingItemDetailsGetAllDataEvent extends BaggingItemDetailsEvent {
  BaggingItemDetailsGetAllDataEvent({
    required this.grnId,
    required this.grnDtId,
  });

  final int grnId;
  final int grnDtId;
}
