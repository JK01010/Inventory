
import 'package:fpdart/fpdart.dart';
import '../entities/con_transaction_view_entity_model.dart';
import '../entities/consumption_transaction_response_entity.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class FetchAllConsumptionTransactionUseCase {
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> call();
}

class FetchConsumptionTransactionUseCaseImpl implements FetchAllConsumptionTransactionUseCase {
  FetchConsumptionTransactionUseCaseImpl({required this.consumptionRepository});
  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> call() {
    return consumptionRepository.fetchAllConsumptionTransactionList();
  }
}