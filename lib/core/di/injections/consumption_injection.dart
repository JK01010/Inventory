import 'package:encrypt_shared_preferences/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../config/network_config.dart';
import '../../../features/common_feature/data/data_source/common_local_data_source.dart';
import '../../../features/common_feature/domain/usecase/common_usecase.dart';
import '../../../features/common_feature/domain/usecase/get_all_equipment_list_usecase.dart';
import '../../../features/common_feature/domain/usecase/get_equipment_children_usecase.dart';
import '../../../features/consumption/data/data_source/consumption_transaction_local_data_source.dart';
import '../../../features/consumption/data/data_source/consumption_transaction_remote_data_source.dart';
import '../../../features/consumption/data/repository_impl/consumption_repository_impl.dart';
import '../../../features/consumption/domin/repository/consumption_repository.dart';
import '../../../features/consumption/domin/usecases/con_tran_multiple_insert_usecase.dart';
import '../../../features/consumption/domin/usecases/con_tran_single_insert_usecase.dart';
import '../../../features/consumption/domin/usecases/consumption_rfid_scanning_view_usecase.dart';
import '../../../features/consumption/domin/usecases/fetch_all_consumption_transaction_header_usecase.dart';
import '../../../features/consumption/domin/usecases/fetch_all_consuption_location_usecase.dart';
import '../../../features/consumption/domin/usecases/fetch_filter_consumption_transaction_usecase.dart';
import '../../../features/consumption/domin/usecases/fetch_rob_consumption_add_page_usecase.dart';
import '../../../features/consumption/domin/usecases/insert_consumption_equipment_list.dart';
import '../../../features/consumption/domin/usecases/insert_consumption_location_list_usecase.dart';
import '../../../features/consumption/domin/usecases/insert_consumption_transaction_list_usecase.dart';
import '../../../features/consumption/domin/usecases/save_api_consumption_transaction_usecase.dart';
import '../../../features/consumption/domin/usecases/search_consumption_transaction_usecase.dart';
import '../../../features/consumption/presentation/bloc/consumption_add_page_bloc/consumption_add_page_bloc.dart';
import '../../../features/consumption/presentation/bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import '../../../features/consumption/presentation/bloc/consumption_location_bloc/consumption_location_bloc.dart';
import '../../../features/consumption/presentation/bloc/consumption_rfid_scanning_bloc/consumption_rfid_scanning_bloc.dart';
import '../../../features/consumption/presentation/bloc/consumption_transaction_bloc/consumption_transaction_bloc.dart';
import '../../service/db_service/table_data_manipulation/consumption_transaction_data_processor.dart';
import '../../service/other_service/file_logger_service.dart';
import '../../utils/app_logger.dart';
import '../service_locator.dart';

