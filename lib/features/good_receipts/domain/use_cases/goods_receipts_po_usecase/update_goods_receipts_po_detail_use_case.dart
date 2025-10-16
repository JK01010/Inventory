import 'package:fpdart/fpdart.dart';

import '../../entities/purchase_order_hd_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class UpdateGoodsReceiptsPoDetailUseCase {
  Future<Either<GoodsReceiptsFailures, PurchaseOrderHDEntity>> call(
    PurchaseOrderHDEntity purchaseOrderHDEntity,
  );
}

class UpdateGoodsReceiptsPoDetailUseCaseImpl
    implements UpdateGoodsReceiptsPoDetailUseCase {
  UpdateGoodsReceiptsPoDetailUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, PurchaseOrderHDEntity>> call(
    PurchaseOrderHDEntity purchaseOrderHDEntity,
  ) {
    return goodsReceiptsRepository.updateGoodsReceiptsPoDetail(
      purchaseOrderHDEntity,
    );
  }
}
