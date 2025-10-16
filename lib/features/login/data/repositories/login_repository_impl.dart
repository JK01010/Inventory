import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../config/identity_server/maersk_identity_dev_configuration.dart';
import '../../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/service/network/connectivity_manager.dart';
import '../../../../core/service/other_service/app_secure_storage_service.dart';
import '../../domain/repositories/login_repository.dart';
import '../../domain/usecases/identity_server_verification_usecase.dart';
import '../data_source/login_remote_data_source.dart';
import '../models/identity_server_model.dart';
import '../models/user_info_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required AppSecureStorageService appSecureStorageService,
    required LoginRemoteDataSource loginRemoteDataSource,
    required ConnectivityManager connectivityManager,
  }) : _appSecureStorageService = appSecureStorageService,
       _loginRemoteDataSource = loginRemoteDataSource,
       _connectivityManager = connectivityManager;

  final AppSecureStorageService _appSecureStorageService;
  final LoginRemoteDataSource _loginRemoteDataSource;
  final ConnectivityManager _connectivityManager;

  @override
  Future<Either<Failure, bool>> identityServerLoginVerification(
    IdentityServerVerificationParams params,
  ) async {
    try {
      debugPrint("inside the try of identityServerLoginVerification **************");
      if (await _connectivityManager.isConnected) {
        if (params.identityServerResponse
            is IdentityServerAuthenticationResult) {
          final identityResult =
              params.identityServerResponse
                  as IdentityServerAuthenticationResult;
          debugPrint(
            "identityResult.credential.accessToken : ${identityResult.credential.accessToken}",
          );
          await _appSecureStorageService.write(
            key: AppEncryptedStorageKeys.accessToken,
            value: identityResult.credential.accessToken,
          );
          await _appSecureStorageService.write(
            key: AppEncryptedStorageKeys.refreshToken,
            value: identityResult.credential.refreshToken ?? '',
          );
          await _appSecureStorageService.write(
            key: AppEncryptedStorageKeys.idToken,
            value: identityResult.credential.idToken ?? '',
          );
          final UserInfoModel? userInfoModel = await _loginRemoteDataSource
              .fetchUserInfo(baseUrl: params.verificationBaseUrl);
          debugPrint("userInfoModel : $userInfoModel");
          if (userInfoModel != null) {
            await _appSecureStorageService.write(
              key: AppEncryptedStorageKeys.userId,
              value: userInfoModel.userId ?? '',
            );
            await _appSecureStorageService.write(
              key: AppEncryptedStorageKeys.userName,
              value: userInfoModel.name ?? '',
            );
            await _appSecureStorageService.write(
              key: AppEncryptedStorageKeys.email,
              value: userInfoModel.email ?? '',
            );
            await _appSecureStorageService.write(
              key: AppEncryptedStorageKeys.isAuthenticate,
              value: 'true',
            );
            return right(true);
          } else {
            return left(
              ServerFailure(code: 'LOGIN-API', message: 'User info not found'),
            );
          }
        } else {
          return left(
            ServerFailure(
              code: 'LOGIN-API',
              message: params.identityServerResponse.message,
            ),
          );
        }
      } else {
        return left(
          NetworkFailure(message: 'No internet connection', code: ''),
        );
      }
    } catch (e) {
      debugPrint("inside the catch of identityServerLoginVerification **************");
      debugPrint("$e");
      debugPrint("inside the catch of identityServerLoginVerification **************");
      return left(UnknownFailure(message: e.toString(), code: ''));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final config = MaerskIdentityServerDevConfig();
      final idToken = await _appSecureStorageService.read(
        key: AppEncryptedStorageKeys.idToken,
      );
      final redirectUrl = '${config.baseUrl}/connect/endsession';

      final result = await _loginRemoteDataSource.logout(
        baseUrl: redirectUrl,
        parameters: {
          'id_token_hint': idToken,
          'post_logout_redirect_uri': redirectUrl,
        },
      );
      if (result != null) {
        await _appSecureStorageService.delete(
          key: AppEncryptedStorageKeys.accessToken,
        );
        await _appSecureStorageService.delete(
          key: AppEncryptedStorageKeys.refreshToken,
        );
        await _appSecureStorageService.delete(
          key: AppEncryptedStorageKeys.idToken,
        );
        await _appSecureStorageService.delete(
          key: AppEncryptedStorageKeys.userId,
        );
        await _appSecureStorageService.delete(
          key: AppEncryptedStorageKeys.userName,
        );
        await _appSecureStorageService.delete(
          key: AppEncryptedStorageKeys.email,
        );
        await _appSecureStorageService.write(
          key: AppEncryptedStorageKeys.isAuthenticate,
          value: "false",
        );
        return right(true);
      }
      return left(UnknownFailure(message: 'Unknown Failure', code: ''));
    } on DioException {
      return left(NetworkFailure(code: '', message: 'Network Failure'));
    } catch (e) {
      return left(UnknownFailure(message: e.toString(), code: ''));
    }
  }
}
