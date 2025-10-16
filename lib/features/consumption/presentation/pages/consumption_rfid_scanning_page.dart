import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/common_floating_action_button.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/common_read_range_adjusting_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../../widgets/rfid_scanning_animated_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../bloc/consumption_rfid_scanning_bloc/consumption_rfid_scanning_bloc.dart';
import '../widgets/consumption_add_rfid_scan_listing.dart';
import '../widgets/consumption_rfid_scanning_page_shimmer.dart';

class ConsumptionRFIDScanningPage extends StatefulWidget {
  const ConsumptionRFIDScanningPage({super.key});

  @override
  State<ConsumptionRFIDScanningPage> createState() =>
      _ConsumptionRFIDScanningPageState();
}

class _ConsumptionRFIDScanningPageState
    extends State<ConsumptionRFIDScanningPage> {
  late final ConsumptionRfidScanningBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<ConsumptionRfidScanningBloc>();
    context.read<ConsumptionRfidScanningBloc>().add(InitialScanningEvent());
    // context.read<ConsumptionLocationBloc>().add(FetchAllLocationDataEvent()); //todo change to consumption module
  }


  @override
  void dispose() {
    bloc.add(DisposeScanningEvent());
    log("Dispose is called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.consumption,
          actions: [
            BlocBuilder<
              ConsumptionRfidScanningBloc,
              ConsumptionRfidScanningState
            >(
              builder: (context, state) {
                return Visibility(
                  visible: !state.isLoading && state.continueEnable,
                  child: GestureDetector(
                    onTap:
                        () => context.push(
                          AppRoute.searchConsumptionTrnRfidListingPage.path,
                        ),
                    child: SvgPicture.asset(
                      AppIcons.searchIcon,
                      height: AppSize.size45,
                      width: AppSize.size45,
                      colorFilter:
                          context.isDarkMode
                              ? const ColorFilter.mode(
                                AppColor.colorWhite,
                                BlendMode.srcIn,
                              )
                              : null,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.scaffoldPadding,
            right: AppPadding.scaffoldPadding,
            top: AppPadding.scaffoldPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<
                ConsumptionRfidScanningBloc,
                ConsumptionRfidScanningState
              >(
                builder: (context, state) {
                  String itemCount = "0 item(s)";
                  if (state.viewList.isNotEmpty) {
                    if (state.viewList.length < 9) {
                      itemCount = "0${state.viewList.length} item(s)";
                    } else {
                      itemCount = "${state.viewList.length} item(s)";
                    }
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.scaffoldPadding,
                        ),
                        child: Row(
                          children: [
                            Visibility(
                              visible:
                                  state.continueEnable &&
                                  state.viewList.isNotEmpty,
                              child: RoundedCheckBoxWidget(
                                value: state.isCompleteSelected,
                                onTap: () {
                                  context
                                      .read<ConsumptionRfidScanningBloc>()
                                      .add(
                                        IsSelectedEvent(
                                          index: -1,
                                          isSelectedValue: false,
                                          completeSelect:
                                              !state.isCompleteSelected,
                                        ),
                                      );
                                },
                              ),
                            ),
                            SizedBox(width: 18),
                            Visibility(
                              visible: state.viewList.isNotEmpty,
                              child: Text(itemCount),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !state.continueEnable && state.isScanning,
                        child: RfidScanningAnimation(),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: AppSize.size12),
              BlocBuilder<
                ConsumptionRfidScanningBloc,
                ConsumptionRfidScanningState
              >(
                builder: (context, state) {
                  return Visibility(
                    visible: !state.continueEnable && !state.isScanning,
                    child: Column(
                      children: [
                        CommonReadRangeAdjustingWidget(
                          valuePassed: state.rangeValue,
                          onChanged: (value) {
                            context.read<ConsumptionRfidScanningBloc>().add(UpdateRangeEvent(range: value));
                          }
                        ),
                        SizedBox(height: AppSize.size10),
                      ],
                    ),
                  );
                },
              ),
              Expanded(child: listingPage()),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<
          ConsumptionRfidScanningBloc,
          ConsumptionRfidScanningState
        >(
          builder: (context, state) {
            return Visibility(
              visible: !state.isLoading && state.continueEnable,
              child: CommonFloatingActionButton(
                onPressedAction: () {
                  context.push(AppRoute.consumptionAdd.path);
                },
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<
          ConsumptionRfidScanningBloc,
          ConsumptionRfidScanningState
        >(
          builder: (context, state) {
            return AppTwoRowButtonWidget(
              buttonSecondTitle:
                  state.isScanning
                      ? state.continueEnable
                          ? context.l.strContinue
                          : context.l.stopScan
                      : context.l.startScan,
              buttonSecondOnPress: () {
                if (state.isScanning) {
                  //navigate to next page Continue button enabled
                  if (state.continueEnable && state.viewList.isNotEmpty) {
                    context.push(
                      AppRoute.consumption.path,
                      extra:
                          state.viewList
                              .where((element) => element.isSelected == true)
                              .toList(),
                    );
                  }
                  context.read<ConsumptionRfidScanningBloc>().add(
                    StopScanningEvent(),
                  );
                } else if(!state.continueEnable){
                  context.read<ConsumptionRfidScanningBloc>().add(
                    FetchRfidScanningListEvent(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget listingPage() {
    return BlocBuilder<
      ConsumptionRfidScanningBloc,
      ConsumptionRfidScanningState
    >(
      builder: (context, state) {
        if (!state.isLoading && state.viewList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: AppPadding.bottomPaddingNoDataFound,
            ),
            child: AppDecoratedBoxShadowWidget(
              child: commonNoDataFoundTwo(context),
            ),
          );
        }
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 100),
          shrinkWrap: true,
          itemCount: state.isLoading ? 2 : state.viewList.length,
          itemBuilder: (context, index) {
            if (state.isLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ConsumptionRfidScanningPageShimmer(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ConsumptionAddRfidScanListing(
                  itemList: state.viewList[index],
                  enableCheckBox: state.continueEnable,
                  index: index,
                ),
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox();
          },
        );
      },
    );
  }
}
