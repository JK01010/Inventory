import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../widgets/show_sync_offline_popup.dart';

class StockUpdateTransactionCardWidget extends StatelessWidget {
  const StockUpdateTransactionCardWidget({
    super.key,
    required this.text,
    this.syncStatus,
    this.onTap,
  });

  final String text;
  final SyncStatus? syncStatus;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                text,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),

        syncStatus != null
            ? SizedBox(
          height: AppSize.size24,
          width: AppSize.size24,
          child:
          syncStatus == SyncStatus.syncing
              ? Center(child: CircularProgressIndicator())
              : InkWell(
                onTap: (){
                  if(syncStatus != null && syncStatus == SyncStatus.unSynced){
                    showSyncOfflinePopup(context);
                  }
                },
                child: SvgPicture.asset(
                            _getSyncIconPath(
                syncStatus: syncStatus ?? SyncStatus.unSynced,
                            ),
                            height: AppSize.size24,
                            width: AppSize.size24,
                          ),
              ),
        )
            : SizedBox(),
      ],
    );
  }

  String _getSyncIconPath({required SyncStatus syncStatus}) {
    switch (syncStatus) {
      case SyncStatus.synced:
        return AppIcons.cloudSyncSuccess;
      case SyncStatus.unSynced:
        return AppIcons.cloudSyncRedIcon;
      case SyncStatus.syncing:
        return AppIcons.cloudSyncSuccess;
    }
  }
}
