import 'dart:math';

import 'package:intl/intl.dart';

//use for modifiedOn
String getCurrentFormattedDateTime() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
  return formattedDate;
}

//use to generate transactionId
String generateMobRefId() {
  var random = Random().nextInt(1000);
  var timestamp = DateFormat("ddMMyyyyHHmmss").format(DateTime.now());
  return "$random$timestamp";
}