part of 'consumption_transaction_bloc.dart';

class ConsumptionTransactionState extends Equatable {
  const ConsumptionTransactionState({
    required this.itemName,//filter
    required this.articleNumber,//filter
    required this.isLoading,
    required this.transactionList,
    required this.consumptionFailures,
    required this.isFilterActive,
    required this.searchTransactionList,
  });

  factory ConsumptionTransactionState.initial() {
    return ConsumptionTransactionState(
      itemName: "",//filter
      articleNumber: "",//filter
      isLoading: true,
      transactionList: [],
      consumptionFailures: none(),
      searchTransactionList: [],
      isFilterActive:false,
    );
  }

  final String itemName;//filter
  final String articleNumber;//filter
  final bool isLoading;
  final bool isFilterActive;
  final List<ConTransactionViewEntity> transactionList;
  final List<ConTransactionViewEntity> searchTransactionList;
  final Option<ConsumptionFailures> consumptionFailures;

  @override
  List<Object?> get props => [itemName,articleNumber,isLoading,isFilterActive, transactionList, searchTransactionList, consumptionFailures];

  @override
  bool get stringify => true;

  ConsumptionTransactionState copyWith({
    String? itemName,
    String? articleNumber,
    bool? isLoading,
    bool? isFilterActive,
    List<ConTransactionViewEntity>? transactionList,
    List<ConTransactionViewEntity>? searchTransactionList,
    Option<ConsumptionFailures>? consumptionFailures,
  }) {
    return ConsumptionTransactionState(
      itemName: itemName ?? this.itemName,
      articleNumber: articleNumber ?? this.articleNumber,
      isLoading: isLoading ?? this.isLoading,
      isFilterActive: isFilterActive ?? this.isFilterActive,
      transactionList: transactionList ?? this.transactionList,
      searchTransactionList: searchTransactionList ?? this.searchTransactionList,
      consumptionFailures: consumptionFailures ?? this.consumptionFailures,
    );
  }
}
