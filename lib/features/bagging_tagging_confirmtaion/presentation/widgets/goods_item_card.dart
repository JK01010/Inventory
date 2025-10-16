import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/page/bagging_tagging_details_page.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../good_receipts/domain/entities/goods_receipt_purchase_item_detail_entity.dart';

class GoodsItemCard extends StatelessWidget {
  const GoodsItemCard({
    super.key,
    required this.baggingTaggingPurchaseListViewEntity,
  });

  final GoodsReceiptPurchaseItemDetailEntity
  baggingTaggingPurchaseListViewEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.padding8),
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.padding18,
        horizontal: AppPadding.padding18,
      ),
      decoration: ShapeDecoration(
        color:
            context.isDarkMode
                ? AppColor.colorDarkProfileContainer
                : AppColor.colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius15)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.push(
                AppRoute.goodsDetailsPage.path,
                extra: baggingTaggingPurchaseListViewEntity,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  baggingTaggingPurchaseListViewEntity.productName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize16,
                  ),
                ),
                buildSizedBox15(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildColumnTitleSubTitle(
                          context: context,
                          title: context.loc.serialNo,
                          subTitle:
                              baggingTaggingPurchaseListViewEntity.poNo,
                        ),
                        buildSizedBox15(),
                        buildColumnTitleSubTitle(
                          context: context,
                          title: context.loc.receivedQty,
                          subTitle: baggingTaggingPurchaseListViewEntity
                              .receivedQty
                              .toString()
                              .padLeft(2, '0'),
                        ),
                        buildSizedBox15(),
                        buildColumnTitleSubTitle(
                          context: context,
                          title: context.loc.storageLocation,
                          subTitle:
                              baggingTaggingPurchaseListViewEntity.poNo,
                        ),
                      ],
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildColumnTitleSubTitle(
                            context: context,
                            title: context.loc.poQty,
                            subTitle:
                                baggingTaggingPurchaseListViewEntity.qualityId
                                    .toString(),
                          ),
                          buildSizedBox15(),
                          buildColumnTitleSubTitle(
                            context: context,
                            title: context.loc.damageWrongSupply,
                            subTitle: baggingTaggingPurchaseListViewEntity
                                .damagedOrWrongSupply
                                .toString()
                                .padLeft(2, '0'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                buildSizedBox15(),
                Divider(height: 1),
                buildSizedBox15(),
              ],
            ),
          ),
          Row(
            children: [
              // if (item.isBadCondition)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.isDarkMode?AppColor.colorTransparent
                  :AppColor.bgColorRedShade100,
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(color: AppColor.redColor),
                ),
                child: Text(
                  baggingTaggingPurchaseListViewEntity.poNo,
                  // "Goods in Bad Condition",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColor.redColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // if (item.isGroupTagged)
              // ChipIconListWidget(
              //   chipStatusList: [
              //     ChipStatus.chipNew,
              //     ChipStatus.fullyReceived,
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.isDarkMode?AppColor.colorTransparent
                      :AppColor.bgColorGreenShade100,
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(color: AppColor.colorGreen),
                ),
                child: Text(
                  "Group Tagged",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColor.colorGreen,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox buildSizedBox15() => const SizedBox(height: AppSize.size15);
}

Column buildColumnTitleSubTitle({
  required BuildContext context,
  required String title,
  required String subTitle,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: AppSize.size6,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
          fontSize: AppFontSize.fontSize13,
        ),
      ),
      Text(
        subTitle,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
          fontSize: AppFontSize.fontSize14,
        ),
      ),
    ],
  );
}
