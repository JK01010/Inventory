import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal_ng_inventory/core/constants/app_enum.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/purchase_order/presentation/widgets/item_detail_row_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_decorated_box_shadow_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_heading_widget.dart';
import 'package:pal_ng_inventory/features/widgets/chip_icon_list_widget.dart';

class ProfileSyncCardWidget extends StatelessWidget {
  final String headingText;
  final String sentDate;
  final String category;
  final String title;
  final String syncIconPath;
  final List<ChipStatus> chipStatusList;
  const ProfileSyncCardWidget({
    super.key,
    required this.headingText,
    required this.sentDate,
    required this.category,
    required this.title,
    required this.chipStatusList,
    required this.syncIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppHeadingWidget(text: title),
                    SvgPicture.asset(
                      syncIconPath,
                      height: AppSize.size24,
                      width: AppSize.size24,
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
                // GRN no and category row
                ItemDetailRowWidget(
                  titleFirst: context.l.poSentDate,
                  valueFirst: sentDate,
                  titleSecond: context.l.category,
                  valueSecond: category,
                ),
              ],
            ),
          ),
          // Title
          Divider(height: 0),
          ChipIconListWidget(chipStatusList: chipStatusList),
        ],
      ),
    );
  }
}
