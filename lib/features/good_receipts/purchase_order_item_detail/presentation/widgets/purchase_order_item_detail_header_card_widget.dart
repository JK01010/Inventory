import 'package:flutter/material.dart';

import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_item_detail_row_widget.dart';
import '../../../../widgets/app_title_widget.dart';
import '../../../presentation/widgets/goods_receipt_value_widget.dart';

final ValueNotifier<bool> isExpand = ValueNotifier<bool>(false);

class PurchaseOrderItemDetailHeaderCardWidget extends StatelessWidget {
  const PurchaseOrderItemDetailHeaderCardWidget({super.key, required this.itemEntity});

  final ItemEntity itemEntity;

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
                      valueFirst: itemEntity.articleNumber,
                      titleSecond: context.l.partNo,
                      valueSecond: itemEntity.partNumber,
                    ),
                    //2
                    SizedBox(height: AppSize.size10),
                    AppItemDetailRowWidget(
                      titleFirst: context.l.productName,
                      valueFirst: itemEntity.productName,
                      titleSecond: context.l.plateOrDrawing,
                      valueSecond: itemEntity.drawingNumber,
                    ),

                    //3
                    SizedBox(height: AppSize.size10),
                    AppItemDetailRowWidget(
                      titleFirst: context.l.uom,
                      valueFirst: itemEntity.uom,
                      titleSecond: context.l.packSize,
                      valueSecond: '${itemEntity.packSize}',
                    ),
                    if (value)
                      Column(
                        children: [
                          //4
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.poQty,
                            valueFirst: '${itemEntity.poQuantity}',
                            titleSecond: context.l.unitPrize,
                            valueSecond: '${itemEntity.unitPrice}',
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
                            valueFirst: itemEntity.imdgClass,
                            titleSecond: context.l.remarksFromVendor,
                            valueSecond: itemEntity.remarksFromVendor,
                          ),

                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.equipment,
                            valueFirst: itemEntity.equipment,
                            titleSecond: context.l.itemCategory,
                            valueSecond: itemEntity.itemCategory,
                          ),

                          //8
                          SizedBox(height: AppSize.size10),
                          AppItemDetailRowWidget(
                            titleFirst: context.l.itemSection,
                            valueFirst: itemEntity.itemSection,
                            titleSecond: context.l.itemSubSection,
                            valueSecond: itemEntity.itemSubSection,
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
                                  text: '${itemEntity.serialNumber}',
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
