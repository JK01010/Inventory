import 'package:fpdart/fpdart.dart';

import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class SaveApiConsumptionTransactionUseCase {
  Future<Either<ConsumptionFailures, Unit>> call();
}

class SaveApiConsumptionTransactionUseCaseImpl implements SaveApiConsumptionTransactionUseCase {
  SaveApiConsumptionTransactionUseCaseImpl({required this.consumptionRepository});
  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, Unit>> call() {
    return consumptionRepository.saveConsumptionTransactionApiCall();
  }
}