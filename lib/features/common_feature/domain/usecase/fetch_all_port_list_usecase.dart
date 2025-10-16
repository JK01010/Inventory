import 'package:fpdart/fpdart.dart';

import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class FetchAllPortListUseCase {
  Future<Either<CommonFailures, Unit>> call();
}

class FetchAllPortListUseCaseImpl implements FetchAllPortListUseCase {
  const FetchAllPortListUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, Unit>> call() {
    return commonRepository.fetchCommonPortListFromApi();
  }
}
