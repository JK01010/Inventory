
import 'package:fpdart/fpdart.dart';
import '../entities/con_transaction_view_entity_model.dart';
import '../entities/consumption_transaction_response_entity.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class SearchConsumptionTransactionUseCase {
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> call({required String searchText});
}

class SearchConsumptionTransactionUseCaseImpl implements SearchConsumptionTransactionUseCase {
  SearchConsumptionTransactionUseCaseImpl({required this.consumptionRepository});
  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures, List<ConTransactionViewEntity>>> call({required String searchText}) {
    return consumptionRepository.searchConTransactionDataFromDb(searchText: searchText);
  }
}