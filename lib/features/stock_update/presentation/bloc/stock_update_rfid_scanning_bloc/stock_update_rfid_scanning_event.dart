part of 'stock_update_rfid_scanning_bloc.dart';

class StockUpdateRfidScanningEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


//checkbox selection events
class SelectAllScannedItemsEvent extends StockUpdateRfidScanningEvent {}

class FetchRfidScanningListEvent extends StockUpdateRfidScanningEvent {}

class IsSelectedEvent extends StockUpdateRfidScanningEvent {
  IsSelectedEvent({
    required this.index,
    required this.isSelectedValue,
    required this.completeSelect,
  });

  final int index;
  final bool isSelectedValue;
  final bool completeSelect;
}

class CompleteDataSelectEvent extends StockUpdateRfidScanningEvent {}

class StockUpdateListingSearchEvent extends StockUpdateRfidScanningEvent {

 StockUpdateListingSearchEvent({required this.searchText,required this.isSearch});

  final String searchText;
  final bool isSearch;
}


//scanning events
class StartScanningEvent extends StockUpdateRfidScanningEvent{}
class StopScanningEvent extends StockUpdateRfidScanningEvent{}
class InitialScanningEvent extends StockUpdateRfidScanningEvent{}
class DisposeScanningEvent extends StockUpdateRfidScanningEvent{}
class UpdateRangeEvent extends StockUpdateRfidScanningEvent{
   UpdateRangeEvent({required this.range});
  final double range;
}