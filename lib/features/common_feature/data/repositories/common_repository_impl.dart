import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/constants/api_constant.dart';
import '../../../../core/error/error_codes.dart';
import '../../../../core/service/db_service/table_data_manipulation/failed_common_api_local_data_source.dart';
import '../../../../core/service/db_service/table_data_manipulation/meta_local_data_source.dart';
import '../../../../core/service/network/connectivity_manager.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../bagging_tagging_confirmtaion/domain/usecase/get_all_bagging_item_details_usecase.dart';
import '../../../consumption/data/models/equipment_fetch_api_response_model.dart';
import '../../../consumption/data/models/equipment_list_model.dart';
import '../../../good_receipts/data/models/goods_receipt_purchase_item_detail_model.dart';
import '../../../good_receipts/data/models/goods_receipt_transaction_item_detail_model.dart';
import '../../../good_receipts/data/models/pending_po_split_location_model.dart';
import '../../../good_receipts/domain/entities/split_location_entity.dart';
import '../../../item_master/data/models/ports_list_common_response_model.dart';
import '../../domain/entities/default_location_entity.dart';
import '../../domain/entities/equipment_list_entity.dart';
import '../../domain/entities/item_category_entity.dart';
import '../../domain/entities/item_master_common_entity_model.dart';
import '../../domain/entities/item_section_entity.dart';
import '../../domain/entities/item_sub_section_entity.dart';
import '../../domain/entities/port_entity.dart';
import '../../domain/entities/quality_entity.dart';
import '../../domain/entities/stock_location_entity.dart';
import '../../domain/entities/storage_location_entity.dart';
import '../../domain/failures/common_failures.dart';
import '../../domain/repositories/common_repository.dart';
import '../../domain/usecase/insert_pending_po_split_location_data_usecase.dart';
import '../data_source/common_local_data_source.dart';
import '../data_source/common_network_data_source.dart';
import '../exceptions/common_exceptions.dart';
import '../model/admin_structure_model.dart';
import '../model/default_location_model.dart';
import '../model/failed_common_api_model.dart';
import '../model/fetch_imdg_class_model.dart';
import '../model/item_category_model.dart';
import '../model/item_master_common_response_model.dart';
import '../model/item_section_model.dart';
import '../model/item_sub_section_model.dart';
import '../model/quality_list_model.dart';
import '../model/stock_location_model.dart';
import '../model/storage_location_model.dart';
import '../model/vessel_model.dart';

class CommonRepositoryImpl implements CommonRepository {
  CommonRepositoryImpl({
    required this.commonLocalDataSource /*,required this.appLogger,required this.fileLoggerService*/,
    required this.commonNetworkDataSource,
    required this.connectivityManager,
    required this.failedCommonApiLocalDataSource,
    required this.metaLocalDataSource,
  });

  final CommonLocalDataSource commonLocalDataSource;
  final CommonNetworkDataSource commonNetworkDataSource;
  final ConnectivityManager connectivityManager;
  final FailedCommonApiLocalDataSource failedCommonApiLocalDataSource;
  final MetaLocalDataSource metaLocalDataSource;

  /*  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;*/

  @override
  Future<Either<CommonFailures, List<ItemMasterEntity>>>
  fetchItemsByStorageLocationId({required int id}) async {
    List<ItemMasterModel> itemMasterList = await commonLocalDataSource
        .fetchItemDetailsBasedOnStorageLocationId(id: id);
    return right(itemMasterList);
  }

  @override
  Future<Either<CommonFailures, List<ItemMasterEntity>>> fetchItemsByItemId({
    required int id,
  }) async {
    List<ItemMasterModel> itemMasterList = await commonLocalDataSource
        .fetchItemDetailsBasedOnItemId(id: id);
    return right(itemMasterList);
  }

