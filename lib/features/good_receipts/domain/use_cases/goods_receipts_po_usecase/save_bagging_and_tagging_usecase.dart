import 'package:fpdart/fpdart.dart';

import '../../failures/goods_receipts_failures.dart';
import '../../repository/goods_receipts_repository.dart';
import 'save_goods_receipts_usecase.dart';

abstract interface class SaveBaggingAndTaggingUsecase {
  Future<Either<GoodsReceiptsFailures, bool>> call(
    BaggingAndTaggingParams params,
  );
}

class SaveBaggingAndTaggingUsecaseImpl implements SaveBaggingAndTaggingUsecase {
  SaveBaggingAndTaggingUsecaseImpl({required this.goodsReceiptsRepository});

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, bool>> call(
    BaggingAndTaggingParams params,
  ) {
    return goodsReceiptsRepository.saveBaggingAndTagging(params);
  }
}
