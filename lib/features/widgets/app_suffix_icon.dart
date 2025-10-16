import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import '../../core/constants/app_colors.dart';
import '../../core/extensions/theme_extension.dart';

class AppSuffixIcon extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;

  const AppSuffixIcon({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppPadding.padding20),
      child: SvgPicture.asset(
        imagePath,
        width: width ?? AppSize.size30,
        height: height ?? AppSize.size30,
        colorFilter: ColorFilter.mode(
          context.customThemeColor(
            light: AppColor.colorBlack2,
            dark: AppColor.colorCloseGrey,
          ),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
