import 'package:fpdart/fpdart.dart';

import '../../../../common_feature/domain/entities/item_entity.dart';
import '../failures/purchase_order_details_failures.dart';
import '../use_cases/draft_purchase_order_usecase.dart';
import '../use_cases/get_purchase_order_items_db_usecase.dart';

abstract interface class PurchaseOrderDetailRepository {
  Future<Either<PurchaseOrderDetailsFailures, List<ItemEntity>>>
  getPurchaseOrderItemsFromDb({required GetPurchaseOrderItemsDbParams params});

  Future<Either<PurchaseOrderDetailsFailures, Unit>> getPurchaseOrderItems();

  Future<Either<PurchaseOrderDetailsFailures, Unit>>
  getPurchaseOrderAttachmentFromApi();

  Future<Either<PurchaseOrderDetailsFailures, Unit>> draftPurchaseOrder({
    required DraftPurchaseOrderParams params,
  });
}
