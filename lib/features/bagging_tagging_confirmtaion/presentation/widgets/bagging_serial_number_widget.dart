import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_text_form_field.dart';
import 'package:pal_ng_inventory/features/widgets/app_two_row_button_widget.dart';
import 'package:pal_ng_inventory/features/widgets/bottom_sheet_header_widget.dart';

import '../bloc/bagging_tagging_purchase_list/bagging_tagging_purchase_list_bloc.dart';

class BaggingSerialNumberWidget extends StatelessWidget {
  const BaggingSerialNumberWidget({
    super.key,
    this.itemCount = 10,
    this.autoGenerate = false,
  });

  final int itemCount;
  final bool autoGenerate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BaggingTaggingPurchaseListBloc,
      BaggingTaggingPurchaseListState
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
                  const Divider(),
                  Row(
                    children: [
                      Checkbox(
                        value: state.isBaggingAutoSerialNumber,
                        onChanged: (bool? value) {
                          context.read<BaggingTaggingPurchaseListBloc>().add(
                            BaggingAutoGenerateNumberCheckboxEvent(value!),
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
                          state.isBaggingAutoSerialNumber!
                              ? AppDecoratedBoxShadowWidget(
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.65,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const BaggingSerialNumberHeaderRow(),
                                        ...List.generate(
                                          state.autoSerialNumberList.length,
                                          (index) => BaggingSerialNumberItemRow(
                                            index: index + 1,
                                            serialNumber:
                                                state
                                                    .autoSerialNumberList[index],
                                            isAutoSerialNumberEnabled:
                                                state
                                                    .isBaggingAutoSerialNumber!,
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
                                      MediaQuery.sizeOf(context).height * 0.65,
                                  child: SingleChildScrollView(
                                    child: BaggingSerialNumberInputWidget(
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
                  AppTwoRowButtonWidget(buttonSecondTitle: context.l.save),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class BaggingSerialNumberInputWidget extends StatelessWidget {
  const BaggingSerialNumberInputWidget({required this.serialNumber});

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
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontSize: AppFontSize.fontSize14),
          ),
        ),
        const Divider(),
        const SizedBox(height: AppSize.size10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding10),
          child: AppTextFormField(
            controller: TextEditingController(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class BaggingSerialNumberHeaderRow extends StatelessWidget {
  const BaggingSerialNumberHeaderRow();

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
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: AppFontSize.fontSize14,
                ),
              ),
              SizedBox(width: AppSize.size10),
              Text(
                context.l.serialNo,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: AppFontSize.fontSize14,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(height: AppSize.size10),
      ],
    );
  }
}

class BaggingSerialNumberItemRow extends StatelessWidget {
  const BaggingSerialNumberItemRow({
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
                Text("$index"),
                SizedBox(width: AppSize.size10),
                Expanded(
                  child: AppTextFormField(
                    controller: TextEditingController(text: serialNumber),
                    enabled: false,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            context.read<BaggingTaggingPurchaseListBloc>().add(
              OnBaggingSerialNoUpdateEvent(serialNumber),
            );
          },
        ),
        const Divider(),
        const SizedBox(height: AppSize.size10),
      ],
    );
  }
}
