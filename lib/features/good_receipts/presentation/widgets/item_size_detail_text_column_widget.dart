import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class ItemsSizeDetailTextColumnWidget extends StatelessWidget {
  final String title;
  final String value;
  const ItemsSizeDetailTextColumnWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: AppFontSize.fontSize13),
        ),
        SizedBox(height: AppSize.size4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontSize: AppFontSize.fontSize14,),
        ),
      ],
    );
  }
}