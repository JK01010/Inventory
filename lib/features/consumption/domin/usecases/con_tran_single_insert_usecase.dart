import 'package:fpdart/fpdart.dart';

import '../entities/consumption_transaction_entity_model.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class ConTransactionSingleInsertUseCase{
  Future<Either<ConsumptionFailures, Unit>> call({required ConsumptionTransactionEntityModel model});
}

class ConTransactionSingleInsertUseCaseImpl extends ConTransactionSingleInsertUseCase{
  ConTransactionSingleInsertUseCaseImpl({required this.consumptionRepository});
  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, Unit>> call({required ConsumptionTransactionEntityModel model}) {
    return consumptionRepository.singleInsertConsumptionTransaction(model: model);
  }
}
