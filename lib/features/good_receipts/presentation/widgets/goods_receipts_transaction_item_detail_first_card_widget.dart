import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/widgets/app_decorated_box_shadow_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_item_detail_row_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../goods_receipt_label_ihm_attachment_bloc/goods_receipt_label_ihm_attachment_bloc.dart';
import '../goods_receipt_transaction_detail_bloc/goods_receipts_transaction_detail_bloc.dart';
import 'attachments_popup_widget.dart';

final ValueNotifier<bool> isExpand = ValueNotifier<bool>(false);

class GoodsReceiptsTransactionItemDetailFirstCardWidget
    extends StatelessWidget {
  const GoodsReceiptsTransactionItemDetailFirstCardWidget({
    super.key,
    required this.selectedTransactionItemIndex,
  });

  final int selectedTransactionItemIndex;

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child: ValueListenableBuilder(
        valueListenable: isExpand,
        builder: (context, value, child) {
          return Stack(
            children: [
              BlocBuilder<
                GoodsReceiptsTransactionDetailBloc,
                GoodsReceiptsTransactionDetailState
              >(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: AppSize.size10),
                        //1
                        AppItemDetailRowWidget(
                          titleFirst: context.l.articleNo,
                          valueFirst:
                              state
                                  .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                  .articleNo ??
                              '',
                          titleSecond: context.l.partNo,
                          valueSecond:
                              state
                                  .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                  .partNo ??
                              '',
                        ),
                        //2
                        SizedBox(height: AppSize.size10),
                        AppItemDetailRowWidget(
                          titleFirst: context.l.productName,
                          valueFirst:
                              state
                                  .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                  .productName ??
                              '',
                          titleSecond: context.l.plateOrDrawing,
                          valueSecond:
                              state
                                  .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                  .productDescription ??
                              '',
                        ),

                        //3
                        SizedBox(height: AppSize.size10),
                        AppItemDetailRowWidget(
                          titleFirst: context.l.uom,
                          valueFirst:
                              '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].uomId ?? 0}',
                          titleSecond: context.l.packSize,
                          valueSecond:
                              state
                                  .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                  .newStock
                                  .toString() ??
                              '',
                        ),
                        if (value)
                          Column(
                            children: [
                              //4
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.poQty,
                                valueFirst:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].qualityId ?? 0}',
                                titleSecond: context.l.unitPrize,
                                valueSecond:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].reconditionedStock ?? 0.0}',
                              ),

                              //5
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.totalAcceptedQty,
                                valueFirst:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].damagedOrWrongSupply ?? 0}',
                                titleSecond: context.l.returnQty,
                                valueSecond:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].reconditionedStock ?? 0}',
                              ),
                              //6
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.imdgClass,
                                valueFirst:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].imdgClassId}',
                                titleSecond: context.l.remarksFromVendor,
                                valueSecond:
                                    state
                                        .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                        .remarks,
                              ),

                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.equipment,
                                valueFirst:
                                    state
                                        .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                        .articleNo ??
                                    '',
                                titleSecond: context.l.itemCategory,
                                valueSecond:
                                    state
                                        .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                        .categoryName,
                              ),

                              //8
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.itemSection,
                                valueFirst:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].sectionName ?? 0}',
                                titleSecond: context.l.itemSubSection,
                                valueSecond:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].subSectionName ?? 0}',
                              ),
                              //9
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.receivedQty,
                                valueFirst:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].receivedQty ?? 0}',
                                titleSecond: context.l.damageWrong,
                                valueSecond:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].damagedOrWrongSupply ?? 0}',
                              ),
                              //10
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.newStock,
                                valueFirst:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].newStock ?? 0}',
                                titleSecond: context.l.reconditionStock,
                                valueSecond:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].reconditionedStock ?? 0}',
                              ),
                              //11
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.quality,
                                valueFirst:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].qualityId ?? 0}',
                                titleSecond: context.l.expiryDate,
                                valueSecond:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].expiryDate ?? 0}',
                              ),
                              //12
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.batchNo,
                                valueFirst:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].batchNo ?? 0}',
                                titleSecond: context.l.serialNo,
                                valueSecond:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].articleNo ?? 0}',
                              ),
                              //13
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.remarks,
                                valueFirst:
                                    state
                                        .goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex]
                                        .remarks,
                                titleSecond: context.l.defaultStorageLocation,
                                valueSecond:
                                    '${state.goodsReceiptPurchaseItemDetailEntityList[selectedTransactionItemIndex].className ?? 0}',
                              ),
                              SizedBox(height: AppSize.size10),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(context.l.attachment),
                                      SizedBox(height: AppSize.size6),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            AppBorderRadius.borderRadius10,
                                          ),
                                          border: Border.all(
                                            color: AppColor.colorPrimary,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            AppPadding.padding8,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<
                                                    GoodsReceiptLabelIhmAttachmentBloc
                                                  >()
                                                  .add(
                                                    GetGoodsReceiptLabelIhmAttachmentEvent(
                                                      itemId:
                                                          '${state.goodsReceiptPurchaseItemDetailEntity.itemId}',
                                                    ),
                                                  );
                                              showModalBottomSheet(
                                                isDismissible: false,
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          context.isDarkMode
                                                              ? AppColor
                                                                  .colorBGBlack
                                                              : AppColor
                                                                  .colorWhite,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top: Radius.circular(
                                                              AppBorderRadius
                                                                  .borderRadius20,
                                                            ),
                                                          ),
                                                    ),
                                                    child:
                                                        AttachmentsPopupWidget(),
                                                  );
                                                },
                                              );
                                            },
                                            child: RotatedBox(
                                              quarterTurns: 3,
                                              child: Icon(
                                                Icons.attachment_outlined,
                                                color: AppColor.colorPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
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
