import 'package:fpdart/fpdart.dart';

import '../../entities/purchase_order_hd_entity.dart';
import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';

abstract interface class SaveGoodReceiptsUseCase {
  Future<Either<GoodsReceiptsFailures, bool>> call(
    SaveGoodsReceiptsParams purchaseOrderHDEntity,
  );
}

class SaveGoodReceiptsUseCaseImpl implements SaveGoodReceiptsUseCase {
  SaveGoodReceiptsUseCaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, bool>> call(
    SaveGoodsReceiptsParams purchaseOrderHDEntity,
  ) {
    return goodsReceiptsRepository.saveGoodReceiptsApi(purchaseOrderHDEntity);
  }
}

class SaveGoodsReceiptsParams {
  SaveGoodsReceiptsParams({
    required this.purchaseOrderHDEntity,
    required this.statusType,
  });

  final PurchaseOrderHDEntity purchaseOrderHDEntity;
  final String statusType;
}

class BaggingAndTaggingParams {
  BaggingAndTaggingParams({required this.id, required this.statusType});

  final int id;
  final String statusType;
}
