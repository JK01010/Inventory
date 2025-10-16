import 'package:fpdart/fpdart.dart';
import '../entities/item_master_common_entity_model.dart';
import '../entities/item_master_filter_entity_model.dart';
import '../entities/item_master_rfid_view_entity_model.dart';
import '../failures/item_master_failures.dart';

abstract interface class ItemMasterRepository{
  Future<Either<ItemMasterFailures, Unit>> insertItemMaster();
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>> fetchAllItemMasterList({required int offSet});
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>> fetchSearchItemMasterList({required String searchText});
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>> fetchFilterItemMasterList(ItemMasterFilterEntity data);
  ///rfidListing
  Future<Either<ItemMasterFailures, Unit>> insertRfidListing();
  Future<Either<ItemMasterFailures, Unit>> insertRfidListingBasedOnItemId({required List<String> rfidList, required int itemId});
  Future<Either<ItemMasterFailures, List<ItemMasterRfidViewEntity>>> fetchItemMasterRfidList({required int itemId});
  ///commonTables

  Future<Either<ItemMasterFailures, Unit>> insertCommonSerialNumberList();
  Future<Either<ItemMasterFailures, Unit>> insertItemGroupNumberList();

  //fetchAllRfid
  Future<Either<ItemMasterFailures, List<String>>> fetchAllRfidFromDb();
}