
import 'package:fpdart/fpdart.dart';

import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class FetchingConfirmationStorageLocationUsecase {
  Future<Either<BaggingAndTaggingFailures, String>> call({required int storageLocationId});
}

class FetchingConfirmationStorageLocationUsecaseImpl
    implements FetchingConfirmationStorageLocationUsecase {
  FetchingConfirmationStorageLocationUsecaseImpl({
    required this.baggingTaggingRepository,
  });

  final BaggingTaggingRepository baggingTaggingRepository;

  @override
  Future<Either<BaggingAndTaggingFailures, String>>call({required int storageLocationId}) {
    return baggingTaggingRepository.getAllStorageLocationData(storageLocationId: storageLocationId);
  }
}
