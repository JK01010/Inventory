import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../good_receipts/presentation/widgets/goods_receipt_value_widget.dart';
import '../../../item_master/presentation/widgets/item_detail_row.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/app_title_widget.dart';
import '../../../widgets/chip_icon_list_widget.dart';
import '../../domin/entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../bloc/stock_update_page_bloc/stock_update_page_bloc.dart';
import 'app_text_form_field_stock_update.dart';
import 'single_heading_text.dart';

class StockUpdateList extends StatelessWidget {
  const StockUpdateList({
    super.key,
    required this.index,
    required this.itemList,
    required this.remarkController,
    required this.newStockController,
    required this.reconditionStockController,
  });

  final int index;
  final StockUpdateRfidListingViewEntity itemList;
  final TextEditingController remarkController;
  final TextEditingController newStockController;
  final TextEditingController reconditionStockController;

  @override
  Widget build(BuildContext context) {
    List<ChipStatus> activeFilterTag = [];

    if (itemList.ihm == 1) {
      activeFilterTag.add(ChipStatus.ihm);
    }
    if (itemList.mdRequired == 1) {
      activeFilterTag.add(ChipStatus.ihm);
    }
    if (itemList.sDocRequired == 1) {
      activeFilterTag.add(ChipStatus.ihm);
    }
    if (itemList.zeroDeclaration == 1) {
      activeFilterTag.add(ChipStatus.ihm);
    }

    ValueNotifier<bool> location = ValueNotifier(true);
    ValueNotifier<bool> equipment = ValueNotifier(false);

    final TextTheme textTheme = Theme.of(context).textTheme;
    return AppDecoratedBoxShadowWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppPadding.scaffoldPadding,
              right: AppPadding.scaffoldPadding,
              top: AppPadding.scaffoldPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //consumption heading
                Text(
                  itemList.itemName,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: AppSize.size10),
                //Rob
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: SingleHeadingText(
                    title: context.l.rob,
                    value: itemList.rob.toString(),
                  ),
                ),

                //newStock
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: SingleHeadingText(
                        title: context.l.newStock,
                        value: itemList.newStock.toString(),
                      ),
                    ),

                    //textEditing field
                    BlocBuilder<StockUpdatePageBloc, StockUpdatePageState>(
                      builder: (context, state) {
                        return Expanded(
                          // width: AppSize.size120,
                          // height: AppSize.size45,
                          child: AppTextFormFieldStockUpdate(
                            labelText: context.l.adjustNewStockRob,
                            hintText: context.l.enterQuantity,
                            controller: newStockController,

                            errorText:
                                state
                                            .selectedRfidItemList[index]
                                            .showErrorConsumedQty ==
                                        true
                                    ? "Please enter Qty"
                                    : null,

                            onChanged: (value) {
                              //value updating event
                              context.read<StockUpdatePageBloc>().add(
                                UpdateItemValue(
                                  index: index,
                                  isForRemarks: false,
                                  newValue: value,
                                  storageLocationId:
                                      itemList.defaultStorageLocationId,
                                  rob: itemList.rob,
                                  consumedQty: newStockController.text,
                                ),
                              );
                            },
                            maxLine: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),

                //reconditionStock
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: SingleHeadingText(
                        title: context.l.reconditionStock,
                        value: itemList.reconditionStock.toString(),
                      ),
                    ),

                    //textEditing field
                    if (itemList.reconditionStock != 0)
                      BlocBuilder<StockUpdatePageBloc, StockUpdatePageState>(
                        builder: (context, state) {
                          return Expanded(
                            // width: AppSize.size120,
                            // height: AppSize.size45,
                            child: AppTextFormFieldStockUpdate(
                              labelText: context.l.adjustReconditionStockRob,
                              hintText: context.l.enterQuantity,
                              controller: reconditionStockController,

                              errorText:
                                  state
                                              .selectedRfidItemList[index]
                                              .showErrorConsumedQty ==
                                          true
                                      ? "Please enter Qty"
                                      : null,

                              onChanged: (value) {
                                //value updating event
                                context.read<StockUpdatePageBloc>().add(
                                  UpdateItemValue(
                                    index: index,
                                    isForRemarks: false,
                                    newValue: value,
                                    storageLocationId:
                                        itemList.defaultStorageLocationId,
                                    rob: itemList.rob,
                                    consumedQty:
                                        reconditionStockController.text,
                                  ),
                                );
                              },
                              maxLine: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
                SizedBox(height: AppSize.size10),

                //article no. area
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
                SizedBox(height: AppSize.size15),

                Column(
                  children: [
                    // SizedBox(height: AppSize.size15),
                    AppTextFormField(
                      labelText: context.l.remarks,
                      hintText: context.l.enterRemarks,
                      controller: remarkController,
                      onChanged: (value) {
                        context.read<StockUpdatePageBloc>().add(
                          UpdateItemValue(
                            index: index,
                            isForRemarks: true,
                            newValue: value,
                            storageLocationId:
                                itemList.defaultStorageLocationId,
                            rob: itemList.rob,
                            consumedQty: newStockController.text,
                          ),
                        );
                      },
                      maxLine: 1,
                    ),
                    SizedBox(height: AppSize.size15),
                  ],
                ),
                SizedBox(height: AppSize.size10),
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
