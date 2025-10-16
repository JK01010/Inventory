import 'package:fpdart/fpdart.dart';
import '../../../common_feature/domain/failures/common_failures.dart';
import '../../../common_feature/domain/repositories/common_repository.dart';
import '../../../good_receipts/domain/entities/split_location_entity.dart';
import '../failures/bagging_and_tagging_failures.dart';

abstract interface class GetItemSplitLocationDataUseCase {
  Future<Either<CommonFailures, List<SplitLocationEntity>>> call({
    required GetItemSplitLocationDataParams getSplitLocationDataParams,
  });
}

class GetItemSplitLocationDataUseCaseImpl
    implements GetItemSplitLocationDataUseCase {
  GetItemSplitLocationDataUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, List<SplitLocationEntity>>> call({
    required GetItemSplitLocationDataParams getSplitLocationDataParams,
  }) async {
    return commonRepository.getSplitLocationDataFromDbByGrn(
      getSplitLocationDataParams: getSplitLocationDataParams,
    );
  }
}

class GetItemSplitLocationDataParams {
  GetItemSplitLocationDataParams({required this.grnId, required this.grnDtId});

  final int grnId;
  final int grnDtId;
}
