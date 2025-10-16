
import 'package:fpdart/fpdart.dart';

import '../entities/consumption_rfid_scanning_view_entity_model.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class ConsumptionRfidScanningViewUseCase{
  Future<Either<ConsumptionFailures, List<ConsumptionRfidListingViewEntity>>> call({required List<String> rfIds});
}

class ConsumptionRfidScanningViewUseCaseImpl implements ConsumptionRfidScanningViewUseCase{
  const ConsumptionRfidScanningViewUseCaseImpl({required this.consumptionRepository});
  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, List<ConsumptionRfidListingViewEntity>>> call({required List<String> rfIds}) {
    return consumptionRepository.fetchRfidScanningList(rfIds: rfIds);
  }

}