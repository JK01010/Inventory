import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/yes_no_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_decorated_box_shadow_widget.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../goods_receipt_label_ihm_attachment_bloc/goods_receipt_label_ihm_attachment_bloc.dart';
import '../goods_receipt_transaction_detail_bloc/goods_receipts_transaction_detail_bloc.dart';
import 'attachments_popup_widget.dart';
import 'ihm_material_popup_widget.dart';

class GoodsReceiptsTransactionItemDetailBottomCardWidget
    extends StatelessWidget {
  const GoodsReceiptsTransactionItemDetailBottomCardWidget({
    super.key,
    required this.itemId,
  });

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GoodsReceiptsTransactionDetailBloc,
      GoodsReceiptsTransactionDetailState
    >(
      builder: (context, state) {
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
                          state.goodsReceiptPurchaseItemDetailEntity.isImdg ==
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
                        state.goodsReceiptPurchaseItemDetailEntity.isSdoc == 'Y'
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
                                      .goodsReceiptPurchaseItemDetailEntity
                                      .zeroDeclaration ==
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
                            state
                                .goodsReceiptPurchaseItemDetailEntity
                                .ihmMaterialQty
                                .toString(),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: AppColor.colorPrimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${context.l.ihmAttachment} (${context.read<GoodsReceiptLabelIhmAttachmentBloc>().state.goodsReceiptIhmAttachmentEntityList.length})',
                    ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
