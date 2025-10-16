import 'package:fpdart/fpdart.dart';

import '../failures/bagging_and_tagging_failures.dart';
import '../repository/bagging_tagging_repository.dart';

abstract interface class InsertBaggingPurchaseListUsecase {
  Future<Either<BaggingAndTaggingFailures, Unit>> call();
}

class InsertBaggingPurchaseListUsecaseImpl
    implements InsertBaggingPurchaseListUsecase {
  InsertBaggingPurchaseListUsecaseImpl({required this.repository});

  final BaggingTaggingRepository repository;

  @override
  Future<Either<BaggingAndTaggingFailures, Unit>> call() {
    return repository.insertBaggingPurchaseList();
  }
}