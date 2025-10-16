import 'package:fpdart/fpdart.dart';

import '../../../good_receipts/domain/entities/split_location_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class InsertPendingPoSplitLocationDataUseCase {
  Future<Either<CommonFailures, Unit>> call({
    required InsertPendingPoSplitLocationDataParams
    insertPendingPoSplitLocationDataParams,
  });
}

class InsertPendingPoSplitLocationDataUseCaseImpl
    implements InsertPendingPoSplitLocationDataUseCase {
  InsertPendingPoSplitLocationDataUseCaseImpl({required this.repository});

  final CommonRepository repository;

  @override
  Future<Either<CommonFailures, Unit>> call({
    required InsertPendingPoSplitLocationDataParams
    insertPendingPoSplitLocationDataParams,
  }) {
    return repository.insertPendingPoSplitLocationData(
      insertPendingPoSplitLocationDataParams:
          insertPendingPoSplitLocationDataParams,
    );
  }
}

class InsertPendingPoSplitLocationDataParams {
  InsertPendingPoSplitLocationDataParams({required this.splitLocationList});

  final List<SplitLocationEntity> splitLocationList;
}
