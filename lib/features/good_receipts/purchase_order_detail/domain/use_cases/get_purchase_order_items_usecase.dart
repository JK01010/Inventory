import 'package:fpdart/fpdart.dart';
import '../failures/purchase_order_details_failures.dart';
import '../repository/purchase_order_detail_repository.dart';

abstract interface class GetPurchaseOrderItemsListUseCase {
  Future<Either<PurchaseOrderDetailsFailures, Unit>> call();
}

class GetPurchaseOrderItemsListUseCaseImpl
    implements GetPurchaseOrderItemsListUseCase {
  GetPurchaseOrderItemsListUseCaseImpl({
    required PurchaseOrderDetailRepository purchaseOrderDetailRepository,
  }) : _purchaseOrderDetailRepository = purchaseOrderDetailRepository;

  final PurchaseOrderDetailRepository _purchaseOrderDetailRepository;

  @override
  Future<Either<PurchaseOrderDetailsFailures, Unit>> call() async {
    return _purchaseOrderDetailRepository.getPurchaseOrderItems();
  }
}
