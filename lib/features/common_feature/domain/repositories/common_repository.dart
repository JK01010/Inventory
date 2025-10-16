import 'package:fpdart/fpdart.dart';
import '../../../bagging_tagging_confirmtaion/domain/usecase/get_all_bagging_item_details_usecase.dart';
import '../../../good_receipts/domain/entities/split_location_entity.dart';
import '../entities/default_location_entity.dart';
import '../entities/equipment_list_entity.dart';
import '../entities/item_category_entity.dart';
import '../entities/item_master_common_entity_model.dart';
import '../entities/item_section_entity.dart';
import '../entities/item_sub_section_entity.dart';
import '../entities/port_entity.dart';
import '../entities/stock_location_entity.dart';
import '../entities/storage_location_entity.dart';
import '../failures/common_failures.dart';
import '../usecase/insert_pending_po_split_location_data_usecase.dart';

abstract interface class CommonRepository {
  Future<Either<CommonFailures, List<ItemMasterEntity>>>
  fetchItemsByStorageLocationId({required int id});

  Future<Either<CommonFailures, List<ItemMasterEntity>>> fetchItemsByItemId({
    required int id,
  });

  Future<Either<CommonFailures, List<EquipmentListEntity>>>
  getAllEquipmentList();

  Future<Either<CommonFailures, List<EquipmentListEntity>>>
  getEquipmentChildrenList(String parentId);


  // Item Category
  Future<Either<CommonFailures, Unit>> insertItemCategory();

  Future<Either<CommonFailures, List<ItemCategoryEntity>>>
  fetchAllItemCategory();

  // Item Section
  Future<Either<CommonFailures, Unit>> insertItemSection();

  Future<Either<CommonFailures, List<ItemSectionEntity>>> fetchAllItemSection();

  // Item Sub Section
  Future<Either<CommonFailures, Unit>> insertItemSubSection();

  Future<Either<CommonFailures, List<ItemSubSectionEntity>>>
  fetchAllItemSubSection();

  Future<Either<CommonFailures, Unit>> insertStorageLocationList();

  Future<Either<CommonFailures, List<StorageLocationEntity>>>
  getStorageLocationByParentId(int parentId);

  Future<Either<CommonFailures, Unit>> fetchCommonPortListFromApi();

  Future<Either<CommonFailures, List<PortEntity>>> fetchPortFromDb({
    required String query,
  });

  Future<Either<CommonFailures, List<CommonStockLocationEntity>>>
  fetchStockLocationFromAPI();

  Future<Either<CommonFailures, List<DefaultLocationEntity>>>
  fetchDefaultLocationFromAPI();

  Future<Either<CommonFailures, Unit>> getSplitLocationData();

  Future<Either<CommonFailures, Unit>> getAllItemsFromApi();

  Future<Either<CommonFailures, List<SplitLocationEntity>>>
  getSplitLocationDataFromDbByGrn({
    required GetItemSplitLocationDataParams getSplitLocationDataParams,
  });

  Future<Either<CommonFailures, Unit>> getAllVesselSpecification();

  Future<Either<CommonFailures, Unit>> getAllPoItems();

  Future<Either<CommonFailures, Unit>> insertPendingPoSplitLocationData({
    required InsertPendingPoSplitLocationDataParams
    insertPendingPoSplitLocationDataParams,
  });

  Future<Either<CommonFailures, Unit>> getAllAdminStructure();


}
