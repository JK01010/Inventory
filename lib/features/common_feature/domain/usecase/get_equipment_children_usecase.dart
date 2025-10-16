import 'package:fpdart/fpdart.dart';

import '../entities/equipment_list_entity.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class GetEquipmentChildrenUsecase {
  Future<Either<CommonFailures, List<EquipmentListEntity>>> call({
    required String parentId,
  });
}

class GetEquipmentChildrenUsecaseImpl implements GetEquipmentChildrenUsecase {
  GetEquipmentChildrenUsecaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;
  @override
  Future<Either<CommonFailures, List<EquipmentListEntity>>> call({
    required String parentId,
  }) {
    return commonRepository.getEquipmentChildrenList(parentId);
  }
}
