import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/widgets/app_flat_button.dart';

class ChooseStorageLocationBottomBarWidget extends StatelessWidget {
  const ChooseStorageLocationBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColor.colorWhite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppSize.size10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.padding16,
              vertical: AppPadding.padding8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: AppFlatButton(
                    backgroundColor: AppColor.colorWhite,
                    textColor: AppColor.colorPrimary,
                    text: context.l.cancel,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: AppSize.size8),
                Expanded(
                  child: AppFlatButton(
                    backgroundColor: AppColor.colorPrimary,
                    textColor: AppColor.colorWhite,
                    text: context.l.select,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
