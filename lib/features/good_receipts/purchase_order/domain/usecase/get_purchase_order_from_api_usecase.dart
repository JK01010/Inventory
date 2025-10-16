import 'package:fpdart/fpdart.dart';

import '../failures/purchase_order_failures.dart';
import '../repository/purchase_order_repository.dart';

abstract interface class GetPurchaseOrderFromApiUsecase {
  Future<Either<PurchaseOrderFailures, Unit>> call();
}

class GetPurchaseOrderFromApiUsecaseImpl
    implements GetPurchaseOrderFromApiUsecase {
  GetPurchaseOrderFromApiUsecaseImpl({required this.purchaseOrderRepository});

  final PurchaseOrderRepository purchaseOrderRepository;
  @override
  Future<Either<PurchaseOrderFailures, Unit>> call() {
    return purchaseOrderRepository.getPurchaseOrderFromApi();
  }
}
