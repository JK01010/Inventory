 import 'dart:convert';
import 'dart:math';

String generateRandomPassword(int length) {
final rand = Random.secure();
final values = List<int>.generate(length, (i) => rand.nextInt(256));
return base64UrlEncode(values);
}