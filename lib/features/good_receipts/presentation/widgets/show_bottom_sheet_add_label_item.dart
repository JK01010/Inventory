import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_heading_widget.dart';
import '../../../widgets/app_title_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';
import '../goods_receipt_detail_label_bloc/goods_receipt_label_bloc.dart';
import '../../purchase_order/presentation/widgets/item_detail_row_widget.dart';
import 'shimmer_widget/goods_receipts_pending_details_shimmer.dart';

Future showBottomSheetAddLabelItem(
  BuildContext context,
  PurchaseOrderHDEntity purchaseOrderHDEntity,
) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.colorWhite,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.sizeOf(context).height * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color:
                context.isDarkMode
                    ? AppColor.colorBGBlack
                    : AppColor.colorWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: BlocBuilder<GoodsReceiptLabelBloc, GoodsReceiptLabelState>(
              builder: (context, state) {
                return Column(
                  children: [
                    BottomSheetHeaderWidget(
                      title: context.l.addItem,
                      onTap: context.pop,
                    ),
                    Divider(
                      color:
                          context.isDarkMode
                              ? AppColor.colorDarkDivider
                              : AppColor.closeButtonColor,
                    ),
                    SizedBox(height: AppSize.size10),
                    state.isLoading
                        ? Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GoodsReceiptsPendingDetailsShimmer();
                            },
                            itemCount: 5,
                            separatorBuilder:
                                (context, index) =>
                                    SizedBox(height: AppSize.size10),
                          ),
                        )
                        : state
                            .purchaseItemToCreateNewLabelEntityList
                            .isNotEmpty
                        ? Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount:
                                state
                                    .purchaseItemToCreateNewLabelEntityList
                                    .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: AppDecoratedBoxShadowWidget(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                          AppPadding.padding12,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            AppHeadingWidget(
                                              text:
                                                  state
                                                      .purchaseItemToCreateNewLabelEntityList[index]
                                                      .sectionName,
                                              labelCheckbox:
                                                  state
                                                      .purchaseItemToCreateNewLabelEntityList[index]
                                                      .isSelected,
                                              showCheckBox: true,
                                              onTapCheckBox: () {
                                                context
                                                    .read<
                                                      GoodsReceiptLabelBloc
                                                    >()
                                                    .add(
                                                      UpdateCheckBoxSelectedStatusEvent(
                                                        index: index,
                                                        isSelectedValue:
                                                            !state
                                                                .purchaseItemToCreateNewLabelEntityList[index]
                                                                .isSelected,
                                                      ),
                                                    );
                                              },
                                            ),
                                            SizedBox(height: AppSize.size10),

                                            // GRN no and category row
                                            ItemDetailRowWidget(
                                              titleFirst: context.l.serialNo,
                                              valueFirst:
                                                  state
                                                      .purchaseItemToCreateNewLabelEntityList[index]
                                                      .sectionName,
                                              titleSecond: context.l.poQty,
                                              valueSecond:
                                                  state
                                                      .purchaseItemToCreateNewLabelEntityList[index]
                                                      .poNo,
                                            ),
                                            SizedBox(height: AppSize.size10),
                                            // Title section
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppTitleWidget(
                                                  text: context.l.storeLocation,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: AppSize.size10),
                                            ItemDetailRowWidget(
                                              titleFirst: context.l.receivedQty,
                                              valueFirst:
                                                  '${state.purchaseItemToCreateNewLabelEntityList[index].receivedQty}',
                                              titleSecond: context.l.damagedQty,
                                              valueSecond:
                                                  '${state.purchaseItemToCreateNewLabelEntityList[index].damagedOrWrongSupply}',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      SizedBox(height: 40),
                                      // state
                                      //         .purchaseItemToCreateNewLabelEntityList[index]
                                      //         .tags
                                      //         .isNotEmpty
                                      //     ? ChipIconWidget(
                                      //       goodsReceiptDetailLabelEntity:
                                      //           state.purchaseItemToCreateNewLabelEntityList[index],
                                      //     )
                                      //     : SizedBox(height: 40),      //R.L GR Label Changes
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return SizedBox(height: 20);
                            },
                          ),
                        )
                        : Center(child: Text(context.l.noItemsFound)),
                    AppTwoRowButtonWidget(
                      buttonFirstTitle: context.l.cancel,
                      buttonSecondTitle: context.l.save,
                      buttonFirstOnPress: () {
                        Navigator.pop(context);
                      },
                      buttonSecondOnPress: () {
                        List<GoodsReceiptPurchaseOrderLineItemEntity>
                        selectedItemList =
                            state.purchaseItemToCreateNewLabelEntityList
                                .where((element) => element.isSelected == true)
                                .toList();
                        context.read<GoodsReceiptLabelBloc>().add(
                          AddItemsToUpdateCreateLabelItemsListForSelectedPOEvent(
                            goodsReceiptPurchaseOrderLineItemEntityList:
                                selectedItemList,
                            poId: purchaseOrderHDEntity.poId!,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
