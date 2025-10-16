import 'package:fpdart/fpdart.dart';

import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class CreateNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase {
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  call(
    List<GoodsReceiptPurchaseOrderLineItemEntity>
    goodsReceiptPurchaseOrderLineItemEntityList,
    int poId,
  );
}

class CreateNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCaseImpl
    implements
        CreateNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCase {
  CreateNewLabelListAndUpdateGoodsReceiptLabelListUsingPoIdUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<
    Either<GoodsReceiptsFailures, List<GoodsReceiptPurchaseOrderLineItemEntity>>
  >
  call(
    List<GoodsReceiptPurchaseOrderLineItemEntity>
    createNewLabelForPoDetailItemList,
    int poId,
  ) {
    return goodsReceiptsRepository.createNewLabelListToUpdateGRLabelLisWithPoId(
      createNewLabelList: createNewLabelForPoDetailItemList,
      poId: poId,
    );
  }
}
