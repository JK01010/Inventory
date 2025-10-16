import 'package:fpdart/fpdart.dart';
import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../repository/purchase_order_item_detail_repository.dart';

abstract interface class UpdatePurchaseOrderItemDataUseCase {
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> call({
    required UpdatePurchaseOrderItemDataParams
    updatePurchaseOrderItemDataParams,
  });
}

class UpdatePurchaseOrderItemDataUseCaseImpl
    implements UpdatePurchaseOrderItemDataUseCase {
  UpdatePurchaseOrderItemDataUseCaseImpl({
    required this.purchaseOrderItemDetailRepository,
  });

  final PurchaseOrderItemDetailRepository purchaseOrderItemDetailRepository;

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, Unit>> call({
    required UpdatePurchaseOrderItemDataParams
    updatePurchaseOrderItemDataParams,
  }) async {
    return purchaseOrderItemDetailRepository.updatePurchaseOrderItemData(
      updatePurchaseOrderItemDataParams: updatePurchaseOrderItemDataParams,
    );
  }
}

class UpdatePurchaseOrderItemDataParams {
  UpdatePurchaseOrderItemDataParams({
    required this.itemEntity,
    required this.purchaseOrderEntity,
    required this.splitLocationData,
  });

  final ItemEntity itemEntity;
  final PurchaseOrderEntity purchaseOrderEntity;
  final List<SplitLocationEntity> splitLocationData;
}
