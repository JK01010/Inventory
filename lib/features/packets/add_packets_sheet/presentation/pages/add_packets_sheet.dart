import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../widgets/app_two_row_button_widget.dart';
import '../../../../widgets/bottom_sheet_header_widget.dart';
import '../../domain/entities/packets_entity.dart';
import '../bloc/add_packets_sheet_bloc.dart';
import '../bloc/add_packets_sheet_bloc_event.dart';
import '../bloc/add_packets_sheet_bloc_state.dart';
import '../widgets/add_packet_card.dart';
import '../widgets/packet_shimmer.dart';

class AddPacketsSheet extends StatefulWidget {
  const AddPacketsSheet({
    super.key,
    required this.packets,
    required this.poHdId,
  });

  final List<PacketEntity> packets;
  final int poHdId;

  @override
  State<AddPacketsSheet> createState() => _AddPacketsSheetState();
}

class _AddPacketsSheetState extends State<AddPacketsSheet> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      context.read<AddPacketsSheetBloc>().add(
        AddPacketSetInitialDataEvent(
          currentPackets: widget.packets,
          poHdId: widget.poHdId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPacketsSheetBloc, AddPacketsSheetBlocState>(
      builder: (context, state) {
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
                      child:
                          state.isLoading
                              ? ListView.builder(
                                itemCount: 2,
                                itemBuilder:
                                    (context, index) =>
                                        const PacketsCardShimmer(),
                              )
                              : ListView.separated(
                                itemCount: state.packets.length + 1,
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context)
                                          .viewInsets
                                          .bottom, // 👈 shifts up with keyboard
                                ),
                                itemBuilder: (context, index) {
                                  if (index == state.packets.length) {
                                    return SizedBox(height: 150);
                                  }
                                  return AddPacketCard(
                                    packetEntity: state.packets[index],
                                  );
                                },
                                separatorBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  return SizedBox(height: AppSize.size10);
                                },
                              ),
                    ),
                    SizedBox(height: AppSize.size10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.scaffoldPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.l.addPacket,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<AddPacketsSheetBloc>().add(
                                AddPacketEvent(),
                              );
                            },
                            icon: Icon(Icons.add, color: AppColor.colorPrimary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSize.size10),
                    AppTwoRowButtonWidget(
                      buttonFirstTitle: context.l.cancel,
                      buttonFirstOnPress: () {
                        context.pop();
                      },
                      buttonSecondTitle: context.l.save,
                      buttonSecondOnPress: () {
                        context.pop(state.packets);
                      },
                    ),
                    // SizedBox(height: AppSize.size10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
