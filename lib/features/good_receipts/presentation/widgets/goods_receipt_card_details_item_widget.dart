import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/sync_to_web_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_decorated_box_shadow_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_text_form_field.dart';
import 'package:pal_ng_inventory/features/widgets/app_title_widget.dart';
import 'package:pal_ng_inventory/features/widgets/chip_icon_widget.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_heading_widget.dart';
import '../../domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../goods_receipt_detail_label_bloc/goods_receipt_label_bloc.dart';
import 'goods_receipt_value_widget.dart';
import '../../purchase_order/presentation/widgets/item_detail_row_widget.dart';

class GoodsReceiptCardDetailsItemWidget extends StatefulWidget {
  GoodsReceiptCardDetailsItemWidget({Key? key, required this.selectedIndex})
    : super(key: key);
  final int selectedIndex;

  @override
  State<GoodsReceiptCardDetailsItemWidget> createState() =>
      GoodsReceiptCardDetailsItemWidgetState();
}

class GoodsReceiptCardDetailsItemWidgetState
    extends State<GoodsReceiptCardDetailsItemWidget> {
  final TextEditingController _receivedQtyController = TextEditingController();
  final TextEditingController _damagedQtyController = TextEditingController();
  late List<GoodsReceiptPurchaseOrderLineItemEntity>
  goodsReceiptPurchaseOrderLineItemEntityList;
  late int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsReceiptLabelBloc, GoodsReceiptLabelState>(
      builder: (context, state) {
        if (state.goodsReceiptPurchaseOrderLineItemEntityList.isNotEmpty) {
          _receivedQtyController.text =
              (state
                          .goodsReceiptPurchaseOrderLineItemEntityList[widget
                              .selectedIndex]
                          .receivedQty >
                      0)
                  ? '${state.goodsReceiptPurchaseOrderLineItemEntityList[widget.selectedIndex].receivedQty}'
                  : '';
          _damagedQtyController.text =
              (state
                          .goodsReceiptPurchaseOrderLineItemEntityList[widget
                              .selectedIndex]
                          .damagedOrWrongSupply >
                      0)
                  ? "${state.goodsReceiptPurchaseOrderLineItemEntityList[widget.selectedIndex].damagedOrWrongSupply}"
                  : '';
          goodsReceiptPurchaseOrderLineItemEntityList =
              state.goodsReceiptPurchaseOrderLineItemEntityList;
          return AppDecoratedBoxShadowWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppHeadingWidget(
                        text:
                            state
                                .goodsReceiptPurchaseOrderLineItemEntityList[widget
                                    .selectedIndex]
                                .productName ??
                            '',
                        labelCheckbox: true,
                      ),
                      SizedBox(height: AppSize.size10),

                      // GRN no and category row
                      ItemDetailRowWidget(
                        titleFirst: context.l.serialNo,
                        valueFirst:
                            state
                                .goodsReceiptPurchaseOrderLineItemEntityList[widget
                                    .selectedIndex]
                                .slNo
                                .toString(),
                        titleSecond: context.l.poQty,
                        valueSecond:
                            state
                                .goodsReceiptPurchaseOrderLineItemEntityList[widget
                                    .selectedIndex]
                                .quantity
                                .toString(),
                      ),
                      SizedBox(height: AppSize.size10),
                      // Title section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTitleWidget(text: context.l.storeLocation),
                          GoodsReceiptValueWidget(
                            text: 'BOSUN STORE / DECKLOCKER',
                            // '${state.goodsReceiptPurchaseItemDetailEntityList[widget.selectedIndex].defaultStorageLocationId}',
                          ), //R.L GR Label Changes
                        ],
                      ),
                      SizedBox(height: AppSize.size20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextFormField(
                                  labelText: context.l.receivedQty,
                                  controller: _receivedQtyController,
                                  hintText: '0.0',
                                  filled: true,
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: AppSize.size25),
                          Expanded(
                            child: AppTextFormField(
                              labelText: context.l.damagedQty,
                              controller: _damagedQtyController,
                              hintText: '0.0',
                              filled: true,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Title
                Divider(
                  height: 0,
                  color: context.customThemeColor(
                    light: AppColor.colorBlack5,
                    dark: AppColor.colorDarkDivider,
                  ),
                ),
                // state
                //         .goodsReceiptPurchaseItemDetailEntityList[widget
                //             .selectedIndex]
                //         .tags
                //         .isNotEmpty
                //     ? ChipIconWidget(
                //       goodsReceiptDetailLabelEntity:
                //           state.goodsReceiptPurchaseItemDetailEntityList[widget
                //               .selectedIndex],
                //     )
                //  : SizedBox(height: 40),
                //R.L GR Label Changes
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  double get receivedQuantity =>
      _receivedQtyController.text.isNotEmpty
          ? double.parse(_receivedQtyController.text)
          : 0;

  double get damagedQuantity =>
      _damagedQtyController.text.isNotEmpty
          ? double.parse(_damagedQtyController.text)
          : 0;

  int get selectedIndex => _selectedIndex;
}

class ChipIconWidget extends StatelessWidget {
  ChipIconWidget({super.key, required this.goodsReceiptDetailLabelEntity});

  GoodsReceiptPurchaseItemDetailEntity goodsReceiptDetailLabelEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.padding12,
        horizontal: AppPadding.padding20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // getTagWidgets(goodsReceiptDetailLabelEntity.tags, context),      //R.L GR Label Changes
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SyncToWebWidget();
                },
              );
            },
            child: SizedBox(
              height: AppSize.size15,
              width: AppSize.size15,
              child: SvgPicture.asset(
                AppIcons.burgerIconHorizontal,
                height: AppSize.size15,
                width: AppSize.size15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox getTagWidgets(String tagList, BuildContext context) {
    List<String> tags = tagList.split(",");
    List<ChipWidget> widgetList = [];
    for (var tag in tags) {
      widgetList.add(ChipWidget(chipText: tag, color: AppColor.colorGreen));
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.72,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(children: widgetList),
      ),
    );
  }
}
