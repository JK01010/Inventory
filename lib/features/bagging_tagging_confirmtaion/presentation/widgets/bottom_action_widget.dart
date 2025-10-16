import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/page/bagging_tagging_details_page.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/widgets/custom_button.dart';

import '../../../../core/extensions/theme_extension.dart';

class BottomActionWidget extends StatelessWidget {
  const BottomActionWidget({
    Key? key,
    required this.onCancelTapCallback,
    required this.onSelectTapCallback,
  }) : super(key: key);

  final VoidCallback onCancelTapCallback;
  final VoidCallback onSelectTapCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:context.isDarkMode?AppColor.colorBGBlack :
        AppColor.colorBackground,
        boxShadow: [
          BoxShadow(
            color: AppColor.colorBoxShadow,
            blurRadius: 8,
            offset: Offset(0, 0),
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.padding20,
        vertical: AppPadding.padding18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            buttonName: context.loc.cancelButtonText,
            color: context.isDarkMode?AppColor.colorTransparent
                :
            AppColor.colorWhite,
            buttonNameColor: AppColor.colorPrimary,
            onTap: () {
              onCancelTapCallback();
              // context.pop();
            },
          ),
          CustomButton(
            buttonName: context.loc.select,
            color: AppColor.colorPrimary,
            buttonNameColor: AppColor.colorWhite,
            onTap: () {
              onSelectTapCallback();
              // context.pop();
            },
          ),
        ],
      ),
    );
  }
}
