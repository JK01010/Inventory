import 'package:fpdart/fpdart.dart';

import '../entities/item_master_common_entity_model.dart';
import '../entities/item_master_rfid_view_entity_model.dart';
import '../failures/item_master_failures.dart';
import '../repository/item_master_repository.dart';

abstract interface class FetchItemMasterRfidListingUseCase{
  Future<Either<ItemMasterFailures, List<ItemMasterRfidViewEntity>>> call({required int itemId});
}

class FetchItemMasterRfidListingUseCaseImpl implements FetchItemMasterRfidListingUseCase{
  const FetchItemMasterRfidListingUseCaseImpl({required this.itemMasterRepository});
  final ItemMasterRepository itemMasterRepository;

  @override
  Future<Either<ItemMasterFailures,  List<ItemMasterRfidViewEntity>>> call({required int itemId}) {
    return itemMasterRepository.fetchItemMasterRfidList(itemId: itemId);
  }

}