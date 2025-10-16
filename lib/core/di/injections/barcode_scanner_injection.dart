import '../../service/barcode_scanner/data/data_sources/barcode_local_data_source.dart';
import '../../service/barcode_scanner/data/repositories/barcode_repository.dart';
import '../../service/barcode_scanner/data/repositories/barcode_repository_impl.dart';
import '../../service/barcode_scanner/domain/use_cases/get_scanned_barcode_stream_use_case.dart';
import '../../service/barcode_scanner/domain/use_cases/initialize_barcode_scanner_use_case.dart';
import '../../service/barcode_scanner/domain/use_cases/request_camera_permission_use_case.dart';
import '../../service/barcode_scanner/domain/use_cases/start_scan_use_case.dart';
import '../../service/barcode_scanner/domain/use_cases/stop_scan_use_case.dart';
import '../../service/barcode_scanner/presentation/bloc/barcode_bloc.dart';
import '../service_locator.dart';

void barcodeInjection() {
  sl
    // Data sources
    ..registerLazySingleton<BarcodeLocalDataSource>(
      BarcodeLocalDataSourceImpl.new,
    )
    // Repository
    ..registerLazySingleton<BarcodeRepository>(
      () => BarcodeRepositoryImpl(sl()),
    )
    // Use cases
    ..registerLazySingleton(() => GetScannedBarcodeStreamUseCase(sl()))
    ..registerLazySingleton(() => InitializeBarcodeScannerUseCase(sl()))
    ..registerLazySingleton(() => RequestCameraPermissionUseCase(sl()))
    ..registerLazySingleton(() => StartScanUseCase(sl()))
    ..registerLazySingleton(() => StopScanUseCase(sl()))
    // Bloc
    ..registerFactory(
      () => BarcodeBloc(
        initializeBarcodeScannerUseCase: sl(),
        startScanUseCase: sl(),
        stopScanUseCase: sl(),
        getScannedBarcodeStreamUseCase: sl(),
        requestCameraPermissionUseCase: sl(),
      ),
    );
}
