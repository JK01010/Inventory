import 'package:fpdart/fpdart.dart';

import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class InsertBaggingConfirmationListUsecase {
  Future<Either<BaggingAndTaggingFailures, Unit>> call();
}

class InsertBaggingConfirmationListUsecaseImpl
    implements InsertBaggingConfirmationListUsecase {
  InsertBaggingConfirmationListUsecaseImpl({required this.repository});

  final BaggingTaggingRepository repository;

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>> call() {
    return repository.insertBaggingConfirmationList();
  }
}
