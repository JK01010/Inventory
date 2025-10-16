import 'package:fpdart/fpdart.dart';

import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class InsertStorageLocationUseCase {
  Future<Either<CommonFailures, Unit>> call();
}

class InsertStorageLocationUseCaseImpl implements InsertStorageLocationUseCase {
  InsertStorageLocationUseCaseImpl({required this.repository});

  final CommonRepository repository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return repository.insertStorageLocationList();
  }
}
