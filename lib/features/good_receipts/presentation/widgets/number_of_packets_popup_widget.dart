import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/number_of_packets_card_widget.dart';
import 'package:pal_ng_inventory/features/widgets/bottom_sheet_header_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../bagging_tagging_confirmtaion/presentation/bloc/bagging_packet_list/bagging_packet_list_bloc.dart';

class NumberOfPacketsPopupWidget extends StatefulWidget {
  const NumberOfPacketsPopupWidget({super.key, required this.grnId});

  final String grnId;

  @override
  State<NumberOfPacketsPopupWidget> createState() =>
      _NumberOfPacketsPopupWidgetState();
}

class _NumberOfPacketsPopupWidgetState extends State<NumberOfPacketsPopupWidget> {
  @override
  void initState() {
    super.initState();
    context.read<BaggingPacketListBloc>().add(
      BaggingPacketFetchAllDataEvent(grnId: widget.grnId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Expanded(
          child: BlocBuilder<BaggingPacketListBloc, BaggingPacketListState>(
            builder: (context, state) {
              if(state.isLoading){
                return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => const NumberOfPacketsCardShimmer(),
                );
              }

              return ListView.builder(
                itemCount: state.packetDetailsEntity.length,
                padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      NumberOfPacketsCardWidget(
                        packetDetailsEntity: state.packetDetailsEntity[index],
                      ),
                      SizedBox(height: AppSize.size10),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
