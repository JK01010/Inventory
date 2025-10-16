import 'package:fpdart/fpdart.dart';

import '../entities/pending_list_model.dart';
import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class GetBaggingTaggingPendingListUseCase {
  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPendingEntity>>> call();
}

class GetBaggingTaggingPendingListUseCaseImpl
    implements GetBaggingTaggingPendingListUseCase {
  GetBaggingTaggingPendingListUseCaseImpl({required this.repository});

  final BaggingTaggingRepository repository;

  @override
  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPendingEntity>>> call() {
    return repository.getAllPendingList();
  }
}
