import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/widgets/app_decorated_box_shadow_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_text_form_field.dart';
import 'package:pal_ng_inventory/features/widgets/app_two_row_button_widget.dart';
import 'package:pal_ng_inventory/features/widgets/bottom_sheet_header_widget.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';

class SerialNumberWidget extends StatelessWidget {
  const SerialNumberWidget({
    super.key,
    this.itemCount = 10,
    this.autoGenerate = false,
  });

  final int itemCount;
  final bool autoGenerate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GoodsReceiptCreateLabelBloc,
      GoodsReceiptCreateLabelState
    >(
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppPadding.scaffoldPadding,
                    ),
                    child: BottomSheetHeaderWidget(
                      title: context.l.serialNumber,
                      onTap: context.pop,
                    ),
                  ),
                  Divider(
                    color:
                        context.isDarkMode
                            ? AppColor.colorDarkDivider
                            : AppColor.closeButtonColor,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: state.isAutoSerialNumber,
                        onChanged: (bool? value) {
                          context.read<GoodsReceiptCreateLabelBloc>().add(
                            GenerateAutoNumberCheckboxEvent(value!),
                          );
                        },
                      ),
                      Text(
                        context.l.generateAutoSerialNumber,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                      child:
                          state.isAutoSerialNumber!
                              ? AppDecoratedBoxShadowWidget(
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.75,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        const _SerialNumberHeaderRow(),
                                        ...List.generate(
                                          state.autoSerialNumberList.length,
                                          (index) => _SerialNumberItemRow(
                                            index: index + 1,
                                            serialNumber:
                                                state
                                                    .autoSerialNumberList[index],
                                            isAutoSerialNumberEnabled:
                                                state.isAutoSerialNumber!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              : AppDecoratedBoxShadowWidget(
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.75,
                                  child: SingleChildScrollView(
                                    child: _SerialNumberInputWidget(
                                      serialNumber:
                                          state.autoSerialNumberList.isEmpty
                                              ? ''
                                              : state
                                                  .autoSerialNumberList
                                                  .first,
                                    ),
                                  ),
                                ),
                              ),
                    ),
                  ),
                  AppTwoRowButtonWidget(
                    buttonFirstTitle: context.l.close,
                    buttonFirstOnPress: () {
                      context.pop();
                    },
                    buttonSecondTitle: context.l.save,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SerialNumberInputWidget extends StatelessWidget {
  const _SerialNumberInputWidget({required this.serialNumber});

  final String serialNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.scaffoldPadding,
          ),
          child: Text(
            context.l.serialNo,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Divider(
          color:
              context.isDarkMode
                  ? AppColor.colorDarkDivider
                  : AppColor.closeButtonColor,
        ),
        const SizedBox(height: AppSize.size10),
        AppTextFormField(controller: TextEditingController()),
      ],
    );
  }
}

class _SerialNumberHeaderRow extends StatelessWidget {
  const _SerialNumberHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.scaffoldPadding,
          ),
          child: Row(
            children: <Widget>[
              Text(
                context.l.qty,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(width: AppSize.size10),
              Text(
                context.l.serialNo,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        Divider(
          color:
              context.isDarkMode
                  ? AppColor.colorDarkDivider
                  : AppColor.closeButtonColor,
        ),
        const SizedBox(height: AppSize.size10),
      ],
    );
  }
}

class _SerialNumberItemRow extends StatelessWidget {
  const _SerialNumberItemRow({
    required this.index,
    required this.serialNumber,
    required this.isAutoSerialNumberEnabled,
  });

  final int index;
  final String serialNumber;
  final bool isAutoSerialNumberEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.scaffoldPadding,
            ),
            child: Row(
              children: <Widget>[
                Text("$index", style: Theme.of(context).textTheme.titleMedium),
                SizedBox(width: AppSize.size10),
                Expanded(
                  child: AppTextFormField(
                    controller: TextEditingController(text: serialNumber),
                    enabled: false,
                    filled: false,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            context.read<GoodsReceiptCreateLabelBloc>().add(
              OnSerialNoUpdateEvent(serialNumber),
            );
          },
        ),
        Divider(
          color:
              context.isDarkMode
                  ? AppColor.commonDividerBlack
                  : AppColor.commonDividerWhite,
        ),
        const SizedBox(height: AppSize.size10),
      ],
    );
  }
}
