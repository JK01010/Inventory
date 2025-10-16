import 'package:equatable/equatable.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../../purchase_order_item_detail/domain/entity/serial_number_entity.dart';
import '../../../transaction/domain/entity/transaction_entity.dart';

class TransactionItemDetailBlocState extends Equatable {
  const TransactionItemDetailBlocState({
    required this.isLoading,
    required this.transactionEntity,
    required this.itemEntity,
    required this.splitLocationEntity,
    required this.serialNumbers,
    required this.isGeneratingSerialNumbers,
  });

  factory TransactionItemDetailBlocState.initial() {
    return TransactionItemDetailBlocState(
      isLoading: true,
      transactionEntity: TransactionEntity.initial(),
      itemEntity: ItemEntity.initial(),
      splitLocationEntity: [],
      serialNumbers: [],
      isGeneratingSerialNumbers: false,
    );
  }

  final bool isLoading;
  final TransactionEntity transactionEntity;
  final ItemEntity itemEntity;
  final List<SplitLocationEntity> splitLocationEntity;
  final List<SerialNumberEntity> serialNumbers;
  final bool isGeneratingSerialNumbers;

  @override
  List<Object?> get props => [isLoading, transactionEntity, itemEntity];

  TransactionItemDetailBlocState copyWith({
    bool? isLoading,
    TransactionEntity? transactionEntity,
    ItemEntity? itemEntity,
    List<SplitLocationEntity>? splitLocationEntity,
    List<SerialNumberEntity>? serialNumbers,
    bool? isGeneratingSerialNumbers,
  }) {
    return TransactionItemDetailBlocState(
      isLoading: isLoading ?? this.isLoading,
      transactionEntity: transactionEntity ?? this.transactionEntity,
      itemEntity: itemEntity ?? this.itemEntity,
      splitLocationEntity: splitLocationEntity ?? this.splitLocationEntity,
      serialNumbers: serialNumbers ?? this.serialNumbers,
      isGeneratingSerialNumbers:
          isGeneratingSerialNumbers ?? this.isGeneratingSerialNumbers,
    );
  }
}
