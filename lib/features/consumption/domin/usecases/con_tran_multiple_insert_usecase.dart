import 'package:fpdart/fpdart.dart';

import '../entities/consumption_transaction_entity_model.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class ConTranMultipleInsertUseCase {
  Future<Either<ConsumptionFailures, Unit>> call({required List<ConsumptionTransactionEntityModel> list});
}

class ConTranMultipleInsertUseCaseImpl implements ConTranMultipleInsertUseCase {
  ConTranMultipleInsertUseCaseImpl({required this.consumptionRepository});

  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, Unit>> call({required List<ConsumptionTransactionEntityModel> list}){
    return consumptionRepository.multipleInsertConsumptionTransaction(list: list);
  }
}