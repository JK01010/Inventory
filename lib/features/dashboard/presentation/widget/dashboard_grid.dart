import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../l10n/app_localizations.dart';
import '../model/dashboard_module_list.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(context.isDarkMode.toString());
    List<DashboardIconList> dashboardIconList = [
      DashboardIconList(
        id: 1,
        iconName: AppLocalizations.of(context)!.goodsReceipts,
        iconPath: AppIcons.iconGoodsReceipts,
        route: AppRoute.goodsReceipts.path,
      ),
      DashboardIconList(
        id: 2,
        iconName: AppLocalizations.of(context)!.baggingAndTaggingConfirmation,
        iconPath: AppIcons.iconBaggingTagging,
        route: AppRoute.baggingTaggingListing.path,
      ),
      DashboardIconList(
        id: 3,
        iconName: AppLocalizations.of(context)!.consumption,
        iconPath: AppIcons.iconConsumption,
        route: AppRoute.consumptionTransaction.path,
      ),
      DashboardIconList(
        id: 4,
        iconName: AppLocalizations.of(context)!.stockUpdate,
        iconPath: AppIcons.iconStockUpdate,
        route: AppRoute.stockUpdateTransaction.path,
      ),
      DashboardIconList(
        id: 5,
        iconName: AppLocalizations.of(context)!.itemMaster,
        iconPath: AppIcons.iconItemMaster,
        route: AppRoute.itemMaster.path,
      ),
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.3,
      ),
      itemCount:
          dashboardIconList.length, // Replace with your actual item count
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push(dashboardIconList[index].route);
          },
          child: Container(
            decoration: ShapeDecoration(
              color:
                  context.isDarkMode
                      ? AppColor.colorDarkProfileContainer
                      : AppColor.colorWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppPadding.padding15),
              ),
              shadows: [
                BoxShadow(
                  color: AppColor.colorBoxShadow,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.padding10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(dashboardIconList[index].iconPath ?? ""),
                  Spacer(),
                  Text(
                    dashboardIconList[index].iconName ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color:
                          context.isDarkMode
                              ? AppColor.colorDividerLight
                              : AppColor.colorBlack,
                    ),
                    // context.isDarkMode
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
