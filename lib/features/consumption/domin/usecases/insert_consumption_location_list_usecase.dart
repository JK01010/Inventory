import 'package:fpdart/fpdart.dart';

import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class InsertConsumptionLocationListUseCase {
  Future<Either<ConsumptionFailures, Unit>> call();
}

// sub class
class InsertConsumptionLocationListUseCaseImpl
    implements InsertConsumptionLocationListUseCase {
  InsertConsumptionLocationListUseCaseImpl({
    required this.consumptionRepository,
  });

  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, Unit>> call() {
    return consumptionRepository.insertConsumptionLocationList();
  }
}
