import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_enum.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import 'rounded_check_box_widget.dart';

class AppHeadingWidget extends StatelessWidget {
  final String text;
  final SyncStatus? syncStatus;
  final bool labelCheckbox;
  final void Function()? onTapCheckBox;
  final bool showCheckBox;

  const AppHeadingWidget({
    super.key,
    required this.text,
    this.syncStatus,
    this.labelCheckbox = false,
    this.onTapCheckBox,
    this.showCheckBox = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              if (showCheckBox == true) ...[
              RoundedCheckBoxWidget(onTap: onTapCheckBox, value: labelCheckbox),
              SizedBox(width: AppSize.size8),
              ],
              Flexible(
                child: Text(
                  text,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        syncStatus != null
            ? SizedBox(
              height: AppSize.size24,
              width: AppSize.size24,
              child:
                  syncStatus == SyncStatus.syncing
                      ? Center(child: CircularProgressIndicator())
                      : SvgPicture.asset(
                        getSyncIconPath(
                          syncStatus: syncStatus ?? SyncStatus.unSynced,
                        ),
                        height: AppSize.size24,
                        width: AppSize.size24,
                      ),
            )
            : SizedBox(),
      ],
    );
  }

  String getSyncIconPath({required SyncStatus syncStatus}) {
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
