import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_flat_button.dart';
import '../goods_receipts_po_bloc/goods_receipts_po_bloc.dart';

void showUnlockInfoPopup(BuildContext context, String poId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor:
            context.isDarkMode ? AppColor.colorBGBlack : AppColor.colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.padding18,
            vertical: AppPadding.padding34,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Info Icon Circle
              SvgPicture.asset(AppIcons.editablePopUpIcon),
              const SizedBox(height: AppSize.size18),

              // Message Text
              Text(
                context.l.thisRecordLocked,
                textAlign: TextAlign.center,

                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: AppSize.size40),

              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: AppFlatButton(
                      backgroundColor: context.customThemeColor(
                        light: AppColor.colorWhite,
                        dark: AppColor.colorTransparent,
                      ),
                      textColor: AppColor.colorPrimary,
                      text: context.l.cancel,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  SizedBox(width: AppSize.size10),
                  Expanded(
                    child: AppFlatButton(
                      backgroundColor: AppColor.colorPrimary,
                      textColor: AppColor.colorWhite,
                      text: context.l.okay,
                      onPressed: () {
                        context
                          ..pop()
                          ..pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
