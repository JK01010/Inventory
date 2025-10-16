import 'package:fpdart/fpdart.dart';

import '../entities/stock_update_view_entity_model.dart';
import '../failures/stock_update_failures.dart';
import '../repository/stock_update_repository.dart';

abstract interface class StockUpdateFetchFilterDataViewUseCase{
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> call({required String itemName,required String articleNo});
}

class StockUpdateFetchFilterDataViewUseCaseImpl implements StockUpdateFetchFilterDataViewUseCase{
  const StockUpdateFetchFilterDataViewUseCaseImpl({required this.stockUpdateRepository});
  final StockUpdateRepository stockUpdateRepository;

  @override
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> call({required String itemName,required String articleNo}) {
    return stockUpdateRepository.fetchAllViewStockUpdateListForFilter(itemName: itemName,articleNo: articleNo);
  }

}