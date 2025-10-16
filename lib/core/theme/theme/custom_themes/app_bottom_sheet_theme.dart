import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class AppBottomSheetTheme {
  AppBottomSheetTheme._();
  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColor.colorWhite,
  );
  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColor.colorBGBlack
  );
}
