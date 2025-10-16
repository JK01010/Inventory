import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../good_receipts/presentation/widgets/goods_receipt_value_widget.dart';
import '../../../item_master/presentation/widgets/item_detail_row.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/app_title_widget.dart';
import '../../../widgets/chip_icon_list_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../../domin/entities/consumption_rfid_scanning_view_entity_model.dart';
import '../bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import 'single_heading_text.dart';

class ConsumptionList extends StatelessWidget {
  const ConsumptionList({
    super.key,
    required this.index,
    required this.itemList,
    required this.remarkController,
    required this.robTextController,
    required this.newStockController,
    required this.reconditionStockController
  });

  final int index;
  final ConsumptionRfidListingViewEntity itemList;
  final TextEditingController remarkController;
  final TextEditingController robTextController;
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
                //Rob area
                //Rob
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: SingleHeadingText(
                    title: context.l.rob,
                    value: itemList.rob.toString(),
                  ),
                ),
                /*Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: SingleHeadingText(
                        title: context.l.rob,
                        value: itemList.rob.toString(),
                      ),
                    ),

                    //textEditing field
                    BlocBuilder<
                      ConsumptionItemUpdateBloc,
                      ConsumptionItemUpdateState
                    >(
                      builder: (context, state) {
                        return Expanded(
                          // width: AppSize.size120,
                          // height: AppSize.size45,
                          child: AppTextFormField(
                            labelText: context.l.consumedQty,
                            hintText: context.l.enterQuantity,
                            controller: robTextController,
                            errorText:
                                state
                                            .selectedRfidItemList[index]
                                            .showErrorConsumedQty ==
                                        true
                                    ? context.l.enterQuantity
                                    : state
                                            .selectedRfidItemList[index]
                                            .showErrorConsumedQtyRob ==
                                        true
                                    ? context.l.qtyGreaterRob
                                    : null,
                            filled: true,
                            onChanged: (value) {
                              context.read<ConsumptionItemUpdateBloc>().add(
                                UpdateItemValue(
                                  index: index,
                                  isForRemarks: false,
                                  newValue: value,
                                  storageLocationId:
                                      itemList.defaultStorageLocationId,
                                  rob: itemList.rob,
                                  consumedQty: robTextController.text,
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
                ),*/
                SizedBox(height: AppSize.size10),

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
                    Visibility(
                      visible: itemList.newStock != 0,
                      child: BlocBuilder< ConsumptionItemUpdateBloc,
                          ConsumptionItemUpdateState>(
                        builder: (context, state) {
                          return Expanded(
                            // width: AppSize.size120,
                            // height: AppSize.size45,
                            child: AppTextFormField(
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
                                context.read<ConsumptionItemUpdateBloc>().add(
                                  UpdateItemValue(
                                    index: index,
                                    isForRemarks: false,
                                    newValue: value,
                                    storageLocationId:
                                    itemList.defaultStorageLocationId,
                                    rob: itemList.rob,
                                    newStockRob: newStockController.text,
                                    reconditionStock:
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
                      BlocBuilder< ConsumptionItemUpdateBloc,
                          ConsumptionItemUpdateState>(
                        builder: (context, state) {
                          return Expanded(
                            // width: AppSize.size120,
                            // height: AppSize.size45,
                            child: AppTextFormField(
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
                                context.read<ConsumptionItemUpdateBloc>().add(
                                  UpdateItemValue(
                                    index: index,
                                    isForRemarks: false,
                                    newValue: value,
                                    storageLocationId:
                                    itemList.defaultStorageLocationId,
                                    rob: itemList.rob,
                                    newStockRob:
                                    newStockController.text,
                                    reconditionStock:
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
                  valueFirst: itemList.articleNo,
                  titleSecond: context.l.articleCode,
                  valueSecond: itemList.articleNo,
                  spacer: AppSize.size105,
                ),
                SizedBox(height: AppSize.size10),
                //storage location
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTitleWidget(text: context.l.storageLocation),
                    GoodsReceiptValueWidget(text: itemList.storageLocation),
                  ],
                ),
                SizedBox(height: AppSize.size10),

                Visibility(
                  visible:
                      itemList.equipmentFlag != "" ||
                      itemList.equipmentFlag != "Y",
                  replacement: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.l.installedOn, style: textTheme.titleMedium),
                      SizedBox(height: AppSize.size10),
                      BlocBuilder<
                        ConsumptionItemUpdateBloc,
                        ConsumptionItemUpdateState
                      >(
                        builder: (context, state) {
                          return Row(
                            children: [
                              Row(
                                children: [
                                  RoundedCheckBoxWidget(
                                    value:
                                        state
                                            .selectedRfidItemList[index]
                                            .isLocationSelected ??
                                        false,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();

                                      context.read<ConsumptionItemUpdateBloc>().add(
                                        LocationOrEquipmentCheckEvent(
                                          index: index,
                                          isLocation:
                                              !(state
                                                      .selectedRfidItemList[index]
                                                      .isLocationSelected ??
                                                  false),
                                          isEquipment: false,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: AppSize.size8),
                                  Text(
                                    context.l.location,
                                    style: textTheme.titleMedium,
                                  ),
                                ],
                              ),

                              SizedBox(width: AppSize.size20),
                              Row(
                                children: [
                                  RoundedCheckBoxWidget(
                                    value:
                                        state
                                            .selectedRfidItemList[index]
                                            .isEquipmentSelected ??
                                        false,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();

                                      context.read<ConsumptionItemUpdateBloc>().add(
                                        LocationOrEquipmentCheckEvent(
                                          index: index,
                                          isEquipment:
                                              !(state
                                                      .selectedRfidItemList[index]
                                                      .isEquipmentSelected ??
                                                  false),
                                          isLocation: false,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: AppSize.size8),
                                  Text(
                                    context.l.equipment,
                                    style: textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(width: AppSize.size20),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppPadding.padding20,
                          bottom: AppPadding.padding15,
                        ),
                        child: BlocBuilder<
                          ConsumptionItemUpdateBloc,
                          ConsumptionItemUpdateState
                        >(
                          builder: (context, state) {
                            return Visibility(
                              visible:
                                  state
                                          .selectedRfidItemList[index]
                                          .isEquipmentSelected ==
                                      true ||
                                  state
                                          .selectedRfidItemList[index]
                                          .isLocationSelected ==
                                      true,
                              child: Visibility(
                                visible:
                                    state
                                        .selectedRfidItemList[index]
                                        .isEquipmentSelected ==
                                    true,
                                replacement: InkWell(
                                  onTap: () {
                                    context.push(
                                      AppRoute
                                          .consumptionSearchLocationListPage
                                          .path,
                                      extra: index,
                                    );
                                  },
                                  child: AppTextFormField(
                                    filled: true,
                                    enabled: false,
                                    labelText: context.l.location,
                                    hintText:
                                        state
                                            .selectedRfidItemList[index]
                                            .selectedLocationName ??
                                        "Select location",
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    context.push(
                                      AppRoute
                                          .consumptionSearchEquipmentListPage
                                          .path,
                                      extra: index,
                                    );
                                  },
                                  child: AppTextFormField(
                                    filled: true,
                                    enabled: false,
                                    labelText: context.l.equipment,
                                    hintText:
                                        state
                                            .selectedRfidItemList[index]
                                            .selectedEquipmentName ??
                                        "Select equipment",
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: AppPadding.padding8,
                      bottom: AppPadding.padding16,
                    ),
                    child: AppTextFormField(
                      labelText: context.l.remarks,
                      hintText: context.l.enterRemarks,
                      controller: remarkController,
                      onChanged: (value) {
                        context.read<ConsumptionItemUpdateBloc>().add(
                          UpdateItemValue(
                            index: index,
                            isForRemarks: true,
                            newValue: value,
                            storageLocationId:
                                itemList.defaultStorageLocationId,
                            rob: itemList.rob,
                            newStockRob: robTextController.text,
                            reconditionStock: reconditionStockController.text
                          ),
                        );
                      },
                      maxLine: 1,
                    ),
                  ),
                ),
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
