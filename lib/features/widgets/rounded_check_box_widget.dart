import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/theme_extension.dart';

class RoundedCheckBoxWidget extends StatelessWidget {
  const RoundedCheckBoxWidget({
    super.key,
    required this.value,
    required this.onTap,
  });

  final bool value;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              value
                  ? AppColor.colorPrimary
                  : context.isDarkMode
                  ? AppColor.colorTransparent
                  : AppColor.colorWhite,
          border: value ? null : Border.all(color: Colors.grey, width: 1.5),
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
                  : SizedBox(
                    height: AppSize.size16,
                    width: AppSize.size16,
                  ), // no icon when false
        ),
      ),
    );
  }
}
