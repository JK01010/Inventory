import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class SyncButtonWidget extends StatelessWidget {
  const SyncButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Container(
        padding: EdgeInsets.all(AppPadding.padding6_6),
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
          border: Border.all(color: AppColor.colorPrimary, width: 1.5),
        ),
        child: SvgPicture.asset(
          AppIcons.syncIcon,
          height: AppSize.size19,
          width: AppSize.size19,
        ),
      ),
    );
  }
}
