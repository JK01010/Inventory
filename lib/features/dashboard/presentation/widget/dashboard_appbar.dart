import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/theme_extension.dart';
import 'dashboard_heading.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,

      backgroundColor: context.customThemeColor(
        light: AppColor.colorBackground2,
        dark: AppColor.colorBGBlackEnd,
      ),
      flexibleSpace: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.customThemeColor(
                    light: AppColor.colorWhite,
                    dark: AppColor.colorDarkProfileContainer,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppBorderRadius.borderRadius30,
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.padding10),
                  child: SvgPicture.asset(
                    AppIcons.dashBoardIcon,
                    height: AppSize.size22,
                    width: AppSize.size22,
                    colorFilter:
                        context.isDarkMode
                            ? ColorFilter.mode(
                              AppColor.colorWhite,
                              BlendMode.srcIn,
                            )
                            : null,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppSize.size20),
            DashboardHeading(),
          ],
        ),
      ),
    );
  }
}
