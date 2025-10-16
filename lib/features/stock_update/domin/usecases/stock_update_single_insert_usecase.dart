import 'package:fpdart/fpdart.dart';

import '../entities/srock_update_entity_model.dart';
import '../failures/stock_update_failures.dart';
import '../repository/stock_update_repository.dart';

abstract interface class StockUpdateSingleInsertUseCase{
  Future<Either<StockUpdateFailures, Unit>> call({required StockUpdateEntity model});
}

class StockUpdateSingleInsertUseCaseImpl extends StockUpdateSingleInsertUseCase{
  StockUpdateSingleInsertUseCaseImpl({required this.stockUpdateRepository});
  final StockUpdateRepository stockUpdateRepository;

  @override
  Future<Either<StockUpdateFailures, Unit>> call({required StockUpdateEntity model}) {
    return stockUpdateRepository.singleInsertData(model: model);
  }
}
