import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_size.dart';

class AppCardTheme {
  AppCardTheme._();

  static const BorderRadiusGeometry _cardBorderRadius = BorderRadius.all(
    Radius.circular(AppBorderRadius.borderRadius15),
  );

  static final lightCardTheme = CardThemeData(
    color: AppColor.colorWhite,
    elevation: 2,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: _cardBorderRadius),
    // margin: const EdgeInsets.all(AppPadding.padding10),
  );

  static final darkCardTheme = CardThemeData(
    color: AppColor.colorDarkProfileContainer,
    elevation: 2,
    shadowColor: Colors.black54,
    shape: RoundedRectangleBorder(borderRadius: _cardBorderRadius),
    // margin: const EdgeInsets.all(AppPadding.padding10),
  );
}
