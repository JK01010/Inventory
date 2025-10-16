import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../bagging_tagging_confirmtaion/presentation/page/bagging_tagging_details_page.dart';
import '../../../bagging_tagging_confirmtaion/presentation/widgets/custom_dropdown_type_page_navigator.dart';
import '../../../bagging_tagging_confirmtaion/presentation/widgets/custom_search_field_bottom_sheet_textfeild.dart';
import '../../../good_receipts/presentation/storage_location_bloc/storage_location_bloc.dart';
import '../../../widgets/add_flat_button_with_three_button.dart';
import '../../../widgets/app_text_form_field_non_editable.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/stock_update_add_page/stock_update_add_bloc.dart';
import '../widgets/app_text_form_field_stock_update.dart';
import '../widgets/stock_update_item_search_bottom_sheet.dart';

class StockUpdateAddPage extends StatefulWidget {
  const StockUpdateAddPage({super.key});

  @override
  State<StockUpdateAddPage> createState() => _StockUpdateAddPageState();
}


class _StockUpdateAddPageState extends State<StockUpdateAddPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController selectedStorageController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  // final TextEditingController actualQtyController = TextEditingController();
  final TextEditingController totalRobController = TextEditingController();

  final TextEditingController newStockController = TextEditingController();
  final TextEditingController adjustNewStockRobController = TextEditingController();

  final TextEditingController reconditionStockController = TextEditingController();
  final TextEditingController adjReconditionNewStockRobController = TextEditingController();

  final TextEditingController uomController = TextEditingController();


  final TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
   /* context.read<StockUpdateAddBloc>().add(
      FetchItemMasterByStorageIdEvent(storageLocationId: 10),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.stockItemDetails,
          onBack: () {
            context.read<StockUpdateAddBloc>().add(ClearButtonEvent());
            context.pop();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: Container(
            decoration: BoxDecoration(
              color:
                  context.isDarkMode
                      ? AppColor.colorDarkProfileContainer
                      : AppColor.colorWhite,
              // border: boxBorder,
              borderRadius: BorderRadius.circular(
                AppBorderRadius.borderRadius15,
              ),
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: SingleChildScrollView(
                  child: BlocConsumer<StockUpdateAddBloc, StockUpdateAddState>(
                    listenWhen: (previous, current) {
                      return (previous.isCompletedFrom !=
                          current.isCompletedFrom);
                    },
                    listener: (
                      BuildContext context,
                      StockUpdateAddState state,
                    ) {
                      if (state.isCompletedFrom == "save") {
                        showSuccessPopup(context.l.savedSuccessfully, context);
                        context
                          ..pop()
                          ..pop();
                      }
                      if (state.isCompletedFrom == "saveAddNew") {
                        showSuccessPopup(context.l.savedSuccessfully, context);
                        searchController.clear();
                        totalRobController.clear();
                        selectedStorageController.clear();
                        newStockController.clear();
                        quantityController.clear();
                        remarkController.clear();
                    /*    context.read<StockUpdateAddBloc>().add(
                          FetchItemMasterByStorageIdEvent(
                            storageLocationId: 10,
                          ),
                        );*/
                      }
                    },
                    builder: (context, state) {
                      searchController.text = state.chooseItemText;
                      selectedStorageController.text = state.selectedStorageLocationCode;
                      totalRobController.text = state.totalRob;
                      newStockController.text = state.newStock;
                      reconditionStockController.text = state.reconditionStock;
                      uomController.text = state.uomName;
                      quantityController.text = state.quantity;
                      remarkController.text = state.remarks;

                      return Column(
                        children: [
                          SizedBox(height: AppSize.size15),
                          //defaultStorageLocation dropDown
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 56),
                            child: dropDownPageNavigator(
                              controller: selectedStorageController,
                              labelText: context.loc.selectedLocation,
                              hintText: context.loc.select,
                              value: null,
                              context: context,
                              filled: true,
                              errorText:
                                  state.isItemSearchError
                                      ? context.l.chooseStorageLocation
                                      : null,
                              onPressed: () {
                                context.read<StorageLocationBloc>().add(
                                  FetchStorageLocationByParentIdEvent(0, null),
                                );
                                context.push(
                                  AppRoute.chooseStorageLocationPage.path,
                                    extra: {'screenType': 'stockUpdate'}
                                );
                              },
                            ),
                          ),
                          SizedBox(height: AppSize.size18),
                          //itemSearch
                          CustomTypeAheadFieldBottomSheet(
                            label: context.l.item,
                            hint: context.l.search,
                            controller: searchController,
                            filled: true,
                            errorText:
                                state.isItemSearchError
                                    ? context.l.chooseItem
                                    : null,
                            onTap: () {
                              stockUpdateItemSearchBottomSheet(context);
                              context.read<StockUpdateAddBloc>().add(
                                ValidationCheckEvent(
                                  fieldName: "chooseItem",
                                  isEnabled: false,
                                  onChangeValue: "",
                                ),
                              );
                            },
                          ),
                          SizedBox(height: AppSize.size20),

                          //total selected rob
                          AppTextFormFieldNonEditable(
                            fillColor: AppColor.colorLightGrey,
                            labelText: context.l.selectedTotalRob,
                            controller: totalRobController,
                            enabled: false,
                            filled: true,
                          ),
                          SizedBox(height: AppSize.size20),
                          //new stock rob
                          AppTextFormFieldNonEditable(
                            fillColor: AppColor.colorLightGrey,
                            labelText: context.l.newStockRob,
                            controller: newStockController,
                            enabled: false,
                            filled: true,
                          ),
                          SizedBox(height: AppSize.size20),
                          //Adjust new stock rob
                          AppTextFormFieldStockUpdate(
                            labelText: context.l.adjustNewStockRob,
                            hintText: context.l.enterQuantity,
                            controller: adjustNewStockRobController,
                            keyboardType: TextInputType.number,
                            filled: true,
                           /* errorText: state.isQuantityError
                                ? context.l.enterQuantity
                                : *//*(int.tryParse(quantityController.text) ?? 0) <
                                (int.tryParse(umoController.text) ?? 0)
                                ? context.l.robLesserQuantity
                                :*//* null,*/
                            onChanged: (value) {
                              context.read<StockUpdateAddBloc>().add(
                                ValidationCheckEvent(
                                  fieldName: "newStock",
                                  isEnabled: false,
                                  onChangeValue: value,
                                ),
                              );
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          SizedBox(height: AppSize.size20),
                          //Recondition new stock rob
                          AppTextFormFieldNonEditable(
                            fillColor: AppColor.colorLightGrey,
                            labelText: context.l.reconditionStockRob,
                            controller: reconditionStockController,
                            enabled: false,
                            filled: true,
                          ),
                          SizedBox(height: AppSize.size20),
                          //Adjust Recondition new stock rob
                          AppTextFormFieldStockUpdate(
                            labelText: context.l.adjustReconditionStockRob,
                            hintText: context.l.enterQuantity,
                            controller: adjReconditionNewStockRobController,
                            keyboardType: TextInputType.number,
                            filled: true,
                           /* errorText: state.isQuantityError
                                ? context.l.enterQuantity
                                : *//*(int.tryParse(quantityController.text) ?? 0) <
                                (int.tryParse(umoController.text) ?? 0)
                                ? context.l.robLesserQuantity
                                :*//* null,*/
                            onChanged: (value) {
                              context.read<StockUpdateAddBloc>().add(
                                ValidationCheckEvent(
                                  fieldName: "reconditionStock",
                                  isEnabled: false,
                                  onChangeValue: value,
                                ),
                              );
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          SizedBox(height: AppSize.size20),
                          //UMO
                          AppTextFormFieldNonEditable(
                            fillColor: AppColor.colorLightGrey,
                            labelText: context.l.uom,
                            controller: uomController,
                            enabled: false,
                            filled: true,
                          ),
                          SizedBox(height: AppSize.size20),

                          //Remarks
                          AppTextFormFieldStockUpdate(
                            labelText: context.l.remarks,
                            hintText: context.l.enterRemarks,
                            controller: remarkController,
                            filled: true,
                            onChanged: (value) {
                              context.read<StockUpdateAddBloc>().add(
                                ValidationCheckEvent(
                                  fieldName: "remark",
                                  isEnabled: false,
                                  onChangeValue: value,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: AppSize.size16),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: AppThreeRowButtonWidget(
          buttonSecondTitle: context.l.save,
          buttonSecondTitleOnPressed: () {
            context.read<StockUpdateAddBloc>().add(
              SaveItemDetailsEvent(isSaveAddNew: false),
            );
          },
          buttonThreeTitle: context.l.saveAndAddNew,
          buttonThreeTitleOnPressed: () {
            context.read<StockUpdateAddBloc>().add(
              SaveItemDetailsEvent(isSaveAddNew: true),
            );
          },
          cancelOnPressed: () {
            context.read<StockUpdateAddBloc>().add(ClearButtonEvent());
            context.pop();
          },
        ),
      ),
    );
  }
}
