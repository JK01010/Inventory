import 'package:fpdart/fpdart.dart';

import '../entities/split_location_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class InsertOrUpdateSplitStorageLocationUseCase {
  Future<Either<GoodsReceiptsFailures, Unit>> insertOrUpdateSplitLocationEntity(
    List<SplitLocationEntity> splitLocationEntityList,
  );
}

class InsertOrUpdateSplitStorageLocationUseCaseImpl
    implements InsertOrUpdateSplitStorageLocationUseCase {
  InsertOrUpdateSplitStorageLocationUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, Unit>> insertOrUpdateSplitLocationEntity(
    List<SplitLocationEntity> splitLocationEntityList,
  ) {
    return goodsReceiptsRepository.insertOrUpdateSplitLocationEntity(
      splitLocationEntityList,
    );
  }
}
