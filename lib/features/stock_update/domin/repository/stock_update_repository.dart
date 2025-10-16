import 'package:fpdart/fpdart.dart';

import '../entities/srock_update_entity_model.dart';
import '../entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../entities/stock_update_view_entity_model.dart';
import '../failures/stock_update_failures.dart';

abstract interface class StockUpdateRepository{
  Future<Either<StockUpdateFailures, Unit>> insertStockUpdateList();
  Future<Either<StockUpdateFailures, Unit>> singleInsertData({required StockUpdateEntity model});
  Future<Either<StockUpdateFailures, Unit>> multipleInsertData({required List<StockUpdateEntity> list});

  Future<Either<StockUpdateFailures, Unit>> saveStockUpdateTransactionApiCall();

  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> fetchAllViewStockUpdateList({required int offSet});
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> fetchSearchViewStockUpdateList({required String searchText});
  Future<Either<StockUpdateFailures, List<StockUpdateViewEntity>>> fetchAllViewStockUpdateListForFilter({required String itemName, required String articleNo});
  Future<Either<StockUpdateFailures, List<StockUpdateRfidListingViewEntity>>> fetchRfidScanningList({required List<String> rfIds});
}