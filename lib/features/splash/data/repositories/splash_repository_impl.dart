import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../../core/service/other_service/app_secure_storage_service.dart';
import '../../domain/repositories/splash_repository.dart';
import '../../domain/splash_failure/splash_failure.dart';

class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl({required AppSecureStorageService secureStorageService})
    : _secureStorageService = secureStorageService;
  final AppSecureStorageService _secureStorageService;

  @override
  Future<Either<SplashFailure, Unit>> checkUserAuthentication() async {
    try {
      final value = await _secureStorageService.read(
        key: AppEncryptedStorageKeys.accessToken,
      );
      String? isAuthenticate = await _secureStorageService.read(
        key: AppEncryptedStorageKeys.isAuthenticate,
      );
      debugPrint("isAuthenticate : ${isAuthenticate}");
      debugPrint("value : ${value}");
      if (value != null && isAuthenticate != null && isAuthenticate == 'true') {
        debugPrint('isAuthenticated');
        return right(unit);
      } else {
        return left(UserNotAuthenticatedFailure(message: ""));
      }
    } catch (e) {
      return left(UserNotAuthenticatedFailure(message: ""));
    }
  }
}
