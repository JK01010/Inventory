import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/widgets/custom_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/theme_extension.dart';

class CustomPreImageButton extends StatelessWidget {
  final String buttonName;
  final Color? buttonNameColor;
  final Color? color;
  final String iconName;
  final void Function() onTap;

  const CustomPreImageButton({
    super.key,
    required this.buttonName,
    this.buttonNameColor = AppColor.colorPrimary,
    this.color = AppColor.colorPrimary,
    this.iconName = AppIcons.addIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: AppSize.size45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.customThemeColor(
              light: AppColor.colorIconBackgroundGrey,
              dark: AppColor.colorDarkProfileContainer,
            ),
            width: 0.1,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                iconName,
                height: AppSize.size25,
                width: AppSize.size25,
              ),
            ),
            CustomText(text: buttonName, color: buttonNameColor),
          ],
        ),
      ),
    );
  }
}
