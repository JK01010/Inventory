import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/yes_no_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_decorated_box_shadow_widget.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';
import '../goods_receipt_label_ihm_attachment_bloc/goods_receipt_label_ihm_attachment_bloc.dart';
import 'rob_details_popup_widget.dart';
import 'attachments_popup_widget.dart';
import 'ihm_material_popup_widget.dart';

class CreateLabelBottomCardWidget extends StatelessWidget {
  const CreateLabelBottomCardWidget({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GoodsReceiptCreateLabelBloc,
      GoodsReceiptCreateLabelState
    >(
      builder: (context, state) {
        // debugPrint("inside state:::::::::${state.itemRobDetailsList?[2].storageLocation}");

        return AppDecoratedBoxShadowWidget(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: AppSize.size163,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.l.mdRequired),
                          SizedBox(height: AppSize.size6),
                          state.goodsReceiptPurchaseOrderLineItemEntity?.isMd ==
                                  'Y'
                              ? YesNoWidget.yes(context)
                              : YesNoWidget.no(context),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.l.sdocRequired),
                        SizedBox(height: AppSize.size6),
                        state.goodsReceiptPurchaseOrderLineItemEntity?.isSDoc ==
                                'Y'
                            ? YesNoWidget.yes(context)
                            : YesNoWidget.no(context),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
                Row(
                  children: [
                    SizedBox(
                      width: AppSize.size163,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.l.zeroDeclaration),
                          SizedBox(height: AppSize.size6),
                          state
                                      .goodsReceiptPurchaseOrderLineItemEntity
                                      ?.zeroDeclaration ==
                                  'Y'
                              ? YesNoWidget.yes(context)
                              : YesNoWidget.no(context),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.l.ihmMaterialQty),
                        SizedBox(height: AppSize.size6),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColor.colorWhite,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                        AppBorderRadius.borderRadius20,
                                      ),
                                    ),
                                  ),
                                  child: IhmMaterialPopupWidget(),
                                );
                              },
                            );
                          },
                          child: Text(
                            '${state.goodsReceiptPurchaseOrderLineItemEntity!.ihmMaterialQty}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: AppColor.colorPrimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
                Row(
                  children: [
                    SizedBox(
                      width: AppSize.size163,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.l.ihmMaterialQty),
                          SizedBox(height: AppSize.size6),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppBorderRadius.borderRadius10,
                              ),
                              border: Border.all(color: AppColor.colorPrimary),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.padding8),
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<GoodsReceiptLabelIhmAttachmentBloc>()
                                      .add(
                                        GetGoodsReceiptLabelIhmAttachmentEvent(
                                          itemId: itemId,
                                        ),
                                      );
                                  showModalBottomSheet(
                                    isDismissible: false,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          color:
                                              context.isDarkMode
                                                  ? AppColor.colorBGBlack
                                                  : AppColor.colorWhite,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(
                                              AppBorderRadius.borderRadius20,
                                            ),
                                          ),
                                        ),
                                        child: AttachmentsPopupWidget(),
                                      );
                                    },
                                  );
                                },
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.attachment_outlined,
                                    color: AppColor.colorPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.l.itemRobQuantity),
                        SizedBox(height: AppSize.size6),
                        InkWell(
                          onTap: () {
                            context.read<GoodsReceiptCreateLabelBloc>().add(
                              FetchItemRobDetailsEvent(
                                itemId: state.goodsReceiptPurchaseOrderLineItemEntity!.itemId,
                              ),
                            );

                            showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColor.colorWhite,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(AppBorderRadius.borderRadius20),
                                    ),
                                  ),
                                  child: ROBDetailsPopupWidget(),
                                );
                              },
                            );
                          },
                          child: Text(
                            '${state.goodsReceiptPurchaseOrderLineItemEntity!.rob}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: AppColor.colorPrimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
