import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/constants/constant.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static final ButtonStyle commonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      vertical: AppPadding.padding12,
      horizontal: AppPadding.padding103,
    ),
    backgroundColor: AppColor.colorPrimary,
    foregroundColor: AppColor.colorWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
      side: const BorderSide(
        color: AppColor.colorButtonBorderColor,
        width: 1.5,
      ),
    ),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: AppFontSize.fontSize16,
      fontFamily: AppConstant.appFontFamily,
    ),
  );

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: commonStyle,
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: commonStyle,
  );
}
