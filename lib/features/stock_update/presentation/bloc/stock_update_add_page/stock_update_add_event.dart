part of 'stock_update_add_bloc.dart';

class StockUpdateAddEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchItemMasterByStorageIdEvent extends StockUpdateAddEvent {
  FetchItemMasterByStorageIdEvent({required this.storageLocationId});

  final int storageLocationId;
}

class IsChooseItemSelectedEvent extends StockUpdateAddEvent {
  IsChooseItemSelectedEvent({
    required this.index,
    required this.isSelectedValue,
    required this.isClosed,
  });

  final int index;
  final bool isSelectedValue;
  final bool isClosed;
}

class ChooseItemListSearchEvent extends StockUpdateAddEvent {
  ChooseItemListSearchEvent({required this.searchText});

  final String searchText;
}

class SaveItemDetailsEvent extends StockUpdateAddEvent {
  SaveItemDetailsEvent({required this.isSaveAddNew});

  final bool isSaveAddNew;
}

class ValidationCheckEvent extends StockUpdateAddEvent {
  ValidationCheckEvent({
    required this.fieldName,
    required this.isEnabled,
    required this.onChangeValue,
  });

  final String fieldName;
  final String onChangeValue;
  final bool isEnabled;
}

class ClearButtonEvent extends StockUpdateAddEvent {}

class UpdateSplitLocationEntityWithSelectedLocationStockUpdateEvent extends StockUpdateAddEvent {
  UpdateSplitLocationEntityWithSelectedLocationStockUpdateEvent(this.selectedCode,this.selectedId);

  String selectedCode;
  int selectedId;
}
