import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/service/db_service/table_data_manipulation/bagging_confirmation_list_datasource.dart';
import '../../../../core/service/db_service/table_data_manipulation/bagging_tagging_pending_datasource.dart';
import '../../../../core/service/db_service/bagging_items_details_datasource.dart';
import '../../model/bagging_confirmation_list_model.dart';
import '../../model/bagging_item_details_model.dart';
import '../model/bagging_tagging_pending_res.dart';
import '../model/bagging_tagging_purchase_list_model.dart';
import '../model/bagging_tagging_purchase_list_view_model.dart';

abstract interface class BaggingTaggingLocalDataSource {
  Future<Unit> insertItemDetailsData();

  Future<Unit> insertPendingItems();

  Future<Unit> insertConfirmationList();

  Future<List<BaggingItemDetailModel>> getAllBaggingItemDetails();

  Future<List<BaggingTaggingPendingModel>> getAllPendingList();

  Future<List<BaggingConfirmationListModel>> getAllConfirmationList();
  Future<String> getAllStorageLocationData({required int storageLocationId});

  //rfidListing
  Future<List<String>> fetchRFIDListViewData({required int itemId});

  //Purchase DT
  Future<Unit> insertBaggingPurchaseList();
  Future<List<BaggingTaggingPurchaseListViewModel>> getAllBaggingPurchaseList({
    required String poHDId,
  });

  Future<bool> changeSyncStatus({required int poId});

  //pending search
  Future<List<BaggingTaggingPendingModel>> searchFromBaggingPendingList({
    required String query,
  });

  //confirmation search
  Future<List<BaggingConfirmationListModel>> searchFromBaggingConfirmationList({
    required String query,
  });

  Future<List<Map<String, dynamic>>> fetchAllLocationOnScanning({
    required List<String> rfid,
    required int itemId,
    required int grnId,
  });

  Future<List<Map<String, dynamic>>> fetchConfirmationListByItemIds({
    required List<int> itemIds,
    required int storageLocationId,
    required int grnId,
  });

  Future<List<Map<String, dynamic>>> fetchConfirmationListByGRNId({
    required String grnId,
  });

  Future<List<int>> fetchItemIdsBasedOnRfid({required List<String> rfid});

  Future<Unit> saveConfirmation({required int grnId, required List<int> items});
}

