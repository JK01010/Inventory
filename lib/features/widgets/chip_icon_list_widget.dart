import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_enum.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/widgets/chip_icon_widget.dart';

class ChipIconListWidget extends StatelessWidget {
  const ChipIconListWidget({super.key, required this.chipStatusList});
  final List<ChipStatus> chipStatusList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.padding10,
        horizontal: AppPadding.padding20,
      ),
      child: Row(
        children: [
          ...List.generate(
            chipStatusList.length,
            (index) => Row(
              children: [
                ChipWidget.fromStatus(context, chipStatusList[index]),
                SizedBox(width: AppSize.size10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
