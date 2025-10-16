import 'package:fpdart/fpdart.dart';

import '../entities/item_master_common_entity_model.dart';
import '../failures/item_master_failures.dart';
import '../repository/item_master_repository.dart';

abstract interface class ItemMasterRfidListingInsertUseCase{
  Future<Either<ItemMasterFailures, Unit>> call();
}

class ItemMasterRfidListingInsertUseCaseImpl implements ItemMasterRfidListingInsertUseCase{
  const ItemMasterRfidListingInsertUseCaseImpl({required this.itemMasterRepository});
  final ItemMasterRepository itemMasterRepository;

  @override
  Future<Either<ItemMasterFailures, Unit>> call() {
    return itemMasterRepository.insertRfidListing();
  }

}