import 'package:fpdart/fpdart.dart';

import '../entity/purchase_order_entity.dart';
import '../entity/purchase_order_filter_entity.dart';
import '../failures/purchase_order_failures.dart';

abstract class PurchaseOrderRepository {
  Future<Either<PurchaseOrderFailures, Unit>> getPurchaseOrderFromApi();
  Future<Either<PurchaseOrderFailures, List<PurchaseOrderEntity>>>
  getPurchaseOrderFromDb({
    PurchaseOrderFilterEntity? purchaseOrderFilterEntity,
  });
}
