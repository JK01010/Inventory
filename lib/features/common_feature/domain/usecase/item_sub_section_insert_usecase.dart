import 'package:fpdart/fpdart.dart';

import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class ItemSubSectionInsertUsecase {
  Future<Either<CommonFailures, Unit>> call();
}

class ItemSubSectionInsertUsecaseImpl
    implements ItemSubSectionInsertUsecase {
  ItemSubSectionInsertUsecaseImpl({required this.repository});

  final CommonRepository repository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return repository.insertItemSubSection();
  }
}