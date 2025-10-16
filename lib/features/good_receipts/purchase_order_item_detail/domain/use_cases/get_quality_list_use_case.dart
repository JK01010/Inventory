import 'package:fpdart/fpdart.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../repository/purchase_order_item_detail_repository.dart';

abstract interface class GetQualityListUseCase {
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> call();
}

class GetQualityListUseCaseImpl implements GetQualityListUseCase {
  GetQualityListUseCaseImpl({required this.purchaseOrderItemDetailRepository});

  final PurchaseOrderItemDetailRepository purchaseOrderItemDetailRepository;

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> call() {
    return purchaseOrderItemDetailRepository.getQualityList();
  }
}
