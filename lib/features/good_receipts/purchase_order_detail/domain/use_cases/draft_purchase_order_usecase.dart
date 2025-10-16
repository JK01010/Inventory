import 'package:fpdart/fpdart.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../failures/purchase_order_details_failures.dart';
import '../repository/purchase_order_detail_repository.dart';

abstract interface class DraftPurchaseOrderUseCase {
  Future<Either<PurchaseOrderDetailsFailures, Unit>> call({
    required DraftPurchaseOrderParams params,
  });
}

class DraftPurchaseOrderUseCaseImpl implements DraftPurchaseOrderUseCase {
  DraftPurchaseOrderUseCaseImpl({
    required PurchaseOrderDetailRepository purchaseOrderDetailRepository,
  }) : _purchaseOrderDetailRepository = purchaseOrderDetailRepository;

  final PurchaseOrderDetailRepository _purchaseOrderDetailRepository;

  @override
  Future<Either<PurchaseOrderDetailsFailures, Unit>> call({
    required DraftPurchaseOrderParams params,
  }) async {
    return _purchaseOrderDetailRepository.draftPurchaseOrder(params: params);
  }
}

class DraftPurchaseOrderParams {
  DraftPurchaseOrderParams({required this.purchaseOrderEntity});

  final PurchaseOrderEntity purchaseOrderEntity;
}
