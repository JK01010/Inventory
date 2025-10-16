import 'package:sqflite/sqflite.dart';
import '../../../config/network_config.dart';
import '../../../features/good_receipts/purchase_order_detail/data/data_source/purchase_order_detail_remote_data_source.dart';
import '../../../features/good_receipts/purchase_order_detail/data/data_source/purchase_order_local_data_source.dart';
import '../../../features/good_receipts/purchase_order_detail/data/repository/purchase_order_detail_repository_imp.dart';
import '../../../features/good_receipts/purchase_order_detail/domain/repository/purchase_order_detail_repository.dart';
import '../../../features/good_receipts/purchase_order_detail/domain/use_cases/get_purchase_order_items_db_usecase.dart';
import '../../../features/good_receipts/purchase_order_detail/domain/use_cases/get_purchase_order_items_usecase.dart';
import '../../../features/good_receipts/purchase_order_detail/presentation/purchase_order_detail_bloc/purchase_order_detail_bloc.dart';
import '../../service/db_service/table_data_manipulation/purchase_order_attachment_data_processor.dart';
import '../../service/db_service/table_data_manipulation/purchase_order_items_table_processor.dart';
import '../../service/db_service/table_data_manipulation/purchase_order_packets_table_data_processor.dart';
import '../../service/other_service/app_secure_storage_service.dart';
import '../../service/other_service/file_logger_service.dart';
import '../../utils/app_logger.dart';
import '../service_locator.dart';

void purchaseOrderDetailInjection() {
  sl
    // Tables
    ..registerSingleton<PurchaseOrderItemsTableProcessor>(
      PurchaseOrderItemsTableProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<PurchaseOrderAttachmentDataProcessor>(
      PurchaseOrderAttachmentDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<PurchaseOrderPacketsTableDataProcessor>(
      PurchaseOrderPacketsTableDataProcessorImpl(db: sl<Database>()),
    )
    // Data sources
    ..registerSingleton<PurchaseOrderDetailsLocalDataSource>(
      PurchaseOrderDetailsLocalDataSourceImpl(
        purchaseOrderItemsTableProcessor:
            sl<PurchaseOrderItemsTableProcessor>(),
        purchaseOrderAttachmentDataProcessor:
            sl<PurchaseOrderAttachmentDataProcessor>(),
        purchaseOrderPacketsTableDataProcessor:
            sl<PurchaseOrderPacketsTableDataProcessor>(),
      ),
    )
    ..registerSingleton<PurchaseOrderDetailRemoteDataSource>(
      PurchaseOrderDetailRemoteDataSourceImpl(
        appNetworkClient: sl<AppNetworkClient>(),
      ),
    )
    // Repository
    ..registerSingleton<PurchaseOrderDetailRepository>(
      PurchaseOrderDetailRepositoryImpl(
        appLogger: sl<AppLogger>(),
        fileLoggerService: sl<FileLoggerService>(),
        purchaseOrderDetailRemoteDataSource:
            sl<PurchaseOrderDetailRemoteDataSource>(),
        purchaseOrderDetailsLocalDataSource:
            sl<PurchaseOrderDetailsLocalDataSource>(),
        appSecureStorageService: sl<AppSecureStorageService>(),
      ),
    )
    // Use cases
    ..registerSingleton<GetPurchaseOrderItemsListUseCase>(
      GetPurchaseOrderItemsListUseCaseImpl(
        purchaseOrderDetailRepository: sl<PurchaseOrderDetailRepository>(),
      ),
    )
    ..registerSingleton<GetPurchaseOrderItemsListDbUseCase>(
      GetPurchaseOrderItemsListDbUseCaseImpl(
        purchaseOrderDetailRepository: sl<PurchaseOrderDetailRepository>(),
      ),
    )
    // Bloc
    ..registerFactory(
      () => PurchaseOrderDetailBloc(
        getPurchaseOrderItemsListDbUseCase:
            sl<GetPurchaseOrderItemsListDbUseCase>(),
      ),
    );
}
