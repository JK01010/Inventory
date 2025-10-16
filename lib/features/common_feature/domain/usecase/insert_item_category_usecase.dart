import 'package:fpdart/fpdart.dart';

import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class InsertItemCategoryUsecase {
  Future<Either<CommonFailures, Unit>> call();
}

class InsertItemCategoryUsecaseImpl implements InsertItemCategoryUsecase {
  InsertItemCategoryUsecaseImpl({required this.repository});

  final CommonRepository repository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return repository.insertItemCategory();
  }
}
