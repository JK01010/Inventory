import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../../config/network_config.dart';
import '../../features/common_feature/data/data_source/common_local_data_source.dart';
import '../../features/theme/theme_bloc.dart';
import '../service/db_service/app_database.dart';
import '../service/db_service/table_data_manipulation/admin_structure_data_processor.dart';
import '../service/db_service/table_data_manipulation/common_data_processor.dart';
import '../service/db_service/table_data_manipulation/default_location_data_processor.dart';
import '../service/db_service/table_data_manipulation/failed_common_api_local_data_source.dart';
import '../service/db_service/table_data_manipulation/stock_location_data_processor.dart';
import '../service/db_service/table_data_manipulation/vessel_specification_data_processor.dart';
import '../service/network/api_logging_interceptor.dart';
import '../service/network/connectivity_manager.dart';
import '../service/other_service/app_secure_storage_service.dart';
import '../service/other_service/attachment_picker_service.dart';
import '../service/other_service/file_logger_service.dart';
import '../service/other_service/permission_manager_service.dart';
import '../service/other_service/quick_action_service.dart';
import '../utils/app_logger.dart';
import 'injections/bagging_tagging_injection.dart';
import 'injections/barcode_scanner_injection.dart';
import 'injections/common_injection.dart';
import 'injections/consumption_injection.dart';
import 'injections/goods_receipt_injection.dart';
import 'injections/item_master_injection.dart';
import 'injections/login_injection.dart';
import 'injections/purchase_order_details_injection.dart';
import 'injections/purchase_order_injection.dart';
import 'injections/purchase_order_item_detail_injection.dart';
import 'injections/rfid_injection.dart';
import 'injections/speech_to_text_injection.dart';
import 'injections/splash_injection.dart';
import 'injections/stock_update_injection.dart';
import 'injections/transaction_detail_injection.dart';
import 'injections/transaction_injection.dart';
import 'injections/transaction_item_detail_injection.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeServiceLocator() async {
  // Core services
  sl
    ..registerLazySingleton<ImagePicker>(ImagePicker.new)
    ..registerLazySingleton<FilePicker>(() => FilePicker.platform)
    ..registerLazySingleton<AppLogger>(
      () => AppLoggerImpl(
        logger: Logger(
          printer: PrettyPrinter(
            dateTimeFormat:
                DateTimeFormat
                    .onlyTimeAndSinceStart, // Should each log message contain a timestamp
          ),
          level: Level.trace,
        ),
      ),
    )
    ..registerLazySingleton<AttachmentPickerService>(
      () => AttachmentPickerServiceImpl(
        imagePicker: sl<ImagePicker>(),
        appLogger: sl<AppLogger>(),
        filePicker: sl<FilePicker>(),
      ),
    )
    // Optional: register FileLoggerService if needed as injectable
    ..registerLazySingleton<FileLoggerService>(
      () => FileLoggerServiceImpl(appLogger: sl<AppLogger>()),
    )
    ..registerLazySingleton<QuickActionService>(
      () => QuickActionService(
        fileLoggerService: sl<FileLoggerService>(),
        appLogger: sl<AppLogger>(),
      )..initialize(),
    )
    ..registerSingleton<Dio>(Dio())
    ..registerSingleton<AppNetworkClient>(DioNetworkClient(dio: sl<Dio>()))
    ..registerSingleton<EncryptedSharedPreferences>(
      EncryptedSharedPreferences.getInstance(),
    )
    ..registerSingleton<AppSecureStorageService>(
      AppSecureStorageServiceImpl(
        encryptedSharedPreferences: sl<EncryptedSharedPreferences>(),
      ),
    )
    ..registerSingleton<Connectivity>(Connectivity())
    ..registerSingleton<ConnectivityManager>(
      ConnectivityManagerImpl(connectivity: sl<Connectivity>()),
    );

  final Database db = await AppDatabase.getInstance();
  sl
    ..registerLazySingleton<Database>(() => db)
    ..registerSingleton<CommonDatasource>(
      CommonDatasourceImpl(db: sl<Database>()),
    )
    ..registerSingleton<StockLocationDataProcessor>(
      StockLocationDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<DefaultLocationDataProcessor>(
      DefaultLocationDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<VesselSpecificationDataProcessor>(
      VesselSpecificationDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<AdminStructureDataProcessor>(
      AdminStructureDataProcessorImpl(db: sl<Database>()),
    )
    ..registerSingleton<CommonLocalDataSource>(
      CommonLocalDataSourceImpl(
        commonDatasource: sl<CommonDatasource>(),
        networkClient: sl<AppNetworkClient>(),
        stockLocationDataProcessor: sl<StockLocationDataProcessor>(),
        defaultLocationDataProcessor: sl<DefaultLocationDataProcessor>(),
        vesselSpecificationDataProcessor:
            sl<VesselSpecificationDataProcessor>(),
        adminStructureDataProcessor: sl<AdminStructureDataProcessor>(),
      ),
    )
    ..registerSingleton<ThemeBloc>(ThemeBloc())
    ..registerLazySingleton<PermissionManagerService>(
      PermissionManagerServiceImpl.new,
    )
    ..registerSingleton<FailedCommonApiLocalDataSource>(
      FailedCommonApiLocalDataSourceImpl(db: sl<Database>()),
    );
  sl<Dio>().interceptors.add(
    ApiLoggingInterceptor(
      fileLoggerService: sl<FileLoggerService>(),
      dio: sl<Dio>(),
      appSecureStorageService: sl<AppSecureStorageService>(),
      failedCommonApiLocalDataSource: sl<FailedCommonApiLocalDataSource>(),
    ),
  );

  // Feature-specific injection
  loginInjection();
  splashInjection();
  purchaseOrderInjection();
  purchaseOrderDetailInjection();
  transactionInjection();
  transactionDetailInjection();
  transactionItemDetailInjection();
  commonInjection();
  purchaseOrderItemDetailInjection();

  speechToTextInjection();
  barcodeInjection();
  rfIdInjection();
  goodsReceiptInjection();
  baggingTaggingInjection();
  consumptionInjection();
  itemMasterInjections();
  stockUpdateInjections();
}
