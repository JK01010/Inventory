import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import '../../core/extensions/theme_extension.dart';

class AppDecoratedBoxShadowWidget extends StatelessWidget {

  const AppDecoratedBoxShadowWidget({
    super.key,
    required this.child,
    this.borderRadius = AppBorderRadius.borderRadius15,
    this.boxBorder,
  });
  final Widget child;
  final double borderRadius;
  final BoxBorder? boxBorder;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.customThemeColor(
          light: AppColor.colorWhite,
          dark: AppColor.colorDarkProfileContainer,
        ),
        border: boxBorder,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: context.customThemeColor(
              light: AppColor.colorBlack6,
              dark: AppColor.colorTransparent,
            ),

            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
