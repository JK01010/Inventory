import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../config/identity_server/maersk_identity_dev_configuration.dart';
import '../../../features/common_feature/data/model/failed_common_api_model.dart';
import '../../constants/app_encrypted_storage_keys.dart';
import '../../error/failures.dart';
import '../db_service/table_data_manipulation/failed_common_api_local_data_source.dart';
import '../other_service/app_secure_storage_service.dart';
import '../other_service/file_logger_service.dart';

class ApiLoggingInterceptor extends Interceptor {
  ApiLoggingInterceptor({
    required this.fileLoggerService,
    required this.dio,
    required this.appSecureStorageService,
    required this.failedCommonApiLocalDataSource,
  });

  final FileLoggerService fileLoggerService;
  final Dio dio;
  final AppSecureStorageService appSecureStorageService;
  final FailedCommonApiLocalDataSource failedCommonApiLocalDataSource;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add the token to the header if it exists
    final accessToken = await appSecureStorageService.read(
      key: AppEncryptedStorageKeys.accessToken,
    );
    debugPrint("accessToken onRequest: $accessToken");
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    // await fileLoggerService.logToFile(
    //   pageType: 'API',
    //   logText: 'Request → ${options.method} ${options.uri}',
    //   apiName: options.path,
    //   extraInfo: 'Headers: ${options.headers}\nData: ${options.data}',
    // );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // await fileLoggerService.logToFile(
    //   pageType: 'API',
    //   logText:
    //       'Response ← ${response.statusCode} ${response.requestOptions.uri}',
    //   apiName: response.requestOptions.path,
    //   extraInfo: 'Response: ${response.data}',
    // );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    FailedCommonApiModel failedCommonApiModel = FailedCommonApiModel(
      id: 1,
      apiEndPoint: '${err.requestOptions.uri}',
      apiPayLoad: '${err.requestOptions.data}',
    );
    await failedCommonApiLocalDataSource.insertFailedApiWithPayLoad(
      failedCommonApiModel: failedCommonApiModel,
    );

    // await fileLoggerService.logToFile(
    //   pageType: 'API',
    //   logText: 'Error ⛔ ${err.requestOptions.method} ${err.requestOptions.uri}',
    //   apiName: err.requestOptions.path,
    //   extraInfo: 'Message: ${err.message}',
    // );
    handleRefreshToken(err, handler);
    handler.next(err);
  }

  void handleRefreshToken(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final config = MaerskIdentityServerDevConfig();
      try {
        final String? refreshToken = await appSecureStorageService.read(
          key: AppEncryptedStorageKeys.refreshToken,
        );

        if (refreshToken == null) {
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: AuthFailure(code: '', message: 'Token refresh exception'),
              type: DioExceptionType.badResponse,
              response: err.response,
            ),
          );
        }

        final url = config.getTokenEndpointUrl();

        final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

        final body = {
          'grant_type': 'refresh_token',
          'client_id': config.clientId,
          'client_secret': config.clientSecret,
          'refresh_token': refreshToken,
          'scope': 'openid profile api1 offline_access',
        };
        var dioOptions = Options(
          headers: headers,
          responseType: ResponseType.plain,
        );
        final response = await dio.post(url, options: dioOptions, data: body);

        if (response.statusCode == 200) {
          final responseData = json.decode(response.data);
          final newAccessToken = responseData['access_token'];
          final newRefreshToken = responseData['refresh_token'];

          await appSecureStorageService.write(
            key: AppEncryptedStorageKeys.accessToken,
            value: newAccessToken,
          );
          await appSecureStorageService.write(
            key: AppEncryptedStorageKeys.refreshToken,
            value: newRefreshToken,
          );

          // Retry the original request with the new access token
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          // Retry the original request
          return handler.resolve(await dio.fetch(err.requestOptions));
        } else {
          // Refresh token request failed, log out the user
          await appSecureStorageService.delete(
            key: AppEncryptedStorageKeys.accessToken,
          );
          await appSecureStorageService.delete(
            key: AppEncryptedStorageKeys.refreshToken,
          );

          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: AuthFailure(code: '', message: 'Token refresh exception'),
              type: DioExceptionType.badResponse,
              response: err.response,
            ),
          );
        }
      } on DioException catch (e) {
        return handler.next(e); // propagate refresh failure
      }
    }
  }
}
