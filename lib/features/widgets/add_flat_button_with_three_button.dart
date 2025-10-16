import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/localization_extension.dart';
import '../../core/extensions/theme_extension.dart';
import 'app_flat_button.dart';

class AppThreeRowButtonWidget extends StatelessWidget {
  const AppThreeRowButtonWidget({
    super.key,
    required this.buttonSecondTitle,
    this.buttonFirstTitle,
    required this.buttonThreeTitle,
    this.buttonSecondTitleOnPressed,
    this.buttonThreeTitleOnPressed,
    this.cancelOnPressed,
  });

  final String buttonSecondTitle;
  final void Function()? buttonSecondTitleOnPressed;
  final void Function()? buttonThreeTitleOnPressed;
  final void Function()? cancelOnPressed;
  final String? buttonFirstTitle;
  final String buttonThreeTitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.customThemeColor(
          light: AppColor.colorWhite,
          dark: AppColor.colorBGBlack,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            offset: Offset(0, 2), // X: 0, Y: 2
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: AppFlatButton(
                text: context.l.cancel,
                onPressed: cancelOnPressed ?? () {},
                backgroundColor: context.customThemeColor(
                  light: AppColor.colorWhite,
                  dark: AppColor.colorBGBlack,
                ),
                textColor: AppColor.colorPrimary,
              ),
            ),
            SizedBox(width: AppSize.size8),
            Expanded(
              child: AppFlatButton(
                text: buttonSecondTitle,
                onPressed: buttonSecondTitleOnPressed ?? () {},
                backgroundColor: AppColor.colorPrimary,
                textColor: AppColor.colorWhite,
              ),
            ),
            SizedBox(width: AppSize.size8),
            Expanded(
              flex: 2,
              child: AppFlatButton(
                text: buttonThreeTitle,
                onPressed: buttonThreeTitleOnPressed ?? () {},
                backgroundColor: AppColor.colorPrimary,
                textColor: AppColor.colorWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
