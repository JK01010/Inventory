import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/page/bagging_tagging_details_page.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

void showBottomPopup(BuildContext context, VoidCallback onClick) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder:
        (context) => Container(
          height: AppSize.size110,
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.padding30,
            horizontal: AppPadding.padding15,
          ),
          decoration: ShapeDecoration(
            color: AppColor.colorBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppBorderRadius.borderRadius20),
                topRight: Radius.circular(AppBorderRadius.borderRadius20),
              ),
            ),
          ),

          child: Container(
            // height: 70,
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.padding10,
              vertical: AppPadding.padding4,
            ),
            decoration: ShapeDecoration(
              color: AppColor.colorWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppBorderRadius.borderRadius12,
                ),
              ),
            ),
            child: InkWell(
              //borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.pop(context); // Close popup
                onClick(); // Call passed function
              },
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.syncIcon),
                  SizedBox(width: AppSize.size10),
                  Text(
                    context.loc.syncToWeb,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColor.colorTextBlack2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
