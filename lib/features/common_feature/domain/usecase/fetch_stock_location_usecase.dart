import 'package:fpdart/fpdart.dart';
import '../entities/stock_location_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class FetchStockLocationUseCase {
  Future<Either<CommonFailures, List<CommonStockLocationEntity>>> call();
}

class FetchStockLocationUseCaseImpl implements FetchStockLocationUseCase {
  FetchStockLocationUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, List<CommonStockLocationEntity>>> call() {
    return commonRepository.fetchStockLocationFromAPI();
  }
}
