import 'package:flutter/material.dart';

import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../domin/entities/stock_update_view_entity_model.dart';
import 'single_heading_text.dart';
import 'stock_update_transaction_card_widget.dart';

class StockUpdateTransactionList extends StatelessWidget {


  const StockUpdateTransactionList({super.key, required this.itemList});
  final StockUpdateViewEntity itemList;

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
                StockUpdateTransactionCardWidget( //reused from goods receipts
                  text: itemList.itemName,
                  syncStatus: itemList.syncStatus == "Y" ? SyncStatus.synced : SyncStatus.unSynced,
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
                          title: context.l.actualQty,
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

