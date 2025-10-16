import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_enum.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../../core/utils/app_date_utils.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_title_widget.dart';
import '../../../../widgets/chip_icon_list_widget.dart';
import '../../../presentation/widgets/goods_receipt_value_widget.dart';
import '../../../purchase_order/presentation/widgets/item_detail_row_widget.dart';
import '../../domain/entity/transaction_entity.dart';
import 'transaction_shimmer.dart';

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({
    super.key,
    required this.transactionEntity,
    required this.isLoading,
  });

  final bool isLoading;

  final TransactionEntity transactionEntity;

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child:
          isLoading
              ? GoodsReceiptsTransactionShimmer()
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: ReceiptTransactionCardHeadingWidget(
                            text: transactionEntity.poNo,
                            syncStatus:
                                transactionEntity.syncStatus == true
                                    ? SyncStatus.synced
                                    : SyncStatus.unSynced,
                            poId: transactionEntity.poId,
                            onTap: () {
                              // context.read<GoodsReceiptsTransactionBloc>().add(
                              //   AddToSyncList(
                              //     transactionEntityItem:
                              //         transactionEntity,
                              //   ),
                              // );
                            },
                          ),
                        ),
                        SizedBox(height: AppSize.size10),
                        // GRN no and category row
                        ItemDetailRowWidget(
                          titleFirst: context.l.grnDate,
                          valueFirst: AppDateUtils.getStringFromDateWithFormat(
                            AppDateUtils.getDateTimeFromString(
                              transactionEntity.receiptDate,
                              "yyyy-MM-ddThh:mm:ss",
                            ),
                            "dd-MMM-yyyy",
                          ),
                          titleSecond: context.l.items,
                          valueSecond: transactionEntity.items.toString(),
                        ),

                        SizedBox(height: AppSize.size10),
                        ItemDetailRowWidget(
                          titleFirst: context.l.receivedQty,
                          valueFirst: transactionEntity.receivedQty.toString(),
                          titleSecond: context.l.damagedQty,
                          valueSecond: transactionEntity.damagedQty.toString(),
                        ),
                        SizedBox(height: AppSize.size10),
                        // Title section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTitleWidget(text: context.l.newStock),
                            GoodsReceiptValueWidget(
                              text: transactionEntity.newStock.toString(),
                            ),
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
                    chipStatusList: [
                      ChipStatus.chipNew,
                      ChipStatus.fullyReceived,
                    ],
                  ),
                ],
              ),
    );
  }
}

class ReceiptTransactionCardHeadingWidget extends StatelessWidget {
  const ReceiptTransactionCardHeadingWidget({
    super.key,
    required this.text,
    required this.syncStatus,
    required this.poId,
    this.onTap,
  });

  final String text;
  final SyncStatus syncStatus;
  final int poId;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),

        SizedBox(
          height: AppSize.size24,
          width: AppSize.size24,
          child:
              syncStatus == SyncStatus.syncing
                  ? Center(child: CircularProgressIndicator())
                  : SvgPicture.asset(
                    _getSyncIconPath(syncStatus: syncStatus, context: context),
                    height: AppSize.size24,
                    width: AppSize.size24,
                  ),
        ),
      ],
    );
  }

  String _getSyncIconPath({
    required SyncStatus syncStatus,
    required BuildContext context,
  }) {
    switch (syncStatus) {
      case SyncStatus.synced:
        return context.isDarkMode
            ? AppIcons.cloudSyncSuccessWhite
            : AppIcons.cloudSyncSuccess;
      case SyncStatus.unSynced:
        return context.isDarkMode
            ? AppIcons.cloudSyncRedIconWhite
            : AppIcons.cloudSyncRedIcon;
      case SyncStatus.syncing:
        return context.isDarkMode
            ? AppIcons.cloudSyncSuccessWhite
            : AppIcons.cloudSyncSuccess;
    }
  }
}
