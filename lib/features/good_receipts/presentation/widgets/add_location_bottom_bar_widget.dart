import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../bagging_tagging_confirmtaion/presentation/widgets/custom_pre_image_button.dart';

class AddLocationBottomBarWidget extends StatelessWidget {
  const AddLocationBottomBarWidget({
    super.key,
    required this.onTap,
    required this.buttonName,
    required this.iconName,
  });

  final void Function() onTap;
  final String buttonName;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: AppSize.size10),
                Container(
                  height: AppSize.size4,
                  width: AppSize.size70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderRadius12,
                    ),
                    color: AppColor.colorGrey3,
                  ),
                ),
                SizedBox(height: AppSize.size30),
                CustomPreImageButton(
                  buttonName: buttonName,
                  onTap: onTap,
                  iconName: iconName,
                  color: context.customThemeColor(
                    light: AppColor.colorWhite,
                    dark: AppColor.colorDarkProfileContainer,
                  ),
                  buttonNameColor: context.customThemeColor(
                    light: AppColor.colorTextBlack2,
                    dark: AppColor.colorDividerLight,
                  ),
                ),
                SizedBox(height: AppSize.size20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
