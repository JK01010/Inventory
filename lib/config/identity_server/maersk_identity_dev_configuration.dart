import '../../core/constants/api_constant.dart';
import 'identity_server_configuration.dart';

class MaerskIdentityServerDevConfig extends IdentityServerConfiguration {
  @override
  String? baseUrl = '${ApiConstant.apiPath}/IdentityServer';

  @override
  String? authorizationEndpointUrl = '/connect/authorize?prompt=login';
  @override
  String? tokenEndpointUrl = '/connect/token';
  @override
  String? clientSecret = 'Welcome@123';
  @override
  String? application = 'Mobile';
  @override
  String? clientId = 'PALngMobileIRTMaersk';
  @override
  String? redirectUrl = 'com.mariapps.inventory.maersk://loginview';
  @override
  List<String>? scopes = ('openid profile api1 offline_access').split(' ');
}
