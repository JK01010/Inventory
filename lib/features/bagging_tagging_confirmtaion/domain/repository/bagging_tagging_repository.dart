import 'package:fpdart/fpdart.dart';
import '../entities/bagging_confirmation_list_entity.dart';
import '../entities/bagging_item_details_entity.dart';
import '../entities/bagging_tagging_purchase_list_view_entity.dart';
import '../entities/pending_list_model.dart';
import '../failures/bagging_and_tagging_failures.dart';

abstract interface class BaggingTaggingRepository {
  //insertion
  Future<Either<BaggingAndTaggingFailures, Unit>>
  insertBaggingAndTaggingItemDetails();

  Future<Either<BaggingAndTaggingFailures, Unit>> insertPendingList();

  Future<Either<BaggingAndTaggingFailures, Unit>>
  insertBaggingConfirmationList();

  //purchase DT
  Future<Either<BaggingAndTaggingFailures, Unit>> insertBaggingPurchaseList();

  Future<
    Either<
      BaggingAndTaggingFailures,
      List<BaggingTaggingPurchaseListViewEntity>
    >
  >
  getAllBaggingPurchaseList({required String poHDId});

  //get all
  Future<Either<BaggingAndTaggingFailures, List<BaggingItemDetailsEntity>>>
  getAllBaggingItemDetails();

  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPendingEntity>>>
  getAllPendingList();

  // Future<Either<BaggingTaggingFailures, Unit>> clearPendingList();
  Future<Either<BaggingAndTaggingFailures, Unit>> updateSyncStatus(int poId);

  Future<Either<BaggingAndTaggingFailures, List<BaggingConfirmationListEntity>>>
  getAllConfirmationList();

  Future<Either<BaggingAndTaggingFailures, String>> getAllStorageLocationData({
    required int storageLocationId,
  });

  //rfid listing
  Future<Either<BaggingAndTaggingFailures, List<String>>>
  fetchRFIDListViewData({required int itemId});

  //pending search
  Future<Either<BaggingAndTaggingFailures, List<BaggingTaggingPendingEntity>>>
  searchFromBaggingPendingList({required String query});

  //confirmation search
  Future<Either<BaggingAndTaggingFailures, List<BaggingConfirmationListEntity>>>
  searchFromBaggingConfirmationList({required String query});

  //fetchAllScannedItems
  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>>
  fetchAllLocationBasedOnScannedRfidItems({
    required List<String> rfid,
    required int itemId,
    required int grnId,});

  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>> fetchConfirmationListByItemIds({required List<int> itemIds,required int storageLocationId,required int grnId});

  Future<Either<BaggingAndTaggingFailures, List<Map<String, dynamic>>>> fetchConfirmationListByGRNId({required String grnId});

  Future<Either<BaggingAndTaggingFailures, List<int>>> fetchItemIdsBasedOnRfid({required List<String> rfid});

  Future<Either<BaggingAndTaggingFailures, Unit>> saveConfirmation({required int grnId,required List<int> itemIds});
}
