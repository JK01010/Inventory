import 'package:fpdart/fpdart.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../repository/purchase_order_item_detail_repository.dart';

abstract interface class GetImdgClassUseCase {
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> call();
}

class GetImdgClassUseCaseImpl implements GetImdgClassUseCase {
  GetImdgClassUseCaseImpl({required this.purchaseOrderItemDetailRepository});

  final PurchaseOrderItemDetailRepository purchaseOrderItemDetailRepository;

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> call() async {
    return purchaseOrderItemDetailRepository.getImdgClass();
  }
}
