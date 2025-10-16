import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../good_receipts/domain/entities/goods_receipt_transaction_entity.dart';
import '../../../widgets/chip_icon_list_widget.dart';

class PendingListCard extends StatelessWidget {
  const PendingListCard({super.key, required this.item, this.onTap});

  final GoodsReceiptsTransactionEntity item;
  final void Function()? onTap;

  /*const PendingListCard({
    super.key,
  });*/

  @override
  Widget build(BuildContext context) {
    debugPrint("poIddddd:${item.poId}");
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.padding14),
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.padding12,
                  top: AppPadding.padding15,
                  right: AppPadding.padding12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.poNo,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: AppFontSize.fontSize13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.size24,
                      width: AppSize.size24,
                      child:
                          (item.syncStatus == true
                                      ? SyncStatus.synced
                                      : SyncStatus.unSynced) ==
                                  SyncStatus.syncing
                              ? Center(child: CircularProgressIndicator())
                              : SvgPicture.asset(
                                getPendingSyncIcon(
                                  syncStatus:
                                      (item.syncStatus == true
                                          ? SyncStatus.synced
                                          : SyncStatus.unSynced),
                                  context: context,
                                ),
                                height: AppSize.size24,
                                width: AppSize.size24,
                              ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.size8),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.padding12,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.sp,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.grnNo ?? "",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontSize: AppFontSize.fontSize13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          item.grnId.toString().isEmpty
                              ? "-"
                              : item.grnId.toString(),
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontSize: AppFontSize.fontSize14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: AppSize.size50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.category,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontSize: AppFontSize.fontSize13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          item.category,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontSize: AppFontSize.fontSize14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.size4),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.padding12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppFontSize.fontSize13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      item.pOtitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppFontSize.fontSize14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.size15),
              Divider(height: AppSize.size1),
              SizedBox(height: AppSize.size12),
              ChipIconListWidget(
                chipStatusList: [ChipStatus.chipNew, ChipStatus.fullyReceived],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Map<String, int> getDeliveryStatusColors(String statusCode) {
  //   switch (statusCode.toLowerCase()) {
  //     // case 'FR': // Fully Received
  //     case 'fully received': // Fully Received
  //       return {'color': 0xFF42B0D5, 'bgColor': 0xFFF2FCFF};
  //     // case 'PR': // Partially Received
  //     case 'partially received': // Partially Received
  //       return {'color': 0xFFFE6231, 'bgColor': 0xFFFFF4F0};
  //     // case 'GBC': // Goods in Bad Condition
  //     case 'goods in bad condition': // Goods in Bad Condition
  //       return {'color': 0xFFF73C3C, 'bgColor': 0xFFFFEBEB};
  //     default:
  //       // Default colors if status code is not recognized
  //       return {
  //         'color': 0xFF808080,
  //         'bgColor': 0xFFF5F5F5,
  //       }; // Grey and light grey defaults
  //   }
  // }

  String getPendingSyncIcon({
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
