
import 'package:fpdart/fpdart.dart';
import '../entities/con_transaction_view_entity_model.dart';
import '../entities/consumption_transaction_response_entity.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';

abstract interface class FetchROBUseCase {
  Future<Either<ConsumptionFailures,int>> call({required int itemId});
}

class FetchROBUseCaseImpl implements FetchROBUseCase {
  FetchROBUseCaseImpl({required this.consumptionRepository});
  final ConsumptionRepository consumptionRepository;

  @override
  Future<Either<ConsumptionFailures,int>> call({required int itemId}) {
    return consumptionRepository.fetchROBDetails(itemId: itemId);
  }
}