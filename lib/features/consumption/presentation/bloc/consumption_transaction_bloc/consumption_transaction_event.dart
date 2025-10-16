import 'package:equatable/equatable.dart';

class ConsumptionTransactionEvent extends Equatable {
  const ConsumptionTransactionEvent();

  @override
  List<Object?> get props => [];
}

class ConsumptionTransactionInsertDataEvent extends ConsumptionTransactionEvent {}

class ConsumptionTransactionFetchDataEvent extends ConsumptionTransactionEvent {}

class ConsumptionTransactionFilterEvent extends ConsumptionTransactionEvent {
  const ConsumptionTransactionFilterEvent(this.itemName, this.articleNo);

  final String itemName;
  final String articleNo;
}

class ConsumptionTransactionSearchEvent extends ConsumptionTransactionEvent {

  const ConsumptionTransactionSearchEvent({required this.searchText,required this.isSearch});

  final String searchText;
  final bool isSearch;
}
