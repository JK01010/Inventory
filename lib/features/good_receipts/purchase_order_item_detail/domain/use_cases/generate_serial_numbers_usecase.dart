import 'package:fpdart/fpdart.dart';
import '../entity/serial_number_entity.dart';
import '../failures/purchase_order_item_details_failures.dart';
import '../repository/purchase_order_item_detail_repository.dart';

abstract interface class GenerateSerialNumbersUseCase {
  Future<Either<PurchaseOrderItemDetailsFailures, List<SerialNumberEntity>>>
  call({required GenerateSerialNumberParams generateSerialNumberParams});
}

class GenerateSerialNumbersUseCaseImpl implements GenerateSerialNumbersUseCase {
  GenerateSerialNumbersUseCaseImpl({
    required this.purchaseOrderItemDetailRepository,
  });

  final PurchaseOrderItemDetailRepository purchaseOrderItemDetailRepository;

  @override
  Future<Either<PurchaseOrderItemDetailsFailures, List<SerialNumberEntity>>>
  call({required GenerateSerialNumberParams generateSerialNumberParams}) async {
    return purchaseOrderItemDetailRepository.generateSerialNumbers(
      generateSerialNumberParams: generateSerialNumberParams,
    );
  }
}

class GenerateSerialNumberParams {
  GenerateSerialNumberParams({
    required this.quantity,
    required this.id,
    required this.itemId,
    required this.isTransaction,
    required this.typeId,
    required this.splitLocationId,
  });

  final double quantity;
  final int id; // poHdId or grnId
  final int itemId; // poDtId or grnDtId
  final bool isTransaction;
  final int typeId; // Damaged(1), New(2), Reconditioned(3)
  final int splitLocationId;
}
