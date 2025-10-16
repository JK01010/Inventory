import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  //lightMode
  static const LinearGradient kAppBackgroundGradient = LinearGradient(
    begin: Alignment(0.50, 1.00),
    end: Alignment(0.50, 0.00),
    colors: [colorBackground, colorBackground2],
  );

  //darkMode
  static const LinearGradient kDarkAppBackgroundGradient = LinearGradient(
    begin: Alignment(0.50, 1.00),
    end: Alignment(0.50, 0.00),
    colors: [colorBGBlack, colorBGBlackEnd],
  );

  static const Color colorTransparent = Colors.transparent;
  static const Color colorPureBlack = Colors.black;
  static const Color colorPrimary = Color(0xFF42B0D5);
  static const Color colorPrimaryDark = Color(0xFF2492B7);
  static const Color colorSecondary = Color(0xFF204259);
  static const Color colorButtonBorderColor = Color(0xFF42B0D5);
  static const Color colorBackground = Color(0xFFF5F9FF); //backgroundWhite
  static const Color colorBackground2 = Color(0xFFD7E9F9); //backgroundBlue
  static const Color colorButtonBorderColor2 = Color(0xFF37A6CB);
  static const Color colorGreen = Color(0xFF56BD7F);
  static const Color colorOrange = Color(0xFFFE6231);
  static const Color colorRed = Color(0xFFFE6A6A);
  static const Color colorYellow = Color(0xFFF4A52B);
  static const Color colorDynamicIsland = Color(0xFFDBEBFA);
  static const Color colorBlack = Color(0xFF363636);
  static const Color colorBGBlack = Color(0xFF151D2B);
  static const Color colorBlack2 = Color(0xFF666666);
  static const Color colorBlack3 = Color(0xFF9A9A9A);
  static const Color colorBlack5 = Color(0xFFEDEDED);
  static const Color colorBackground3 = Color(0xFFF2FCFF);
  static const Color colorBackground4 = Color(0xFFF5FEF9);
  static const Color colorBlack6 = Color(0xFFE0E0E0);
  static const Color colorWhite = Colors.white;
  static const Color colorGrey = Color(0xFFC8C8C8);
  static const Color colorCloseGrey = Color(0xFFD1D1D1);
  static const Color colorLightGrey = Color(0xFFEBEBEB);


  static const Color colorIconBackgroundGrey = Color(0xFFEFF5FD);
  static const Color closeButtonColor = Color(0xFFF1F1F1);

  static const Color colorHeadline3 = Color(0xFF353535);
  static const Color colorGrey2 = Color(0xFFE3E8EF);
  static const Color bgColorRedShade100 = Color(0xFFFFEBEB);
  static const Color bgColorGreenShade100 = Color(0xFFF5FEF9);
  static const Color redColor = Color(0xFFF73C3C);

  static const Color colorBoxShadow = Color(0x21000000);
  static const Color colorCommonTextColor = Color(0xFF373737);
  static const Color colorBackground5 = Color(0xFFF1F1F1);
  static const Color colorTextBlack3 = Color(0xFF9A9A9A);
  static const Color colorTextBlack2 = Color(0xFF666666);
  static const Color colorCommonTextColor2 = Color(0xFF676767);
  static const Color colorDarkRed = Color(0xFFF73C3C);
  static const Color colorDividerDark = Color(0xFF3D3D3D);
  static const Color colorDividerLight = Color(0xFFE7E7E7);
  static const Color colorDarkProfileContainer = Color(0xFF29313E);
  static const Color colorYesText = Color(0xFF29CF8B);

  static const Color borderShadowColor = Color(0x00000033);

  static const Color colorGrey3 = Color(0xFFD9D9D9);

  static const Color slateGrayishPurpleColor = Color(0xFF68657E);

  static const Color colorBlue1 = Color(0xffB9DAF1);
  static const Color colorMediumGrey = Color(0xffB0B0B0);
  static const Color colorBGBlackEnd = Color(0xff202939);
  static const Color colorDarkDivider = Color(0xff1A2833);
  static const Color createLabelBorderDarkColor = Color(0xff47556E);
  static const Color itemBgDarkColor = Color(0xff202939);
  static const Color listItemFieldDarkColor = Color(0xffB0B0B0);
  static const Color dividerDarkColor = Color(0xff1A2833);
  static const Color lightFillColor = Colors.white;
  static const Color darkFillColor = colorBGBlackEnd;
  static const Color barCodeScannerBgColorLight = Color(0xFF284759);
  static const Color commonDividerWhite = Color(0xffECF2F9);
  static const Color commonDividerBlack = Color(0xff1A2833);
}
