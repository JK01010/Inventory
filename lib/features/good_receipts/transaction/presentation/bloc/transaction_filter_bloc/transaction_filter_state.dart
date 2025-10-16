// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_filter_bloc.dart';

class TransactionFilterState extends Equatable {
  const TransactionFilterState({
    required this.transactionFilterEntity,
    required this.transactionList,
    required this.itemCategoryList,
    required this.tempCategoryList,
    required this.grnFilteredList,
    required this.portEntityList,
  });

  factory TransactionFilterState.initial() {
    return TransactionFilterState(
      transactionFilterEntity: TransactionFilterEntity(),
      transactionList: [],
      itemCategoryList: [],
      tempCategoryList: [],
      grnFilteredList: [],
      portEntityList: [],
    );
  }
  final TransactionFilterEntity transactionFilterEntity;
  final List<TransactionEntity> transactionList;
  final List<ItemCategoryEntity> itemCategoryList;
  final List<ItemCategoryEntity> tempCategoryList;
  final List<TransactionEntity> grnFilteredList;
  final List<PortEntity> portEntityList;

  @override
  List<Object?> get props => [
    transactionFilterEntity,
    transactionList,
    itemCategoryList,
    tempCategoryList,
    grnFilteredList,
    portEntityList,
  ];

  TransactionFilterState copyWith({
    TransactionFilterEntity? transactionFilterEntity,
    List<TransactionEntity>? transactionList,
    List<ItemCategoryEntity>? itemCategoryList,
    List<ItemCategoryEntity>? tempCategoryList,
    List<TransactionEntity>? grnFilteredList,
    List<PortEntity>? portEntityList,
  }) {
    return TransactionFilterState(
      transactionFilterEntity:
          transactionFilterEntity ?? this.transactionFilterEntity,
      transactionList: transactionList ?? this.transactionList,
      itemCategoryList: itemCategoryList ?? this.itemCategoryList,
      tempCategoryList: tempCategoryList ?? this.tempCategoryList,
      grnFilteredList: grnFilteredList ?? this.grnFilteredList,
      portEntityList: portEntityList ?? this.portEntityList,
    );
  }
}
