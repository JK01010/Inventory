import 'package:fpdart/fpdart.dart';
import '../entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetPoItemDetailsUseCase {
  Future<Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity?>>
  call({required GetPoItemDetailsParams getPoItemDetailsParams});
}

class GetPoItemDetailsUseCaseImpl implements GetPoItemDetailsUseCase {
  GetPoItemDetailsUseCaseImpl({required this.goodsReceiptRepository});

  final GoodsReceiptsRepository goodsReceiptRepository;

  @override
  Future<Either<GoodsReceiptsFailures, GoodsReceiptPurchaseOrderLineItemEntity?>>
  call({required GetPoItemDetailsParams getPoItemDetailsParams}) async{
    return goodsReceiptRepository.getPoItemDetails(getPoItemDetailsParams: getPoItemDetailsParams);
  }
}

class GetPoItemDetailsParams {
  GetPoItemDetailsParams({required this.poHdId, required this.poDtId});

  final int poHdId;
  final int poDtId;
}
