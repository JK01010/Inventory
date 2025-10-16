import 'package:sqflite/sqflite.dart';
import '../../../config/network_config.dart';
import '../../../features/common_feature/data/data_source/common_local_data_source.dart';
import '../../../features/good_receipts/presentation/quality_bloc/quality_bloc.dart';
import '../../../features/good_receipts/purchase_order_item_detail/data/data_source/purchase_order_item_detail_local_data_source.dart';
import '../../../features/good_receipts/purchase_order_item_detail/data/data_source/purchase_order_item_detail_remote_data_source.dart';
import '../../../features/good_receipts/purchase_order_item_detail/data/repository/purchase_order_item_detail_repository_impl.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/repository/purchase_order_item_detail_repository.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/generate_serial_numbers_usecase.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_imdg_class_db_usecase.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_imdg_class_usecase.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_purchase_order_item_serial_number_usecase.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_purchase_order_item_split_location_data.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_quality_list_db_usecase.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/get_quality_list_use_case.dart';
import '../../../features/good_receipts/purchase_order_item_detail/domain/use_cases/update_purchase_order_item_usecase.dart';
import '../../../features/good_receipts/purchase_order_item_detail/presentation/purchase_order_detail_bloc/purchase_order_item_detail_bloc.dart';
import '../../../features/packets/add_packets_sheet/presentation/bloc/add_packets_sheet_bloc.dart';
import '../../../features/packets/add_packets_sheet/presentation/pages/add_packets_sheet.dart';
import '../../../features/serial_numbers_sheet/presentation/bloc/serial_numbers_listing_bloc.dart';
import '../../service/db_service/table_data_manipulation/imdg_class_table_data_processor.dart';
import '../../service/db_service/table_data_manipulation/pending_po_split_location_table_processor.dart';
import '../../service/db_service/table_data_manipulation/purchase_order_item_serial_numbers_table_processor.dart';
import '../../service/db_service/table_data_manipulation/purchase_order_items_table_processor.dart';
import '../../service/db_service/table_data_manipulation/quality_list_table_data_processor.dart';
import '../../service/other_service/file_logger_service.dart';
import '../../utils/app_logger.dart';
import '../service_locator.dart';

void purchaseOrderItemDetailInjection() {
  sl
    // Tables
    ..registerSingleton<QualityTableDataProcessor>(
      QualityTableDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<ImdgClassTableDataProcessor>(
      ImdgClassTableDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<PendingPoSplitLocationTableProcessor>(
      PendingPoSplitLocationTableProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<PurchaseOrderItemSerialNumbersTableProcessor>(
      PurchaseOrderItemSerialNumbersTableProcessorImpl(db: sl<Database>()),
    )
    // Data sources
    ..registerSingleton<PurchaseOrderItemDetailLocalDataSource>(
      PurchaseOrderItemDetailLocalDataSourceImpl(
        qualityTableDataProcessor: sl<QualityTableDataProcessor>(),
        imdgClassTableDataProcessor: sl<ImdgClassTableDataProcessor>(),
        purchaseOrderItemsTableProcessor:
            sl<PurchaseOrderItemsTableProcessor>(),
        pendingPoSplitLocationTableProcessor:
            sl<PendingPoSplitLocationTableProcessor>(),
        purchaseOrderItemSerialNumbersTableProcessor:
            sl<PurchaseOrderItemSerialNumbersTableProcessor>(),
      ),
    )
    ..registerSingleton<PurchaseOrderItemDetailRemoteDataSource>(
      PurchaseOrderItemDetailRemoteDataSourceImpl(
        appNetworkClient: sl<AppNetworkClient>(),
      ),
    )
    // Repository
    ..registerSingleton<PurchaseOrderItemDetailRepository>(
      PurchaseOrderItemDetailRepositoryImpl(
        appLogger: sl<AppLogger>(),
        fileLoggerService: sl<FileLoggerService>(),
        purchaseOrderItemDetailLocalDataSource:
            sl<PurchaseOrderItemDetailLocalDataSource>(),
        purchaseOrderItemDetailRemoteDataSource:
            sl<PurchaseOrderItemDetailRemoteDataSource>(),
        commonLocalDataSource: sl<CommonLocalDataSource>(),
      ),
    )
    // Use cases
    ..registerSingleton<GetQualityListUseCase>(
      GetQualityListUseCaseImpl(
        purchaseOrderItemDetailRepository:
            sl<PurchaseOrderItemDetailRepository>(),
      ),
    )
    ..registerSingleton<GetQualityListDbUseCase>(
      GetQualityListDbUseCaseImpl(
        purchaseOrderItemDetailRepository:
            sl<PurchaseOrderItemDetailRepository>(),
      ),
    )
    ..registerSingleton<GetImdgClassUseCase>(
      GetImdgClassUseCaseImpl(
        purchaseOrderItemDetailRepository:
            sl<PurchaseOrderItemDetailRepository>(),
      ),
    )
    ..registerSingleton<GetImdgClassListDbUseCase>(
      GetImdgClassListDbUseCaseImpl(
        purchaseOrderItemDetailRepository:
            sl<PurchaseOrderItemDetailRepository>(),
      ),
    )
    ..registerSingleton<UpdatePurchaseOrderItemDataUseCase>(
      UpdatePurchaseOrderItemDataUseCaseImpl(
        purchaseOrderItemDetailRepository:
            sl<PurchaseOrderItemDetailRepository>(),
      ),
    )
    ..registerSingleton<GetPurchaseOrderItemSplitLocationDataUseCase>(
      GetPurchaseOrderItemSplitLocationDataUseCaseImpl(
        purchaseOrderItemDetailRepository:
            sl<PurchaseOrderItemDetailRepository>(),
      ),
    )
    ..registerSingleton<GenerateSerialNumbersUseCase>(
      GenerateSerialNumbersUseCaseImpl(
        purchaseOrderItemDetailRepository:
            sl<PurchaseOrderItemDetailRepository>(),
      ),
    )
    ..registerSingleton<GetPurchaseOrderItemSerialNumberUseCase>(
      GetPurchaseOrderItemSerialNumberUseCaseImpl(
        purchaseOrderItemDetailRepository:
            sl<PurchaseOrderItemDetailRepository>(),
      ),
    )
    // Bloc
    ..registerFactory<PurchaseOrderItemDetailBloc>(
      () => PurchaseOrderItemDetailBloc(
        getImdgClassListDbUseCase: sl<GetImdgClassListDbUseCase>(),
        updatePurchaseOrderItemDataUseCase:
            sl<UpdatePurchaseOrderItemDataUseCase>(),
        getPurchaseOrderItemSplitLocationDataUseCase:
            sl<GetPurchaseOrderItemSplitLocationDataUseCase>(),
        generateSerialNumbersUseCase: sl<GenerateSerialNumbersUseCase>(),
        getPurchaseOrderItemSerialNumberUseCase:
            sl<GetPurchaseOrderItemSerialNumberUseCase>(),
      ),
    )
    ..registerFactory<QualityBloc>(
      () => QualityBloc(getQualityListDbUseCase: sl<GetQualityListDbUseCase>()),
    )
    ..registerFactory<SerialNumbersListingBloc>(SerialNumbersListingBloc.new)
    ..registerFactory<AddPacketsSheetBloc>(AddPacketsSheetBloc.new);
}
