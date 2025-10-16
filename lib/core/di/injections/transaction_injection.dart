import 'package:encrypt_shared_preferences/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../config/network_config.dart';
import '../../../features/common_feature/domain/usecase/fetch_all_port_list_db_usecase.dart';
import '../../../features/common_feature/domain/usecase/fetch_item_category_usecase.dart';
import '../../../features/good_receipts/transaction/data/data_source/transaction_local_data_source.dart';
import '../../../features/good_receipts/transaction/data/data_source/transaction_remote_data_source.dart';
import '../../../features/good_receipts/transaction/data/repository/transaction_repository_impl.dart';
import '../../../features/good_receipts/transaction/domain/repository/transaction_repository.dart';
import '../../../features/good_receipts/transaction/domain/usecase/get_all_transaction_from_api_usecase.dart';
import '../../../features/good_receipts/transaction/domain/usecase/get_all_transaction_from_db_usecase.dart';
import '../../../features/good_receipts/transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import '../../../features/good_receipts/transaction/presentation/bloc/transaction_filter_bloc/transaction_filter_bloc.dart';
import '../../service/db_service/table_data_manipulation/transactions_table_data_processor.dart';
import '../service_locator.dart';

void transactionInjection() {
  sl
    ..registerSingleton<TransactionRemoteDataSource>(
      TransactionRemoteDataSourceImpl(
        encryptedSharedPreferences: sl<EncryptedSharedPreferences>(),
        appNetworkClient: sl<AppNetworkClient>(),
      ),
    )
    ..registerSingleton<TransactionsTableDataProcessor>(
      TransactionsTableDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<TransactionLocalDataSource>(
      TransactionLocalDataSourceImpl(
        transactionsTableDataProcessor: sl<TransactionsTableDataProcessor>(),
      ),
    )
    ..registerSingleton<TransactionRepository>(
      TransactionRepositoryImpl(
        transactionLocalDataSource: sl<TransactionLocalDataSource>(),
        transactionRemoteDataSource: sl<TransactionRemoteDataSource>(),
      ),
    )
    ..registerSingleton<GetAllTransactionFromApiUseCase>(
      GetAllTransactionFromApiUseCaseImpl(
        transactionRepository: sl<TransactionRepository>(),
      ),
    )
    ..registerSingleton<GetAllTransactionFromDbUsecase>(
      GetAllTransactionFromDbUsecaseImpl(
        transactionRepository: sl<TransactionRepository>(),
      ),
    )
    ..registerFactory<TransactionBloc>(
      () => TransactionBloc(
        getAllTransactionFromDbUsecase: sl<GetAllTransactionFromDbUsecase>(),
      ),
    )
    ..registerFactory<TransactionFilterBloc>(
      () => TransactionFilterBloc(
        getItemCategoryUsecase: sl<GetItemCategoryUsecase>(),
        getAllPortListFromDbUseCase: sl<GetAllPortListFromDbUseCase>(),
        getAllTransactionFromDbUsecase: sl<GetAllTransactionFromDbUsecase>(),
      ),
    );
}
