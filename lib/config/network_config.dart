import 'package:dio/dio.dart';

import '../core/di/service_locator.dart';
import '../core/utils/app_logger.dart';
import '../core/utils/helper.dart';

abstract class AppNetworkClient {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> post(
    String url, {
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<dynamic> postMultipart(
    String url, {
    required FormData formData,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });
}

class DioNetworkClient implements AppNetworkClient {
  DioNetworkClient({required Dio dio}) : _dio = dio;
  final Dio _dio;

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(headers: headers),
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );

      if (response.statusCode != 200) {
        logException(
          name: "$url Exception",
          log: response.statusMessage ?? "Unknown error",
        );
      }

      return response.data;
    } on DioException catch (e) {
      // This catches Dio-specific errors
      logException(
        name: "$url DioException",
        log: e.message ?? 'Unknown Dio error',
      );

      // Optional: You can also log e.response?.data for server-side error message
      if (e.response != null) {
        logException(
          name: "$url Error Response",
          log: e.response?.data.toString() ?? 'No response body',
        );
      }

      rethrow; // Rethrow if you want it to propagate
    } catch (e, stackTrace) {
      // For other types of exceptions
      logException(name: "$url Unknown Exception", log: e.toString());
      rethrow;
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      if (response.statusCode != 200 || response.statusCode != 201) {
        logException(
          name: "$url Exception",
          log: response.statusMessage ?? "Unknown error",
        );
        // sl<AppLogger>().debug(
        //   "Api Error : $url \n ${response.statusCode} \n ${response.statusMessage}",
        // );
      }

      return response.data;
    } on DioException catch (e) {
      // This catches Dio-specific errors
      logException(
        name: "$url DioException",
        log: e.message ?? 'Unknown Dio error',
      );

      // Optional: You can also log e.response?.data for server-side error message
      if (e.response != null) {
        logException(
          name: "$url Error Response",
          log: e.response?.data.toString() ?? 'No response body',
        );
      }

      rethrow; // Rethrow if you want it to propagate
    } catch (e, stackTrace) {
      // For other types of exceptions
      logException(name: "$url Unknown Exception", log: e.toString());
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.put(
      url,
      data: data,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
    return response.data;
  }

  @override
  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.delete(
      url,
      data: data,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
    return response.data;
  }

  @override
  Future<dynamic> postMultipart(
    String url, {
    required FormData formData,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post(
      url,
      data: formData,
      options: Options(
        headers: {...?headers, 'Content-Type': 'multipart/form-data'},
      ),
      cancelToken: cancelToken,
    );
    return response.data;
  }
}