void consumptionInjection() {
  sl
    ..registerSingleton<ConsumptionTransactionDataProcessor>(
      ConsumptionTransactionDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<ConsumptionTransactionLocalDataSource>(
      ConsumptionLocalDataSourceImpl(
        consumptionTransactionDataSource:
            sl<ConsumptionTransactionDataProcessor>(),
      ),
    )
    ..registerSingleton<ConsumptionTransactionRemoteDataSource>(
      ConsumptionTransactionRemoteDataSourceImpl(
        appNetworkClient: sl<AppNetworkClient>(),
        consumptionTransactionDataProcessor: sl<ConsumptionTransactionDataProcessor>(),
        encryptedSharedPreferences: sl<EncryptedSharedPreferences>(),
      ),
    )
    ..registerSingleton<ConsumptionRepository>(
      ConsumptionRepositoryImpl(
        appLogger: sl<AppLogger>(),
        fileLoggerService: sl<FileLoggerService>(),
        consumptionTransactionLocalDataSource: sl<ConsumptionTransactionLocalDataSource>(),
        consumptionTransactionRemoteDataSource: sl<ConsumptionTransactionRemoteDataSource>(),
        commonLocalDataSource: sl<CommonLocalDataSource>(),
        consumptionTransactionDataProcessor: sl<ConsumptionTransactionDataProcessor>(),
      ),
    )


    ///UseCases///****************************

    ..registerSingleton<FetchAllConsumptionTransactionUseCase>(
      FetchConsumptionTransactionUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<InsertConsumptionTransactionUseCase>(
      InsertConsumptionTransactionUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<FetchConsumptionTransactionFilterUseCase>(
      FetchConsumptionTransactionFilterUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<SearchConsumptionTransactionUseCase>(
      SearchConsumptionTransactionUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<ConsumptionRfidScanningViewUseCase>(
      ConsumptionRfidScanningViewUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<ConTransactionSingleInsertUseCase>(
      ConTransactionSingleInsertUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<SaveApiConsumptionTransactionUseCase>(
      SaveApiConsumptionTransactionUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<ConTranMultipleInsertUseCase>(
      ConTranMultipleInsertUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<InsertConsumptionLocationListUseCase>(
      InsertConsumptionLocationListUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<FetchAllConsumptionLocationUseCase>(
      FetchAllConsumptionLocationUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<InsertEquipmentListUseCase>(
      InsertEquipmentListUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )
    ..registerSingleton<FetchROBUseCase>(
      FetchROBUseCaseImpl(
        consumptionRepository: sl<ConsumptionRepository>(),
      ),
    )

    ///Bloc///******************************

    //Consumption Transaction Bloc
    ..registerSingleton<ConsumptionTransactionBloc>(
      ConsumptionTransactionBloc(
        insertConsumptionTransactionUseCase:
            sl<InsertConsumptionTransactionUseCase>(),
        fetchAllConsumptionTransactionUseCase:
            sl<FetchAllConsumptionTransactionUseCase>(),
        fetchConsumptionTransactionFilterUseCase:
            sl<FetchConsumptionTransactionFilterUseCase>(),
        searchConsumptionTransactionHeaderUseCase:
            sl<SearchConsumptionTransactionUseCase>(),
      ),
    )

    //Consumption RFID Scanning Bloc
    ..registerSingleton<ConsumptionRfidScanningBloc>(
      ConsumptionRfidScanningBloc(
        consumptionRfidScanningViewUseCase:
            sl<ConsumptionRfidScanningViewUseCase>(),
      ),
    )

    //Add page Bloc
    ..registerSingleton<ConsumptionAddPageBloc>(
      ConsumptionAddPageBloc(
        conTransactionSingleInsertUseCase: sl<ConTransactionSingleInsertUseCase>(),
        commonUseCase: sl<CommonUseCase>(),
        saveApiConsumptionTransactionUseCase: sl<SaveApiConsumptionTransactionUseCase>(),
        fetchROBUseCase: sl<FetchROBUseCase>(),
      ),
    )

    //Update Page Bloc
    ..registerSingleton<ConsumptionItemUpdateBloc>(
      ConsumptionItemUpdateBloc(
        insertEquipmentListUseCase: sl<InsertEquipmentListUseCase>(),
        getAllEquipmentListUseCase: sl<GetAllEquipmentListUseCase>(),
        conTranMultipleInsertUseCase: sl<ConTranMultipleInsertUseCase>(),
        getEquipmentChildrenUseCase: sl<GetEquipmentChildrenUsecase>(),
        fetchAllConsumptionLocationUseCase: sl<FetchAllConsumptionLocationUseCase>(),
        saveApiConsumptionTransactionUseCase: sl<SaveApiConsumptionTransactionUseCase>(),
      ),
    )

    //consumption location
    ..registerSingleton<ConsumptionLocationBloc>(
      ConsumptionLocationBloc(
        insertConsumptionLocationListUseCase:
            sl<InsertConsumptionLocationListUseCase>(),
        fetchAllConsumptionLocationUseCase:
            sl<FetchAllConsumptionLocationUseCase>(),
      ),
    );
}
