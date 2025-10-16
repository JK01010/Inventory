import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/widgets/app_flat_button.dart';

import '../../../../core/extensions/theme_extension.dart';

class GoodsReceiptsBottomBarWidget extends StatelessWidget {
  GoodsReceiptsBottomBarWidget({
    required this.onDraftSave,
    required this.onFinalizeSave,
    super.key,
  });

  VoidCallback onDraftSave;
  VoidCallback onFinalizeSave;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color:
          context.isDarkMode ? AppColor.colorBGBlack : AppColor.colorBackground,
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
                    backgroundColor:
                        context.isDarkMode
                            ? AppColor.colorBGBlack
                            : AppColor.colorWhite,
                    textColor: AppColor.colorPrimary,
                    text: context.l.cancel,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: AppSize.size8),
                Expanded(
                  child: AppFlatButton(
                    backgroundColor:
                        context.isDarkMode
                            ? AppColor.colorBGBlack
                            : AppColor.colorWhite,
                    textColor: AppColor.colorPrimary,
                    text: context.l.draft,
                    onPressed: () {
                      onDraftSave();
                    },
                  ),
                ),
                SizedBox(width: AppSize.size8),
                Expanded(
                  child: AppFlatButton(
                    backgroundColor: AppColor.colorPrimary,
                    textColor: AppColor.colorWhite,
                    text: context.l.finalize,
                    onPressed: () {
                      onFinalizeSave();
                    },
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
