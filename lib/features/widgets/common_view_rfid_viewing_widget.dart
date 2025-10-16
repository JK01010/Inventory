import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../core/extensions/localization_extension.dart';
import '../item_master/domin/entities/item_master_rfid_view_entity_model.dart';


class CommonListingRfidWidget extends StatelessWidget {
  const CommonListingRfidWidget({super.key,required this.item, required this.count});

  final ItemMasterRfidViewEntity item;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${context.l.rfid } $count", style: context.textTheme.titleMedium?.copyWith(
            ),),
            Text(item.rfidId,
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColor.colorPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}



