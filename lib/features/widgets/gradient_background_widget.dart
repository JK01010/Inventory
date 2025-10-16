import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/extensions/theme_extension.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient:
            context.isDarkMode
                ? AppColor.kDarkAppBackgroundGradient
                : AppColor.kAppBackgroundGradient,

      ),
      child: SafeArea(top: false, child: child),
    );
  }
}
