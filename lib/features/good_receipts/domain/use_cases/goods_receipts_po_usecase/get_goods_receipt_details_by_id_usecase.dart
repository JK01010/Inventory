import 'package:fpdart/fpdart.dart';

import '../../entities/purchase_order_hd_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class GetGoodsReceiptDetailsByIdUseCase {
  Future<Either<GoodsReceiptsFailures, PurchaseOrderHDEntity>>
  getGoodsReceiptDetailsById(int poId);
}

class GetGoodsReceiptDetailsByIdUseCaseImpl
    implements GetGoodsReceiptDetailsByIdUseCase {
  GetGoodsReceiptDetailsByIdUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, PurchaseOrderHDEntity>>
  getGoodsReceiptDetailsById(int poId) {
    return goodsReceiptsRepository.getGoodsReceiptDetailsById(poId);
  }
}
