import 'package:flutter/material.dart';

import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../domin/entities/con_transaction_view_entity_model.dart';
import 'consumption_transaction_card_widget.dart';
import 'single_heading_text.dart';

class ConsumptionTransactionList extends StatelessWidget {


  const ConsumptionTransactionList({super.key, required this.itemList});
  final ConTransactionViewEntity itemList;

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
                ConsumptionTransactionCardWidget( //reused from goods receipts
                  text: itemList.itemName,
                  syncStatus: itemList.syncStatus == "N" ? SyncStatus.unSynced : SyncStatus.synced,
                  onTap: () {

                  },
                ),
                SizedBox(height: AppSize.size10),
                // GRN no and category row
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleHeadingText(
                          title: context.l.consumedQty,
                          value:  itemList.quantity,
                        )
                      ],
                    ),
                    SizedBox(width: AppSize.size55),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleHeadingText(
                          title: context.l.articleNo,
                          value:  itemList.articleNumber,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
                SingleHeadingText(
                  title: context.l.defaultStorageLocation,
                  value: itemList.defaultStorageLocation,
                ),

                SizedBox(height: AppSize.size10),
                SingleHeadingText(
                  title: context.l.remarks,
                  value: itemList.remarks,
                )


              ],
            ),
          ),
        ],
      ),
    );
  }
}

