import 'package:fpdart/fpdart.dart';
import '../entities/consumption_location_entity.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class FetchAllConsumptionLocationUseCase {
  Future<Either<ConsumptionFailures, List<ConsumptionLocationEntity>>> call();
}

class FetchAllConsumptionLocationUseCaseImpl implements FetchAllConsumptionLocationUseCase {
  FetchAllConsumptionLocationUseCaseImpl({required this.consumptionRepository});
  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, List<ConsumptionLocationEntity>>> call() {
    return consumptionRepository.fetchAllConsumptionLocationList();
  }
}