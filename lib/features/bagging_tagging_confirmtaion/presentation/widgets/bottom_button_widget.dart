import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/widgets/app_flat_button.dart';

import '../../../../core/extensions/theme_extension.dart';

class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({
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
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.padding18,
          horizontal: AppPadding.padding20,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: AppFlatButton(
                text: buttonFirstTitle ?? context.l.cancel,
                onPressed:
                    buttonFirstOnPress ??
                    () {
                      context.pop();
                    },
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
