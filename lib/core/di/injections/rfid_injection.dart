import 'package:zebraRfid/enums.dart';

import '../../service/other_service/permission_manager_service.dart';
import '../../service/rfid/data/data_sources/local_data_source.dart';
import '../../service/rfid/data/repositories/rfid_repository_impl.dart';
import '../../service/rfid/domain/rfid_repository.dart';
import '../../service/rfid/domain/use_cases/connection_status_use_case.dart';
import '../../service/rfid/domain/use_cases/disconnect_scanner_use_case.dart';
import '../../service/rfid/domain/use_cases/initialize_rfid_use_case.dart';
import '../../service/rfid/domain/use_cases/request_bluetooth_permission_use_case.dart';
import '../../service/rfid/domain/use_cases/rfid_connect_use_case.dart';
import '../../service/rfid/domain/use_cases/set_power_level_use_case.dart';
import '../../service/rfid/domain/use_cases/start_scan_use_case.dart';
import '../../service/rfid/domain/use_cases/stop_scan_use_case.dart';
import '../../service/rfid/rfid_bloc.dart';
import '../service_locator.dart';

void rfIdInjection() {
  sl
    ..registerLazySingleton<RfIdLocalDataSource>(
      () => RfIdLocalDataSourceImpl(
        permissionManagerService: sl<PermissionManagerService>(),
      ),
    )
    ..registerLazySingleton<RfidRepository>(
      () => RfidRepositoryImpl(rfIdLocalDataSource: sl<RfIdLocalDataSource>()),
    )
    ..registerLazySingleton<InitializeRfidUseCase>(
      () => InitializeRfidUseCaseImpl(rfidRepository: sl<RfidRepository>()),
    )
    ..registerLazySingleton<RfidConnectionStatusUseCase>(
      () =>
          RfidConnectionStatusUseCaseImpl(rfidRepository: sl<RfidRepository>()),
    )
    ..registerLazySingleton<RfidSetPowerLevelUseCase>(
      () => RfidSetPowerLevelUseCaseImpl(rfidRepository: sl<RfidRepository>()),
    )
    ..registerLazySingleton<RfidStartScanUseCase>(
      () => RfidStartScanUseCaseImpl(rfidRepository: sl<RfidRepository>()),
    )
    ..registerLazySingleton<RfidStopScanUseCase>(
      () => RfidStopScanUseCaseImpl(rfidRepository: sl<RfidRepository>()),
    )
    ..registerLazySingleton<RequestBluetoothPermissionUseCase>(
      () => RequestBluetoothPermissionUseCaseImpl(
        rfidRepository: sl<RfidRepository>(),
      ),
    )
    ..registerLazySingleton<RfidConnectUseCase>(
      () => RfidConnectUseCaseImpl(rfidRepository: sl<RfidRepository>()),
    )
    ..registerLazySingleton<RfidDisconnectUseCase>(
      () => RfidDisconnectUseCaseImpl(rfidRepository: sl<RfidRepository>()),
    )
    ..registerLazySingleton<RfidBloc>(
      () => RfidBloc(
        connectionStatus: Status.unknown,
        initializeRfidUseCase: sl<InitializeRfidUseCase>(),
        rfidConnectionStatusUseCase: sl<RfidConnectionStatusUseCase>(),
        rfidSetPowerLevelUseCase: sl<RfidSetPowerLevelUseCase>(),
        rfidStartScanUseCase: sl<RfidStartScanUseCase>(),
        rfidStopScanUseCase: sl<RfidStopScanUseCase>(),
        requestBluetoothPermissionUseCase:
            sl<RequestBluetoothPermissionUseCase>(),
        rfidConnectUseCase: sl<RfidConnectUseCase>(),
        rfidDisconnectUseCase: sl<RfidDisconnectUseCase>(),
      ),
    );
}
