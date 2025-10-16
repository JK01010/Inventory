import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/theme_extension.dart';

class BottomSheetHeaderWidget extends StatelessWidget {
  //complete this function
  const BottomSheetHeaderWidget({super.key, required this.title, this.onTap});

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding18,
            vertical: AppPadding.padding10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.customThemeColor(
                    light: AppColor.colorBlack2,
                    dark: AppColor.colorDividerLight,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset(
                  context.isDarkMode
                      ? AppIcons.closeDarkIcon
                      : AppIcons.closeIcon,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
