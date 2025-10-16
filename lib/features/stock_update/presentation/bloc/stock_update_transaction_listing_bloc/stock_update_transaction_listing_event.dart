part of 'stock_update_transaction_listing_bloc.dart';

class StockUpdateTransactionListingEvent extends Equatable {

  const StockUpdateTransactionListingEvent();

  @override
  List<Object?> get props => [];
}

class StockUpdateTransactionListingInsertEvent
    extends StockUpdateTransactionListingEvent {}

class StockUpdateTransactionListingFetchViewEvent
    extends StockUpdateTransactionListingEvent {}

class StockUpdateFilterFetchDataEvent
    extends StockUpdateTransactionListingEvent {
  const StockUpdateFilterFetchDataEvent({
    required this.itemName,
    required this.articleNo,
  });

  final String itemName;
  final String articleNo;
}

class StockUpdateSearchEvent extends StockUpdateTransactionListingEvent {
  const StockUpdateSearchEvent({
    required this.searchText,
    required this.isSearch,
  });

  final String searchText;
  final bool isSearch;
}
