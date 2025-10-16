import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class AppBarTitleWidget extends StatelessWidget {
  const AppBarTitleWidget({super.key, required this.text,this.textColor});
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: textTheme.headlineSmall?.copyWith(
        fontSize: AppFontSize.fontSize17,
        fontWeight: FontWeight.w700,
        color: textColor
      ),
    );
  }
}
