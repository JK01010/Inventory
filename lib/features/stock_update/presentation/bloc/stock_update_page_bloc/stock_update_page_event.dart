part of 'stock_update_page_bloc.dart';


class StockUpdatePageEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class ReadPreviousPageDataEvent extends StockUpdatePageEvent{
  ReadPreviousPageDataEvent({required this.selectedItemsList});
  final List<StockUpdateRfidListingViewEntity> selectedItemsList;
}

class SaveTransactionListEvent extends StockUpdatePageEvent {}

class UpdateItemValue extends StockUpdatePageEvent {

  UpdateItemValue({required this.index, required this.newValue, required this.isForRemarks,required this.rob, required this.consumedQty,required this.storageLocationId});

  final int index;
  final String newValue;
  final bool isForRemarks;

  final int rob;
  final int storageLocationId;
  final String consumedQty;
}

class ConsumedQtyCheckWithRobEvent extends StockUpdatePageEvent {

  ConsumedQtyCheckWithRobEvent({required this.rob, required this.consumedQty,required this.storageLocationId});

  final int rob;
  final int storageLocationId;
  final String consumedQty;
}

class ResetStateEvent extends StockUpdatePageEvent {}

class StockUpdateListSearchEvent extends StockUpdatePageEvent {

  StockUpdateListSearchEvent({required this.searchText,required this.isSearch});

  final String searchText;
  final bool isSearch;
}
