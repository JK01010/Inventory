import 'package:fpdart/fpdart.dart';

import '../failures/purchase_order_details_failures.dart';
import '../repository/purchase_order_detail_repository.dart';

abstract interface class GetPurchaseOrderAttachmentFromApiUsecase {
  Future<Either<PurchaseOrderDetailsFailures, Unit>> call();
}

class GetPurchaseOrderAttachmentFromApiUsecaseImpl
    implements GetPurchaseOrderAttachmentFromApiUsecase {
  GetPurchaseOrderAttachmentFromApiUsecaseImpl({
    required this.purchaseOrderDetailRepository,
  });

  final PurchaseOrderDetailRepository purchaseOrderDetailRepository;
  @override
  Future<Either<PurchaseOrderDetailsFailures, Unit>> call() async {
    return purchaseOrderDetailRepository.getPurchaseOrderAttachmentFromApi();
  }
}
