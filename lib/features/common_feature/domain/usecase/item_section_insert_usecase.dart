import 'package:fpdart/fpdart.dart';

import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class ItemSectionInsertUsecase {
  Future<Either<CommonFailures, Unit>> call();
}

class ItemSectionInsertUsecaseImpl
    implements ItemSectionInsertUsecase {
  ItemSectionInsertUsecaseImpl({required this.repository});

  final CommonRepository repository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return repository.insertItemSection();
  }
}