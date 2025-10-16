import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';
import 'show_bottom_sheet_bar_code.dart';



Future showBottomSheetPrintMode(
  BuildContext context,
  PurchaseOrderHDEntity purchaseOrderHDEntity,
    {required List<int> itemIds, required int grnHdId}
    ) {
  ValueNotifier<PrintMode?> selectedPrintMode = ValueNotifier(
    purchaseOrderHDEntity.qrCode == true
        ? PrintMode.qrCode
        : purchaseOrderHDEntity.barCode == true
            ? PrintMode.barCode
            : null,
  );

  return showModalBottomSheet(
    isScrollControlled: true,isDismissible: false,useSafeArea: true,
    context: context,
    backgroundColor: AppColor.colorWhite,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.36,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color:
                context.isDarkMode
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
                    //print mode area
                    BottomSheetHeaderWidget(
                      title: context.l.select,
                      onTap: () {
                        context.pop();
                      },
                    ),
                    Divider(
                      color:
                          context.isDarkMode
                              ? AppColor.colorDarkDivider
                              : AppColor.closeButtonColor,
                    ),
                    //radio button area
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                Text(context.l.qrCode),
                                Spacer(),
                                ValueListenableBuilder(
                                  valueListenable: selectedPrintMode,
                                  builder: (context, value, child) {
                                    return RoundedCheckBoxWidget(
                                      value: value == PrintMode.qrCode,
                                      onTap: () {
                                        selectedPrintMode.value = PrintMode.qrCode;
                                        purchaseOrderHDEntity..qrCode = true
                                        ..barCode = false;
                                      },
                                    );
                                  },
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                Text(context.l.barCode),
                                Spacer(),
                                ValueListenableBuilder(
                                  valueListenable: selectedPrintMode,
                                  builder: (context, value, child) {
                                    return RoundedCheckBoxWidget(
                                      value: value == PrintMode.barCode,
                                      onTap: () {
                                        selectedPrintMode.value = PrintMode.barCode;
                                        purchaseOrderHDEntity..barCode = true
                                        ..qrCode = false;
                                      },
                                    );
                                  },
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
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
                IntrinsicHeight(
                  child: AppTwoRowButtonWidget(
                    buttonFirstTitle: context.l.clear,
                    buttonSecondTitle: context.l.apply,
                    buttonFirstOnPress: () {
                      Navigator.pop(context);
                    },
                    buttonSecondOnPress: () {
                      if (selectedPrintMode.value == null) {
                        showSuccessPopup('Please Choose Print Mode', context);
                      } else {
                        Navigator.pop(context);
                        showBottomSheetBarCode(
                          context,
                          purchaseOrderHDEntity,
                          itemIds: itemIds,
                          grnHdId: grnHdId,
                          selectedPrintMode: selectedPrintMode.value,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
