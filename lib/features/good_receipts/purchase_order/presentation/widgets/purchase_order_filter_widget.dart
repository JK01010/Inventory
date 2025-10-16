import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../../core/utils/app_date_utils.dart';
import '../../../../common_feature/domain/entities/port_entity.dart';
import '../../../../widgets/app_search_bar_widget.dart';
import '../../../../widgets/app_suffix_icon.dart';
import '../../../../widgets/app_text_form_field.dart';
import '../../../../widgets/app_two_row_button_widget.dart';
import '../../../../widgets/bottom_sheet_header_widget.dart';
import '../../../../widgets/choose_category_widget.dart';
import '../../domain/entity/purchase_order_entity.dart';
import '../bloc/purchase_order_bloc/purchase_order_bloc.dart';
import '../bloc/purchase_order_filter_bloc/purchase_order_filter_bloc.dart';
import 'choose_category_purchase_order_bottom_sheet_widget.dart';

class PurchaseOrderFilterWidget extends StatefulWidget {
  const PurchaseOrderFilterWidget({super.key});

  @override
  State<PurchaseOrderFilterWidget> createState() =>
      _PurchaseOrderFilterWidgetState();
}

class _PurchaseOrderFilterWidgetState extends State<PurchaseOrderFilterWidget> {
  late TextEditingController _fromDateTextController;
  late TextEditingController _toDateTextController;
  late TextEditingController _textEditingController;
  late TextEditingController _categoryTextEditingController;
  late TextEditingController _grnSearchController;
  late TextEditingController _portController;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fromDateTextController = TextEditingController();
    _toDateTextController = TextEditingController();
    _textEditingController = TextEditingController();
    _categoryTextEditingController = TextEditingController();
    _grnSearchController = TextEditingController();
    _portController = TextEditingController();