class BaggingTaggingLocalDataSourceImpl
    implements BaggingTaggingLocalDataSource {
  BaggingTaggingLocalDataSourceImpl({
    required this.baggingItemDetailsDataSource,
    required this.baggingTaggingPendingDatasource,
    required this.baggingConfirmationListDatasource,
  });

  final BaggingItemDetailsDataSource baggingItemDetailsDataSource;
  final BaggingTaggingPendingDatasource baggingTaggingPendingDatasource;
  final BaggingConfirmationListDatasource baggingConfirmationListDatasource;

  //insert all
  @override
  Future<Unit> insertItemDetailsData() async {
    // final String jsonString = await rootBundle.loadString(
    //   'assets/data/bagging_item_details.json',
    // );

    // final BaggingItemDetailResponseModel data =
    //     BaggingItemDetailResponseModel.fromJson(jsonString);
    // await baggingItemDetailsDataSource.clearItemDetailsDataTable();
    // await baggingItemDetailsDataSource.insertItemDetailsData(
    //   baggingItemDetailModel: data.baggingItemDetailModel,
    // );
    return unit;
  }

  @override
  Future<Unit> insertPendingItems() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/bagging_tagging_pendingList.json',
    );

    final BaggingTaggingPendingResponseModel data =
        BaggingTaggingPendingResponseModel.fromJson(jsonString);

    await baggingTaggingPendingDatasource.clearPendingListTable();

    await baggingTaggingPendingDatasource.insertBaggingTaggingPendingList(
      baggingTaggingPendingList: data.items,
    );

    return unit;
  }

  @override
  Future<Unit> insertConfirmationList() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/bagging_confirmed_list.json',
    );

    final BaggingConfirmationListResponseModel data =
        BaggingConfirmationListResponseModel.fromJson(jsonString);
    await baggingConfirmationListDatasource.clearConfirmationListsData();
    await baggingConfirmationListDatasource.insertConfirmationListsData(
      baggingConfirmationListModel: data.baggingConfirmationListModel,
    );
    return unit;
  }

  //get all
  @override
  Future<List<BaggingItemDetailModel>> getAllBaggingItemDetails() async {
    final List<Map<String, dynamic>> data =
        await baggingItemDetailsDataSource.getAllBaggingItemDetails();

    final List<BaggingItemDetailModel> baggingItemDetailList =
        data.map(BaggingItemDetailModel.fromMap).toList();
    return baggingItemDetailList;
  }

  @override
  Future<List<BaggingTaggingPendingModel>> getAllPendingList() async {
    final List<Map<String, dynamic>> rawList =
        await baggingTaggingPendingDatasource.getAllPendingList();

    return rawList.map(BaggingTaggingPendingModel.fromMap).toList();
  }

  @override
  Future<bool> changeSyncStatus({required int poId}) {
    return baggingTaggingPendingDatasource.changeSyncStatus(poId: poId);
  }

  @override
  Future<List<BaggingConfirmationListModel>> getAllConfirmationList() async {
    final List<Map<String, dynamic>> data =
        await baggingConfirmationListDatasource.getAllConfirmationListsData();

    final List<BaggingConfirmationListModel> baggingConfirmationList =
        data.map(BaggingConfirmationListModel.fromMap).toList();
    return baggingConfirmationList;
  }

  //confirmation Storage location id
  @override
  Future<String> getAllStorageLocationData({required int storageLocationId}) {
    return baggingConfirmationListDatasource.getAllStorageLocationData(
      storageLocationId: storageLocationId,
    );
  }

  //rfid listing
  @override
  Future<List<String>> fetchRFIDListViewData({required int itemId}) {
    return baggingTaggingPendingDatasource.fetchRFIDListViewData(
      itemId: itemId,
    );
  }

  //Purchase DT
  @override
  Future<Unit> insertBaggingPurchaseList() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/bagging_tagging_purchase_list.json',
    );

    final BaggingTaggingPurchaseListResponseModel data =
        BaggingTaggingPurchaseListResponseModel.fromJson(jsonString);
    await baggingTaggingPendingDatasource.clearBaggingPurchaseList();
    await baggingTaggingPendingDatasource.insertBaggingTaggingPurchaseList(
      baggingTaggingPurchaseList: data.baggingTaggingPurchaseList,
    );
    return unit;
  }

  @override
  Future<List<BaggingTaggingPurchaseListViewModel>> getAllBaggingPurchaseList({
    required String poHDId,
  }) async {
    final List<Map<String, dynamic>> data =
        await baggingTaggingPendingDatasource.getAllBaggingPurchaseList(
          poHDId: poHDId,
        );
    final List<BaggingTaggingPurchaseListViewModel>
    baggingTaggingPurchaseListView =
        data.map(BaggingTaggingPurchaseListViewModel.fromMap).toList();
    return baggingTaggingPurchaseListView;
  }

  @override
  Future<List<BaggingTaggingPendingModel>> searchFromBaggingPendingList({
    required String query,
  }) async {
    final data = await baggingTaggingPendingDatasource
        .searchBaggingPurchaseOrder(query: query);
    final List<BaggingTaggingPendingModel> purchaseOrderList =
        data.map(BaggingTaggingPendingModel.fromMap).toList();
    return purchaseOrderList;
  }

  @override
  Future<List<BaggingConfirmationListModel>> searchFromBaggingConfirmationList({
    required String query,
  }) async {
    final data = await baggingConfirmationListDatasource
        .searchBaggingConfirmationOrders(query: query);
    final List<BaggingConfirmationListModel> confirmationList =
        data.map(BaggingConfirmationListModel.fromMap).toList();
    return confirmationList;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllLocationOnScanning({
    required List<String> rfid,
    required int itemId,
    required int grnId,
  }) {
    return baggingConfirmationListDatasource.fetchAllLocationOnScanningFromDb(
      rfid: rfid,
      itemId: itemId,
      grnId: grnId,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchConfirmationListByItemIds({
    required List<int> itemIds,
    required int storageLocationId,
    required int grnId,
  }) {
    return baggingConfirmationListDatasource.fetchConfirmationListByItemIds(
      itemIds: itemIds,
      storageLocationId: storageLocationId,
      grnId: grnId,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchConfirmationListByGRNId({
    required String grnId,
  }) {
    return baggingConfirmationListDatasource.fetchConfirmationListByGRNId(
      grnId: grnId,
    );
  }

  @override
  Future<List<int>> fetchItemIdsBasedOnRfid({required List<String> rfid}) {
    return baggingConfirmationListDatasource.fetchItemIdsBasedOnRfid(
      rfid: rfid,
    );
  }

  @override
  Future<Unit> saveConfirmation({
    required int grnId,
    required List<int> items,
  }) async {
    return baggingConfirmationListDatasource.saveConfirmation(
      grnId: grnId,
      items: items,
    );
  }
}
