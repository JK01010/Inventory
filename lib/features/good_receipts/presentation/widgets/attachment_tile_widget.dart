import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class AttachmentTileWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  const AttachmentTileWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(AppBorderRadius.borderRadius8),
            ),
            child: File(imagePath).existsSync()?
            Image.file(
                File(imagePath),
                height: AppSize.size48,
                width: AppSize.size48,
                fit: BoxFit.cover):
            Image.asset(
              imagePath,
              height: AppSize.size48,
              width: AppSize.size48,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: AppSize.size10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                // color: AppColor.colorBlack,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(subtitle, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ],
    );
  }
}
