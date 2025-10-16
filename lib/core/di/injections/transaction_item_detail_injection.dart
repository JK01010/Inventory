import 'package:sqflite/sqflite.dart';

import '../../../config/network_config.dart';
import '../../../features/good_receipts/transaction_item_detail/data/data_source/transaction_item_detail_local_data_source.dart';
import '../../../features/good_receipts/transaction_item_detail/data/data_source/transaction_item_detail_remote_data_source.dart';
import '../../../features/good_receipts/transaction_item_detail/data/repository/transaction_item_detail_repository_impl.dart';
import '../../../features/good_receipts/transaction_item_detail/domain/repository/transaction_item_detail_repository.dart';
import '../../../features/good_receipts/transaction_item_detail/domain/usecase/get_all_transaction_item_detail_usecase.dart';
import '../../../features/good_receipts/transaction_item_detail/domain/usecase/get_split_location_data_transaction_item_usecase.dart';
import '../../../features/good_receipts/transaction_item_detail/domain/usecase/get_split_location_data_usecase.dart';
import '../../../features/good_receipts/transaction_item_detail/presentation/bloc/transaction_item_detail_bloc.dart';
import '../../service/db_service/table_data_manipulation/split_location_data_processor.dart';
import '../../service/db_service/table_data_manipulation/transaction_dt_table_data_processor.dart';
import '../../service/other_service/app_secure_storage_service.dart';
import '../../service/other_service/file_logger_service.dart';
import '../../utils/app_logger.dart';
import '../service_locator.dart';

void transactionItemDetailInjection() {
  sl
    ..registerSingleton<SplitLocationDataProcessor>(
      SplitLocationDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<TransactionItemDetailLocalDataSource>(
      TransactionItemDetailLocalDataSourceImpl(
        transactionDtTableDataProcessor: sl<TransactionItemsTableProcessor>(),
        splitLocationDataProcessor: sl<SplitLocationDataProcessor>(),
      ),
    )
    ..registerSingleton<TransactionItemDetailRemoteDataSource>(
      TransactionItemDetailRemoteDataSourceImpl(
        appNetworkClient: sl<AppNetworkClient>(),
      ),
    )
    ..registerSingleton<TransactionItemDetailRepository>(
      TransactionItemDetailRepositoryImpl(
        appLogger: sl<AppLogger>(),
        fileLoggerService: sl<FileLoggerService>(),
        transactionItemDetailLocalDataSource:
            sl<TransactionItemDetailLocalDataSource>(),
        transactionItemDetailRemoteDataSource:
            sl<TransactionItemDetailRemoteDataSource>(),
        appSecureStorageService: sl<AppSecureStorageService>(),
      ),
    )
    //Use Case
    ..registerSingleton<GetAllTransactionItemDetailUsecase>(
      GetAllTransactionItemDetailUsecaseImpl(
        transactionItemDetailRepository: sl<TransactionItemDetailRepository>(),
      ),
    )
    ..registerSingleton<GetSplitLocationDataUseCase>(
      GetSplitLocationDataUseCaseImpl(
        transactionItemDetailRepository: sl<TransactionItemDetailRepository>(),
      ),
    )
    ..registerSingleton<GetSplitLocationDatForTransactionItemUseCase>(
      GetSplitLocationDatForTransactionItemUseCaseImpl(
        transactionItemDetailRepository: sl<TransactionItemDetailRepository>(),
      ),
    )

    //BloC
    ..registerFactory<TransactionItemDetailBloc>(
      () => TransactionItemDetailBloc(
        getSplitLocationDatForTransactionItemUseCase:
            sl<GetSplitLocationDatForTransactionItemUseCase>(),
      ),
    );
}
