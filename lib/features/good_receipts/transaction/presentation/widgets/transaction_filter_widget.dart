import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_enum.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/utils/app_date_utils.dart';
import '../../../../common_feature/domain/entities/port_entity.dart';
import '../../../../widgets/app_search_bar_widget.dart';
import '../../../../widgets/app_suffix_icon.dart';
import '../../../../widgets/app_text_form_field.dart';
import '../../../../widgets/app_two_row_button_widget.dart';
import '../../../../widgets/bottom_sheet_header_widget.dart';
import '../../../../widgets/choose_category_transaction_bottom_sheet_widget.dart';
import '../../../../widgets/choose_category_widget.dart';
import '../../../../widgets/rounded_check_box_widget.dart';
import '../../domain/entity/transaction_entity.dart';
import '../bloc/transaction_bloc/transaction_bloc.dart';
import '../bloc/transaction_filter_bloc/transaction_filter_bloc.dart';

class GoodReceiptTransactionFilterWidget extends StatefulWidget {
  const GoodReceiptTransactionFilterWidget({super.key});

  @override
  State<GoodReceiptTransactionFilterWidget> createState() =>
      _GoodReceiptTransactionFilterWidgetState();
}

class _GoodReceiptTransactionFilterWidgetState
    extends State<GoodReceiptTransactionFilterWidget> {
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

    context.read<TransactionFilterBloc>().add(FetchAllCategory());
  }

  void _onSearchChanged({required String query}) {
    if (query.isEmpty) {
      context.read<TransactionFilterBloc>().add(SearchPoNumber(poNumber: ''));
      return;
    }
    if (query.length <= 2) {
      return;
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<TransactionFilterBloc>().add(
        SearchPoNumber(poNumber: query),
      );
    });
  }

  void _onPortChanged({required String query}) {
    if (query.isEmpty) {
      context.read<TransactionFilterBloc>().add(
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
      context.read<TransactionFilterBloc>().add(
        FetchAllPortListFromDb(query: query),
      );
    });
  }

  void _onGrnSearchChanged({required String query}) {
    if (query.isEmpty) {
      context.read<TransactionFilterBloc>().add(SearchGrnNo(grnNo: ''));
      return;
    }
    if (query.length <= 2) {
      return;
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<TransactionFilterBloc>().add(SearchGrnNo(grnNo: query));
    });
  }

  @override
  Widget build(BuildContext ctx) {
    final state = context.read<TransactionFilterBloc>().state;

    _fromDateTextController.text =
        state.transactionFilterEntity.toDate == null
            ? "Select Date"
            : AppDateUtils.formatDateDdMMMyyyy(
              date: state.transactionFilterEntity.toDate!,
            );
    _toDateTextController.text =
        state.transactionFilterEntity.fromDate == null
            ? "Select Date"
            : AppDateUtils.formatDateDdMMMyyyy(
              date: state.transactionFilterEntity.fromDate!,
            );
    _textEditingController.text =
        state.transactionFilterEntity.poNumberOrTitle ?? "";
    _grnSearchController.text = state.transactionFilterEntity.grnNo ?? "";
    return BlocBuilder<TransactionFilterBloc, TransactionFilterState>(
      builder: (context, state) {
        final list =
            state.transactionFilterEntity.categoryList
                ?.map((e) => e.categoryName)
                .toList() ??
            [];

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
            Padding(
              padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
              child: BottomSheetHeaderWidget(
                title: context.l.filter,
                onTap: () {
                  context.read<TransactionFilterBloc>().add(
                    ClearCategoryTempFilter(),
                  );
                  context.pop();
                },
              ),
            ),
            Divider(color: AppColor.closeButtonColor),
            Padding(
              padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //search
                  AppSearchBar<TransactionEntity>(
                    itemToString: (p0) {
                      return p0.poNo;
                    },
                    suggestionsCallback: (p0) async {
                      return state.transactionList;
                    },
                    items: state.transactionList,
                    labelText: context.l.search,
                    hintText: context.l.poNumberOrTitle,
                    controller: _textEditingController,
                    onChanged: (value) {
                      _onSearchChanged(query: value);
                      _textEditingController.text = value;
                    },
                    onSelected: (value) {
                      context.read<TransactionFilterBloc>().add(
                        ChangePoNumberEvent(poNumber: value.poNo),
                      );
                      _textEditingController.text = value.poNo;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    suffixIcon: AppSuffixIcon(imagePath: AppIcons.searchIcon),
                    suffixIconBoxConstraints: BoxConstraints(),
                  ),
                  SizedBox(height: AppSize.size10),
                  //category
                  ChooseCategoryWidget(
                    onTap: () async {
                      context.read<TransactionFilterBloc>().add(
                        AddCategoryListToTempList(),
                      );
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,

                        backgroundColor: AppColor.colorTransparent,
                        builder: (_) {
                          return SafeArea(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColor.colorWhite,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    AppBorderRadius.borderRadius20,
                                  ),
                                ),
                              ),
                              child: BlocProvider.value(
                                value: context.read<TransactionFilterBloc>(),
                                child:
                                    ChooseCategoryTransactionBottomSheetWidget(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    hintText: context.l.chooseCategory,
                    labelText: context.l.category,
                    controller: _categoryTextEditingController,

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
                      context.read<TransactionFilterBloc>().add(
                        ChangeDeliveryPort(portId: value.id),
                      );
                      _portController.text = value.portName;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    suffixIcon: AppSuffixIcon(imagePath: AppIcons.searchIcon),
                    suffixIconBoxConstraints: BoxConstraints(),
                  ),
                  SizedBox(height: AppSize.size10),
                  //search grn
                  AppSearchBar<TransactionEntity>(
                    itemToString: (p0) {
                      return p0.receiptNo.toString();
                    },
                    suggestionsCallback: (p0) async {
                      return state.grnFilteredList;
                    },
                    items: state.grnFilteredList,
                    labelText: context.l.search,
                    direction: VerticalDirection.up,
                    hintText: context.l.grnNoForPartialGrn,
                    onSelected: (value) {
                      _grnSearchController.text = value.grnId.toString();
                      context.read<TransactionFilterBloc>().add(
                        ChangeGrnNo(query: value.grnId),
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
                            );
                            if (pickedDate != null && context.mounted) {
                              context.read<TransactionFilterBloc>().add(
                                ChangeStartDate(dateTime: pickedDate),
                              );
                              _fromDateTextController
                                  .text = AppDateUtils.formatDateDdMMMyyyy(
                                date: pickedDate,
                              );
                            }
                          },
                          readOnly: true,
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
                            );
                            if (pickedDate != null && context.mounted) {
                              context.read<TransactionFilterBloc>().add(
                                ChangeEndDate(dateTime: pickedDate),
                              );
                              _toDateTextController
                                  .text = AppDateUtils.formatDateDdMMMyyyy(
                                date: pickedDate,
                              );
                            }
                          },
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size10),

                  Text(context.l.status),
                  SizedBox(height: AppSize.size10),

                  Row(
                    children: [
                      _StatusCheckbox(
                        label: context.l.all,
                        value:
                            state.transactionFilterEntity.syncFilter ==
                            SyncFilter.all,
                        onTap: () {
                          context.read<TransactionFilterBloc>().add(
                            ChangeSyncFilter(syncFilter: SyncFilter.all),
                          );
                        },
                      ),
                      _StatusCheckbox(
                        label: context.l.synced,
                        value:
                            state.transactionFilterEntity.syncFilter ==
                            SyncFilter.synced,
                        onTap: () {
                          context.read<TransactionFilterBloc>().add(
                            ChangeSyncFilter(syncFilter: SyncFilter.synced),
                          );
                        },
                      ),
                      _StatusCheckbox(
                        label: context.l.unSynced,
                        value:
                            state.transactionFilterEntity.syncFilter ==
                            SyncFilter.unSynced,
                        onTap: () {
                          context.read<TransactionFilterBloc>().add(
                            ChangeSyncFilter(syncFilter: SyncFilter.unSynced),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppTwoRowButtonWidget(
              buttonSecondTitle: context.l.apply,
              buttonFirstOnPress: () {
                context.read<TransactionFilterBloc>().add(ClearFilter());
                _categoryTextEditingController.clear();
                _textEditingController.clear();
                _grnSearchController.clear();
                context.read<TransactionBloc>().add(GetAllTransactionFromDb());
                context.pop();
              },
              buttonSecondOnPress: () {
                context.read<TransactionBloc>().add(
                  GetAllTransactionFromDb(
                    transactionFilterEntity: state.transactionFilterEntity,
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
  }
}

class _StatusCheckbox extends StatelessWidget {
  const _StatusCheckbox({required this.label, required this.value, this.onTap});

  final String label;
  final bool value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedCheckBoxWidget(value: value, onTap: onTap ?? () {}),
        const SizedBox(width: AppSize.size10),
        Text(label),
        const SizedBox(width: AppSize.size10),
      ],
    );
  }
}
