import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../theme/theme_bloc.dart';
import '../../../theme/theme_event.dart';
import '../page/dark_mode_switch.dart';

class ProfileDrawerItemsWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool switchButton;
  final void Function()? onTap;
  final double? padding;
  final bool? showArrow;
  final bool? isColorFilterEnabled;

  const ProfileDrawerItemsWidget({
    super.key,
    required this.title,
    required this.icon,
    this.switchButton = false,
    this.onTap,
    this.padding,
    this.showArrow,
    this.isColorFilterEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(padding ?? AppPadding.padding0),
                child: SvgPicture.asset(
                  icon,
                  colorFilter:
                      isColorFilterEnabled == true
                          ? ColorFilter.mode(
                            context.customThemeColor(
                              light: AppColor.colorBlack2,
                              dark: AppColor.colorCloseGrey,
                            ),
                            BlendMode.srcIn,
                          )
                          : null,
                ),
              ),
              SizedBox(width: AppSize.size10),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: AppFontSize.fontSize16,
                ),
                maxLines: 1,
              ),
            ],
          ),
          switchButton == true
              ? Flexible(
                child: SizedBox(
                  width: AppSize.size60,
                  height: AppSize.size24,
                  child: DarkModeSwitch(
                    onToggle: (value) {
                      context.read<ThemeBloc>().add(
                        ToggleThemeEvent(
                          context.read<ThemeBloc>().state.themeMode ==
                                  ThemeMode.dark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        ),
                      );
                    },
                  ),
                ),
              )
              : SizedBox(),
          showArrow == true
              ? Flexible(
                child: SizedBox(
                  height: AppSize.size12,
                  child: SvgPicture.asset(
                    AppIcons.rightArrowIcon,
                    colorFilter: ColorFilter.mode(
                      context.customThemeColor(
                        light: AppColor.colorBlack2,
                        dark: AppColor.colorCloseGrey,
                      ),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
