// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/number_of_packets_card_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_two_row_button_widget.dart';
import 'package:pal_ng_inventory/features/widgets/bottom_sheet_header_widget.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../../domain/entities/packet_details_entity.dart';
import '../goods_receipt_packet_detail_bloc/goods_receipt_packet_detail_bloc.dart';

class NumberOfPacketsWidget extends StatelessWidget {
  NumberOfPacketsWidget({super.key, this.poId, this.poDtId, this.noOfPackets});

  final Map<int, GlobalKey<NumberOfPacketsCardEmptyWidgetState>>
  packetWidgetListKeyMap = {};
  int? poId;
  int? poDtId;
  int? noOfPackets;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            BottomSheetHeaderWidget(
              title: context.l.noOfPackets,
              onTap: () {
                context.pop();
              },
            ),
            Divider(
              color:
                  context.isDarkMode
                      ? AppColor.colorDarkDivider
                      : AppColor.closeButtonColor,
            ),
            Expanded(
              child: BlocBuilder<
                GoodsReceiptPacketDetailBloc,
                GoodsReceiptPacketDetailState
              >(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.packetDetailsEntityList.length,
                    padding: EdgeInsets.all(AppSize.size5),
                    itemBuilder: (context, index) {
                      packetWidgetListKeyMap[index] =
                          GlobalKey<NumberOfPacketsCardEmptyWidgetState>();
                      return Column(
                        children: [
                          (state
                                  .packetDetailsEntityList[index]
                                  .packetName
                                  .isNotEmpty)
                              ? NumberOfPacketsCardWidget(
                                packetDetailsEntity:
                                    state.packetDetailsEntityList[index],
                              )
                              : NumberOfPacketsCardEmptyWidget(
                                packetDetailsEntity:
                                    state.packetDetailsEntityList[index],
                                key: packetWidgetListKeyMap[index],
                                index: index,
                              ),
                          SizedBox(height: AppSize.size10),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.scaffoldPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l.addPacket,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<GoodsReceiptPacketDetailBloc>().add(
                        GoodsReceiptAddEmptyPacketEvent(),
                      );
                    },
                    icon: Icon(Icons.add, color: AppColor.colorPrimary),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.size70),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AppTwoRowButtonWidget(
            buttonFirstOnPress: onCancelPacketInfo(context),
            buttonSecondTitle: context.l.save,
            buttonSecondOnPress: onSavePacketInfo(context),
          ),
        ),
      ],
    );
  }

  VoidCallback onSavePacketInfo(BuildContext context) {
    return () {
      List<PacketDetailsEntity> noOfPacketsEntityList = [];
      if (packetWidgetListKeyMap.isNotEmpty) {
        PacketDetailsEntity? packetDetailsEntity;
        packetWidgetListKeyMap.forEach((key, value) {
          if (value.currentState != null) {
            double width =
                value.currentState!.widthController.text.isEmpty
                    ? 0
                    : double.parse(value.currentState!.widthController.text);
            double length =
                value.currentState!.lengthController.text.isEmpty
                    ? 0
                    : double.parse(value.currentState!.lengthController.text);
            double height =
                value.currentState!.heightController.text.isEmpty
                    ? 0
                    : double.parse(value.currentState!.heightController.text);
            double weight =
                value.currentState!.weighController.text.isEmpty
                    ? 0
                    : double.parse(value.currentState!.weighController.text);
            double actualVolume =
                value.currentState!.actualVolumeController.text.isEmpty
                    ? 0
                    : double.parse(
                      value.currentState!.actualVolumeController.text,
                    );
            packetDetailsEntity = PacketDetailsEntity(
              id: DateTime.now().microsecondsSinceEpoch,
              poId: poId.toString(),
              poDtId: poDtId!,
              width: width,
              length: length,
              height: height,
              weight: weight,
              actualVolume: actualVolume,
              packetName: value.currentState!.packetName,
            );
            noOfPacketsEntityList.add(packetDetailsEntity!);
            context.read<GoodsReceiptPacketDetailBloc>().add(
              SavePacketListEvent(noOfPacketsEntityList),
            );
          }
        });
        context.pop();
      }
    };
  }

  VoidCallback onCancelPacketInfo(BuildContext context) {
    return () {
      context.pop();
    };
  }
}

ValueNotifier<List<PacketsEntity>> packageListValue =
    ValueNotifier<List<PacketsEntity>>(packetsList);

List<PacketsEntity> packetsList = List.generate(
  5,
  (index) => PacketsEntity(
    packetName: "Packet $index",
    width: index.toString(),
    length: index.toString(),
    height: index.toString(),
    weight: index.toString(),
    actualVolume: index.toString(),
  ),
);

class PacketsEntity {
  final String packetName;
  final String width;
  final String length;
  final String height;
  final String weight;
  final String actualVolume;

  PacketsEntity({
    required this.packetName,
    required this.width,
    required this.length,
    required this.height,
    required this.weight,
    required this.actualVolume,
  });

  factory PacketsEntity.empty() => PacketsEntity(
    packetName: "",
    width: "",
    length: "",
    height: "",
    weight: "",
    actualVolume: "",
  );

  PacketsEntity copyWith({
    String? packetName,
    String? width,
    String? length,
    String? height,
    String? weight,
    String? actualVolume,
  }) {
    return PacketsEntity(
      packetName: packetName ?? this.packetName,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      actualVolume: actualVolume ?? this.actualVolume,
    );
  }
}
