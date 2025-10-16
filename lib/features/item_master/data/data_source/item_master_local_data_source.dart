import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/service/db_service/table_data_manipulation/item_master_data_processor.dart';
import '../models/item_group_common_response_model.dart';
import '../models/item_master_common_response_model.dart';
import '../models/item_master_filter_model.dart';
import '../models/rfid_listing_common_response_model.dart';
import '../models/serial_number_common_response_model.dart';

abstract interface class ItemMasterLocalDataSource {
  // Future<Unit> insertData();
  Future<List<ItemMasterModel>> fetchAllItemMasterListFromDb({
    required int offSet,
  });
  Future<List<ItemMasterModel>> fetchSearchItemMasterListFromDb({
    required String searchText,
  });
  Future<List<ItemMasterModel>> fetchFilterItemMasterListFromDb(
    ItemMasterFilterModel data,
  );

  ///rfidListing
  Future<Unit> insertRfidListingData();

  Future<Unit> insertRfidBasedOnItemId({required List<String> rfidList,required int itemId});

  Future<List<String>> fetchAllRfidFromDb();



  Future<List<RfidIdModel>> fetchItemMasterRfidListFromDb({required int itemId});

  ///CommonTables

  Future<Unit> insertSerialNumberListData();
  Future<Unit> insertItemGroupListData();
}

class ItemMasterLocalDataSourceImpl implements ItemMasterLocalDataSource {
  const ItemMasterLocalDataSourceImpl({required this.itemMasterDataSource});

  final ItemMasterDataProcessor itemMasterDataSource;

/*  @override
  Future<Unit> insertData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/item_master.json',
    );
    final ItemMasterResponseModel data = ItemMasterResponseModel.fromJson(
      jsonString,
    );
    await itemMasterDataSource.clearItemMasterTable();
    await itemMasterDataSource.insertItemMasterList(
      itemMasterList: data.itemMasterList,
    );
    return unit;
  }*/

  @override
  Future<List<ItemMasterModel>> fetchAllItemMasterListFromDb({
    required int offSet,
  }) async {
    final List<Map<String, dynamic>> data = await itemMasterDataSource
        .fetchAllItemMasterList(offSet: offSet);
    final List<ItemMasterModel> mappedDataList =
        data.map(ItemMasterModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<ItemMasterModel>> fetchSearchItemMasterListFromDb({
    required String searchText,
  }) async {
    final List<Map<String, dynamic>> data = await itemMasterDataSource
        .fetchSearchItemMasterList(searchText: searchText);
    final List<ItemMasterModel> mappedDataList =
        data.map(ItemMasterModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<ItemMasterModel>> fetchFilterItemMasterListFromDb(
    ItemMasterFilterModel model,
  ) async {
    final List<Map<String, dynamic>> data = await itemMasterDataSource
        .fetchFilterItemMasterList(itemMasterFilterModel: model);
    final List<ItemMasterModel> mappedDataList =
        data.map(ItemMasterModel.fromMap).toList();
    return mappedDataList;
  }

  ///rfidListing

  @override
  Future<Unit> insertRfidListingData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/rfid_listing.json',
    );
    final RfidIdListResponseModel data = RfidIdListResponseModel.fromJson(
      jsonString,
    );
    // await itemMasterDataSource.clearRfidListingData();
    await itemMasterDataSource.insertRfidListing(
      rfidIdModelList: [], //change this [] and connect with api called data
    );
    return unit;
  }

  @override
  Future<List<RfidIdModel>> fetchItemMasterRfidListFromDb({required int itemId}) async {
    final List<Map<String, dynamic>> data =
        await itemMasterDataSource.fetchItemMasterRfidList(itemId: itemId);
    final List<RfidIdModel> mappedDataList =
        data.map(RfidIdModel.fromMap).toList();
    return mappedDataList;
  }



  @override
  Future<Unit> insertSerialNumberListData() async {
    // final String jsonString = await rootBundle.loadString(
    //   'assets/data/serial_number.json',
    // );
    // final SerialNumberListResponseModel data =
    //     SerialNumberListResponseModel.fromJson(jsonString);
    // await itemMasterDataSource.insertCommonSerialNumberList(
    //   serialNumberList: data.serialNumberList,
    // );
    return unit;
  }

  @override
  Future<Unit> insertItemGroupListData() async {
    // final String jsonString = await rootBundle.loadString(
    //   'assets/data/item_group.json',
    // );
    // final ItemGroupListResponseModel data = ItemGroupListResponseModel.fromJson(
    //   jsonString,
    // );
    // await itemMasterDataSource.insertCommonItemGroupList(
    //   itemGroupList: data.itemGroup,
    // );
    return unit;
  }

  @override
  Future<Unit> insertRfidBasedOnItemId({required List<String> rfidList, required int itemId}) async {
    await itemMasterDataSource.insertRfidBasedOnItemId(rfidList: rfidList, itemId: itemId);
    return unit;
  }

  @override
  Future<List<String>> fetchAllRfidFromDb() async {
    final List<String> data = await itemMasterDataSource.fetchAllRfidFromDb();
    return data;
  }
}
