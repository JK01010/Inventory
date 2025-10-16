import 'package:fpdart/fpdart.dart';

import '../../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../../purchase_order/domain/entity/purchase_order_filter_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class GoodsReceiptGetAllPoLineItemsDataUseCase {
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  call({PurchaseOrderFilterEntity? filter});
}

class GoodsReceiptGetAllPoLineItemsDataUseCaseImpl
    implements GoodsReceiptGetAllPoLineItemsDataUseCase {
  GoodsReceiptGetAllPoLineItemsDataUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  call({PurchaseOrderFilterEntity? filter}) {
    return goodsReceiptsRepository.goodsReceiptGetAllPoLineItemsData();
  }
}