  @override
  Future<Either<CommonFailures, List<EquipmentListEntity>>>
  getAllEquipmentList() async {
    try {
      final List<ConsumptionEquipmentListModel> equipmentListModel =
      await commonLocalDataSource.getAllEquipmentList();
      final List<EquipmentListEntity> list =
      equipmentListModel.map((e) => e.toEntity()).toList();

      return right(list);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.equipmentListLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.equipmentListLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, List<EquipmentListEntity>>>
  getEquipmentChildrenList(String parentId) async {
    try {
      final List<ConsumptionEquipmentListApiModel> equipmentListModel =
      await commonLocalDataSource.getEquipmentChildrenList();
      final List<EquipmentListEntity> list =
      equipmentListModel.map((e) => e.toEntity()).toList();

      return right(list);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.equipmentListLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.equipmentListLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }


  //ItemCategory

  @override
  Future<Either<CommonFailures, List<ItemCategoryEntity>>>
  fetchAllItemCategory() async {
    try {
      final List<ItemCategoryModel> itemCategoryModel =
      await commonNetworkDataSource.fetchAllItemCategory();

      final List<ItemCategoryEntity> list =
      itemCategoryModel.map((e) => e.toEntity()).toList();

      return right(list);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemCategoryLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemCategoryLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> insertItemCategory() async {
    // try {
    await commonNetworkDataSource.insertItemCategory();
    return right(unit);
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.fetchItemCategoryDbWriteFail,
    //     message: e.toString(),
    //     exceptions: EquipmentListInsertDetailsException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.fetchItemCategoryDbWriteFail,
    //     message: e.toString(),
    //     exceptions: EquipmentListInsertDetailsException(),
    //   );
    // }
  }

  //ItemSection

  @override
  Future<Either<CommonFailures, Unit>> insertItemSection() async {
    // try {
    await commonNetworkDataSource.insertItemSection();
    return right(unit);
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.fetchItemSectionDbWriteFail,
    //     message: e.toString(),
    //     exceptions: EquipmentListInsertDetailsException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.fetchItemSectionDbWriteFail,
    //     message: e.toString(),
    //     exceptions: EquipmentListInsertDetailsException(),
    //   );
    // }
  }

  @override
  Future<Either<CommonFailures, List<ItemSectionEntity>>>
  fetchAllItemSection() async {
    try {
      final List<ItemSectionModel> itemSectionModel =
      await commonNetworkDataSource.fetchAllItemSection();
      final List<ItemSectionEntity> list =
      itemSectionModel.map((e) => e.toEntity()).toList();

      return right(list);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  // Item sub section

  @override
  Future<Either<CommonFailures, List<ItemSubSectionEntity>>>
  fetchAllItemSubSection() async {
    try {
      final List<ItemSubSectionModel> itemSubSectionModel =
      await commonNetworkDataSource.fetchAllItemSubSection();
      final List<ItemSubSectionEntity> list =
      itemSubSectionModel.map((e) => e.toEntity()).toList();

      return right(list);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSubSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSubSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> insertItemSubSection() async {
    // try {
    await commonNetworkDataSource.insertItemSubSection();
    return right(unit);
    // } on DatabaseException catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.fetchItemSubSectionDbWriteFail,
    //     message: e.toString(),
    //     exceptions: EquipmentListInsertDetailsException(),
    //   );
    // } catch (e) {
    //   return _errorFun(
    //     errorCode: AppErrorCodes.fetchItemSubSectionDbWriteFail,
    //     message: e.toString(),
    //     exceptions: EquipmentListInsertDetailsException(),
    //   );
    // }
  }

  @override
  Future<Either<CommonFailures, Unit>> insertStorageLocationList() async {
    try {
      // if (await connectivityManager.isConnected) {
      try {
        var vesselData =
        await commonLocalDataSource.getAllVesselSpecification();
        if (vesselData.isEmpty) {
          return right(unit);
        }

        await commonNetworkDataSource.insertStorageLocationData(
          pageNo: 0,
          referenceId: vesselData.first.siteTypeID,
          referenceTypeId: vesselData.first.vesselRegID,
        );
      } catch (e, stackTrace) {
        return _errorFun(
          errorCode: AppErrorCodes.storageLocationListDbWriteFail,
          message: e.toString(),
          exceptions: ServerException(),
          stackTrace: stackTrace,
        );
        // }
        // } else {
        //   await commonLocalDataSource.insertStorageLocationData();
      }
      return right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.storageLocationListDbWriteFail,
        message: e.toString(),
        exceptions: StorageLocationInsertException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.storageLocationListDbWriteFail,
        message: e.toString(),
        exceptions: StorageLocationInsertException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, List<StorageLocationEntity>>>
  getStorageLocationByParentId(int parentId) async {
    try {
      List<StorageLocationModel> storageLocationModelList =
      await commonLocalDataSource.getStorageLocationByParentId(parentId);
      List<StorageLocationEntity> storageLocationEntityList =
      storageLocationModelList.map((e) => e.toEntity()).toList();
      return right(storageLocationEntityList);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.storageLocationListLoadFail,
        message: e.toString(),
        exceptions: StorageLocationGetLocationsByIdFailure(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.storageLocationListLoadFail,
        message: e.toString(),
        exceptions: StorageLocationGetLocationsByIdFailure(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, List<QualityEntity>>>
  fetchAllQualityList() async {
    try {
      final List<QualityListData> qualityModel =
      await commonLocalDataSource.fetchQualityList();
      final List<QualityEntity> list =
      qualityModel.map((e) => e.toEntity()).toList();
      return right(list);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSubSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSubSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> fetchCommonPortListFromApi() async {
    try {
      // MetaLocalParams metaLocalParams = MetaLocalParams(
      //   vesselId: AppConstant.vesselId,
      //   code: ApiConstant.fetchStorageLocation,
      // );

      // Check if this is the first time calling API
      // String? lastModifiedTimeStamp = await metaLocalDataSource
      //     .fetchLastCallTime(metaLocalParams: metaLocalParams);

      // if (lastModifiedTimeStamp == null) {
      // First-time fetch: fetch all pages
      // int pageNo = 1;
      // bool hasMorePages = true;

      // while (hasMorePages) {
      final PortListResponseModel portListModel = await commonNetworkDataSource
          .fetchPort(
        queryParameters: {
          "isPaginationRequired": false,
          "pageNext": 1,
          "pageOffset": 1,
        },
      );

      await commonLocalDataSource.insertCommonPortList(
        portModelList: portListModel.portList ?? [],
      );

      // if ((portListModel.totalCount ?? 0) <=
      //     pageNo * AppConstant.pageSize) {
      //   hasMorePages = false;
      // } else {
      //   pageNo++;
      // }
      // }

      // Mark last fetch timestamp
      // await metaLocalDataSource.insertApiLastModifiedDate(
      //   metaLocalParams: metaLocalParams,
      // );
      // }

      // Handle any failed API requests separately (do not change pageNo)
      List<FailedCommonApiModel> failedRequests =
      await failedCommonApiLocalDataSource.fetchApiListViaEndPoint(
        endPoint: ApiConstant.fetchPort,
      );

      for (var request in failedRequests) {
        String stored = request.apiPayLoad.toString().trim();
        String jsonRequestString = AppUtils.convertStoredApiRequestToJsonString(
          stored,
        );
        final Map<String, dynamic> params = jsonDecode(jsonRequestString);

        await failedCommonApiLocalDataSource.updateExecutedAt(id: request.id);

        // Retry the failed request
        await commonNetworkDataSource.fetchPort(
          queryParameters: {
            "isPaginationRequired": params["isPaginationRequired"],
            "pageNext": params["pageNext"],
            "pageOffset": params["pageOffset"],
          },
        );

        // Optional: throttle
        await Future.delayed(const Duration(seconds: 1));
      }

      return right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSubSectionLoadFail,
        message: e.toString(),
        exceptions: PortException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSubSectionLoadFail,
        message: e.toString(),
        exceptions: PortException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, List<PortEntity>>> fetchPortFromDb({
    required String query,
  }) async {
    try {
      final List<PortModel> portModelList = await commonLocalDataSource
          .getAllPortsFromDb(query: query);
      final List<PortEntity> portEntityList =
      portModelList.map((e) => e.toEntity()).toList();

      return right(portEntityList);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSubSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSubSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  Either<CommonFailures, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required CommonExceptions exceptions,
    required StackTrace stackTrace,
  }) {
    switch (exceptions) {
      case PortException():
        return left(PortFailure(code: errorCode, message: message));
      case EquipmentListServerException():
        return left(EquipmentServerFailure(code: errorCode, message: message));
      case EquipmentListInsertDetailsException():
        return left(
          EquipmentListInsertDetailsExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case EquipmentListGetAllDetailsException():
        return left(
          EquipmentListGetAllDetailsExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case FetchImdgInsertAllDetailsException():
        return left(
          FetchImdgInsertAllDetailsExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case FetchImdgFetchAllDetailsException():
        return left(
          FetchImdgFetchAllDetailsExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case StorageLocationInsertException():
        return left(
          StorageLocationInsertExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case StorageLocationGetLocationsByIdFailure():
        return left(
          FetchStorageLocationsExceptionFailure(
            code: errorCode,
            message: message,
          ),
        );
      case InsertQualityItemException():
        return left(InsertQualitytFailure(code: errorCode, message: message));
      case ServerException():
        return left(ServerFailure(code: "", message: message));
      case QualityListItemDbException():
        return left(QualityListDbFailure(code: errorCode, message: message));

      case QualityListNetworkException():
        return left(
          QualityListNetworkFailure(code: errorCode, message: message),
        );

      case QualityListUnknownException():
        return left(
          QualityListUnknownFailure(code: errorCode, message: message),
        );
    }
  }

  @override
  Future<Either<CommonFailures, List<CommonStockLocationEntity>>>
  fetchStockLocationFromAPI() async {
    try {
      /// fetching 'stock location' from API
      final List<CommonStockLocationModel> stockLocationModel =
      await commonNetworkDataSource.fetchStockLocation();

      /// model to entity conversion
      final List<CommonStockLocationEntity> stockLocationList =
      stockLocationModel.map((e) => e.toEntity()).toList();

      ///storing response to DB
      ///only required fields from response are stored in DB
      await commonLocalDataSource.insertStockLocationData(
        commonStockLocationModelList: stockLocationModel,
      );

      return right(stockLocationList);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, List<DefaultLocationEntity>>>
  fetchDefaultLocationFromAPI() async {
    try {
      /// fetching 'default location' from API
      final List<DefaultLocationModel> defaultLocationModel =
      await commonNetworkDataSource.fetchDefaultLocation();

      /// model to entity conversion
      final List<DefaultLocationEntity> defaultLocationList =
      defaultLocationModel.map((e) => e.toEntity()).toList();

      ///storing response to DB
      await commonLocalDataSource.insertDefaultLocationData(
        defaultLocationModelList: defaultLocationModel,
      );

      return right(defaultLocationList);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> getSplitLocationData() async {
    try {
      // final SplitLocationModel? splitLocationModel =
      //     await commonNetworkDataSource.getSplitLocationData();
      //
      // if (splitLocationModel != null && splitLocationModel.reportData != null) {
      //   debugPrint("inside the splitLocationModel **************");
      //   await commonLocalDataSource.insertSplitLocationData(
      //     splitLocationData: splitLocationModel.reportData!,
      //   );
      // }

      return right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> getAllItemsFromApi() async {
    try {
      final GoodsReceiptTransactionItemDetailResponseModel?
      itemDetailResponseModel = await commonNetworkDataSource.getAllItems();

      if (itemDetailResponseModel != null &&
          itemDetailResponseModel.reportData != null &&
          itemDetailResponseModel.reportData!.isNotEmpty) {
        debugPrint(
          "itemDetailResponseModel.reportData : ${itemDetailResponseModel
              .reportData?.length}",
        );
        debugPrint(
          "itemDetailResponseModel.reportData!.first.grnDtId : ${itemDetailResponseModel
              .reportData!.first.grnDtId}",
        );
      }

      return right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, List<SplitLocationEntity>>>
  getSplitLocationDataFromDbByGrn({
    required GetItemSplitLocationDataParams getSplitLocationDataParams,
  }) async {
    try {
      // final List<SplitLocationData> splitLocationData =
      //     await commonLocalDataSource.getSplitLocationDataFromDbByGrn(
      //       getSplitLocationDataParams: getSplitLocationDataParams,
      //     );
      // return right(
      //   splitLocationData.map((element) => element.toEntity()).toList(),
      // );
      return right([]);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> getAllVesselSpecification() async {
    try {
      final VesselModelResponse? vesselModelResponse =
      await commonNetworkDataSource.getAllVesselSpecification();

      await commonLocalDataSource.insertVesselSpecification(
        vesselModel: vesselModelResponse?.data ?? [],
      );
      return Right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> getAllPoItems() async {
    try {
      debugPrint("inside the getAllPoItems *********************");
      final GoodsReceiptPurchaseItemDetailResponseModel?
      itemDetailResponseModel = await commonNetworkDataSource.getAllPoItems();
      debugPrint(
        "itemDetailResponseModel.reportData : ${itemDetailResponseModel
            ?.reportData?.length}",
      );
      if (itemDetailResponseModel != null &&
          itemDetailResponseModel.reportData != null &&
          itemDetailResponseModel.reportData!.isNotEmpty) {
        debugPrint(
          "itemDetailResponseModel.reportData : ${itemDetailResponseModel
              .reportData?.length}",
        );
        await commonLocalDataSource.clearPoItemsData();
        await commonLocalDataSource.insertPoItemsData(
          itemsDetailData: itemDetailResponseModel.reportData!,
        );
      }

      return right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> insertPendingPoSplitLocationData({
    required InsertPendingPoSplitLocationDataParams
    insertPendingPoSplitLocationDataParams,
  }) async {
    try {
      List<PendingPoSplitLocationModel> pendingPoSplitLocationModelList =
      insertPendingPoSplitLocationDataParams.splitLocationList
          .map(PendingPoSplitLocationModel.fromEntity)
          .toList();
      await commonLocalDataSource.insertPendingPoSplitLocationDataList(
        pendingPoSplitLocationModelList: pendingPoSplitLocationModelList,
      );
      return right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchImdgListDbWriteFail,
        message: e.toString(),
        exceptions: FetchImdgInsertAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchImdgListDbWriteFail,
        message: e.toString(),
        exceptions: FetchImdgInsertAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> getQualityList() async {
    try {
      final response = await commonNetworkDataSource.getQualityList();
      if (response != null &&
          response.reportData != null &&
          response.reportData!.isNotEmpty) {
        await commonLocalDataSource.insertQualityListItems(
          qualityListData: response.reportData!,
        );
      }
      return right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.purchaseOrderListFetchFailed,
        message: e.toString(),
        exceptions: QualityListItemDbException(),
        stackTrace: stackTrace,
      );
    } on DioException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: QualityListNetworkException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: QualityListUnknownException(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Either<CommonFailures, Unit>> getAllAdminStructure() async {
    try {
      final AdminStructureModelResponse? apiResponseModel =
      await commonNetworkDataSource.getAllAdminStructureData();

      await commonLocalDataSource.insertAdminStructure(
        list: apiResponseModel?.data ?? [],
      );
      return Right(unit);
    } on DatabaseException catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      return _errorFun(
        errorCode: AppErrorCodes.fetchItemSectionLoadFail,
        message: e.toString(),
        exceptions: EquipmentListGetAllDetailsException(),
        stackTrace: stackTrace,
      );
    }
  }
}
