part of 'consumption_item_update_bloc.dart';

class ConsumptionItemUpdateEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

//insert
class EquipmentListInsertDataEvent extends ConsumptionItemUpdateEvent {}

//get
class EquipmentListGetAllDataEvent extends ConsumptionItemUpdateEvent {}
class LocationListGetAllDataEvent extends ConsumptionItemUpdateEvent {}

class SelectedEquipmentFromListEvent extends ConsumptionItemUpdateEvent {
  SelectedEquipmentFromListEvent({required this.selectedItemIndex});
  final int selectedItemIndex;
}

class SelectedLocationFromListEvent extends ConsumptionItemUpdateEvent {
  SelectedLocationFromListEvent({required this.selectedItemIndex});
  final int selectedItemIndex;
}

//Equipment

class EquipmentListSearchEvent extends ConsumptionItemUpdateEvent {
  EquipmentListSearchEvent({required this.searchText});

  final String searchText;
}

class LocationListSearchEvent extends ConsumptionItemUpdateEvent {
  LocationListSearchEvent({required this.searchText});

  final String searchText;
}



class EquipmentSelectedEvent extends ConsumptionItemUpdateEvent {
  EquipmentSelectedEvent({required this.currentItem});

  final EquipmentListEntity currentItem;
}

class LocationSelectedEvent extends ConsumptionItemUpdateEvent {
  LocationSelectedEvent({required this.currentItem});

  final ConsumptionLocationEntity currentItem;
}

//save functionality
class ReadPreviousPageDataEvent extends ConsumptionItemUpdateEvent {
  ReadPreviousPageDataEvent({required this.selectedItemsList});

  final List<ConsumptionRfidListingViewEntity> selectedItemsList;
}

class SaveTransactionListEvent extends ConsumptionItemUpdateEvent {}

class UpdateItemValue extends ConsumptionItemUpdateEvent {
  UpdateItemValue({
    required this.index,
    required this.newValue,
    required this.isForRemarks,
    required this.rob,
    required this.newStockRob,
    required this.storageLocationId,
    required this.reconditionStock
  });

  final int index;
  final String newValue;
  final bool isForRemarks;

  final int rob;
  final int storageLocationId;
  final String newStockRob;
  final String reconditionStock;
}

class ConsumedQtyCheckWithRobEvent extends ConsumptionItemUpdateEvent {
  ConsumedQtyCheckWithRobEvent({
    required this.rob,
    required this.consumedQty,
    required this.storageLocationId,
  });

  final int rob;
  final int storageLocationId;
  final String consumedQty;
}

class ResetStateEvent extends ConsumptionItemUpdateEvent {}

class EquipmentDataResetEvent extends ConsumptionItemUpdateEvent {}

class LocationDataResetEvent extends ConsumptionItemUpdateEvent {}


class LocationOrEquipmentCheckEvent extends ConsumptionItemUpdateEvent {
  LocationOrEquipmentCheckEvent({
    required this.isLocation,
    required this.isEquipment,
    required this.index,
  });

  final bool isLocation;
  final bool isEquipment;
  final int index;
}

class ConsumptionListSearchEvent extends ConsumptionItemUpdateEvent {

  ConsumptionListSearchEvent({required this.searchText,required this.isSearch});

  final String searchText;
  final bool isSearch;
}
