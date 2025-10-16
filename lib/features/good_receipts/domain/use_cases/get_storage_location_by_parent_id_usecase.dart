import 'package:fpdart/fpdart.dart';

import '../../../common_feature/domain/entities/storage_location_entity.dart';
import '../../../common_feature/domain/failures/common_failures.dart';
import '../../../common_feature/domain/repositories/common_repository.dart';

abstract interface class GetStorageLocationByParentIdUseCase {
  Future<Either<CommonFailures, List<StorageLocationEntity>>>
  getStorageLocationByParentId(int parentId);
}

class GetStorageLocationByParentIdUseCaseImpl
    implements GetStorageLocationByParentIdUseCase {
  GetStorageLocationByParentIdUseCaseImpl({required this.commonRepository});

  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, List<StorageLocationEntity>>>
  getStorageLocationByParentId(int parentId) {
    return commonRepository.getStorageLocationByParentId(parentId);
  }
}
