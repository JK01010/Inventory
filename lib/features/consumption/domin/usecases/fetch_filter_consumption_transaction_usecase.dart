
import 'package:fpdart/fpdart.dart';
import '../entities/con_transaction_view_entity_model.dart';
import '../entities/consumption_transaction_response_entity.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class FetchConsumptionTransactionFilterUseCase {
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> call(String itemName,String articleNo);
}

class FetchConsumptionTransactionFilterUseCaseImpl implements FetchConsumptionTransactionFilterUseCase {
  FetchConsumptionTransactionFilterUseCaseImpl({required this.consumptionRepository});
  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> call(String itemName,String articleNo) {
    return consumptionRepository.fetchConsumptionTransactionFilterList(itemName,articleNo);
  }
}