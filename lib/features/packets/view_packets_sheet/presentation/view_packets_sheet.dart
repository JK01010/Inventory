import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../add_packets_sheet/domain/entities/packets_entity.dart';
import 'widgets/packet_card_widget.dart';

class ViewPacketsSheet extends StatelessWidget {
  const ViewPacketsSheet({super.key, required this.packets});

  final List<PacketEntity> packets;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(
              context,
            ).viewInsets.bottom, // 👈 shifts up with keyboard
      ),
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color:
                  context.isDarkMode
                      ? AppColor.colorBGBlack
                      : AppColor.colorWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                  child: BottomSheetHeaderWidget(
                    title: context.l.noOfPackets,
                    onTap: context.pop,
                  ),
                ),
                Divider(
                  height: AppSize.size0,
                  color:
                      context.isDarkMode
                          ? AppColor.dividerDarkColor
                          : AppColor.closeButtonColor,
                ),
                SizedBox(height: AppSize.size10),
                Expanded(
                  child: ListView.separated(
                    itemCount: packets.length,
                    padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                    itemBuilder: (context, index) {
                      return PacketCardWidget(packetEntity: packets[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: AppSize.size15);
                    },
                  ),
                ),
                SizedBox(height: AppSize.size10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
