import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class CustomCloseButton extends StatelessWidget {
  final void Function()? onPressed;

  const CustomCloseButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.size25,
      height: AppSize.size25,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.close, color: AppColor.colorGrey, size: 18),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
