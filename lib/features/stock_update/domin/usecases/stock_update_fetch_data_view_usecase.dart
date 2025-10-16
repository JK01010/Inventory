import 'package:fpdart/fpdart.dart';

import '../entities/stock_update_view_entity_model.dart';
import '../failures/stock_update_failures.dart';
import '../repository/stock_update_repository.dart';

abstract interface class StockUpdateFetchDataViewUseCase{
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> call({required int offSet});
}

class StockUpdateFetchDataViewUseCaseImpl implements StockUpdateFetchDataViewUseCase{
  const StockUpdateFetchDataViewUseCaseImpl({required this.stockUpdateRepository});
  final StockUpdateRepository stockUpdateRepository;

  @override
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> call({required int offSet}) {
    return stockUpdateRepository.fetchAllViewStockUpdateList(offSet: offSet);
  }

}