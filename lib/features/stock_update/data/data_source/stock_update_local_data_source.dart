import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/service/db_service/table_data_manipulation/srock_update_datasource.dart';
import '../models/stock_update_response_model.dart';
import '../models/stock_update_rfid_listing_view_model.dart';
import '../models/stock_update_view_model.dart';

abstract interface class StockUpdateLocalDataSource {
  Future<Unit> insertData();
  Future<Unit> singleInsertData({required StockUpdateModel model});
  Future<Unit> multipleInsertData({required List<StockUpdateModel> list});

  Future<List<StockUpdateViewModel>> fetchStockUpdateViewData({
    required int offSet,
  });
  Future<List<StockUpdateViewModel>> fetchSearchStockUpdateViewData({
    required String searchText,
  });
  Future<List<StockUpdateViewModel>> fetchStockUpdateViewDataForFilter({
    required String itemName,
    required String articleNo,
  });

  ///rdfId Scanning
  Future<List<StockUpdateRfidListingViewModel>> fetchRfidScanningList({
    required List<String> rfId,
  });
}

class StockUpdateLocalDataSourceImpl implements StockUpdateLocalDataSource {
  const StockUpdateLocalDataSourceImpl({required this.stockUpdateDataSource});

  final StockUpdateDataProcessor stockUpdateDataSource;

  @override
  Future<Unit> insertData() async {
    // final String jsonString = await rootBundle.loadString(
    //   'assets/data/stock_update.json',
    // );
    // final StockUpdateResponseModel data = StockUpdateResponseModel.fromJson(jsonString);
    // await stockUpdateDataSource. clearDataFromTable();
    // await stockUpdateDataSource.insertStockUpdateTransactionList(stockUpdateList: data.stockUpdates);
    return unit;
  }

  @override
  Future<Unit> singleInsertData({required StockUpdateModel model}) async {
    await stockUpdateDataSource.singleInsertStockUpdate(
      stockUpdateModel: model,
    );
    return unit;
  }

  @override
  Future<Unit> multipleInsertData({
    required List<StockUpdateModel> list,
  }) async {
    await stockUpdateDataSource.multipleInsertStockUpdate(
      stockUpdateList: list,
    );
    return unit;
  }

  @override
  Future<List<StockUpdateViewModel>> fetchStockUpdateViewData({
    required int offSet,
  }) async {
    final List<Map<String, dynamic>> data = await stockUpdateDataSource
        .fetchAllStockUpdateViewData(offSet: offSet);
    final List<StockUpdateViewModel> mappedDataList =
        data.map(StockUpdateViewModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<StockUpdateViewModel>> fetchSearchStockUpdateViewData({
    required String searchText,
  }) async {
    final List<Map<String, dynamic>> data = await stockUpdateDataSource
        .fetchSearchStockUpdateViewData(searchText: searchText);
    final List<StockUpdateViewModel> mappedDataList =
        data.map(StockUpdateViewModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<StockUpdateViewModel>> fetchStockUpdateViewDataForFilter({
    required String itemName,
    required String articleNo,
  }) async {
    final List<Map<String, dynamic>> data = await stockUpdateDataSource
        .fetchAllStockUpdateViewDataForFilter(
          itemName: itemName,
          articleNo: articleNo,
        );
    final List<StockUpdateViewModel> mappedDataList =
        data.map(StockUpdateViewModel.fromMap).toList();
    return mappedDataList;
  }

  @override
  Future<List<StockUpdateRfidListingViewModel>> fetchRfidScanningList({
    required List<String> rfId,
  }) async {
    final List<Map<String, dynamic>> data = await stockUpdateDataSource
        .fetchAllRfidScanningListByRfIds(rfIds: rfId);
    final List<StockUpdateRfidListingViewModel> mappedDataList =
        data.map(StockUpdateRfidListingViewModel.fromMap).toList();
    return mappedDataList;
  }
}
