part of 'consumption_add_page_bloc.dart';

class ConsumptionAddPageEvent extends Equatable{

  @override
  List<Object?> get props => [];
}


class FetchItemMasterByStorageIdEvent extends ConsumptionAddPageEvent {
  FetchItemMasterByStorageIdEvent({required this.storageLocationId});

  final int storageLocationId;
}

class IsChooseItemSelectedEvent extends ConsumptionAddPageEvent {
  IsChooseItemSelectedEvent({
    required this.index,
    required this.isSelectedValue,
    required this.isClosed,
  });

  final int index;
  final bool isSelectedValue;
  final bool isClosed;
}

class ChooseItemListSearchEvent extends ConsumptionAddPageEvent {
  ChooseItemListSearchEvent({required this.searchText});

  final String searchText;
}

class SaveItemDetailsEvent extends ConsumptionAddPageEvent {
  SaveItemDetailsEvent({required this.isSaveAddNew});

  final bool isSaveAddNew;
}

class ValidationCheckEvent extends ConsumptionAddPageEvent {
  ValidationCheckEvent({
    required this.fieldName,
    required this.isEnabled,
    required this.onChangeValue,
  });

  final String fieldName;
  final String onChangeValue;
  final bool isEnabled;
}

class ClearButtonEvent extends ConsumptionAddPageEvent {}

class UpdateSplitLocationEntityWithSelectedLocationConsumptionEvent extends ConsumptionAddPageEvent {
  UpdateSplitLocationEntityWithSelectedLocationConsumptionEvent(/*this.splitLocationEntity,*/this.selectedCode,this.selectedId);

  String selectedCode;
  int selectedId;
}
