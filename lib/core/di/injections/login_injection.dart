import '../../../config/network_config.dart';
import '../../../features/login/data/data_source/login_remote_data_source.dart';
import '../../../features/login/data/repositories/login_repository_impl.dart';
import '../../../features/login/domain/repositories/login_repository.dart';
import '../../../features/login/domain/usecases/identity_server_verification_usecase.dart';
import '../../../features/login/domain/usecases/logout_usecase.dart';
import '../../../features/login/presentation/login_bloc/login_bloc.dart';
import '../../service/network/connectivity_manager.dart';
import '../../service/network/domain/network_connectivity_usecase.dart';
import '../../service/other_service/app_secure_storage_service.dart';
import '../service_locator.dart';

void loginInjection() {
  sl
    // === Data Source ===
    ..registerSingleton<LoginRemoteDataSource>(
      LoginRemoteDataSourceImpl(appNetworkClient: sl<AppNetworkClient>()),
    )
    // === Repository ===
    ..registerSingleton<LoginRepository>(
      LoginRepositoryImpl(
        appSecureStorageService: sl<AppSecureStorageService>(),
        loginRemoteDataSource: sl<LoginRemoteDataSource>(),
        connectivityManager: sl<ConnectivityManager>(),
      ),
    )
    // === Use Cases ===
    ..registerSingleton<IdentityServerVerificationUseCase>(
      IdentityServerVerificationUseCaseImpl(
        loginRepository: sl<LoginRepository>(),
      ),
    )
    ..registerSingleton<LogoutUseCase>(
      LogoutUseCaseImpl(loginRepository: sl<LoginRepository>()),
    )
    // === Bloc ===
    ..registerFactory<LoginBloc>(
      () => LoginBloc(
        identityServerVerificationUseCase:
            sl<IdentityServerVerificationUseCase>(),
        networkConnectivityUseCase: sl<NetworkConnectivityUseCase>(),
      ),
    );
}
