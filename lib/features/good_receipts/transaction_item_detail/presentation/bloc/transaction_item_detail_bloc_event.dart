import 'package:equatable/equatable.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../../transaction/domain/entity/transaction_entity.dart';

sealed class TransactionItemDetailBlocEvent extends Equatable {
  const TransactionItemDetailBlocEvent();

  @override
  List<Object> get props => [];
}

class SetTransactionItemDetailInitialDataEvent
    extends TransactionItemDetailBlocEvent {
  const SetTransactionItemDetailInitialDataEvent({
    required this.transactionEntity,
    required this.itemEntity,
  });

  final TransactionEntity transactionEntity;
  final ItemEntity itemEntity;
}

class GenerateSerialNumbersEvent extends TransactionItemDetailBlocEvent {
  const GenerateSerialNumbersEvent({
    required this.splitLocationEntity,
    required this.quantity,
  });

  final SplitLocationEntity splitLocationEntity;
  final double quantity;
}
