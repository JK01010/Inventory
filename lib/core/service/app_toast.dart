import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static void showToast({
    required String msg,
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.CENTER,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    double fontSize = 16,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: toastGravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
