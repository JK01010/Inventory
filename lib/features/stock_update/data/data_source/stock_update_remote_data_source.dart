import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config/default_api_payload.dart';
import '../../../../config/network_config.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../../core/service/db_service/table_data_manipulation/srock_update_datasource.dart';
import '../models/stocck_update_transaction_fetch_api_response_model.dart';
import '../models/stock_update_transaction_save_request_model.dart';
import '../models/stock_update_transaction_save_response_model.dart';

abstract interface class StockUpdateRemoteDataSource {
  Future<void> getAllStockUpdateTransactionList();

  Future<StockUpdateTransactionSaveResponseModel?>
  saveStockUpdateTransactionList({
    required StockUpdateTransactionSaveRequestModel savePayload,
  });
}

class StockUpdateRemoteDataSourceImpl implements StockUpdateRemoteDataSource {
  StockUpdateRemoteDataSourceImpl({
    required this.appNetworkClient,
    required this.encryptedSharedPreferences,
    required this.stockUpdateDataProcessor,
  });

  final AppNetworkClient appNetworkClient;
  final EncryptedSharedPreferences encryptedSharedPreferences;
  final StockUpdateDataProcessor stockUpdateDataProcessor;

  @override
  Future<void> getAllStockUpdateTransactionList() async {
    var lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsStockUpdateTransaction,
    );

    var filters = [
      FilterCondition(
        field: "TransactionTypeCode",
        operator: "in",
        value: "ADJUST",
      ),
      FilterCondition(
        field: "TDate",
        operator: "gte",
        value: "2025-03-01 12:27:08.2287994",
      ),
      FilterCondition(
        field: "TDate",
        operator: "lte",
        value: "2025-09-17 12:27:08.2287994",
      ),
    ];

    /* if (lastModifiedTimeStamp != null) {
      filters.add(
          FilterCondition(
            field: "ModifiedOn",
            operator: "gt",
            value: lastModifiedTimeStamp,
          )
      );
    }*/

    DefaultApiPayload apiPayload = DefaultApiPayload(
      fields: [
        Field(field: "TransactionDTID"),
        Field(field: "ItemID"),
        Field(field: "Quantity"),
        Field(field: "CurrentLocationID"),
        Field(field: "Remarks"),
        Field(field: "ModifiedOn"),
        Field(field: "TransactionHdID"),
        Field(field: "EquipmentID"),
      ],
      filter: FilterGroup(logic: "and", filters: filters),
      sort: [SortOption(field: "TDate", direction: "desc")],
      paginationParams: PaginationParams(pageNo: 1, pageSize: 100),
    );

    final response = await appNetworkClient.post(
      ApiConstant.stockTransactionHistory,
      data: apiPayload.toJson(),
    );

    final data = StockUpdateTransactionFetchApiResponseModel.fromJson(response);

    if (data.reportData != null && data.reportData!.isNotEmpty) {
      final List<StockUpdateTrnFetchApiModel> consumptionTransactionList =
          data.reportData!.toList();
      await stockUpdateDataProcessor.insertStockUpdateTransactionList(
        stockUpdateList: consumptionTransactionList,
      );
    }
  }

  @override
  Future<StockUpdateTransactionSaveResponseModel?>
  saveStockUpdateTransactionList({
    required StockUpdateTransactionSaveRequestModel savePayload,
  }) async {
    log("Save Stock update url ----------->  ${ApiConstant.stockTransaction}");
    final response = await appNetworkClient.post(
      ApiConstant.stockTransaction,
      data: savePayload.toJson(),
    );
    log("Save Stock update response -----------> ${jsonEncode(response)}");
    return StockUpdateTransactionSaveResponseModel.fromJson(response);
  }
}
