import 'package:encrypt_shared_preferences/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../../config/network_config.dart';
import '../../../features/item_master/data/data_source/item_master_local_data_source.dart';
import '../../../features/item_master/data/data_source/item_master_remote_data_source.dart';
import '../../../features/item_master/data/repository/item_master_repository_impl.dart';
import '../../../features/item_master/domin/repository/item_master_repository.dart';
import '../../../features/item_master/domin/usecases/fetch_all_rfid_list_db_usecase.dart';
import '../../../features/item_master/domin/usecases/fetch_serial_number_usecase.dart';
import '../../../features/item_master/domin/usecases/insert_item_group_usecase.dart';
import '../../../features/item_master/domin/usecases/insert_rfid_basedon_item_id_usecase.dart';
import '../../../features/item_master/domin/usecases/item_master_apply_filter_usecase.dart';
import '../../../features/item_master/domin/usecases/item_master_fetch_all_data.dart';
import '../../../features/item_master/domin/usecases/item_master_fetch_search_data.dart';
import '../../../features/item_master/domin/usecases/item_master_insert_use_case.dart';
import '../../../features/item_master/domin/usecases/item_master_rfid_listing_insert_use_case.dart';
import '../../../features/item_master/domin/usecases/item_master_rfid_view_fetch_use_case.dart';
import '../../../features/item_master/presentation/bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../../../features/item_master/presentation/bloc/rfid_view_bloc/rfid_view_bloc.dart';
import '../../service/db_service/table_data_manipulation/item_master_data_processor.dart';
import '../../service/network/connectivity_manager.dart';
import '../../service/other_service/file_logger_service.dart';
import '../../utils/app_logger.dart';
import '../service_locator.dart';

void itemMasterInjections() {
  sl
    ..registerSingleton<ItemMasterDataProcessor>(
      ItemMasterDataProcessorImpl(db: sl<Database>()),
    )
    //local data source
    ..registerSingleton<ItemMasterLocalDataSource>(
      ItemMasterLocalDataSourceImpl(
        itemMasterDataSource: sl<ItemMasterDataProcessor>(),
      ),
    )
    ///remote data source
    ..registerSingleton<ItemMasterRemoteDataSource>(
      ItemMasterRemoteDataSourceImpl(
        appNetworkClient: sl<AppNetworkClient>(),
        encryptedSharedPreferences: sl<EncryptedSharedPreferences>(),
        itemMasterDataProcessor: sl<ItemMasterDataProcessor>(),
      ),
    )
    ///repository
    ..registerSingleton<ItemMasterRepository>(
      ItemMasterRepositoryImpl(
        appLogger: sl<AppLogger>(),
        fileLoggerService: sl<FileLoggerService>(),
        itemMasterLocalDataSource: sl<ItemMasterLocalDataSource>(),
        itemMasterRemoteDataSource: sl<ItemMasterRemoteDataSource>(), connectivityManager:  sl<ConnectivityManager>(),
      ),
    )
    ///useCause
    ..registerSingleton<ItemMasterInsertUseCase>(
      ItemMasterInsertUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ..registerSingleton<FetchAllDataItemMasterUseCase>(
      FetchAllDataItemMasterUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ..registerSingleton<ItemMasterApplyFilterUseCase>(
      ItemMasterApplyFilterUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ..registerSingleton<ItemMasterRfidListingInsertUseCase>(
      ItemMasterRfidListingInsertUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ..registerSingleton<FetchItemMasterRfidListingUseCase>(
      FetchItemMasterRfidListingUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ///common tables use case
    ..registerSingleton<FetchSerialNumberUseCase>(
      FetchSerialNumberUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ..registerSingleton<FetchSearchDataItemMasterUseCase>(
      FetchSearchDataItemMasterUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ..registerSingleton<ItemGroupInsertUseCase>(
      ItemGroupInsertUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ..registerSingleton<ItemMasterRfidListingInsertBasedOnItemIdUseCase>(
      ItemMasterRfidListingInsertBasedOnItemIdUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ..registerSingleton<FetchAllRfidListDbUseCase>(
      FetchAllRfidListDbUseCaseImpl(
        itemMasterRepository: sl<ItemMasterRepository>(),
      ),
    )
    ///bloc
    ..registerSingleton<ItemMasterBloc>(
      ItemMasterBloc(
        itemMasterInsertUseCase: sl<ItemMasterInsertUseCase>(),
        itemMasterApplyFilterUseCase: sl<ItemMasterApplyFilterUseCase>(),
        fetchAllDataItemMasterUseCase: sl<FetchAllDataItemMasterUseCase>(),
        fetchSerialNumberUseCase: sl<FetchSerialNumberUseCase>(),
        fetchSearchDataItemMasterUseCase: sl<FetchSearchDataItemMasterUseCase>(),
        itemGroupInsertUseCase: sl<ItemGroupInsertUseCase>(),
        itemMasterRfidListingInsertBasedOnItemIdUseCase: sl<ItemMasterRfidListingInsertBasedOnItemIdUseCase>(),
        fetchAllRfidListDbUseCase: sl<FetchAllRfidListDbUseCase>(),
      ),
    )
    ..registerSingleton<RfidViewBloc>(
      RfidViewBloc(
        itemMasterRfidListingInsertUseCase:
            sl<ItemMasterRfidListingInsertUseCase>(),
        fetchItemMasterRfidListingUseCase:
            sl<FetchItemMasterRfidListingUseCase>(),
      ),
    );
}
