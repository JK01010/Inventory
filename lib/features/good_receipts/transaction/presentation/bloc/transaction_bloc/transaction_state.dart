part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  const TransactionState({
    required this.transactionEntityList,
    required this.isLoading,
  });

  factory TransactionState.initial() {
    return TransactionState(transactionEntityList: [], isLoading: false);
  }

  final List<TransactionEntity> transactionEntityList;
  final bool isLoading;

  @override
  List<Object> get props => [transactionEntityList, isLoading];

  TransactionState copyWith({
    List<TransactionEntity>? transactionEntityList,
    bool? isLoading,
    bool? isSelectionModeEnabled,
  }) {
    return TransactionState(
      transactionEntityList:
          transactionEntityList ?? this.transactionEntityList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
