import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetAllItemListToCreateNewLabelUseCase {
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  getAllGoodsReceiptDetailLabelItemsToCreateNewLabel(int poId);
}

class GetAllItemListToCreateNewLabelUseCaseImpl
    implements GetAllItemListToCreateNewLabelUseCase {
  GetAllItemListToCreateNewLabelUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  getAllGoodsReceiptDetailLabelItemsToCreateNewLabel(int poId) {
    return goodsReceiptsRepository.getAllGRLabelItemsToCreateNewLabel(
      poId: poId,
    );
  }
}
