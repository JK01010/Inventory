import 'package:fpdart/fpdart.dart';

import '../entities/stock_update_view_entity_model.dart';
import '../failures/stock_update_failures.dart';
import '../repository/stock_update_repository.dart';

abstract interface class StockUpdateFetchSearchDataViewUseCase{
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> call({required String searchText});
}

class StockUpdateFetchSearchDataViewUseCaseImpl implements StockUpdateFetchSearchDataViewUseCase{
  const StockUpdateFetchSearchDataViewUseCaseImpl({required this.stockUpdateRepository});
  final StockUpdateRepository stockUpdateRepository;

  @override
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> call({required String searchText}) {
    return stockUpdateRepository.fetchSearchViewStockUpdateList(searchText: searchText);
  }

}