import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';

class PurchaseOrderItemDetailPageParams {
  PurchaseOrderItemDetailPageParams({
    required this.purchaseOrderEntity,
    required this.itemEntity,
  });

  final PurchaseOrderEntity purchaseOrderEntity;
  final ItemEntity itemEntity;
}
