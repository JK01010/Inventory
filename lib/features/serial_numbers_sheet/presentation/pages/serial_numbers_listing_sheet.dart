import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../good_receipts/purchase_order_item_detail/domain/entity/serial_number_entity.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../bloc/serial_numbers_listing_bloc.dart';
import '../bloc/serial_numbers_listing_bloc_event.dart';
import '../bloc/serial_numbers_listing_bloc_state.dart';
import '../widgets/serial_number_listing_header_widget.dart';
import '../widgets/serial_number_listing_text_field.dart';

class SerialNumbersListingSheet extends StatefulWidget {
  const SerialNumbersListingSheet({
    super.key,
    required this.currentSerialNumbers,
    required this.allSerialNumbers,
  });

  final List<SerialNumberEntity> currentSerialNumbers;
  final List<SerialNumberEntity> allSerialNumbers;

  @override
  State<SerialNumbersListingSheet> createState() =>
      _SerialNumbersListingSheetState();
}

class _SerialNumbersListingSheetState extends State<SerialNumbersListingSheet> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      context.read<SerialNumbersListingBloc>().add(
        SetSerialNumbersInitialDataEvent(
          currentSerialNumbers: widget.currentSerialNumbers,
          allSerialNumbers: widget.allSerialNumbers,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      SerialNumbersListingBloc,
      SerialNumbersListingBlocState
    >(
      listener: (context, state) {
        debugPrint(
          "inside the listener ${state.validationMessage} ${state.isValidated}",
        );
        if (state.isValidated && state.validationMessage.isEmpty) {
          showSuccessPopup("Success", context);
          context.pop(state.editedSerialNumbers);
        }
        if (state.validationMessage.isNotEmpty && state.isValidated == false) {
          showSuccessPopup(state.validationMessage, context);
        }
      },
      listenWhen: (previous, current) {
        return (previous.isValidated != current.isValidated ||
            previous.validationMessage != current.validationMessage);
      },
      builder: (context, state) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            child:
                state.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : state.editedSerialNumbers.isNotEmpty
                    ? Column(
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
                              value: state.isAutoGenerateEnabled,
                              onChanged: (bool? value) {
                                if (value != null) {
                                  context.read<SerialNumbersListingBloc>().add(
                                    ChangeAutoGenerateCheckBoxEvent(
                                      newValue: value,
                                    ),
                                  );
                                }
                              },
                            ),
                            Text(
                              context.l.generateAutoSerialNumber,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        Expanded(
                          child: AppDecoratedBoxShadowWidget(
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.75,
                              child: Column(
                                children: [
                                  SizedBox(height: AppSize.size10),
                                  SerialNumbersListingHeaderWidget(),
                                  Expanded(
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.scaffoldPadding,
                                      ),
                                      itemCount:
                                          state.editedSerialNumbers.length,
                                      itemBuilder: (context, index) {
                                        return SerialNumberListingTextField(
                                          key: ValueKey(
                                            state
                                                .editedSerialNumbers[index]
                                                .serialNumberId,
                                          ),
                                          isAutoGenerateEnabled:
                                              state.isAutoGenerateEnabled,
                                          index: index,
                                          initialValue:
                                              state
                                                  .editedSerialNumbers[index]
                                                  .serialNumber,
                                          onChanged: (value, itemIndex) {
                                            context
                                                .read<
                                                  SerialNumbersListingBloc
                                                >()
                                                .add(
                                                  ChangeSerialNumberEvent(
                                                    index: itemIndex,
                                                    newValue: value,
                                                  ),
                                                );
                                          },
                                        );
                                      },
                                      separatorBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        return SizedBox(height: AppSize.size10);
                                      },
                                    ),
                                  ),
                                ],
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
                          buttonSecondOnPress: () {
                            debugPrint("save button pressed");
                            context.read<SerialNumbersListingBloc>().add(
                              SaveSerialNumbersEvent(),
                            );
                            // context.pop(state.serialNumbers);
                          },
                        ),
                      ],
                    )
                    : Container(),
          ),
        );
      },
    );
  }
}
