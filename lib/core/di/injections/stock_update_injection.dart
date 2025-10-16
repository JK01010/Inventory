import 'package:encrypt_shared_preferences/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../config/network_config.dart';
import '../../../features/common_feature/data/data_source/common_local_data_source.dart';
import '../../../features/common_feature/domain/usecase/common_usecase.dart';
import '../../../features/stock_update/data/data_source/stock_update_local_data_source.dart';
import '../../../features/stock_update/data/data_source/stock_update_remote_data_source.dart';
import '../../../features/stock_update/data/repository_impl/stock_update_repository_impl.dart';
import '../../../features/stock_update/domin/repository/stock_update_repository.dart';
import '../../../features/stock_update/domin/usecases/stock_update_fetch_data_view_usecase.dart';
import '../../../features/stock_update/domin/usecases/stock_update_fetch_filter_date_view_usecase.dart';
import '../../../features/stock_update/domin/usecases/stock_update_fetch_search_data_view_usecase.dart';
import '../../../features/stock_update/domin/usecases/stock_update_multiple_insert_usecase.dart';
import '../../../features/stock_update/domin/usecases/stock_update_rfid_scanning_view_usecase.dart';
import '../../../features/stock_update/domin/usecases/stock_update_single_insert_usecase.dart';
import '../../../features/stock_update/domin/usecases/stock_update_table_insert_usecase.dart';
import '../../../features/stock_update/domin/usecases/stock_update_transaction_save_api_usecase.dart';
import '../../../features/stock_update/presentation/bloc/stock_update_add_page/stock_update_add_bloc.dart';
import '../../../features/stock_update/presentation/bloc/stock_update_page_bloc/stock_update_page_bloc.dart';
import '../../../features/stock_update/presentation/bloc/stock_update_rfid_scanning_bloc/stock_update_rfid_scanning_bloc.dart';
import '../../../features/stock_update/presentation/bloc/stock_update_transaction_listing_bloc/stock_update_transaction_listing_bloc.dart';
import '../../service/db_service/table_data_manipulation/srock_update_datasource.dart';
import '../service_locator.dart';

void stockUpdateInjections() {
  sl
    ..registerSingleton<StockUpdateDataProcessor>(
      StockUpdateDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<StockUpdateLocalDataSource>(
      StockUpdateLocalDataSourceImpl(
        stockUpdateDataSource: sl<StockUpdateDataProcessor>(),
      ),
    )
    ..registerSingleton<StockUpdateRemoteDataSource>(
      StockUpdateRemoteDataSourceImpl(
        appNetworkClient: sl<AppNetworkClient>(),
        encryptedSharedPreferences: sl<EncryptedSharedPreferences>(),
        stockUpdateDataProcessor: sl<StockUpdateDataProcessor>(),
      ),
    )
    ..registerSingleton<StockUpdateRepository>(
      StockUpdateRepositoryImpl(
        stockUpdateLocalDataSource: sl<StockUpdateLocalDataSource>(),
        stockUpdateRemoteDataSource: sl<StockUpdateRemoteDataSource>(),
        commonLocalDataSource: sl<CommonLocalDataSource>(),
        stockUpdateDataProcessor: sl<StockUpdateDataProcessor>(),
      ),
    )
    //useCause
    ..registerSingleton<StockUpdateInsertUseCase>(
      StockUpdateInsertUseCaseImpl(
        stockUpdateRepository: sl<StockUpdateRepository>(),
      ),
    )
    ..registerSingleton<StockUpdateFetchDataViewUseCase>(
      StockUpdateFetchDataViewUseCaseImpl(
        stockUpdateRepository: sl<StockUpdateRepository>(),
      ),
    )
    ..registerSingleton<StockUpdateRfidScanningViewUseCase>(
      StockUpdateRfidScanningViewUseCaseImpl(
        stockUpdateRepository: sl<StockUpdateRepository>(),
      ),
    )
    ..registerSingleton<StockUpdateFetchFilterDataViewUseCase>(
      StockUpdateFetchFilterDataViewUseCaseImpl(
        stockUpdateRepository: sl<StockUpdateRepository>(),
      ),
    )
    ..registerSingleton<StockUpdateSingleInsertUseCase>(
      StockUpdateSingleInsertUseCaseImpl(
        stockUpdateRepository: sl<StockUpdateRepository>(),
      ),
    )
    ..registerSingleton<StockUpdateFetchSearchDataViewUseCase>(
      StockUpdateFetchSearchDataViewUseCaseImpl(
        stockUpdateRepository: sl<StockUpdateRepository>(),
      ),
    )
    ..registerSingleton<StockUpdateMultipleInsertUseCase>(
      StockUpdateMultipleInsertUseCaseImpl(
        stockUpdateRepository: sl<StockUpdateRepository>(),
      ),
    )
    ..registerSingleton<StockUpdateTrnSaveApiUseCase>(
      StockUpdateTrnSaveApiUseCaseImpl(
        stockUpdateRepository: sl<StockUpdateRepository>(),
      ),
    )
    //bloc
    ..registerSingleton<StockUpdateTransactionListingBloc>(
      StockUpdateTransactionListingBloc(
        stockUpdateInsertUseCase: sl<StockUpdateInsertUseCase>(),
        stockUpdateFetchDataViewUseCase: sl<StockUpdateFetchDataViewUseCase>(),
        stockUpdateFetchFilterDataViewUseCase:
            sl<StockUpdateFetchFilterDataViewUseCase>(),
        stockUpdateFetchSearchDataViewUseCase:
            sl<StockUpdateFetchSearchDataViewUseCase>(),
      ),
    )
    ..registerSingleton<StockUpdateRfidScanningBloc>(
      StockUpdateRfidScanningBloc(
        stockUpdateRfidScanningViewUseCase:
            sl<StockUpdateRfidScanningViewUseCase>(),
      ),
    )
    ..registerSingleton<StockUpdatePageBloc>(
      StockUpdatePageBloc(
        commonUseCase: sl<CommonUseCase>(),
        stockUpdateMultipleInsertUseCase: sl<StockUpdateMultipleInsertUseCase>(),
        stockUpdateTrnSaveApiUseCase: sl<StockUpdateTrnSaveApiUseCase>(),
      ),
    )
    ..registerSingleton<StockUpdateAddBloc>(
      StockUpdateAddBloc(
        commonUseCase: sl<CommonUseCase>(),
        stockUpdateSingleInsertUseCase: sl<StockUpdateSingleInsertUseCase>(),
        stockUpdateTrnSaveApiUseCase: sl<StockUpdateTrnSaveApiUseCase>(),
      ),
    );
  ;
}
