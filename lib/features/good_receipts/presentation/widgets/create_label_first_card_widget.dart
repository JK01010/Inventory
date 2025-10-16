import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/goods_receipt_value_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_decorated_box_shadow_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_item_detail_row_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_title_widget.dart';

import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';

final ValueNotifier<bool> isExpand = ValueNotifier<bool>(false);

class CreateLabelFirstCardWidget extends StatelessWidget {
  const CreateLabelFirstCardWidget({
    super.key,
    required this.goodsReceiptPurchaseOrderLineItemEntity,
  });

  final GoodsReceiptPurchaseOrderLineItemEntity
  goodsReceiptPurchaseOrderLineItemEntity;

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child: ValueListenableBuilder(
        valueListenable: isExpand,
        builder: (context, value, child) {
          return Stack(
            children: [
              BlocBuilder<
                GoodsReceiptCreateLabelBloc,
                GoodsReceiptCreateLabelState
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
                              goodsReceiptPurchaseOrderLineItemEntity
                                  .articleNumber ??
                              '',
                          titleSecond: context.l.partNo,
                          valueSecond:
                              goodsReceiptPurchaseOrderLineItemEntity
                                  .partNumber ??
                              '',
                        ),
                        //2
                        SizedBox(height: AppSize.size10),
                        AppItemDetailRowWidget(
                          titleFirst: context.l.productName,
                          valueFirst:
                              goodsReceiptPurchaseOrderLineItemEntity
                                  .productName ??
                              '',
                          titleSecond: context.l.plateOrDrawing,
                          valueSecond:
                              goodsReceiptPurchaseOrderLineItemEntity
                                  .drawingNumber ??
                              '',
                        ),

                        //3
                        SizedBox(height: AppSize.size10),
                        AppItemDetailRowWidget(
                          titleFirst: context.l.uom,
                          valueFirst:
                              '${goodsReceiptPurchaseOrderLineItemEntity.uomId ?? 0}',
                          titleSecond: context.l.packSize,
                          valueSecond:
                              '${goodsReceiptPurchaseOrderLineItemEntity.packSize}',
                        ),
                        if (value)
                          Column(
                            children: [
                              //4
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.poQty,
                                valueFirst:
                                    '${goodsReceiptPurchaseOrderLineItemEntity.quantity ?? 0}',
                                titleSecond: context.l.unitPrize,
                                valueSecond:
                                    '${goodsReceiptPurchaseOrderLineItemEntity.unitPrice ?? 0.0}',
                              ),

                              //5
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.totalAcceptedQty,
                                valueFirst: '0', //R.L GR Label Changes
                                titleSecond: context.l.returnQty,
                                valueSecond: '0', //R.L GR Label Changes
                              ),
                              //6
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.imdgClass,
                                valueFirst:
                                    '${goodsReceiptPurchaseOrderLineItemEntity.imdgName ?? 0}',
                                titleSecond: context.l.remarksFromVendor,
                                valueSecond:
                                    '${goodsReceiptPurchaseOrderLineItemEntity.remarksToVendor ?? 0}',
                              ),

                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.equipment,
                                valueFirst:
                                    goodsReceiptPurchaseOrderLineItemEntity
                                        .equipmentName ?? //R.L GR Label Changes
                                    '',
                                titleSecond: context.l.itemCategory,
                                valueSecond:
                                    '${goodsReceiptPurchaseOrderLineItemEntity.categoryName ?? 0}',
                              ),

                              //8
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.itemSection,
                                valueFirst:
                                    goodsReceiptPurchaseOrderLineItemEntity
                                        .sectionName ??
                                    '',
                                titleSecond: context.l.itemSubSection,
                                valueSecond:
                                    goodsReceiptPurchaseOrderLineItemEntity
                                        .subSectionName ??
                                    '',
                              ),

                              //9
                              SizedBox(height: AppSize.size10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTitleWidget(text: context.l.serialNo),
                                    GoodsReceiptValueWidget(
                                      text:
                                          '${goodsReceiptPurchaseOrderLineItemEntity.slNo ?? 0}',
                                    ),
                                  ],
                                ),
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
