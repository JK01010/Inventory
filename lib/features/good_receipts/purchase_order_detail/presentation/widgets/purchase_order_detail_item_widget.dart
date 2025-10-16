import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_heading_widget.dart';
import '../../../../widgets/app_text_form_field.dart';
import '../../../../widgets/app_title_widget.dart';
import '../../../presentation/widgets/goods_receipt_value_widget.dart';
import '../../../purchase_order/presentation/widgets/item_detail_row_widget.dart';

class PurchaseOrderDetailItemWidget extends StatefulWidget {
  const PurchaseOrderDetailItemWidget({super.key, required this.itemEntity});

  final ItemEntity itemEntity;

  @override
  State<PurchaseOrderDetailItemWidget> createState() =>
      PurchaseOrderDetailItemWidgetState();
}

class PurchaseOrderDetailItemWidgetState
    extends State<PurchaseOrderDetailItemWidget> {
  final TextEditingController _receivedQtyController = TextEditingController();
  final TextEditingController _damagedQtyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _receivedQtyController.text =
        widget.itemEntity.receivedQuantity == -1
            ? ''
            : widget.itemEntity.receivedQuantity.toString();
    _damagedQtyController.text =
        widget.itemEntity.damagedQuantity == -1
            ? ''
            : widget.itemEntity.damagedQuantity.toString();
  }

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
                AppHeadingWidget(
                  text: widget.itemEntity.productName,
                  labelCheckbox: true,
                ),
                SizedBox(height: AppSize.size10),

                // GRN no and category row
                ItemDetailRowWidget(
                  titleFirst: context.l.serialNo,
                  valueFirst: widget.itemEntity.serialNumber.toString(),
                  titleSecond: context.l.poQty,
                  valueSecond: widget.itemEntity.poQuantity.toString(),
                ),
                SizedBox(height: AppSize.size10),
                // Title section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTitleWidget(text: context.l.storeLocation),
                    Text(widget.itemEntity.defaultStorageLocation),
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
                            readOnly: true,
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
                        readOnly: true,
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
  }
}
