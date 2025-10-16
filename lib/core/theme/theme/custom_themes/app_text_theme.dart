import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/constants/constant.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    // h4
    headlineLarge: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize24,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: AppColor.colorBlack,
    ),

    // h5
    headlineMedium: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize20,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorBlack,
    ),

    // h6
    headlineSmall: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize18,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: AppColor.colorHeadline3,
    ),

    titleLarge: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorBlack,
    ),

    titleMedium: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 22 / 14,
      color: AppColor.colorBlack2,
    ),

    titleSmall: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 1.0,
      color: AppColor.colorBlack,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize18,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 1.0,
      color: AppColor.colorBlack,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 1.0,
    ),
    bodySmall: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorBlack2,
    ),
    labelSmall: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize13,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 1.0,
      color: AppColor.colorBlack2,
    ),
    labelLarge: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 22 / 14,
      color: AppColor.colorSecondary,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    // h4
    headlineLarge: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize24,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorDividerLight,
    ),

    // h5
    headlineMedium: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize20,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),

    // h6
    headlineSmall: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize18,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorDividerLight,
    ),

    titleLarge: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorDividerLight,
    ),

    titleMedium: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 22 / 14,
      color: AppColor.colorDividerLight,
    ),

    titleSmall: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorDividerLight,
      height: 1.0,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize18,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorDividerLight,
      height: 1.0,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorDividerLight,
      height: 1.0,
    ),
    bodySmall: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColor.colorDividerLight,
    ),

    labelSmall: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize13,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 1.0,
      color: AppColor.colorCloseGrey,
    ),
    labelLarge: const TextStyle().copyWith(
      fontFamily: AppConstant.appFontFamily,
      fontSize: AppFontSize.fontSize14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 22 / 14,
      color: AppColor.colorButtonBorderColor,
    ),
  );
}
