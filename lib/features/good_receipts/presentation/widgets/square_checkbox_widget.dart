import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class SquareCheckboxWidget extends StatelessWidget {
  final bool value;
  final void Function()? onTap;
  const SquareCheckboxWidget({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: value ? AppColor.colorPrimary : AppColor.colorTransparent,
          border: value ? null : Border.all(color: AppColor.colorTextBlack3, width: AppSize.size2),
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.padding4),
          child:
          value
              ? Icon(
            Icons.check,
            size: AppIconSize.size16,
            color: AppColor.colorWhite,
          )
              : SizedBox(height: AppSize.size16, width: AppSize.size16), // no icon when false
        ),
      ),
    );
  }
}
