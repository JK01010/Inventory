import 'dart:convert';
import 'package:oauth2/oauth2.dart';
class CredentialsJsonFormatter {
  static String format(Credentials credentials) {
    final jsonMap = {
      'access_token': credentials.accessToken,
      'refresh_token': credentials.refreshToken,
      'id_token': credentials.idToken,
      'token_endpoint': credentials.tokenEndpoint?.toString(),
      'scopes': credentials.scopes,
      'expiration': credentials.expiration?.millisecondsSinceEpoch
    };
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    return encoder.convert(jsonMap);
  }
}