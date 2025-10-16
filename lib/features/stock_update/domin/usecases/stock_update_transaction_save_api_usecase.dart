import 'package:fpdart/fpdart.dart';
import '../failures/stock_update_failures.dart';
import '../repository/stock_update_repository.dart';

abstract interface class StockUpdateTrnSaveApiUseCase{
  Future<Either<StockUpdateFailures, Unit>> call();
}

class StockUpdateTrnSaveApiUseCaseImpl extends StockUpdateTrnSaveApiUseCase{
  StockUpdateTrnSaveApiUseCaseImpl({required this.stockUpdateRepository});
  final StockUpdateRepository stockUpdateRepository;

  @override
  Future<Either<StockUpdateFailures, Unit>> call() {
    return stockUpdateRepository.saveStockUpdateTransactionApiCall();
  }
}
