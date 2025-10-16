import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';

class YesNoWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const YesNoWidget._({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  /// Factory constructor for "Yes"
  factory YesNoWidget.yes(BuildContext context) {
    return YesNoWidget._(
      text: context.l.yes,
      backgroundColor: AppColor.colorYesText,
      textColor: AppColor.colorWhite,
    );
  }

  /// Factory constructor for "No"
  factory YesNoWidget.no(BuildContext context) {
    return YesNoWidget._(
      text: context.l.no,
      backgroundColor: AppColor.colorGrey2,
      textColor: AppColor.colorBlack,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
      ),
      child: SizedBox(
        width: AppSize.size40,
        height: AppSize.size20,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.padding1),
          child: Text(
            text,
            style: TextStyle(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
