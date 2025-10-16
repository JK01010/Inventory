import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../good_receipts/presentation/widgets/goods_receipt_value_widget.dart';
import '../../../item_master/presentation/widgets/item_detail_row.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_title_widget.dart';
import '../../../widgets/chip_icon_list_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../../domin/entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../bloc/stock_update_rfid_scanning_bloc/stock_update_rfid_scanning_bloc.dart';
import 'single_heading_text.dart';

class StockUpdateAddRfidScanListing extends StatelessWidget {
   const StockUpdateAddRfidScanListing({super.key, required this.itemList,required this.enableCheckBox,required this.index});

  final StockUpdateRfidListingViewEntity itemList;
  final bool enableCheckBox;
  final int index;



   @override
  Widget build(BuildContext context) {
    bool isIhm = false;
    List<ChipStatus> activeFilterTag = [];

    if (itemList.ihm == 1) {
      activeFilterTag.add(ChipStatus.ihm);
    }
    if (itemList.mdRequired == 1) {
      // activeFilterTag.add(ChipStatus.ihm);
    }
    if (itemList.sDocRequired == 1) {
      // activeFilterTag.add(ChipStatus.ihm);
    }
    if (itemList.zeroDeclaration == 1) {
      // activeFilterTag.add(ChipStatus.ihm);
    }

    final TextTheme textTheme = Theme.of(context).textTheme;
    return AppDecoratedBoxShadowWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //consumption heading
                Row(
                  children: [
                    Visibility(
                      visible: enableCheckBox,
                      child: Row(
                        children: [
                          BlocBuilder<StockUpdateRfidScanningBloc, StockUpdateRfidScanningState>(
                          builder: (context, state) {
                          return RoundedCheckBoxWidget(
                              value:  state.viewList[index].isSelected ?? false,
                              onTap: () {
                                bool value =  state.viewList[index].isSelected ?? false;
                                context.read<StockUpdateRfidScanningBloc>().add(IsSelectedEvent(
                                    index: index,
                                    isSelectedValue :!value,
                                    completeSelect:false));
                          });
                          },
                          ),
                          SizedBox(width: AppSize.size15),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        itemList.itemName,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size15),

                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: SingleHeadingText(
                    title: context.l.rob,
                    value: itemList.rob.toString() ?? "",
                  ),
                ),
                SizedBox(height: AppSize.size10),
                ItemDetailRow(
                  titleFirst: context.l.newStock,
                  valueFirst: itemList.newStock.toString(),
                  titleSecond: context.l.reconditionStock,
                  valueSecond: itemList.reconditionStock.toString(),
                  spacer: AppSize.size105,
                ),

                SizedBox(height: AppSize.size10),

                ItemDetailRow(
                  titleFirst: context.l.articleNo,
                  valueFirst: itemList.articleNo ?? "",
                  titleSecond: context.l.articleCode,
                  valueSecond: itemList.articleNo ?? "",
                  spacer: AppSize.size105,
                ),
                SizedBox(height: AppSize.size10),
                //storage location
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTitleWidget(text: context.l.storageLocation),
                    GoodsReceiptValueWidget(
                      text: itemList.storageLocation ?? "",
                    ),
                  ],
                ),

                Visibility(
                  visible: isIhm,
                  replacement:  Column(
                    children: [
                      SizedBox(height: AppSize.size10),
                      SingleHeadingText(
                        title: context.l.remarks,
                        value: '-',
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSize.size10),
                      AppTitleWidget(text: context.l.installedOnLocation),
                      GoodsReceiptValueWidget(
                        text: itemList.installedOnLocation ?? "",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppSize.size2),
              ],
            ),
          ),
          Divider(height: 0),
          ChipIconListWidget(chipStatusList: activeFilterTag),
          SizedBox(height: 3),
        ],
      ),
    );
  }
}
