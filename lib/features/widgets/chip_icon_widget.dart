import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_enum.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';

class ChipWidget extends StatelessWidget {
  final String chipText;
  final Color color;

  const ChipWidget({super.key, required this.chipText, required this.color});

  factory ChipWidget.fromStatus(BuildContext context, ChipStatus status) {
    switch (status) {
      case ChipStatus.ihm:
        return ChipWidget(chipText: context.l.ihm, color: AppColor.colorRed);
      case ChipStatus.chipNew:
        return ChipWidget(
          chipText: context.l.newTxt,
          color: AppColor.colorPrimary,
        );

      case ChipStatus.partiallyReceived:
        return ChipWidget(
          chipText: context.l.partiallyReceived,
          color: AppColor.colorYellow,
        );
      case ChipStatus.fullyReceived:
        return ChipWidget(
          chipText: context.l.fullyReceived,
          color: AppColor.colorPrimary,
        );
      case ChipStatus.groupTagged:
        return ChipWidget(
          chipText: context.l.groupTagged,
          color: AppColor.colorGreen,
        );
      case ChipStatus.noDataFound:
        return ChipWidget(
          chipText: "No Data Found",
          color:  AppColor.colorRed
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppSize.size8),
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.padding10,
        vertical: AppPadding.padding5,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
      ),
      child: Text(
        chipText,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
        textAlign: TextAlign.center,
      ),
    );
  }
}
