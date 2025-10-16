import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config/default_api_payload.dart';
import '../../../../config/network_config.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../../core/service/db_service/table_data_manipulation/consumption_transaction_data_processor.dart';
import '../models/consumption_equipment_list_fetch_api_response_model.dart';
import '../models/consumption_transaction_fetch_api_response_model.dart';
import '../models/consumption_transaction_save_api_request_model.dart';
import '../models/consumption_transaction_save_api_response_model.dart';
import '../models/equipment_fetch_api_response_model.dart';

abstract interface class ConsumptionTransactionRemoteDataSource {
  Future<void> getAllConsumptionTransactionListFromApi();

  Future<ConsumptionTransactionSaveResponseModel?>
  saveConsumptionTransactionListFromApi({
    required ConsumptionTransactionSaveRequestModel savePayload,
  });

  ///equipment
  Future<void> getAllEquipmentListFromApi();

  ///location
  Future<void> getAllLocationListFromApi();
}

class ConsumptionTransactionRemoteDataSourceImpl
    implements ConsumptionTransactionRemoteDataSource {
  ConsumptionTransactionRemoteDataSourceImpl({
    required this.appNetworkClient,
    required this.encryptedSharedPreferences,
    required this.consumptionTransactionDataProcessor,
  });

  final AppNetworkClient appNetworkClient;
  final EncryptedSharedPreferences encryptedSharedPreferences;
  final ConsumptionTransactionDataProcessor consumptionTransactionDataProcessor;

  @override
  Future<void> getAllConsumptionTransactionListFromApi() async {
    var lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsConsumptionTransaction,
    );

    var filters = [
      FilterCondition(
        field: "TransactionTypeCode",
        operator: "in",
        value: "ISSUE",
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

    final data = ConsumptionTransactionFetchApiResponseModel.fromJson(response);

    if (data.reportData != null && data.reportData!.isNotEmpty) {
      final List<ConsumptionTrnFetchApiModel> consumptionTransactionList =
          data.reportData!.toList();
      await consumptionTransactionDataProcessor
          .insertConsumptionTransactionList(
            consumptionTransactionList: consumptionTransactionList,
          );
    }
  }

  @override
  Future<ConsumptionTransactionSaveResponseModel?>
  saveConsumptionTransactionListFromApi({
    required ConsumptionTransactionSaveRequestModel savePayload,
  }) async {
    log("Save Consumption url ----------->  ${ApiConstant.stockTransaction}");
    final response = await appNetworkClient.post(
      ApiConstant.stockTransaction,
      data: savePayload.toJson(),
    );
    log("Save Consumption response ----------->  ${jsonEncode(response)}");
    return ConsumptionTransactionSaveResponseModel.fromJson(response);
  }

  @override
  Future<void> getAllLocationListFromApi() async {
    var lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsLocationSearchList,
    );

    final response = await appNetworkClient.get(ApiConstant.fetchLocation);

    final data = LocationListApiModel.fromJson(response);

    if (data.locationList.isNotEmpty) {
      await consumptionTransactionDataProcessor.insertLocationList(
        consumptionLocationList: data.locationList,
      );
    }
  }

  @override
  Future<void> getAllEquipmentListFromApi() async {
    var lastModifiedTimeStamp = encryptedSharedPreferences.getString(
      AppEncryptedStorageKeys.lastModifiedTimeStampInsStockUpdateTransaction,
    );

    var filters = [
      FilterCondition(field: "ReferenceID", operator: "eq", value: 1),
      FilterCondition(field: "ReferenceSubID", operator: "eq", value: 13),
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
        Field(field: "VesselStructureId"),
        Field(field: "VesselComponentId"),
        Field(field: "componentName"),
        Field(field: "ParentEquipmentId"),
        Field(field: "code"),
        Field(field: "EquipmentTypeID"),
        Field(field: "EquipmentType"),
      ],

      filter: FilterGroup(logic: "and", filters: filters),
      sort: [],
      paginationParams: PaginationParams(pageNo: 1, pageSize: 100),
    );

    final response = await appNetworkClient.post(
      ApiConstant.fetchEquipment,
      data: apiPayload.toJson(),
    );

    final data = EquipmentFetchApiResponseModel.fromJson(response);

    if (data.reportData != null && data.reportData!.isNotEmpty) {
      final List<ConsumptionEquipmentListModel> equipmentList =
          data.reportData!.toList();
      await consumptionTransactionDataProcessor.insertEquipmentList(
        equipmentListModel: equipmentList,
      );
    }
  }
}
