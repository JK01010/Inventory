import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../presentation/widgets/attachments_popup_widget.dart';
import '../../../presentation/widgets/ihm_material_popup_widget.dart';
import '../../../presentation/widgets/yes_no_widget.dart';
import '../bloc/transaction_item_detail_bloc.dart';
import '../bloc/transaction_item_detail_bloc_state.dart';

class TransactionItemDetailBottomWidget extends StatelessWidget {
  const TransactionItemDetailBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      TransactionItemDetailBloc,
      TransactionItemDetailBlocState
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
                          state.itemEntity.isImdg
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
                        state.itemEntity.isSDoc
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
                          state.itemEntity.zeroDeclaration
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
                            state.itemEntity.ihmMaterialQty.toString(),
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
                    Text('${context.l.ihmAttachment} (0))'),
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
                            // context
                            //     .read<GoodsReceiptLabelIhmAttachmentBloc>()
                            //     .add(
                            //       GetGoodsReceiptLabelIhmAttachmentEvent(
                            //         itemId: itemId,
                            //       ),
                            //     );
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
