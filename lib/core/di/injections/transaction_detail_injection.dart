import 'package:sqflite/sqflite.dart';
import '../../../features/good_receipts/transaction_detail/data/data_source/transaction_detail_local_data_source.dart';
import '../../../features/good_receipts/transaction_detail/data/repository/transaction_detail_repository_impl.dart';
import '../../../features/good_receipts/transaction_detail/domain/repository/transaction_detail_repository.dart';
import '../../../features/good_receipts/transaction_detail/domain/use_cases/get_transaction_items_db_usecase.dart';
import '../../../features/good_receipts/transaction_detail/presentation/bloc/transaction_detail_bloc.dart';
import '../../service/db_service/table_data_manipulation/transaction_dt_table_data_processor.dart';
import '../../service/other_service/file_logger_service.dart';
import '../../utils/app_logger.dart';
import '../service_locator.dart';

void transactionDetailInjection() {
  sl
    // Database
    ..registerSingleton<TransactionItemsTableProcessor>(
      TransactionItemsTableProcessorImpl(db: sl<Database>()),
    )
    // Data Sources
    ..registerSingleton<TransactionDetailLocalDataSource>(
      TransactionDetailLocalDataSourceImpl(
        transactionItemsTableProcessor: sl<TransactionItemsTableProcessor>(),
      ),
    )
    // Repository
    ..registerSingleton<TransactionDetailRepository>(
      TransactionDetailRepositoryImpl(
        appLogger: sl<AppLogger>(),
        fileLoggerService: sl<FileLoggerService>(),
        transactionDetailLocalDataSource:
            sl<TransactionDetailLocalDataSource>(),
      ),
    )
    //Use Case
    ..registerSingleton<GetTransactionItemsDbUseCase>(
      GetTransactionItemsDbUseCaseImpl(
        transactionDetailRepository: sl<TransactionDetailRepository>(),
      ),
    )
    //Bloc
    ..registerFactory<TransactionDetailBloc>(
      () => TransactionDetailBloc(
        getTransactionItemsDbUseCase: sl<GetTransactionItemsDbUseCase>(),
      ),
    );
}
