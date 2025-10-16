import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/localization_extension.dart';
import '../../core/extensions/theme_extension.dart';
import 'app_flat_button.dart';
import 'app_flat_button_with_icon.dart';

class AppTwoRowButtonWidget extends StatelessWidget {
  const AppTwoRowButtonWidget({
    super.key,
    required this.buttonSecondTitle,
    this.buttonFirstTitle,
    this.buttonSecondOnPress,
    this.buttonFirstOnPress,
  });

  final String? buttonFirstTitle;
  final String buttonSecondTitle;

  final void Function()? buttonSecondOnPress;
  final void Function()? buttonFirstOnPress;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            context.isDarkMode
                ? AppColor.colorTransparent
                : AppColor.colorWhite,
        // boxShadow: [
        //   BoxShadow(
        //     color: Color.fromRGBO(0, 0, 0, 0.13), // #000000 with 13% opacity
        //     offset: Offset(0, 2), // X: 0, Y: 2
        //     blurRadius: 4,
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.padding18,
          horizontal: AppPadding.padding20,
        ),
        child: Row(
          children: <Widget>[
            buttonFirstTitle == null
                ? Expanded(
                  child: AppFlatButton(
                    text: buttonFirstTitle ?? context.l.cancel,
                    onPressed: buttonFirstOnPress ?? () {},
                    backgroundColor:
                        context.isDarkMode
                            ? AppColor.colorTransparent
                            : AppColor.colorWhite,
                    textColor: AppColor.colorPrimary,
                  ),
                )
                : Expanded(
                  child: AppFlatButtonWithIcon(
                    text: buttonFirstTitle ?? context.l.cancel,
                    onPressed: buttonFirstOnPress ?? () {},
                    backgroundColor:
                        context.isDarkMode
                            ? AppColor.colorTransparent
                            : AppColor.colorWhite,
                    textColor: AppColor.colorPrimary,
                  ),
                ),
            SizedBox(width: AppSize.size10),
            Expanded(
              child: AppFlatButton(
                text: buttonSecondTitle,
                onPressed: buttonSecondOnPress ?? () {},
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
