import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../bagging_tagging_confirmtaion/presentation/page/bagging_tagging_details_page.dart';
import '../../../bagging_tagging_confirmtaion/presentation/widgets/custom_dropdown_type_page_navigator.dart';
import '../../../bagging_tagging_confirmtaion/presentation/widgets/custom_search_field_bottom_sheet_textfeild.dart';
import '../../../good_receipts/presentation/storage_location_bloc/storage_location_bloc.dart';
import '../../../widgets/add_flat_button_with_three_button.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/app_text_form_field_non_editable.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/consumption_add_page_bloc/consumption_add_page_bloc.dart';
import '../widgets/consumption_item_search_bottom_sheet.dart';

class ConsumptionAddPage extends StatefulWidget {
  const ConsumptionAddPage({super.key});

  @override
  State<ConsumptionAddPage> createState() => _ConsumptionAddPageState();
}

class _ConsumptionAddPageState extends State<ConsumptionAddPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController defaultStorageController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController actualQtyController = TextEditingController();
  final TextEditingController umoController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.consumedItemDetails,
          onBack: () {
            context.read<ConsumptionAddPageBloc>().add(ClearButtonEvent());
            context.pop();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: AppDecoratedBoxShadowWidget(
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: SingleChildScrollView(
                  child: BlocConsumer<
                    ConsumptionAddPageBloc,
                    ConsumptionAddPageState
                  >(
                    listenWhen: (previous, current) {
                      return (previous.isCompletedFrom !=
                          current.isCompletedFrom);
                    },
                    listener: (
                      BuildContext context,
                      ConsumptionAddPageState state,
                    ) {
                      if (state.isCompletedFrom == "save") {
                        showSuccessPopup(context.l.savedSuccessfully, context);
                        context.read<ConsumptionAddPageBloc>().add(
                          ClearButtonEvent(),
                        );
                        context
                          ..pop()
                          ..pop();
                      }
                      if (state.isCompletedFrom == "saveAddNew") {
                        showSuccessPopup(context.l.savedSuccessfully, context);
                        searchController.clear();
                        defaultStorageController.clear();
                        umoController.clear();
                        actualQtyController.clear();
                        quantityController.clear();
                        remarkController.clear();
                        context.read<ConsumptionAddPageBloc>().add(
                          ClearButtonEvent(),
                        );
                      }
                    },
                    builder: (context, state) {
                      searchController.text = state.chooseItemText;
                      defaultStorageController.text = state.selectedStorageLocationCode;
                      umoController.text = state.umo;
                      actualQtyController.text = state.actualQuantity;
                      quantityController.text = state.quantity;
                      remarkController.text = state.remarks;

                      return Column(
                        children: [
                          SizedBox(height: AppSize.size15),
                          //defaultStorageLocation dropDown
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 56),
                            child: dropDownPageNavigator(
                              controller: defaultStorageController,
                              labelText: context.loc.defaultStorageLocation,
                              hintText: context.loc.select,
                              value: null,
                              context: context,
                              filled: true,
                              errorText:
                                  state.isChooseStorageLocationError
                                      ? context.l.chooseStorageLocation
                                      : null,
                              onPressed: () {
                                context.read<StorageLocationBloc>().add(
                                  FetchStorageLocationByParentIdEvent(0, null),
                                );
                                context.push(
                                  AppRoute.chooseStorageLocationPage.path,
                                  extra: {'screenType': 'consumption'}
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
                              consumptionItemSearchBottomSheet(context);
                              context.read<ConsumptionAddPageBloc>().add(
                                ValidationCheckEvent(
                                  fieldName: "chooseItem",
                                  isEnabled: false,
                                  onChangeValue: "",
                                ),
                              );
                            },
                          ),

                          SizedBox(height: AppSize.size20),

                          //quantity
                          AppTextFormField(
                            labelText: context.l.quantity,
                            hintText: context.l.enterQuantity,
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            filled: true,
                            errorText: state.isQuantityError
                                ? context.l.enterQuantity
                                : (int.tryParse(quantityController.text) ?? 0) >
                                (int.tryParse(actualQtyController.text) ?? 0)
                                ? context.l.qtyGreaterRob
                                : null,
                            onChanged: (value) {
                              context.read<ConsumptionAddPageBloc>().add(
                                ValidationCheckEvent(
                                  fieldName: "quantity",
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
                          //ActualQuantity
                          AppTextFormFieldNonEditable(
                            labelText: context.l.rob,
                            controller: actualQtyController,
                            enabled: false,
                            filled: true,
                          ),
                          SizedBox(height: AppSize.size20),
                          //UMO
                          /*AppTextFormField(
                            labelText: context.l.uom,
                            hintText: context.l.enterUnit,
                            controller: umoController,
                            keyboardType: TextInputType.number,
                            errorText:
                                state.isUmoError ? context.l.enterUMO : null,
                            filled: true,
                            onChanged: (value) {
                              context.read<ConsumptionAddPageBloc>().add(
                                ValidationCheckEvent(
                                  fieldName: "umo",
                                  isEnabled: false,
                                  onChangeValue: value,
                                ),
                              );
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          SizedBox(height: AppSize.size20),*/
                          //Remarks
                          AppTextFormField(
                            labelText: context.l.remarks,
                            hintText: context.l.enterRemarks,
                            controller: remarkController,
                            filled: true,
                            onChanged: (value) {
                              context.read<ConsumptionAddPageBloc>().add(
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
            context.read<ConsumptionAddPageBloc>().add(
              SaveItemDetailsEvent(isSaveAddNew: false),
            );
          },
          buttonThreeTitle: context.l.saveAndAddNew,
          buttonThreeTitleOnPressed: () {
            context.read<ConsumptionAddPageBloc>().add(
              SaveItemDetailsEvent(isSaveAddNew: true),
            );
          },
          cancelOnPressed: () {
            context.read<ConsumptionAddPageBloc>().add(ClearButtonEvent());
            context.pop();
          },
        ),
      ),
    );
  }
}
