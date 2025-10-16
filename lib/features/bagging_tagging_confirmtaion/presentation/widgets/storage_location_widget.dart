import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/extensions/theme_extension.dart';

class StorageLocationWidget extends StatelessWidget {
  const StorageLocationWidget({
    super.key,
    this.onTap,
    required this.titleLabel,
    this.isSelected = false,
  });

  final void Function()? onTap;
  final String titleLabel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: AppSize.size56,
          decoration: BoxDecoration(
            color:
                context.isDarkMode
                    ? AppColor.colorBGBlack
                    : AppColor.colorWhite,
            border: Border.all(
              color:
                  isSelected
                      ? AppColor.colorPrimary
                      : context.isDarkMode
                      ? AppColor.colorBGBlack
                      : AppColor.colorGrey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(AppBorderRadius.borderRadius20),
            ),
          ),
          child: InkWell(
            onTap: onTap,
            child: ListTile(
              leading: SvgPicture.asset(
                AppIcons.folderIcon,
                width: AppSize.size20,
                height: AppSize.size16,
                colorFilter:
                    context.isDarkMode
                        ? const ColorFilter.mode(
                          AppColor.listItemFieldDarkColor,
                          BlendMode.srcIn,
                        )
                        : null,
              ),
              title: Text(
                titleLabel,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: context.customThemeColor(
                    light: AppColor.colorCommonTextColor,
                    dark: AppColor.listItemFieldDarkColor,
                  ),
                  fontWeight: FontWeight.w400,
                  fontSize: AppFontSize.fontSize16,
                ),
              ),
              trailing: SvgPicture.asset(
                AppIcons.rightArrowIcon,
                width: AppSize.size6,
                height: AppSize.size11,
                colorFilter:
                    context.isDarkMode
                        ? const ColorFilter.mode(
                          AppColor.listItemFieldDarkColor,
                          BlendMode.srcIn,
                        )
                        : null,
              ),
            ),
          ),
        ),
        SizedBox(height: AppSize.size10),
      ],
    );
  }
}
