import 'package:flutter/material.dart';

import '../../../../core/constants/app_size.dart';

class GoodsReceiptValueWidget extends StatelessWidget {
  const GoodsReceiptValueWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: textTheme.headlineSmall?.copyWith(
        fontSize: AppFontSize.fontSize14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: 22 / 14,
      ),
    );
  }
}
