import 'package:fpdart/fpdart.dart';
import '../failures/consumption_failures.dart';
import '../repository/consumption_repository.dart';


abstract interface class InsertEquipmentListUseCase {
  Future<Either<ConsumptionFailures, Unit>> call();
}

class InsertEquipmentListUseCaseImpl implements InsertEquipmentListUseCase {
  InsertEquipmentListUseCaseImpl({required this.consumptionRepository});

  final ConsumptionRepository consumptionRepository;


  @override
  Future<Either<ConsumptionFailures, Unit>> call() {
    return consumptionRepository.insertEquipmentList();
  }
}
