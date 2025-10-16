import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc_state.dart';

class PurchaseOrderDetailCreateLabelWidget extends StatefulWidget {
  const PurchaseOrderDetailCreateLabelWidget({super.key});

  @override
  State<PurchaseOrderDetailCreateLabelWidget> createState() =>
      PurchaseOrderDetailCreateLabelWidgetState();
}

class PurchaseOrderDetailCreateLabelWidgetState
    extends State<PurchaseOrderDetailCreateLabelWidget> {
  // Removed _currentItemId and updateItemId as they are no longer needed.

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseOrderDetailBloc, PurchaseOrderDetailBlocState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${context.l.items}(${state.purchaseOrderItems.length})",
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
                        if (state.purchaseOrderData.grnId == null) {
                          showSuccessPopup(context.l.emptyGrnId, context);
                          return;
                        }

                        if (state.purchaseOrderItems.isEmpty) {
                          showSuccessPopup(
                            context.l.noItemsToCreateLabelsFor,
                            context,
                          );

                          return;
                        }
                        //
                        // showBottomSheetPrintMode(
                        //   context,
                        //   widget.purchaseOrderHDEntity,
                        //   itemIds: widget.itemIds,
                        //   grnHdId: widget.purchaseOrderHDEntity.grnId!,
                        // );
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
                      //ToDo
                      // onTap:
                      //     () => showBottomSheetAddDeleteItem(
                      //       context,
                      //       widget.purchaseOrderHDEntity,
                      //     ),
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
}
