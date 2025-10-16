import 'package:fpdart/fpdart.dart';

import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class InsertBaggingTaggingItemDetailsUsecase {
  Future<Either<BaggingAndTaggingFailures, Unit>> call();
}

class InsertBaggingTaggingItemDetailsUsecaseImpl implements InsertBaggingTaggingItemDetailsUsecase {
  InsertBaggingTaggingItemDetailsUsecaseImpl({required this.baggingTaggingRepository});

  final BaggingTaggingRepository baggingTaggingRepository;
  @override
  Future<Either<BaggingAndTaggingFailures, Unit>> call() {
    return baggingTaggingRepository.insertBaggingAndTaggingItemDetails();
  }
}
