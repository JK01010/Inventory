import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../good_receipts/presentation/widgets/item_size_detail_text_column_widget.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../add_packets_sheet/domain/entities/packets_entity.dart';

class PacketCardWidget extends StatelessWidget {
  const PacketCardWidget({super.key, required this.packetEntity});

  final PacketEntity packetEntity;

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      boxBorder: Border.all(
        color:
            context.isDarkMode
                ? AppColor.colorDarkProfileContainer
                : AppColor.colorGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //title
            Text(
              packetEntity.packetName,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: AppSize.size16),

            //width length
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ItemsSizeDetailTextColumnWidget(
                    title: AppLocalizations.of(context)?.width ?? "",
                    value: packetEntity.width.toString(),
                  ),
                ),
                SizedBox(
                  width: AppSize.size133,
                  child: ItemsSizeDetailTextColumnWidget(
                    title: AppLocalizations.of(context)?.length ?? "",
                    value: packetEntity.length.toString(),
                  ),
                ),
                SizedBox(),
              ],
            ),
            SizedBox(height: AppSize.size9),
            //height  Weight
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ItemsSizeDetailTextColumnWidget(
                    title: AppLocalizations.of(context)?.height ?? "",
                    value: packetEntity.height.toString(),
                  ),
                ),
                SizedBox(
                  width: AppSize.size133,
                  child: ItemsSizeDetailTextColumnWidget(
                    title: AppLocalizations.of(context)?.weight ?? "",
                    value: packetEntity.weight.toString(),
                  ),
                ),
                SizedBox(),
              ],
            ),
            SizedBox(height: AppSize.size9),
            //Actual volume
            ItemsSizeDetailTextColumnWidget(
              title: AppLocalizations.of(context)?.actualVolume ?? "",
              value: packetEntity.actualVolume.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
