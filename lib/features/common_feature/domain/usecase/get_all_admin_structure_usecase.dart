import 'package:fpdart/fpdart.dart';

import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class GetAllAdminStructureUseCase {
  Future<Either<CommonFailures, Unit>> call();
}

class GetAllAdminStructureUseCaseImpl implements GetAllAdminStructureUseCase {
  GetAllAdminStructureUseCaseImpl({required this.repository});

  final CommonRepository repository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return repository.getAllAdminStructure();
  }
}
