import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';

import '../../../widgets/app_decorated_box_shadow_widget.dart';


import '../../domin/entities/item_master_common_entity_model.dart';
import 'item_detail_row.dart';

class ItemMasterList extends StatelessWidget {


  const ItemMasterList({super.key, required this.itemList, this.onTap});
  final ItemMasterEntity itemList;
  final void Function()? onTap;

  @override

  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        itemList.itemName,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: onTap,
                        child: SvgPicture.asset(AppIcons.iconTag)),
                  ],
                ),
                SizedBox(height: AppSize.size10),
                // GRN no and category row
                ItemDetailRow(
                  titleFirst: context.l.equipmentName,
                  valueFirst: itemList.equipmentName,
                  titleSecond: context.l.drawingNo,
                  valueSecond: itemList.drawingNo,
                ),

                SizedBox(height: AppSize.size10),
                // Title section

                ItemDetailRow(
                  titleFirst: context.l.partNo,
                  valueFirst: itemList.partNo,
                  titleSecond: context.l.articleName,
                  valueSecond: itemList.articleNumber, //todo :itemId changes articleName
                    spacer:AppSize.size105
                ),
              ],
            ),
          ),
          // Title
        ],
      ),
    );
  }
}