import 'package:fpdart/fpdart.dart';

import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class UpdateStockLocationByItemIdUseCase {
  Future<Either<GoodsReceiptsFailures, Unit>> call(int itemId);
}

class UpdateStockLocationByItemIdUseCaseImpl
    implements UpdateStockLocationByItemIdUseCase {
  UpdateStockLocationByItemIdUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, Unit>> call(int itemId) {
    return goodsReceiptsRepository.updateStockLocationByItemId(itemId);
  }
}
