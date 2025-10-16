import 'package:fpdart/fpdart.dart';
import '../entities/split_location_entity.dart';
import '../failures/goods_receipts_failures.dart';
import '../repository/goods_receipts_repository.dart';

abstract interface class GetPendingPoSplitLocationDataUseCase {
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>> call({
    required GetPendingPoSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  });
}

class GetPendingPoSplitLocationDataUseCaseImpl
    implements GetPendingPoSplitLocationDataUseCase {
  GetPendingPoSplitLocationDataUseCaseImpl({
    required this.goodsReceiptsRepository,
  });

  final GoodsReceiptsRepository goodsReceiptsRepository;

  @override
  Future<Either<GoodsReceiptsFailures, List<SplitLocationEntity>>> call({
    required GetPendingPoSplitLocationDataParams
    getPendingPoSplitLocationDataParams,
  }) {
    return goodsReceiptsRepository.getPendingPoSplitLocationData(
      getPendingPoSplitLocationDataParams: getPendingPoSplitLocationDataParams,
    );
  }
}

class GetPendingPoSplitLocationDataParams {
  GetPendingPoSplitLocationDataParams({
    required this.poHdId,
    required this.poDtId,
  });

  final int poHdId;
  final int poDtId;
}
