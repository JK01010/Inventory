import '../../../../config/network_config.dart';
import '../models/user_info_model.dart';

abstract interface class LoginRemoteDataSource {
  Future<UserInfoModel?> fetchUserInfo({required String baseUrl});

  Future<dynamic> logout({
    required String baseUrl,
    required Map<String, dynamic> parameters,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl({required AppNetworkClient appNetworkClient})
    : _appNetworkClient = appNetworkClient;

  final AppNetworkClient _appNetworkClient;

  @override
  Future<UserInfoModel?> fetchUserInfo({required String baseUrl}) async {
    final result = await _appNetworkClient.get('$baseUrl/connect/userinfo');
    return UserInfoModel.fromJson(result);
  }

  @override
  Future<dynamic> logout({
    required String baseUrl,
    required Map<String, dynamic> parameters,
  }) async {
    final result = await _appNetworkClient.get(
      baseUrl,
      queryParameters: parameters,
    );
    return result;
  }
}
