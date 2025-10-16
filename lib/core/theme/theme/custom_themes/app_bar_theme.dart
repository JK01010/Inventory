import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';

class AppBarThemeData {
  AppBarThemeData._();

  static const AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColor.colorBackground2,
    surfaceTintColor: AppColor.colorTransparent,
  );

  static const AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColor.colorBGBlackEnd,
    surfaceTintColor: AppColor.colorTransparent,
  );
}
