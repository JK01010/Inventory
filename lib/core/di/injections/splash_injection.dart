import '../../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../../features/splash/domain/repositories/splash_repository.dart';
import '../../../features/splash/domain/usecases/check_authentication_use_case.dart';
import '../../../features/splash/presentation/splash_bloc/bloc/splash_bloc.dart';
import '../../service/other_service/app_secure_storage_service.dart';
import '../service_locator.dart';

void splashInjection() {
  sl
    // === Repository ===
    ..registerSingleton<SplashRepository>(
      SplashRepositoryImpl(secureStorageService: sl<AppSecureStorageService>()),
    )
    // === Use Cases ===
    ..registerSingleton<CheckAuthenticationUseCase>(
      CheckAuthenticationUseCaseImpl(splashRepository: sl<SplashRepository>()),
    )
    // === Bloc ===
    ..registerFactory<SplashBloc>(
      () => SplashBloc(
        checkAuthenticationUseCase: sl<CheckAuthenticationUseCase>(),
      ),
    );
}
