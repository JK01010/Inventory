import 'package:fpdart/fpdart.dart';

import '../entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../entities/stock_update_view_entity_model.dart';
import '../failures/stock_update_failures.dart';
import '../repository/stock_update_repository.dart';

abstract interface class StockUpdateRfidScanningViewUseCase{
  Future<Either<StockUpdateFailures, List<StockUpdateRfidListingViewEntity>>> call({required List<String> rfIds});
}

class StockUpdateRfidScanningViewUseCaseImpl implements StockUpdateRfidScanningViewUseCase{
  const StockUpdateRfidScanningViewUseCaseImpl({required this.stockUpdateRepository});
  final StockUpdateRepository stockUpdateRepository;

  @override
  Future<Either<StockUpdateFailures, List<StockUpdateRfidListingViewEntity>>> call({required List<String> rfIds}) {
    return stockUpdateRepository.fetchRfidScanningList(rfIds: rfIds);
  }

}