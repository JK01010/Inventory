import 'package:fpdart/fpdart.dart';
import '../entities/default_location_entity.dart';
import '../entities/stock_location_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class FetchDefaultLocationUseCase {
  Future<Either<CommonFailures, List<DefaultLocationEntity>>> call();
}

class FetchDefaultLocationUseCaseImpl implements FetchDefaultLocationUseCase {
  FetchDefaultLocationUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, List<DefaultLocationEntity>>> call() {
    return commonRepository.fetchDefaultLocationFromAPI();
  }
}
