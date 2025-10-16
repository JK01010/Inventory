import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/bagging_confirmation_list_entity.dart';
import '../bloc/bagging_confirmation_list/bagging_confirmation_list_bloc.dart';
import '../../../good_receipts/domain/entities/goods_receipt_transaction_entity.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}

class ConfirmationCard extends StatelessWidget {
  final GoodsReceiptsTransactionEntity item;

  const ConfirmationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.padding6),
      decoration: BoxDecoration(
        color:
            context.isDarkMode
                ? AppColor.colorDarkProfileContainer
                : AppColor.colorWhite,
        borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.padding16,
          vertical: AppPadding.padding10,
        ),
        // Title → PO Code
        title: Text(
          item.poNo,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),

        // Subtitle → GRN, Storage Location, Status/Icon
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppPadding.padding8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: GRN
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.grnNo,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppFontSize.fontSize13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: AppSize.size2),
                    Text(
                      item.grnId.toString(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppFontSize.fontSize14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Middle: Storage Location
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.storageLocation,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppFontSize.fontSize13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: AppSize.size2),
                    Text(
                      item.deliveryToLocation,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppFontSize.fontSize14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Right: Status or Scan Icon
              Expanded(
                flex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(""),
                    const SizedBox(height: AppSize.size2),
                    SizedBox(
                      width: 60,
                      child:
                          item.syncStatus == 'Synced'
                              ? Container(
                                height: AppSize.size22,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.padding10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      context.isDarkMode
                                          ? AppColor.colorTransparent
                                          : AppColor.colorBackground4,
                                  borderRadius: BorderRadius.circular(
                                    AppBorderRadius.borderRadius20,
                                  ),
                                  border: Border.all(
                                    color: AppColor.colorGreen,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)?.done ?? '',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      fontSize: AppFontSize.fontSize12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.colorGreen,
                                    ),
                                  ),
                                ),
                              )
                              : GestureDetector(
                                onTap: () {
                                  context.push(
                                    AppRoute
                                        .baggingTaggingConfirmationScanning
                                        .path,
                                    extra:item.grnId,
                                  );
                                  log("init called");
                                  log("passed grnID 1${item.grnId}");
                                  context.read<BaggingConfirmationListBloc>().add(KdcReaderInitEvent());
                                },
                                child: SvgPicture.asset(
                                  AppIcons.scanIcon,
                                  height: AppSize.size24,
                                  width: AppSize.size24,
                                  semanticsLabel: 'Scanner Icon',
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
