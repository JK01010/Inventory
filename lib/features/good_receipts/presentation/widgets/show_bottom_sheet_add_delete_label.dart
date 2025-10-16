import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../bagging_tagging_confirmtaion/presentation/widgets/custom_pre_image_button.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';
import 'show_bottom_sheet_add_label_item.dart';

Future showBottomSheetAddDeleteItem(
  BuildContext context,
  PurchaseOrderHDEntity purchaseOrderHDEntity,
) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.colorBackground2,
    isScrollControlled: true,
    builder: (context) {
      return SizedBox(
        height: AppSize.size200,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color:
                context.isDarkMode
                    ? AppColor.colorBGBlack
                    : AppColor.colorBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: AppSize.size10),
                Container(
                  height: AppSize.size4,
                  width: AppSize.size70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderRadius12,
                    ),
                    color: AppColor.colorGrey3,
                  ),
                ),
                SizedBox(height: AppSize.size20),
                CustomPreImageButton(
                  buttonName: context.l.add,
                  onTap: () {
                    // context.read<GoodsReceiptLabelBloc>().add(
                    //   GetAllGRLabelItemListToCreateLabelEvent(
                    //     purchaseOrderHDEntity.poId!,
                    //   ),
                    // );
                    Navigator.pop(context);
                    showBottomSheetAddLabelItem(context, purchaseOrderHDEntity);
                  },
                  iconName: AppIcons.addIcon,
                  color: context.customThemeColor(
                    light: AppColor.colorWhite,
                    dark: AppColor.colorDarkProfileContainer,
                  ),
                  buttonNameColor: context.customThemeColor(
                    light: AppColor.colorTextBlack2,
                    dark: AppColor.colorDividerLight,
                  ),
                ),
                SizedBox(height: AppSize.size5),
                CustomPreImageButton(
                  buttonName: context.l.delete,
                  onTap: () {},
                  iconName: AppIcons.deleteIconRed,
                  color: context.customThemeColor(
                    light: AppColor.colorWhite,
                    dark: AppColor.colorDarkProfileContainer,
                  ),
                  buttonNameColor: context.customThemeColor(
                    light: AppColor.colorTextBlack2,
                    dark: AppColor.colorDividerLight,
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
