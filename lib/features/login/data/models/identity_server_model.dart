import 'package:oauth2/oauth2.dart';

abstract class IdentityServerResponse {
  String get message;
}

class IdentityServerAuthenticationResult implements IdentityServerResponse {

  IdentityServerAuthenticationResult({
    required this.message,
    required this.credential,
  });
  @override
  final String message;
  final Credentials credential;
}


class IdentityServerAuthenticationError implements IdentityServerResponse {

  IdentityServerAuthenticationError({required this.message});
  @override
  final String message;
}
