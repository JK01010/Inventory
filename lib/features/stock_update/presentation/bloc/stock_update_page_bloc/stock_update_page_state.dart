part of 'stock_update_page_bloc.dart';

class StockUpdatePageState extends Equatable {
  const StockUpdatePageState({
    required this.selectedRfidItemList,
    required this.selectedMainList,
    required this.stockUpdateFailures,
    required this.showErrorConsumedQty,
    required this.isSaveCompleted,
  });

  factory StockUpdatePageState.initial() {
    return StockUpdatePageState(
      selectedRfidItemList: [],
      selectedMainList: [],
      stockUpdateFailures: none(),
      showErrorConsumedQty: false,
      isSaveCompleted: false,
    );
  }

  final List<StockUpdateRfidListingViewEntity> selectedRfidItemList;
  final List<StockUpdateRfidListingViewEntity> selectedMainList;
  final Option<ItemMasterFailures> stockUpdateFailures;

  final bool showErrorConsumedQty;
  final bool isSaveCompleted;

  @override
  List<Object?> get props => [
    selectedRfidItemList,
    selectedMainList,
    stockUpdateFailures,
    showErrorConsumedQty,
    isSaveCompleted,
  ];

  @override
  bool get stringify => true;

  StockUpdatePageState copyWith({
    List<StockUpdateRfidListingViewEntity>? selectedRfidItemList,
    List<StockUpdateRfidListingViewEntity>? selectedMainList,
    Option<ItemMasterFailures>? stockUpdateFailures,
    bool? showErrorConsumedQty,
    bool? isSaveCompleted,
  }) {
    return StockUpdatePageState(
      selectedRfidItemList: selectedRfidItemList ?? this.selectedRfidItemList,
      selectedMainList: selectedMainList ?? this.selectedMainList,
      stockUpdateFailures: stockUpdateFailures ?? this.stockUpdateFailures,
      showErrorConsumedQty: showErrorConsumedQty ?? this.showErrorConsumedQty,
      isSaveCompleted: isSaveCompleted ?? this.isSaveCompleted,
    );
  }
}
