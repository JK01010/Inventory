import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class AppFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final BoxBorder? border;

  const AppFlatButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColor.colorTransparent,
    this.borderColor = AppColor.colorPrimary,
    this.textColor = AppColor.colorBlack,
    this.borderRadius = AppBorderRadius.borderRadius12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: AppSize.size45,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border ?? Border.all(color: borderColor),

          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
