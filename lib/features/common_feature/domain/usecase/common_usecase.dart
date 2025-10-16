import 'package:fpdart/fpdart.dart';
import '../entities/item_master_common_entity_model.dart';
import '../failures/common_failures.dart';
import '../repositories/common_repository.dart';

abstract interface class CommonUseCase {
  Future<Either<CommonFailures, List<ItemMasterEntity>>> call({
    required int storageLocationId,
  });
}

class CommonUseCaseImpl implements CommonUseCase {
  CommonUseCaseImpl({required this.commonRepository});
  final CommonRepository commonRepository;

  @override
  Future<Either<CommonFailures, List<ItemMasterEntity>>> call({
    required int storageLocationId,
  }) {
    return commonRepository.fetchItemsByStorageLocationId(
      id: storageLocationId,
    );
  }
}
