import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/extensions/text_theme_extension.dart';
import '../../../core/service/rfid/rfid_bloc.dart';
import '../../item_master/domin/entities/rfid_add_manually_view_model.dart';
import '../../item_master/presentation/bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../../item_master/presentation/bloc/rfid_view_bloc/rfid_view_bloc.dart';
import '../../item_master/presentation/widgets/common_rfid_found_dialog_box.dart';
import '../../widgets/app_decorated_box_shadow_widget.dart';
import '../../widgets/app_two_row_button_widget.dart';
import '../../widgets/chip_icon_widget.dart';
import '../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../widgets/common_read_range_adjusting_widget.dart';
import '../../widgets/common_view_rfid_viewing_shimmer.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_background_widget.dart';
import '../../widgets/rfid_scanning_animated_widget.dart';
import '../../widgets/rounded_check_box_widget.dart';
import '../../widgets/wifi_animation_widget.dart';

class AddManualPage extends StatefulWidget {
  AddManualPage({
    super.key,
    required this.selectedItemId,
    required this.screenType,
  });

  int? selectedItemId;
  String screenType;

  @override
  State<AddManualPage> createState() => _AddManualPageState();
}

class _AddManualPageState extends State<AddManualPage> {
  @override
  void initState() {
    super.initState();
    log("screen ---> ${widget.screenType}");
    /*  context.read<RfidBloc>().add(InitRfidEvent());
    context.read<RfidBloc>().add(DispatchConnectionStatusEvent());
    context.read<RfidBloc>().add(ConnectScannerEvent());
    context.read<RfidBloc>().add(SetPowerLevelEvent(powerLevel: 100));*/
  }

  @override
  void dispose() {
    super.dispose();
     context.read<ItemMasterBloc>().add(KdcReaderDisposeEvent());
  }


  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: BlocConsumer<ItemMasterBloc, ItemMasterState>(
        listener: (BuildContext context, ItemMasterState state) {
          if (state.commonRfid.isNotEmpty) {
            log("selected Item pop ${state.selectedItemId}");
            commonRfidFoundDialog(
              context,
              state.commonRfid,
              state.selectedItemId,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(title: context.l.addManually),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.padding15,
                      ),
                      child: BlocBuilder<ItemMasterBloc, ItemMasterState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // RoundedCheckBoxWidget(value: false, onTap: () {}),
                              // SizedBox(width: AppSize.size6),
                              Text(
                                "${state.rfidList.length}${context.l.numberItems}",

                                style: context.textTheme.titleMedium,
                              ),
                              Visibility(
                                visible: state.isScanning,
                                child: RfidScanningAnimation(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    SizedBox(height: AppSize.size10),
                    CommonReadRangeAdjustingWidget(
                      onChanged: (value){
                        log("range $value");
                        context.read<ItemMasterBloc>().add(KdcReaderUpdateRangeEvent(range: value));
                      },
                      valuePassed: state.rangeValue,
                    ),
                    SizedBox(height: AppSize.size20),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: AppDecoratedBoxShadowWidget(
                        child: BlocBuilder<ItemMasterBloc, ItemMasterState>(
                          builder: (context, state) {
                            if(state.isLoading){
                              return ListView.separated(
                                  separatorBuilder:
                                      (context, index) =>
                                      SizedBox(height: AppSize.size10),
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                        child: CommonViewRfidViewingShimmer(),
                                      ));
                                }
                              );
                            }

                            if (state.rfidList.isEmpty) {
                              return commonNoDataFoundTwo(context);
                            }

                            return ListView.separated(
                              padding: EdgeInsets.all(
                                AppPadding.scaffoldPadding,
                              ),
                              itemBuilder: (context, index) {
                                int count = index + 1;
                                return _RfidWidget(
                                  rfidTitle: count.toString(),
                                  rfidValue: state.rfidList[index],
                                );
                              },
                              separatorBuilder:
                                  (context, index) =>
                                      SizedBox(height: AppSize.size10),
                              itemCount: state.rfidList.length,
                            );
                          },
                        ),
                      ),
                    ),

                    // Expanded(
                    //   child: Center(
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         SvgPicture.asset(AppIcons.noItemIcon),
                    //         const SizedBox(height: AppSize.size6),
                    //         Text(context.l.noItemsScanned),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            bottomNavigationBar: BlocBuilder<ItemMasterBloc, ItemMasterState>(
              builder: (context, state) {
                return AppTwoRowButtonWidget(
                  buttonSecondTitle:
                      state.isScanning
                          ? context.l.stopScan
                          : context.l.startScan,
                  buttonFirstTitle: context.l.cancel,
                  buttonSecondOnPress: () {
                    if (state.isScanning) {
                      //todo rfid stop
                      context.read<ItemMasterBloc>().add(
                        KdcReaderStopScanEvent(
                          selectedItemId: widget.selectedItemId ?? 0,
                          screenType: widget.screenType,
                        ),
                      );
                      if (state.commonRfid.isEmpty) {
                        context.read<RfidViewBloc>().add(
                          ItemMasterRfidListingFetchEvent(
                            selectedItemId: widget.selectedItemId ?? 0,
                          ),
                        );
                        // showSuccessPopup("Item Mapped Successfully", context);
                        context.pop();
                      }
                    } else if(state.isLoading == false){
                      //todo rfid start
                      // if(selectedItemId != 0){
                      context.read<ItemMasterBloc>().add(
                        KdcReaderStartScanEvent(screenType: widget.screenType),
                      );
                      // }
                      log(">>>>>>>> ${state.rfidList.length}");
                    }
                    log("2");
                    // context.read<RfidBloc>().add(StartScanEvent());
                  },
                  buttonFirstOnPress: () {
                    log("1");
                    // context.read<RfidBloc>().add(StopScanEvent());
                    //todo rfid stop
                    context.read<ItemMasterBloc>().add(
                      KdcReaderStopScanEvent(
                        selectedItemId: 0,
                        screenType: widget.screenType,
                      ),
                    );
                    context.pop();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _RfidWidget extends StatelessWidget {
  const _RfidWidget({required this.rfidTitle, required this.rfidValue});

  final String rfidTitle;
  final RfidModel rfidValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: rfidValue.isTaggedWithAnother == false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedCheckBoxWidget(
              value: rfidValue.isSelected,
              onTap: () {
                context.read<ItemMasterBloc>().add(
                  RfidSelectionEvent(
                    isSelected: !(rfidValue.isSelected),
                    rfidName: rfidValue.rfidName,
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(width: AppSize.size10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text("RFID $rfidTitle"),
                SizedBox(width: AppSize.size6),
                /* Text(
                  rfidValue.rfidName,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColor.colorPrimary,
                  ),
                ),*/
                Visibility(
                  visible: rfidValue.isTaggedWithAnother,
                  child: ChipWidget(
                    chipText: "Tagged With Another",
                    color: AppColor.colorYellow,
                  ),
                ),
              ],
            ),
            Text(
              rfidValue.rfidName,
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColor.colorPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
