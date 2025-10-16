import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/constants/constant.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  static final OutlineInputBorder _lightThemeBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
    borderSide: const BorderSide(color: AppColor.colorBlack3),
  );
  static final OutlineInputBorder _darkThemeBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
    borderSide: const BorderSide(color: AppColor.createLabelBorderDarkColor),
  );
  static final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
    borderSide: const BorderSide(color: AppColor.colorRed),
  );

  static final InputDecorationTheme _lightThemeInputDecoration =
      InputDecorationTheme(
        border: _lightThemeBorder,
        enabledBorder: _lightThemeBorder,
        focusedBorder: _lightThemeBorder,
        errorBorder: _errorBorder,
        disabledBorder: _lightThemeBorder,
        focusedErrorBorder: _errorBorder,
        //content padding added for adjust the size of text form field
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.padding16,
          vertical: AppPadding.padding14,
        ),
        hintStyle: const TextStyle(
          color: AppColor.colorBlack3,
          fontFamily: AppConstant.appFontFamily,
          fontSize: AppFontSize.fontSize14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          height: 22 / 14, // 157.143%
        ),
      );

  static final InputDecorationTheme _darkThemeInputDecoration =
      InputDecorationTheme(
        border: _darkThemeBorder,
        enabledBorder: _darkThemeBorder,
        focusedBorder: _darkThemeBorder,
        errorBorder: _errorBorder,
        disabledBorder: _darkThemeBorder,
        focusedErrorBorder: _errorBorder,
        //content padding added for adjust the size of text form field
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.padding16,
          vertical: AppPadding.padding14,
        ),
        hintStyle: const TextStyle(
          color: AppColor.colorBlack3,
          fontFamily: AppConstant.appFontFamily,
          fontSize: AppFontSize.fontSize14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          height: 22 / 14, // 157.143%
        ),
      );

  static final InputDecorationTheme lightInputDecorationTheme =
      _lightThemeInputDecoration;
  static final InputDecorationTheme darkInputDecorationTheme =
      _darkThemeInputDecoration;
}
