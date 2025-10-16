import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/widgets/custom_checkbox.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/widgets/deck_store_list_widget.dart';
import 'package:pal_ng_inventory/features/widgets/wifi_animation_widget.dart';
import 'package:pal_ng_inventory/l10n/app_localizations.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../widgets/app_bar_title_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/common_read_range_adjusting_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../../widgets/rfid_scanning_animated_widget.dart';
import '../bloc/bagging_confirmation_list/bagging_confirmation_list_bloc.dart';

class BaggingTaggingConfirmScanningPage extends StatefulWidget {
  final int grnId;

  const BaggingTaggingConfirmScanningPage({
    super.key,
    required this.grnId,
  });

  @override
  State<BaggingTaggingConfirmScanningPage> createState() =>
      _BaggingTaggingConfirmScanningPageState();
}

class _BaggingTaggingConfirmScanningPageState
    extends State<BaggingTaggingConfirmScanningPage> {
  @override
  void initState() {
    super.initState();
    context.read<BaggingConfirmationListBloc>().add(
      BaggingConfirmationListStorageLocationEvent(
        selectedGrnId: widget.grnId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GradientBackground(
      child: BlocBuilder<
        BaggingConfirmationListBloc,
        BaggingConfirmationListState
      >(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.colorTransparent,
            appBar: AppBar(
              titleSpacing: AppSize.size0,
              title: Padding(
                padding: EdgeInsets.only(top: AppPadding.scaffoldPadding),
                child: AppBarTitleWidget(
                  text: AppLocalizations.of(context)?.confirmation ?? "",
                ),
              ),

              leadingWidth: AppSize.appBarLeadingWidth,
              leading: InkWell(
                onTap: () {
                  context.read<BaggingConfirmationListBloc>().add(BaggingConfirmationListResetEvent());
                  context.pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.scaffoldPadding,
                    left: AppPadding.scaffoldPadding,
                  ),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(AppSize.size30),
                child: BlocBuilder<
                  BaggingConfirmationListBloc,
                  BaggingConfirmationListState
                >(
                  builder: (context, state) {
                    return Row(
                      children: [
                        const SizedBox(width: AppSize.size25),
                       /* CustomCheckButton(
                          checkBoxName:
                          "${state.locList.length.toString()} Item(s) found",
                          enableButton: true,
                          onItemUpdate: onDeckStoreItemFound,
                          onTap: () {
                            context.read<BaggingConfirmationListBloc>().add(
                              IsAllItemsSelectEvent(
                                isSelected: !state.isCompleteSelected,
                              ),
                            );
                          },
                          checkBoxValue: state.isCompleteSelected,
                        ),*/
                        Visibility(
                          visible: state.locList.isNotEmpty,
                          child: Text("${state.locList.length}${context.l.itemsFound}"),
                        ),
                        Spacer(),
                        Visibility(
                          visible: state.isScanning,
                          child: RfidScanningAnimation(),
                        ),
                        const SizedBox(width: AppSize.size10),
                      ],
                    );
                  },
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.padding12),
              child: Column(
                children: [
                  // CommonReadRangeAdjustingWidget(),
                  SizedBox(height: AppSize.size10),
                  BlocBuilder<BaggingConfirmationListBloc, BaggingConfirmationListState>(
                   builder: (context, state) {
                    if(state.locList.isEmpty){
                     return Expanded(
                       child: AppDecoratedBoxShadowWidget(
                         child: commonNoDataFoundTwo(context),
                       ),
                     );
                    }
                    return Expanded(
                    child: DeckStorePage(),
                  );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BlocBuilder<
              BaggingConfirmationListBloc,
              BaggingConfirmationListState
            >(
              builder: (context, state) {
                return AppTwoRowButtonWidget(
                  buttonSecondTitle: state.isScanning?context.l.stopScan:(state.isContinueEnable?context.l.strContinue:context.l.startScan),
                  buttonFirstOnPress: (){
                    log("scanning started");
                    context.read<BaggingConfirmationListBloc>().add(KdcReaderStopScanEvent());
                    context.pop();
                  },
                  buttonSecondOnPress: () {
                    if(state.isScanning){
                      log("scanning started");
                      context.read<BaggingConfirmationListBloc>().add(KdcReaderStopScanEvent());
                    }else if(!state.isScanning && !state.isContinueEnable){
                      log("scanning started");
                      context.read<BaggingConfirmationListBloc>().add(KdcReaderStartScanEvent());
                    }
                     //todo commended
                    bool isSelectedExist = false;

                     isSelectedExist = state.locList.any((item) => item.isSelected);

                    if(state.isContinueEnable && isSelectedExist){
                      context.push(
                        AppRoute.baggingConfirmationStorageDetailsPage.path,
                        extra: {
                          'selectedItemIds' : state.rfidItemIds??[0],
                          'storageLocId': state.locList.where((element) => element.isSelected).map((e) => e.locId).first,
                          'grnId': widget.grnId ?? 0,
                        },
                      );
                    }else if(state.isContinueEnable && !isSelectedExist){
                      showSuccessPopup("No location selected", context);
                    }

                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  void onDeckStoreItemFound(bool value) {
    //print('The checkbox value is $value');
  }
}
