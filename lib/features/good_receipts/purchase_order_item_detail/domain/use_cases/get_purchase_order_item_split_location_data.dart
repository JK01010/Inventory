import 'package:fpdart/fpdart.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../repository/purchase_order_item_detail_repository.dart';

abstract interface class GetPurchaseOrderItemSplitLocationDataUseCase {
  Future<Either<PurchaseOrderItemDetailsFailures, List<SplitLocationEntity>>>
  call({
    required GetPurchaseOrderItemSplitLocationDataParams
    getPurchaseOrderItemSplitLocationDataParams,
  });
}

class GetPurchaseOrderItemSplitLocationDataUseCaseImpl
    implements GetPurchaseOrderItemSplitLocationDataUseCase {
  GetPurchaseOrderItemSplitLocationDataUseCaseImpl({
    required this.purchaseOrderItemDetailRepository,
  });

  final PurchaseOrderItemDetailRepository purchaseOrderItemDetailRepository;

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<SplitLocationEntity>>>
  call({
    required GetPurchaseOrderItemSplitLocationDataParams
    getPurchaseOrderItemSplitLocationDataParams,
  }) {
    return purchaseOrderItemDetailRepository
        .getPurchaseOrderItemSplitLocationData(
          getPendingPoSplitLocationDataParams:
              getPurchaseOrderItemSplitLocationDataParams,
        );
  }
}

class GetPurchaseOrderItemSplitLocationDataParams {
  GetPurchaseOrderItemSplitLocationDataParams({
    required this.poHdId,
    required this.poDtId,
  });

  final int poHdId;
  final int poDtId;
}
