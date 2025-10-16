part of 'bagging_confirmation_list_bloc.dart';

sealed class BaggingConfirmationListEvent extends Equatable {
  const BaggingConfirmationListEvent();

  @override
  List<Object> get props => [];
}

//insert
class BaggingConfirmationListInsertDataEvent
    extends BaggingConfirmationListEvent {}

//get
class BaggingConfirmationListGetAllDataEvent extends BaggingConfirmationListEvent{}
class BaggingConfirmationListStorageLocationEvent extends BaggingConfirmationListEvent{
  const BaggingConfirmationListStorageLocationEvent({required this.selectedGrnId});
  final int selectedGrnId;

}

// checkbox
class IsCheckBoxSelectedEvent extends BaggingConfirmationListEvent {
  IsCheckBoxSelectedEvent({required this.index, required this.isSelectedValue});

  final int index;
  final bool isSelectedValue;
}

class IsAllItemsSelectEvent extends BaggingConfirmationListEvent {
  const IsAllItemsSelectEvent({required this.isSelected});

  final bool isSelected;
}

class KdcReaderUpdateRangeEvent extends BaggingConfirmationListEvent {
  const KdcReaderUpdateRangeEvent({required this.range});

  final int range;
}

class KdcReaderDisposeEvent extends BaggingConfirmationListEvent {}

class KdcReaderInitEvent extends BaggingConfirmationListEvent {}

class KdcReaderStartScanEvent extends BaggingConfirmationListEvent {}

class KdcReaderStopScanEvent extends BaggingConfirmationListEvent {}

class BaggingConfirmationListResetEvent extends BaggingConfirmationListEvent{}

class FetchConfirmationListByItemIdsEvent extends BaggingConfirmationListEvent {
  const FetchConfirmationListByItemIdsEvent({required this.itemIds, required this.storageLocationId, required this.grnId});

  final List<int> itemIds;
  final int grnId;
  final int storageLocationId;
}

class FetchConfirmationListByGRNIdEvent extends BaggingConfirmationListEvent {
  const FetchConfirmationListByGRNIdEvent({required this.grnId});

  final String grnId;
}

class SaveConfirmationEvent extends BaggingConfirmationListEvent {
  const SaveConfirmationEvent({required this.grnId});

  final int grnId;
}
