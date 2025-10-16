import 'package:flutter/material.dart';

import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_title_widget.dart';
import '../../../purchase_order/presentation/widgets/item_detail_row_widget.dart';

class TransactionDetailItemCardWidget extends StatelessWidget {
  const TransactionDetailItemCardWidget({super.key, required this.itemEntity});

  final ItemEntity itemEntity;

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
                Text(
                  itemEntity.productName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: AppSize.size10),

                // GRN no and category row
                // TODO Commented for the GRPOLineItem model change
                // ItemDetailRowWidget(
                //   titleFirst: context.l.equipmentName,
                //   valueFirst:
                //       state
                //           .goodsReceiptPurchaseItemDetailEntityList[index]
                //           .equipmentName ??
                //       '',
                //   titleSecond: context.l.drawingNo,
                //   valueSecond:
                //       state
                //           .goodsReceiptPurchaseItemDetailEntityList[index]
                //           .productDescription ??
                //       '',
                // ),
                SizedBox(height: AppSize.size10),
                ItemDetailRowWidget(
                  titleFirst: context.l.partNo,
                  valueFirst: itemEntity.partNumber,
                  titleSecond: context.l.robSmall,
                  valueSecond: '${itemEntity.receivedQuantity}',
                ),

                SizedBox(height: AppSize.size10),
                // Title section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTitleWidget(text: context.l.articleNo),
                    Text(
                      itemEntity.articleNumber,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontSize: AppFontSize.fontSize14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        height: 22 / 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
                // Title section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTitleWidget(text: context.l.storageLocation),
                    Text(
                      itemEntity.imdgClass,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontSize: AppFontSize.fontSize14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        height: 22 / 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
