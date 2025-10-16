import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_enum.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/core/routes/route_name.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/profile_sync_card_widget.dart';
import 'package:pal_ng_inventory/features/widgets/custom_app_bar.dart';
import 'package:pal_ng_inventory/features/widgets/gradient_background_widget.dart';

class ProfileSyncStatusPage extends StatelessWidget {
  const ProfileSyncStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(title: context.l.synchronizedgrn),
        body: ListView.separated(
          itemCount: 10,
          padding: EdgeInsets.all(AppPadding.scaffoldPadding),
          itemBuilder: (context, index) {
            if (index % 2 == 0) {
              return GestureDetector(
                onTap: () {
                  context.push(AppRoute.goodsReceiptsDetail.path);
                },
                child: ProfileSyncCardWidget(
                  title: "AMR-0-0621-PO12",
                  sentDate: "19-Aug-2024",
                  headingText: "AMR-0-0621-PO12",
                  category: "Medicine",
                  syncIconPath: AppIcons.cloudSyncSuccess,
                  chipStatusList: [ChipStatus.fullyReceived],
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  context.push(AppRoute.goodsReceiptsDetail.path);
                },
                child: ProfileSyncCardWidget(
                  title: "AMR-0-0621-PO13",
                  sentDate: "19-Aug-2024",
                  headingText: "AMR-0-0621-PO12",
                  category: "Medicine",
                  syncIconPath: AppIcons.cloudSyncRedIcon,
                  chipStatusList: [ChipStatus.partiallyReceived],
                ),
              );
            }
          },
          separatorBuilder:
              (context, index) => SizedBox(height: AppSize.size10),
        ),
      ),
    );
  }
}
