part of 'stock_location_bloc.dart';

sealed class StockLocationEvent extends Equatable {
  const StockLocationEvent();

  @override
  List<Object> get props => [];
}

class UpdateStockLocationByItemIdEvent extends StockLocationEvent {
  UpdateStockLocationByItemIdEvent(this.itemId);

  int itemId;
}
