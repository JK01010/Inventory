abstract class IdentityServerConfiguration {
  String? get baseUrl;
  String? get authorizationEndpointUrl;
  String? get tokenEndpointUrl;
  String? get clientSecret;
  String? get clientId;
  String? get application;
  // bool? get silentRenew;
  List<String>? get scopes;
  String? get redirectUrl;
  String getTokenEndpointUrl() => baseUrl! + tokenEndpointUrl!;
  String getAuthorizationEndpointUrl() => baseUrl! + authorizationEndpointUrl!;
  String getIssuerUrl() => baseUrl!;
}