    context.read<PurchaseOrderFilterBloc>().add(FetchAllCategory());
  }

  void _onPortChanged({required String query}) {
    if (query.isEmpty) {
      context.read<PurchaseOrderFilterBloc>().add(
        FetchAllPortListFromDb(query: ''),
      );
      return;
    }
    if (query.length <= 2) {
      return;
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<PurchaseOrderFilterBloc>().add(
        FetchAllPortListFromDb(query: query),
      );
    });
  }

  void _onSearchChanged({required String query}) {
    if (query.isEmpty) {
      context.read<PurchaseOrderFilterBloc>().add(SearchPoNumber(poNumber: ''));
      return;
    }
    if (query.length <= 2) {
      return;
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<PurchaseOrderFilterBloc>().add(
        SearchPoNumber(poNumber: query),
      );
    });
  }

  void _onGrnSearchChanged({required String query}) {
    if (query.isEmpty) {
      context.read<PurchaseOrderFilterBloc>().add(SearchGrnNo(grnNo: ''));
      return;
    }
    if (query.length <= 2) {
      return;
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<PurchaseOrderFilterBloc>().add(SearchGrnNo(grnNo: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<PurchaseOrderFilterBloc>().state;

    _fromDateTextController.text =
        state.purchaseOrderFilterEntity.toDate == null
            ? "Select Date"
            : AppDateUtils.formatDateDdMMMyyyy(
              date: state.purchaseOrderFilterEntity.fromDate!,
            );
    _toDateTextController.text =
        state.purchaseOrderFilterEntity.fromDate == null
            ? "Select Date"
            : AppDateUtils.formatDateDdMMMyyyy(
              date: state.purchaseOrderFilterEntity.toDate!,
            );
    _textEditingController.text =
        state.purchaseOrderFilterEntity.poNumberOrTitle ?? "";
    _grnSearchController.text = state.purchaseOrderFilterEntity.grnNo ?? "";
    _portController.text =
        state.purchaseOrderFilterEntity.deliveryPortName ?? "";

    return BlocBuilder<PurchaseOrderFilterBloc, PurchaseOrderFilterState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final list =
            state.purchaseOrderFilterEntity.categoryList
                .map((e) => e.categoryName)
                .toList();

        String displayText;
        if (list.isEmpty) {
          displayText = '';
        } else if (list.length == 1) {
          displayText = list.first;
        } else if (list.length == 2) {
          displayText = '${list[0]}, ${list[1]}';
        } else {
          displayText = '${list[0]}, ${list[1]} +${list.length - 2}';
        }

        _categoryTextEditingController.text = displayText;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHeaderWidget(
              title: context.l.filter,
              onTap: () {
                context.read<PurchaseOrderFilterBloc>().add(
                  ClearCategoryTempFilter(),
                );
                context.pop();
              },
            ),
            Divider(
              color:
                  context.isDarkMode
                      ? AppColor.colorDarkDivider
                      : AppColor.closeButtonColor,
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //search
                  AppSearchBar<PurchaseOrderEntity>(
                    itemToString: (p0) {
                      return p0.poCode;
                    },
                    suggestionsCallback: (search) async {
                      return state.purchaseOrderList;
                    },
                    items: state.purchaseOrderList,
                    labelText: context.l.search,
                    hintText: context.l.poNumberOrTitle,
                    controller: _textEditingController,
                    onSelected: (value) {
                      context.read<PurchaseOrderFilterBloc>().add(
                        ChangePoNumberEvent(poNumber: value.poCode),
                      );
                      _textEditingController.text = value.poCode;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    suffixIcon: AppSuffixIcon(imagePath: AppIcons.searchIcon),
                    suffixIconBoxConstraints: BoxConstraints(),
                    onChanged: (value) {
                      _onSearchChanged(query: value);
                    },
                  ),
                  SizedBox(height: AppSize.size10),
                  //category
                  ChooseCategoryWidget(
                    controller: _categoryTextEditingController,
                    onTap: () async {
                      context.read<PurchaseOrderFilterBloc>().add(
                        AddCategoryListToTempList(),
                      );
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: false,
                        backgroundColor: AppColor.colorTransparent,
                        builder: (context) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColor.colorWhite,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                  AppBorderRadius.borderRadius20,
                                ),
                              ),
                            ),
                            child: SafeArea(
                              child:
                                  ChooseCategoryPurchaseOrderBottomSheetWidget(),
                            ),
                          );
                        },
                      );
                    },

                    hintText: context.l.chooseCategory,
                    labelText: context.l.category,

                    suffixIcon: AppSuffixIcon(
                      imagePath: AppIcons.dropDownArrow,
                      height: AppSize.size20,
                      width: AppSize.size20,
                    ),
                    suffixIconBoxConstraints: BoxConstraints(),
                  ),
                  SizedBox(height: AppSize.size10),
                  //delivery port
                  AppSearchBar<PortEntity>(
                    itemToString: (p0) {
                      return p0.portName;
                    },
                    suggestionsCallback: (p0) async {
                      return state.portEntityList;
                    },
                    items: state.portEntityList,
                    labelText: context.l.deliveryPort,
                    hintText: context.l.chooseDeliveryPort,
                    controller: _portController,
                    onChanged: (value) {
                      _onPortChanged(query: value);
                      _portController.text = value;
                    },
                    onSelected: (value) {
                      context.read<PurchaseOrderFilterBloc>().add(
                        ChangeDeliveryPort(deliveryPortName: value.portName),
                      );
                      _portController.text = value.portName;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    suffixIcon: AppSuffixIcon(imagePath: AppIcons.searchIcon),
                    suffixIconBoxConstraints: BoxConstraints(),
                  ),
                  SizedBox(height: AppSize.size10),
                  //search grn
                  AppSearchBar<PurchaseOrderEntity>(
                    itemToString: (p0) {
                      return p0.grnId.toString();
                    },
                    suggestionsCallback: (search) async {
                      return state.grnFilteredList;
                    },
                    items: state.grnFilteredList,
                    labelText: context.l.search,
                    direction: VerticalDirection.up,
                    hintText: context.l.grnNoForPartialGrn,
                    controller: _grnSearchController,
                    onSelected: (value) {
                      _grnSearchController.text = value.grnId.toString();
                      context.read<PurchaseOrderFilterBloc>().add(
                        ChangeGrnNo(purchaseOrderHDEntity: value),
                      );
                    },
                    suffixIcon: AppSuffixIcon(imagePath: AppIcons.searchIcon),
                    suffixIconBoxConstraints: BoxConstraints(),
                    onChanged: (value) {
                      _onGrnSearchChanged(query: value);
                    },
                  ),
                  SizedBox(height: AppSize.size10),
                  //date
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          labelText: context.l.grnDateFrom,
                          controller: _fromDateTextController,
                          suffixIcon: AppSuffixIcon(
                            imagePath: AppIcons.calendarIcon,
                            height: AppSize.size16,
                          ),
                          suffixIconConstraints: BoxConstraints(),

                          onTap: () async {
                            final pickedDate = await AppDateUtils.appDatePicker(
                              context: context,
                              initialDate:
                                  state.purchaseOrderFilterEntity.fromDate,
                            );
                            if (pickedDate != null && context.mounted) {
                              context.read<PurchaseOrderFilterBloc>().add(
                                ChangeStartDate(dateTime: pickedDate),
                              );
                              _fromDateTextController
                                  .text = AppDateUtils.formatDateDdMMMyyyy(
                                date: pickedDate,
                              );
                            }
                          },
                          readOnly: true,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(width: AppSize.size13),
                      Expanded(
                        child: AppTextFormField(
                          labelText: context.l.grnDateTo,
                          controller: _toDateTextController,
                          suffixIcon: AppSuffixIcon(
                            imagePath: AppIcons.calendarIcon,
                            height: AppSize.size16,
                          ),
                          suffixIconConstraints: BoxConstraints(),

                          onTap: () async {
                            final pickedDate = await AppDateUtils.appDatePicker(
                              context: context,
                              initialDate:
                                  state.purchaseOrderFilterEntity.toDate,
                            );
                            if (pickedDate != null && context.mounted) {
                              context.read<PurchaseOrderFilterBloc>().add(
                                ChangeEndDate(dateTime: pickedDate),
                              );
                              _toDateTextController
                                  .text = AppDateUtils.formatDateDdMMMyyyy(
                                date: pickedDate,
                              );
                            }
                          },
                          readOnly: true,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size10),
                ],
              ),
            ),
            AppTwoRowButtonWidget(
              buttonSecondTitle: context.l.apply,
              buttonFirstOnPress: () {
                context.read<PurchaseOrderFilterBloc>().add(ClearFilter());
                _categoryTextEditingController.clear();
                _textEditingController.clear();
                _grnSearchController.clear();
                context.read<PurchaseOrderBloc>().add(GetPurchaseOrderFromDb());

                context.pop();
              },
              buttonSecondOnPress: () {
                context.read<PurchaseOrderBloc>().add(
                  GetPurchaseOrderFromDb(
                    purchaseOrderFilterEntity: state.purchaseOrderFilterEntity,
                  ),
                );
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _fromDateTextController.dispose();
    _toDateTextController.dispose();
    _textEditingController.dispose();
    _categoryTextEditingController.dispose();
  }
}

// class _StatusCheckbox extends StatelessWidget {
//   const _StatusCheckbox({required this.label, required this.value, this.onTap});

//   final String label;
//   final bool value;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         RoundedCheckBoxWidget(value: value, onTap: onTap ?? () {}),
//         const SizedBox(width: AppSize.size10),
//         Text(label),
//         const SizedBox(width: AppSize.size10),
//       ],
//     );
//   }
// }
