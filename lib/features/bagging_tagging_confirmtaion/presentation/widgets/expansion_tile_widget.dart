import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/widgets/App_item_detail_row_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../good_receipts/domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';

final ValueNotifier<bool> isExpand = ValueNotifier<bool>(false);

class ExpansionTileWidget extends StatelessWidget {
  final GoodsReceiptPurchaseItemDetailEntity baggingTaggingPurchaseListViewEntity;

  const ExpansionTileWidget({
    super.key,
    required this.baggingTaggingPurchaseListViewEntity,
  });

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child: ValueListenableBuilder(
        valueListenable: isExpand,
        builder: (context, value, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: AppSize.size10),
                    //1
                    AppItemDetailRowWidget(
                      titleFirst: context.l.articleNo,
                      valueFirst: baggingTaggingPurchaseListViewEntity.articleNo,
                      titleSecond: context.l.partNo,
                      valueSecond: baggingTaggingPurchaseListViewEntity.partNo,
                    ),
                    //2
                    SizedBox(height: AppSize.size10),
                    AppItemDetailRowWidget(
                      titleFirst: context.l.productName,
                      valueFirst: baggingTaggingPurchaseListViewEntity.productName,
                      titleSecond: context.l.plateOrDrawing,
                      valueSecond: baggingTaggingPurchaseListViewEntity.drawingNumber,
                    ),

                    //3
                    SizedBox(height: AppSize.size10),
                    AppItemDetailRowWidget(
                      titleFirst: context.l.uom,
                      valueFirst: baggingTaggingPurchaseListViewEntity.uomId.toString(),
                      titleSecond: context.l.packSize,
                      valueSecond: baggingTaggingPurchaseListViewEntity.poNo,
                    ),
                    if (value)
                      Column(
                        children: [
                          //4
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.poQty,
                            valueFirst:
                            baggingTaggingPurchaseListViewEntity.qualityId.toString(),
                            titleSecond: context.l.unitPrize,
                            valueSecond:
                            baggingTaggingPurchaseListViewEntity.itemUom,
                          ),

                          //5
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.totalAcceptedQty,
                            valueFirst:
                            baggingTaggingPurchaseListViewEntity.remarks.toString(),
                            titleSecond: context.l.returnQty,
                            valueSecond:
                            baggingTaggingPurchaseListViewEntity.receivedQty.toString(),
                          ),
                          //6
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.imdgClass,
                            valueFirst: baggingTaggingPurchaseListViewEntity.sectionName,
                            titleSecond: context.l.remarksFromVendor,
                            valueSecond:
                            baggingTaggingPurchaseListViewEntity.remarks,
                          ),

                          SizedBox(height: AppSize.size10),
                               AppItemDetailRowWidget(
                                titleFirst: context.l.equipment,
                                valueFirst: baggingTaggingPurchaseListViewEntity.itemUom,
                                titleSecond: context.l.itemCategory,
                                valueSecond:
                                baggingTaggingPurchaseListViewEntity.categoryName,
                              ),

                          //8
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.itemSection,
                            valueFirst: baggingTaggingPurchaseListViewEntity.sectionName,
                            titleSecond: context.l.itemSubSection,
                            valueSecond:
                            baggingTaggingPurchaseListViewEntity.subSectionName,
                          ),

                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.receivedQty,
                            valueFirst:
                            baggingTaggingPurchaseListViewEntity.receivedQty.toString(),
                            titleSecond: context.l.damageWrong,
                            valueSecond:
                            baggingTaggingPurchaseListViewEntity.damagedOrWrongSupply
                                    .toString(),
                          ),
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.newStock,
                            valueFirst:
                            baggingTaggingPurchaseListViewEntity.newStock.toString(),
                            titleSecond: context.l.reconditionStock,
                            valueSecond:
                            baggingTaggingPurchaseListViewEntity.reconditionedStock
                                    .toString(),
                          ),
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.quality,
                            valueFirst: baggingTaggingPurchaseListViewEntity.qualityId.toString(),
                            titleSecond: context.l.expiryDate,
                            valueSecond: baggingTaggingPurchaseListViewEntity.expiryDate,
                          ),
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.batchNo,
                            valueFirst: baggingTaggingPurchaseListViewEntity.batchNo,
                            titleSecond: context.l.serialNo,
                            valueSecond: baggingTaggingPurchaseListViewEntity.sectionName,
                          ),
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.remarks,
                            valueFirst: baggingTaggingPurchaseListViewEntity.remarks.toString(),
                            titleSecond: context.l.defaultStorageLocation,
                            valueSecond:
                            baggingTaggingPurchaseListViewEntity.sectionName,
                          ),
                          SizedBox(height: AppSize.size10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: AppSize.size6,
                              children: [
                                Text(
                                  context.l.attachment,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppFontSize.fontSize13,
                                  ),
                                ),
                                Container(
                                  width: AppSize.size45,
                                  height: AppSize.size45,
                                  decoration: ShapeDecoration(
                                    color:context.isDarkMode?AppColor.colorTransparent
                                        :
                                    AppColor.colorWhite,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: AppSize.size1_5,
                                        color: AppColor.colorPrimary,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppBorderRadius.borderRadius12,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.paperclipIcon,
                                      height: AppSize.size25,
                                      width: AppSize.size25,
                                      semanticsLabel: 'Paper Clip Icon',
                                      colorFilter: context.isDarkMode
                                          ? const ColorFilter.mode(AppColor.colorPrimary, BlendMode.srcIn)
                                          : null,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    isExpand.value = !isExpand.value;
                  },
                  icon:
                      isExpand.value
                          ? Icon(Icons.keyboard_arrow_up)
                          : Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
