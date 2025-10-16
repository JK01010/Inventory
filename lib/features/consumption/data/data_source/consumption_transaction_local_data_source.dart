import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/service/db_service/table_data_manipulation/consumption_transaction_data_processor.dart';
import '../models/con_transaction_view_model.dart';
import '../models/consumption_location_model.dart';
import '../models/consumption_rfid_scanning_view_model.dart';
import '../models/consumption_taransaction_response_model.dart';
import '../models/equipment_list_model.dart';

abstract interface class ConsumptionTransactionLocalDataSource {
  Future<Unit> insertData();
  Future<Unit> multipleInsertData({
    required List<ConsumptionTransactionModel> list,
  });
  Future<Unit> singleInsertData({required ConsumptionTransactionModel model});

  Future<List<ConTransactionViewModel>> fetchAllConsumptionTransactionList();
  Future<List<ConTransactionViewModel>> searchConTransactionDataFromDb({
    required String searchText,
  });

  Future<List<ConTransactionViewModel>> fetchConsumptionTransactionListFilter(
    String itemName,
    String articleNo,
  );

  //rfid scanning page
  Future<List<ConsumptionRfidScanningViewModel>> fetchRfidScanningList({
    required List<String> rfId,
  });
  //stockUpdate add page

  //location
  Future<Unit> insertLocationListData();
  Future<List<ConsumptionLocationModel>> fetchAllConsumptionLocationList();

  //equipment
  Future<Unit> insertEquipmentListData();

  //fetch quantity
  Future<int> fetchRobConsumptionAdd({required int itemId});
}

class ConsumptionLocalDataSourceImpl
    implements ConsumptionTransactionLocalDataSource {
  const ConsumptionLocalDataSourceImpl({
    required this.consumptionTransactionDataSource,
  });
  final ConsumptionTransactionDataProcessor consumptionTransactionDataSource;

  @override
  Future<Unit> insertData() async {
    // final String jsonString = await rootBundle.loadString(
    //   'assets/data/consumption_transaction.json',
    // );
    // final ConsumptionTrnResponseModel data = ConsumptionTrnResponseModel.fromJson(jsonString);
    // await consumptionTransactionDataSource.clearConTransactionTable();
    // await consumptionTransactionDataSource.insertConsumptionTransactionList(consumptionTransactionList: data.consumptionTrn);
    return unit;
  }

  @override
  Future<List<ConTransactionViewModel>>
  fetchAllConsumptionTransactionList() async {
    final List<Map<String, dynamic>> data =
        await consumptionTransactionDataSource
            .fetchAllConTransactionListFromDb();
    final List<ConTransactionViewModel> mappedDataList =
        data.map(ConTransactionViewModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<ConTransactionViewModel>> searchConTransactionDataFromDb({
    required String searchText,
  }) async {
    final List<Map<String, dynamic>> data =
        await consumptionTransactionDataSource.searchConTransactionDataFromDb(
          searchText: searchText,
        );
    final List<ConTransactionViewModel> mappedDataList =
        data.map(ConTransactionViewModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<ConTransactionViewModel>> fetchConsumptionTransactionListFilter(
    String itemName,
    String articleNo,
  ) async {
    final List<Map<String, dynamic>> data =
        await consumptionTransactionDataSource.fetchConTransactionListForFilter(
          itemName,
          articleNo,
        );
    final List<ConTransactionViewModel> mappedDataList =
        data.map(ConTransactionViewModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<ConsumptionRfidScanningViewModel>> fetchRfidScanningList({
    required List<String> rfId,
  }) async {
    final List<Map<String, dynamic>> data =
        await consumptionTransactionDataSource.fetchAllRfidScanningListByRfIds(
          rfIds: rfId,
        );
    final List<ConsumptionRfidScanningViewModel> mappedDataList =
        data.map(ConsumptionRfidScanningViewModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<Unit> singleInsertData({
    required ConsumptionTransactionModel model,
  }) async {
    await consumptionTransactionDataSource
        .singleInsertConsumptionTransactionList(model: model);
    return unit;
  }

  @override
  Future<Unit> multipleInsertData({
    required List<ConsumptionTransactionModel> list,
  }) async {
    await consumptionTransactionDataSource
        .multipleInsertConsumptionTransactionList(
          consumptionTransactionList: list,
        );
    return unit;
  }

  //location

  @override
  Future<Unit> insertLocationListData() async {
    // final String jsonString = await rootBundle.loadString(
    //   'assets/data/location_list.json',
    // );
    // final ConsumptionLocationResponseModel data = ConsumptionLocationResponseModel.fromJson(jsonString);
    // await consumptionTransactionDataSource.clearLocationData();
    // await consumptionTransactionDataSource.insertLocationListToDB(consumptionLocationList: data.locationList);
    return unit;
  }

  @override
  Future<List<ConsumptionLocationModel>>
  fetchAllConsumptionLocationList() async {
    final List<Map<String, dynamic>> data =
        await consumptionTransactionDataSource.fetchAllLocationListFromDb();

    final List<ConsumptionLocationModel> locationList =
        data.map(ConsumptionLocationModel.fromMap).toList();
    return locationList;
  }

  @override
  Future<Unit> insertEquipmentListData() async {
    // final String jsonString = await rootBundle.loadString(
    //   'assets/data/equipment_list.json',
    // );
    // final EquipmentListResponseModel data = EquipmentListResponseModel.fromJson(
    //   jsonString,
    // );
    // await consumptionTransactionDataSource.clearEquipmentList();
    // await consumptionTransactionDataSource.insertEquipmentList(equipmentListModel: data.equipmentList);
    return unit;
  }

  @override
  Future<int> fetchRobConsumptionAdd({required int itemId}) async {
    int quantity = await consumptionTransactionDataSource
        .fetchRobConsumptionAdd(itemId: itemId);
    return quantity; //ROB
  }
}
