import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../entities/split_location_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetSplitLocationByPurchaseItemDetailUseCase {
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>>
  getSplitLocationByPurchaseItemDetail(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  );
}

class GetSplitLocationByPurchaseItemDetailUseCaseImpl
    implements GetSplitLocationByPurchaseItemDetailUseCase {
  GetSplitLocationByPurchaseItemDetailUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>>
  getSplitLocationByPurchaseItemDetail(
    GoodsReceiptPurchaseOrderLineItemEntity
    goodsReceiptPurchaseOrderLineItemEntity,
  ) {
    return goodsReceiptsRepository.getSplitLocationByPurchaseItemDetail(
      goodsReceiptPurchaseOrderLineItemEntity,
    );
  }
}
