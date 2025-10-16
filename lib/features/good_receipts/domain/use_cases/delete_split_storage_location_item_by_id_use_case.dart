import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../entities/split_location_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class DeleteSplitStorageLocationItemByIdUseCase {
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>> call(
    SplitLocationEntity splitLocationEntity,
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  );
}

class DeleteSplitStorageLocationItemByIdUseCaseImpl
    implements DeleteSplitStorageLocationItemByIdUseCase {
  DeleteSplitStorageLocationItemByIdUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>> call(
    SplitLocationEntity splitLocationEntity,
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) {
    return goodsReceiptsRepository.deleteSplitStorageLocationItemById(
      splitLocationEntity,
      goodsReceiptPurchaseOrderLineItemEntity,
    );
  }
}
