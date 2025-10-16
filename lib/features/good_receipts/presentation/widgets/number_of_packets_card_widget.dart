import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/item_size_detail_text_column_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_decorated_box_shadow_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_text_form_field.dart';
import 'package:pal_ng_inventory/features/widgets/app_title_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/packet_details_entity.dart';

class NumberOfPacketsCardWidget extends StatelessWidget {
  const NumberOfPacketsCardWidget({
    super.key,
    required this.packetDetailsEntity,
  });

  final PacketDetailsEntity packetDetailsEntity;

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
              packetDetailsEntity.packetName,
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
                    value: packetDetailsEntity.width.toString(),
                  ),
                ),
                SizedBox(
                  width: AppSize.size133,
                  child: ItemsSizeDetailTextColumnWidget(
                    title: AppLocalizations.of(context)?.length ?? "",
                    value: packetDetailsEntity.length.toString(),
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
                    value: packetDetailsEntity.height.toString(),
                  ),
                ),
                SizedBox(
                  width: AppSize.size133,
                  child: ItemsSizeDetailTextColumnWidget(
                    title: AppLocalizations.of(context)?.weight ?? "",
                    value: packetDetailsEntity.weight.toString(),
                  ),
                ),
                SizedBox(),
              ],
            ),
            SizedBox(height: AppSize.size9),
            //Actual volume
            ItemsSizeDetailTextColumnWidget(
              title: AppLocalizations.of(context)?.actualVolume ?? "",
              value: packetDetailsEntity.actualVolume.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberOfPacketsCardEmptyWidget extends StatefulWidget {
  const NumberOfPacketsCardEmptyWidget({
    required this.packetDetailsEntity,
    required GlobalKey<NumberOfPacketsCardEmptyWidgetState>? key,
    required this.index,
  }) : super(key: key);

  final PacketDetailsEntity packetDetailsEntity;
  final int index;

  @override
  State<NumberOfPacketsCardEmptyWidget> createState() =>
      NumberOfPacketsCardEmptyWidgetState();
}

class NumberOfPacketsCardEmptyWidgetState
    extends State<NumberOfPacketsCardEmptyWidget> {
  late TextEditingController _widthController;
  late TextEditingController _lengthController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _actualVolumeController;

  String width = "";
  String length = "";
  String height = "";
  String weight = "";
  String actualVolume = "";
  String _packetName = "";

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController(text: '0');
    _lengthController = TextEditingController(text: '0');
    _heightController = TextEditingController(text: '0');
    _weightController = TextEditingController(text: '0');
    _actualVolumeController = TextEditingController(text: '0');
    _packetName = "Packet ${widget.index + 1}";
  }

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: AppSize.size30,
              child: Text(
                _packetName,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    labelText: context.l.width,
                    suffixIcon: UnconstrainedBox(
                      child: AppTitleWidget(text: "M"),
                    ),
                    controller: _widthController,
                    onChanged: (value) {
                      width = value;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(width: AppSize.size10),
                Expanded(
                  child: AppTextFormField(
                    labelText: context.l.length,
                    suffixIcon: UnconstrainedBox(
                      child: AppTitleWidget(text: "M"),
                    ),
                    controller: _lengthController,
                    onChanged: (value) {
                      length = value;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(width: AppSize.size10),
                Expanded(
                  child: AppTextFormField(
                    labelText: context.l.height,
                    suffixIcon: UnconstrainedBox(
                      child: AppTitleWidget(text: "M"),
                    ),
                    enabled: true,
                    controller: _heightController,
                    onChanged: (value) {
                      height = value;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.size20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppTextFormField(
                    labelText: context.l.weight,
                    suffixIcon: UnconstrainedBox(
                      child: AppTitleWidget(text: "Kg"),
                    ),
                    controller: _weightController,
                    onChanged: (value) {
                      weight = value;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(width: AppSize.size10),
                Expanded(
                  flex: 2,
                  child: AppTextFormField(
                    labelText: context.l.actualVolume,
                    suffixIcon: UnconstrainedBox(
                      child: AppTitleWidget(text: "Mtq"),
                    ),
                    controller: _actualVolumeController,
                    onChanged: (value) {
                      actualVolume = value;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController get widthController => _widthController;

  TextEditingController get lengthController => _lengthController;

  TextEditingController get heightController => _heightController;

  TextEditingController get weighController => _weightController;

  TextEditingController get actualVolumeController => _actualVolumeController;

  String get packetName => _packetName;
}


class NumberOfPacketsCardShimmer extends StatelessWidget {
  const NumberOfPacketsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
      context.isDarkMode
          ? AppColor.colorDarkProfileContainer
          : AppColor.colorBlack6,
      highlightColor: AppColor.colorIconBackgroundGrey,
      child: AppDecoratedBoxShadowWidget(
        boxBorder: Border.all(
          color: context.isDarkMode
              ? AppColor.colorDarkProfileContainer
              : AppColor.colorGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.padding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title shimmer
              Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: AppSize.size16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: _buildShimmerColumn()),
                  SizedBox(
                    width: AppSize.size133,
                    child: _buildShimmerColumn(),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: AppSize.size9),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: _buildShimmerColumn()),
                  SizedBox(
                    width: AppSize.size133,
                    child: _buildShimmerColumn(),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: AppSize.size9),

              _buildShimmerColumn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title placeholder
        Container(
          width: 60,
          height: 16,
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        // Value placeholder
        Container(
          width: 80,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}