import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/localization_extension.dart';
import '../../core/extensions/theme_extension.dart';

Widget commonNoDataFound(BuildContext context) {
  return Expanded(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.noItemIcon),
          const SizedBox(height: AppSize.size6),
          Text(
            context.l.noItemsFound,
            style: TextStyle(
              color: context.customThemeColor(
                light: AppColor.colorTextBlack2,
                dark: AppColor.colorCloseGrey,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget commonNoDataFoundTwo(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppIcons.noItemIcon),
        const SizedBox(height: AppSize.size6),
        Text(
          context.l.noItemsFound,
          style: TextStyle(
            color: context.customThemeColor(
              light: AppColor.colorTextBlack2,
              dark: AppColor.colorCloseGrey,
            ),
          ),
        ),
      ],
    ),
  );
}

void showSuccessPopup(String msg, BuildContext context) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColor.colorButtonBorderColor,
    textColor: AppColor.colorWhite,
    fontSize: 14.0,
  );
}
