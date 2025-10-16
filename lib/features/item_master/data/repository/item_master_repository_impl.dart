import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/error/error_codes.dart';
import '../../../../core/service/network/connectivity_manager.dart';
import '../../../../core/service/other_service/file_logger_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domin/entities/item_master_common_entity_model.dart';
import '../../domin/entities/item_master_filter_entity_model.dart';
import '../../domin/entities/item_master_rfid_view_entity_model.dart';
import '../../domin/failures/item_master_failures.dart';
import '../../domin/repository/item_master_repository.dart';
import '../data_source/item_master_local_data_source.dart';
import '../data_source/item_master_remote_data_source.dart';
import '../exception/item_master_exceptions.dart';
import '../models/item_master_common_response_model.dart';
import '../models/item_master_filter_model.dart';
import '../models/rfid_listing_common_response_model.dart';

class ItemMasterRepositoryImpl implements ItemMasterRepository {
  ItemMasterRepositoryImpl({
    required this.itemMasterLocalDataSource,
    required this.itemMasterRemoteDataSource,
    required this.appLogger,
    required this.fileLoggerService,
    required this.connectivityManager
  });

  final ItemMasterLocalDataSource itemMasterLocalDataSource;
  final ItemMasterRemoteDataSource itemMasterRemoteDataSource;
  final AppLogger appLogger;
  final FileLoggerService fileLoggerService;
  final ConnectivityManager connectivityManager;

  //ErrorFunction
  Either<ItemMasterFailures, T> _errorFun<T>({
    required String errorCode,
    required String message,
    required ItemMasterExceptions exceptions,
  }) {
    appLogger.error(errorCode);
    fileLoggerService.logToFile(logText: errorCode, pageType: message);

    switch (exceptions) {
      case ItemMasterServerException():
        return left(ItemMasterServerFailure(code: errorCode, message: message));
      case ItemMasterGetAllDbException():
        return left(
          ItemMasterGetAllDbFailure(code: errorCode, message: message),
        );
      case ItemMasterInsertException():
        return left(
          ItemMasterGetAllDbFailure(code: errorCode, message: message),
        );
    }
  }

  @override
  Future<Either<ItemMasterFailures, Unit>> insertItemMaster() async {

    try {
      if (await connectivityManager.isConnected) {
        await itemMasterRemoteDataSource.getAllItemMasterPurchase();
        await itemMasterRemoteDataSource.getAllItemMasterPms();
      }
      //await itemMasterLocalDataSource.insertData();
      // await itemMasterRemoteDataSource.getAllItemMaster(); ///api call and insert to db for item master
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.itemMasterLoadFail,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.itemMasterLoadFail,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    }
  }

  @override
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>>
  fetchAllItemMasterList({required int offSet}) async {
    // try {
      List<ItemMasterModel> itemMasterList = await itemMasterLocalDataSource
          .fetchAllItemMasterListFromDb(offSet: offSet);
      return right(itemMasterList);
  /*  } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    }*/
  }

  @override
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>>
  fetchSearchItemMasterList({required String searchText}) async {
    try {
      List<ItemMasterModel> itemMasterList = await itemMasterLocalDataSource
          .fetchSearchItemMasterListFromDb(searchText: searchText);
      return right(itemMasterList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    }
  }

  @override
  Future<Either<ItemMasterFailures, List<ItemMasterEntity>>>
  fetchFilterItemMasterList(ItemMasterFilterEntity data) async {
    try {
      final ItemMasterFilterModel model = ItemMasterFilterModel.fromEntity(
        data,
      );
      List<ItemMasterModel> itemMasterList = await itemMasterLocalDataSource
          .fetchFilterItemMasterListFromDb(model);

      return right(itemMasterList);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    }
  }

  @override
  Future<Either<ItemMasterFailures, Unit>> insertRfidListing() async {
    try {
      await itemMasterLocalDataSource.insertRfidListingData();
      return right(unit);
    } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.itemMasterLoadFail,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.itemMasterLoadFail,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    }
  }

  @override
  Future<Either<ItemMasterFailures, List<ItemMasterRfidViewEntity>>>
  fetchItemMasterRfidList({required int itemId}) async {
    // try {
    final List<RfidIdModel> entities =
        await itemMasterLocalDataSource.fetchItemMasterRfidListFromDb(itemId: itemId);
    final List<ItemMasterRfidViewEntity> mappedItems =
        entities.map((e) => e.toEntity()).toList();
    return right(mappedItems);

    // return right(entities.cast<ItemMasterRfidViewEntity>());
    /*   } on DatabaseException catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    } catch (e) {
      return _errorFun(
        errorCode: AppErrorCodes.grnDbSaveError,
        message: e.toString(),
        exceptions: ItemMasterGetAllDbException(),
      );
    }*/
  }

  @override
  Future<Either<ItemMasterFailures, Unit>>
  insertCommonSerialNumberList() async {
    await itemMasterLocalDataSource.insertSerialNumberListData();
    return right(unit);
  }

  @override
  Future<Either<ItemMasterFailures, Unit>> insertItemGroupNumberList() async {
    await itemMasterLocalDataSource.insertItemGroupListData();
    return right(unit);
  }

  @override
  Future<Either<ItemMasterFailures, Unit>> insertRfidListingBasedOnItemId({required List<String> rfidList, required int itemId}) async {
    await itemMasterLocalDataSource.insertRfidBasedOnItemId(rfidList: rfidList, itemId: itemId);
    return right(unit);
  }

  @override
  Future<Either<ItemMasterFailures, List<String>>> fetchAllRfidFromDb() async {
    final List<String> data = await itemMasterLocalDataSource.fetchAllRfidFromDb();
    return right(data);
  }
}
