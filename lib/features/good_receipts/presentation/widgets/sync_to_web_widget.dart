import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';

class SyncToWebWidget extends StatelessWidget {
  const SyncToWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.scaffoldPadding * 2),
      child: Row(
        children: [
          Icon(Icons.sync, color: AppColor.colorPrimary),
          SizedBox(width: AppSize.size10),
          Text(
            context.l.syncToWeb,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColor.colorPrimary),
          ),
        ],
      ),
    );
  }
}
