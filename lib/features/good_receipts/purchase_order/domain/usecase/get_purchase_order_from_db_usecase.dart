import 'package:fpdart/fpdart.dart';

import '../entity/purchase_order_entity.dart';
import '../entity/purchase_order_filter_entity.dart';
import '../failures/purchase_order_failures.dart';
import '../repository/purchase_order_repository.dart';

abstract interface class GetPurchaseOrderFromDbUsecase {
  Future<Either<PurchaseOrderFailures, List<PurchaseOrderEntity>>> call({
    PurchaseOrderFilterEntity? purchaseOrderFilterEntity,
  });
}

class GetPurchaseOrderFromDbUsecaseImpl
    implements GetPurchaseOrderFromDbUsecase {
  GetPurchaseOrderFromDbUsecaseImpl({required this.purchaseOrderRepository});

  final PurchaseOrderRepository purchaseOrderRepository;
  @override
  Future<Either<PurchaseOrderFailures, List<PurchaseOrderEntity>>> call({
    PurchaseOrderFilterEntity? purchaseOrderFilterEntity,
  }) async {
    return purchaseOrderRepository.getPurchaseOrderFromDb(
      purchaseOrderFilterEntity: purchaseOrderFilterEntity,
    );
  }
}
