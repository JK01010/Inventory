import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/widgets/app_bar_title_widget.dart';
import '../../core/extensions/theme_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBack,
    this.appBarPadding = AppPadding.scaffoldPadding,
    this.bottom,
    this.arrowBackColor,
    this.appBarTitleColor,
  });

  final String title;
  final List<Widget>? actions;
  final double appBarPadding;
  final void Function()? onBack;
  final PreferredSizeWidget? bottom;
  final Color? arrowBackColor;
  final Color? appBarTitleColor;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: AppSize.size0,
      title: Padding(
        padding: EdgeInsets.only(top: appBarPadding),
        child: AppBarTitleWidget(text: title, textColor: appBarTitleColor),
      ),
      leadingWidth: AppSize.appBarLeadingWidth,
      leading: InkWell(
        highlightColor: AppColor.colorTransparent,
        splashColor: AppColor.colorTransparent,
        onTap:
            onBack ??
            () {
              context.pop(true);
            },
        child: Padding(
          padding: EdgeInsets.only(top: appBarPadding, left: appBarPadding),
          child: Icon(
            Icons.arrow_back_ios,
            color:
                arrowBackColor ??
                context.customThemeColor(
                  light: AppColor.colorBlack,
                  dark: AppColor.colorWhite,
                ),
            // size: AppFontSize.fontSize18,
          ),
        ),
      ),
      actionsPadding: EdgeInsets.only(top: appBarPadding, right: appBarPadding),
      actions: actions,
      bottom: bottom,
    );
  }
}
