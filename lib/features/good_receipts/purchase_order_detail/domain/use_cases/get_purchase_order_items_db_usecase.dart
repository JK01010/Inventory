import 'package:fpdart/fpdart.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../failures/purchase_order_details_failures.dart';
import '../repository/purchase_order_detail_repository.dart';

abstract interface class GetPurchaseOrderItemsListDbUseCase {
  Future<Either<PurchaseOrderDetailsFailures, List<ItemEntity>>> call({
    required GetPurchaseOrderItemsDbParams params,
  });
}

class GetPurchaseOrderItemsListDbUseCaseImpl
    implements GetPurchaseOrderItemsListDbUseCase {
  GetPurchaseOrderItemsListDbUseCaseImpl({
    required PurchaseOrderDetailRepository purchaseOrderDetailRepository,
  }) : _purchaseOrderDetailRepository = purchaseOrderDetailRepository;

  final PurchaseOrderDetailRepository _purchaseOrderDetailRepository;

  @override
  Future<Either<PurchaseOrderDetailsFailures, List<ItemEntity>>> call({
    required GetPurchaseOrderItemsDbParams params,
  }) async {
    return _purchaseOrderDetailRepository.getPurchaseOrderItemsFromDb(
      params: params,
    );
  }
}

class GetPurchaseOrderItemsDbParams {
  GetPurchaseOrderItemsDbParams({required this.poHdId});

  final int poHdId;
}
