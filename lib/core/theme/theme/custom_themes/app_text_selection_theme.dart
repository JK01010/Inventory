import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class AppTextSelectionTheme {
  AppTextSelectionTheme._();

  static final TextSelectionThemeData lightTextSelectionThemeData =
      TextSelectionThemeData(
        cursorColor: AppColor.colorBlack,
            selectionHandleColor:AppColor.colorBlack,
      );
  static final TextSelectionThemeData darkTextSelectionThemeData =
      TextSelectionThemeData(
        cursorColor: AppColor.colorBlack5,
        selectionHandleColor:AppColor.colorBlack5,
      );
}
