import 'package:fpdart/fpdart.dart';

import '../entities/srock_update_entity_model.dart';
import '../failures/stock_update_failures.dart';
import '../repository/stock_update_repository.dart';

abstract interface class StockUpdateMultipleInsertUseCase{
  Future<Either<StockUpdateFailures, Unit>> call({required List<StockUpdateEntity> list});
}

class StockUpdateMultipleInsertUseCaseImpl extends StockUpdateMultipleInsertUseCase{
  StockUpdateMultipleInsertUseCaseImpl({required this.stockUpdateRepository});
  final StockUpdateRepository stockUpdateRepository;

  @override
  Future<Either<StockUpdateFailures, Unit>> call({required List<StockUpdateEntity> list}) {
    return stockUpdateRepository.multipleInsertData(list: list);
  }
}
