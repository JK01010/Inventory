import 'package:fpdart/fpdart.dart';

import '../entities/item_master_common_entity_model.dart';
import '../failures/item_master_failures.dart';
import '../repository/item_master_repository.dart';

abstract interface class ItemMasterRfidListingInsertBasedOnItemIdUseCase{
  Future<Either<ItemMasterFailures, Unit>> call({required List<String> rfidList, required int itemId});
}

class ItemMasterRfidListingInsertBasedOnItemIdUseCaseImpl implements ItemMasterRfidListingInsertBasedOnItemIdUseCase{
  const ItemMasterRfidListingInsertBasedOnItemIdUseCaseImpl({required this.itemMasterRepository});
  final ItemMasterRepository itemMasterRepository;

  @override
  Future<Either<ItemMasterFailures, Unit>> call({required List<String> rfidList, required int itemId}) {
    return itemMasterRepository.insertRfidListingBasedOnItemId(itemId: itemId,rfidList: rfidList);
  }

}