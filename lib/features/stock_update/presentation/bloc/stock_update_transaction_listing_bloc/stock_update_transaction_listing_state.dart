part of 'stock_update_transaction_listing_bloc.dart';

class StockUpdateTransactionListingState extends Equatable {
  const StockUpdateTransactionListingState({
    required this.isLoading,
    required this.isFilterActive,
    required this.stockUpdateViewList,
    required this.stockUpdateSearchList,
    required this.stockUpdateFailures,
  });

  factory StockUpdateTransactionListingState.initialSetup() =>
      StockUpdateTransactionListingState(
        isLoading: false,
        isFilterActive: false,
        stockUpdateViewList: [],
        stockUpdateSearchList: [],
        stockUpdateFailures: none(),
      );

  final bool isLoading;
  final bool isFilterActive;
  final List<StockUpdateViewEntity> stockUpdateViewList;
  final List<StockUpdateViewEntity> stockUpdateSearchList;
  final Option<StockUpdateFailures> stockUpdateFailures;
  @override
  List<Object?> get props => [
        isLoading,
        isFilterActive,
        stockUpdateViewList,
        stockUpdateSearchList,
        stockUpdateFailures,
      ];

  StockUpdateTransactionListingState copyWith({
    bool? isLoading,
    bool? isFilterActive,
    List<StockUpdateViewEntity>? stockUpdateViewList,
    List<StockUpdateViewEntity>? stockUpdateSearchList,
    Option<StockUpdateFailures>? stockUpdateFailures
  }) {
    return StockUpdateTransactionListingState(
      isLoading: isLoading ?? this.isLoading,
      isFilterActive: isFilterActive ?? this.isFilterActive,
      stockUpdateViewList: stockUpdateViewList ?? this.stockUpdateViewList,
      stockUpdateSearchList: stockUpdateSearchList ?? this.stockUpdateSearchList,
      stockUpdateFailures: stockUpdateFailures ?? this.stockUpdateFailures
    );
  }
}
