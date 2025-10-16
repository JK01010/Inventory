import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';
import '../goods_receipt_detail_label_bloc/goods_receipt_label_bloc.dart';
import 'show_bottom_sheet_add_delete_label.dart';
import 'show_bottom_sheet_print_mode.dart';

class CreateLabelRowWidget extends StatefulWidget {
  CreateLabelRowWidget(
    this.purchaseOrderHDEntity, {
    Key? key,
    required this.itemIds,
  }) : super(key: key);
  final List<int> itemIds; // Accept a list of item IDs

  PurchaseOrderHDEntity purchaseOrderHDEntity;

  @override
  State<CreateLabelRowWidget> createState() => CreateLabelRowWidgetState();
}

class CreateLabelRowWidgetState extends State<CreateLabelRowWidget> {
  // Removed _currentItemId and updateItemId as they are no longer needed.

  @override
  Widget build(BuildContext context) {
    debugPrint(
      "widget.purchaseOrderHDEntity.grnId::${widget.purchaseOrderHDEntity.grnId}",
    );
    debugPrint("Item IDs::${widget.itemIds}");
    return BlocBuilder<GoodsReceiptLabelBloc, GoodsReceiptLabelState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${context.l.items}(${state.goodsReceiptPurchaseOrderLineItemEntityList.length})",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color:
                      context.isDarkMode
                          ? AppColor.colorBGBlackEnd
                          : AppColor.colorWhite,
                  borderRadius: BorderRadius.circular(
                    AppBorderRadius.borderRadius8,
                  ),
                  border: Border.all(color: AppColor.colorGrey),
                ),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.padding12,
                          vertical: AppPadding.padding8,
                        ),
                        child: Text(
                          context.l.createLabel,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color:
                                context.isDarkMode
                                    ? AppColor.colorWhite
                                    : AppColor.colorBlack2,
                          ),
                        ),
                      ),
                      //Condition check for showing 'Create Label'
                      onTap: () {
                        if (widget.purchaseOrderHDEntity.grnId == null) {
                          showSuccessPopup(context.l.emptyGrnId, context);
                          return;
                        }

                        if (widget.itemIds.isEmpty) {
                          showSuccessPopup(
                            context.l.noItemsToCreateLabelsFor,
                            context,
                          );

                          return;
                        }

                        showBottomSheetPrintMode(
                          context,
                          widget.purchaseOrderHDEntity,
                          itemIds: widget.itemIds,
                          grnHdId: widget.purchaseOrderHDEntity.grnId!,
                        );
                      },
                    ),
                    SizedBox(
                      height: AppSize.size35,
                      child: VerticalDivider(
                        thickness: AppSize.size1,
                        color: AppColor.colorGrey,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap:
                          () => showBottomSheetAddDeleteItem(
                            context,
                            widget.purchaseOrderHDEntity,
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.padding15),
                        child: SvgPicture.asset(
                          AppIcons.burgerIconHorizontal,
                          colorFilter: ColorFilter.mode(
                            context.isDarkMode
                                ? AppColor.colorWhite
                                : AppColor.colorBlack2,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  PurchaseOrderHDEntity get purchaseOrderHDEntity =>
      widget.purchaseOrderHDEntity;

  
}

