import 'package:fpdart/fpdart.dart';

import '../entities/stock_update_view_entity_model.dart';
import '../failures/stock_update_failures.dart';
import '../repository/stock_update_repository.dart';

abstract interface class StockUpdateInsertUseCase{
  Future<Either<StockUpdateFailures, Unit>> call();
}

class StockUpdateInsertUseCaseImpl implements StockUpdateInsertUseCase{
  const StockUpdateInsertUseCaseImpl({required this.stockUpdateRepository});
  final StockUpdateRepository stockUpdateRepository;

  @override
  Future<Either<StockUpdateFailures, Unit>> call() {
    return stockUpdateRepository.insertStockUpdateList();
  }

}