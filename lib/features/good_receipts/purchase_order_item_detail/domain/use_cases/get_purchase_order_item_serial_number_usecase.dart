import 'package:fpdart/fpdart.dart';
import '../entity/serial_number_entity.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../repository/purchase_order_item_detail_repository.dart';

abstract interface class GetPurchaseOrderItemSerialNumberUseCase {
  Future<Either<PurchaseOrderItemDetailsFailures, List<SerialNumberEntity>>>
  call({
    required GetPurchaseOrderItemSerialNumberParams
    getPurchaseOrderItemSerialNumberParams,
  });
}

class GetPurchaseOrderItemSerialNumberUseCaseImpl
    implements GetPurchaseOrderItemSerialNumberUseCase {
  GetPurchaseOrderItemSerialNumberUseCaseImpl({
    required this.purchaseOrderItemDetailRepository,
  });

  final PurchaseOrderItemDetailRepository purchaseOrderItemDetailRepository;

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<SerialNumberEntity>>>
  call({
    required GetPurchaseOrderItemSerialNumberParams
    getPurchaseOrderItemSerialNumberParams,
  }) async {
    return purchaseOrderItemDetailRepository
        .getPurchaseOrderItemSerialNumberUseCase(
          getPurchaseOrderItemSerialNumberParams:
              getPurchaseOrderItemSerialNumberParams,
        );
  }
}

class GetPurchaseOrderItemSerialNumberParams {
  GetPurchaseOrderItemSerialNumberParams({
    required this.poHdId,
    required this.poDtId,
  });

  final int poHdId;
  final int poDtId;
}
