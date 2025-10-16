import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_enum.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../../core/utils/app_date_utils.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_title_widget.dart';
import '../../../../widgets/chip_icon_list_widget.dart';
import '../../../presentation/widgets/goods_receipt_value_widget.dart';
import '../../domain/entity/purchase_order_entity.dart';
import 'item_detail_row_widget.dart';

class PurchaseOrderCardWidget extends StatelessWidget {
  const PurchaseOrderCardWidget({super.key, required this.purchaseOrderEntity});

  final PurchaseOrderEntity purchaseOrderEntity;

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ReceiptCardHeadingWidget(
                  purchaseOrderEntity: purchaseOrderEntity,
                ),
                SizedBox(height: AppSize.size10),
                // GRN no and category row
                ItemDetailRowWidget(
                  titleFirst: context.l.deliveryDate,
                  valueFirst:
                      (purchaseOrderEntity.vendorDeliveryDate.isNotEmpty)
                          ? AppDateUtils.getStringFromDateWithFormat(
                            DateTime.parse(
                              purchaseOrderEntity.vendorDeliveryDate,
                            ),
                            'dd-MMM-yyyy',
                          )
                          : '',
                  titleSecond: context.l.category,
                  valueSecond:
                      purchaseOrderEntity.requisitionCategory.toString(),
                ),

                SizedBox(height: AppSize.size10),
                // Title section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTitleWidget(text: context.l.title),
                    GoodsReceiptValueWidget(text: purchaseOrderEntity.title),
                  ],
                ),
              ],
            ),
          ),
          // Title
          Divider(
            height: 0,
            color: context.customThemeColor(
              light: AppColor.colorBlack5,
              dark: AppColor.colorDarkDivider,
            ),
          ),
          ChipIconListWidget(
            chipStatusList: [ChipStatus.chipNew, ChipStatus.fullyReceived],
          ),
        ],
      ),
    );
  }
}

class ReceiptCardHeadingWidget extends StatelessWidget {
  const ReceiptCardHeadingWidget({
    super.key,
    required this.purchaseOrderEntity,
  });

  final PurchaseOrderEntity purchaseOrderEntity;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // final String iconPath =
    //     goodsReceiptHDEntity.isLocked!
    //         ? AppIcons.lockIcon
    //         : AppIcons.unlockIcon;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          purchaseOrderEntity.poCode,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        // InkWell(
        //   onTap: () {
        //     if (goodsReceiptHDEntity.isLocked!) {
        //       return;
        //     }
        //     showModalBottomSheet(
        //       context: context,
        //       isScrollControlled: true,
        //       backgroundColor: AppColor.colorTransparent,
        //       builder: (context) {
        //         return DecoratedBox(
        //           decoration: BoxDecoration(
        //             color:
        //                 context.isDarkMode
        //                     ? AppColor.colorBGBlack
        //                     : AppColor.colorWhite,
        //             borderRadius: BorderRadius.vertical(
        //               top: Radius.circular(AppBorderRadius.borderRadius20),
        //             ),
        //           ),
        //           child: AddLocationBottomBarWidget(
        //             onTap: () {
        //               // showUnlockInfoPopup(context, goodsReceiptHDEntity.poNo!);
        //             },
        //             iconName: AppIcons.lockIcon,
        //             buttonName: context.l.lock,
        //           ),
        //         );
        //       },
        //     );
        //   },
        //   child: SvgPicture.asset(
        //     iconPath,
        //     height: AppSize.size25,
        //     width: AppSize.size25,
        //   ),
        // ),
      ],
    );
  }
}
