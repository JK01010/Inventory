import 'package:fpdart/fpdart.dart';

import '../entities/equipment_list_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class GetAllEquipmentListUseCase {
  Future<Either<CommonFailures, List<EquipmentListEntity>>> call();
}

class GetAllEquipmentListUseCaseImpl implements GetAllEquipmentListUseCase {
  GetAllEquipmentListUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;
  @override
  Future<Either<CommonFailures, List<EquipmentListEntity>>> call() {
    return commonRepository.getAllEquipmentList();
  }
}
