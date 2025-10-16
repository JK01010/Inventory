// show_bottom_sheet_bar_code.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_dropdown_widget.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';
import '../goods_receipt_detail_label_bloc/goods_receipt_label_bloc.dart'; // Import the bloc
import 'goods_receipts_page/barcode_qr_pdf.dart';

Future showBottomSheetBarCode(
  BuildContext context,
  PurchaseOrderHDEntity purchaseOrderHDEntity, {
  required List<int> itemIds,
  required int grnHdId,
  required PrintMode? selectedPrintMode,
}) {
  TextEditingController printingController = TextEditingController();
  TextEditingController numberOfLabelController = TextEditingController();

  debugPrint("purchaseOrderHDEntity.grnId::${purchaseOrderHDEntity.grnId}");
  debugPrint("grnhdId::$grnHdId");
  debugPrint("itemIds::$itemIds");

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: AppColor.colorWhite,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.isDarkMode
                ? AppColor.colorBGBlack
                : AppColor.colorWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    //Bar Code mode area
                    BottomSheetHeaderWidget(
                      title: context.l.barCode,
                      onTap: () {
                        context.pop();
                      },
                    ),
                    Divider(
                      color: context.isDarkMode
                          ? AppColor.colorDarkDivider
                          : AppColor.closeButtonColor,
                    ),
                    //Bar code widget list
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: AppSize.size25),
                          AppDropDownWidget(
                            hintText: 'Select Type',
                            labelText: context.l.labelType,
                            items: purchaseOrderHDEntity.barCodeLabelTypeList
                                .map(
                                  (element) => DropdownMenuItem(
                                    value: element,
                                    child: Text(element),
                                  ),
                                )
                                .toList(),
                            onChanged: (selectedLabel) {
                              purchaseOrderHDEntity.selectedLabelType =
                                  selectedLabel.toString();
                            },
                            selectedValue:
                                purchaseOrderHDEntity.selectedLabelType,
                            filled: true,
                          ),
                          SizedBox(height: AppSize.size25),
                          AppTextFormField(
                            labelText: context.l.printingPosition,
                            controller: printingController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: Theme.of(context).textTheme.titleMedium,
                            filled: true,
                            maxLine: 1,
                          ),
                          // SizedBox(height: AppSize.size25),
                          /* AppTextFormField(
                            labelText: context.l.numberOfLabels,
                            controller: numberOfLabelController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: Theme.of(context).textTheme.titleMedium,
                            filled: true,
                            maxLine: 1,
                          ),
                          SizedBox(height: AppSize.size25),*/
                        ],
                      ),
                    ),
                  ],
                ),
                //button
                AppTwoRowButtonWidget(
                  buttonFirstTitle: context.l.clear,
                  buttonSecondTitle: context.l.print,
                  buttonFirstOnPress: () {
                    Navigator.pop(context);
                  },
                  buttonSecondOnPress: () {
                    purchaseOrderHDEntity.printingPosition = printingController
                        .text
                        .toString();
                    if (numberOfLabelController.text.isNotEmpty) {
                      purchaseOrderHDEntity.numberOfLabels = int.parse(
                        numberOfLabelController.text.toString(),
                      );
                    }
                    Navigator.pop(context);
                    context.read<GoodsReceiptLabelBloc>().add(
                      GRNCreateLabelEvent(grnId: grnHdId, itemIds: itemIds),
                    );
                    debugPrint("GRNCreateLabelEvent:$grnHdId $itemIds");

                    final bloc = context.read<GoodsReceiptLabelBloc>();

                    StreamSubscription<GoodsReceiptLabelState>? subscription;

                    subscription = bloc.stream.listen((state) {
                      if (!state.isLoading) {
                        subscription?.cancel();

                        if (state.grnCreateLabelList.isNotEmpty) {
                          Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) =>
                                generateBarcodesPdf(
                                  grnCreateLabelEntity:
                                      state.grnCreateLabelList,
                                  selectedPrintMode: selectedPrintMode,
                                  labelType:
                                      purchaseOrderHDEntity.selectedLabelType,
                                  printPosition: printingController.text,
                                ),
                          );
                        } else if (state.getGoodsReceiptsLabelDetailFailure
                            .isSome()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Failed to create labels. Please try again.",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "No labels were generated for the selected items.",
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
