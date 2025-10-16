import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../../../transaction/domain/entity/transaction_entity.dart';

class TransactionItemDetailPageParams {
  TransactionItemDetailPageParams({
    required this.transactionEntity,
    required this.itemEntity,
  });

  final TransactionEntity transactionEntity;
  final ItemEntity itemEntity;
}
