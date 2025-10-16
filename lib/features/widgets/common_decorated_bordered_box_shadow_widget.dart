import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class CommonDecoratedBorderedBoxShadowWidget extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  const CommonDecoratedBorderedBoxShadowWidget({super.key, required this.child, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColor.colorWhite,
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius15),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1), // Adjust color as needed
            offset: const Offset(0, 4), // X: 0, Y: 4
            blurRadius: 2, // Blur radius 2
            spreadRadius: -0.2, // Spread: -0.2 to approximate -0
          ),
        ],
      ),
      child: child,
    );
  }
}
