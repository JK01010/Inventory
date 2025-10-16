import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/localization_extension.dart';
import 'app_flat_button.dart';

void showSyncOfflinePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColor.colorWhite,
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
              SvgPicture.asset(AppIcons.syncWarningIcon),
              const SizedBox(height: AppSize.size18),

              // Message Text
              Text(
                context.l.syncWarning,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  color: AppColor.colorBlack,
                ),
              ),
              const SizedBox(height: AppSize.size40),

              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: AppFlatButton(
                      backgroundColor: AppColor.colorWhite,
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
                        context.pop();
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