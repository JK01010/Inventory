import 'package:flutter/material.dart' hide AppBarThemeData;
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/constant.dart';
import 'package:pal_ng_inventory/core/theme/theme/custom_themes/app_bar_theme.dart';
import 'package:pal_ng_inventory/core/theme/theme/custom_themes/app_bottom_sheet_theme.dart';
import 'package:pal_ng_inventory/core/theme/theme/custom_themes/app_elevated_button_theme.dart';
import 'package:pal_ng_inventory/core/theme/theme/custom_themes/app_text_form_field_theme.dart';
import 'package:pal_ng_inventory/core/theme/theme/custom_themes/app_text_selection_theme.dart';
import 'package:pal_ng_inventory/core/theme/theme/custom_themes/app_text_theme.dart';

import 'custom_themes/app_card_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppConstant.appFontFamily,
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    appBarTheme: AppBarThemeData.lightAppBarTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    textSelectionTheme: AppTextSelectionTheme.lightTextSelectionThemeData,
    scaffoldBackgroundColor: AppColor.colorTransparent,
    cardTheme: AppCardTheme.lightCardTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppConstant.appFontFamily,
    brightness: Brightness.dark,
    textTheme: AppTextTheme.darkTextTheme,
    appBarTheme: AppBarThemeData.darkAppBarTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
    textSelectionTheme: AppTextSelectionTheme.darkTextSelectionThemeData,
    scaffoldBackgroundColor: AppColor.colorTransparent,
    cardTheme: AppCardTheme.darkCardTheme
  );
}
