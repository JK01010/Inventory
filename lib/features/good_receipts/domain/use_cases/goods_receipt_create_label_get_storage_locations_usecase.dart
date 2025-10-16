import 'package:fpdart/fpdart.dart';

import '../../../common_feature/domain/entities/storage_location_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GoodsReceiptCreateLabelGetStorageLocationsUseCase {
  Future<Either<GoodsReceiptsFailures, List<StorageLocationEntity>>>
  getAllStorageLocations();
}

class GoodsReceiptCreateLabelGetStorageLocationsUseCaseImpl
    implements GoodsReceiptCreateLabelGetStorageLocationsUseCase {
  GoodsReceiptCreateLabelGetStorageLocationsUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, List<StorageLocationEntity>>>
  getAllStorageLocations() {
    return goodsReceiptsRepository.getAllStorageLocations();
  }
}
