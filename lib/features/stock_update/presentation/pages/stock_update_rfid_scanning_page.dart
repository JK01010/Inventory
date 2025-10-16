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
import '../../../consumption/presentation/widgets/consumption_rfid_scanning_page_shimmer.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/common_floating_action_button.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/common_read_range_adjusting_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../../widgets/rfid_scanning_animated_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../bloc/stock_update_rfid_scanning_bloc/stock_update_rfid_scanning_bloc.dart';
import '../widgets/stock_update_add_rfid_scan_listing.dart';

class StockUpdateRFIDScanningPage extends StatefulWidget {
  const StockUpdateRFIDScanningPage({super.key});

  @override
  State<StockUpdateRFIDScanningPage> createState() =>
      _StockUpdateRFIDScanningPageState();
}

class _StockUpdateRFIDScanningPageState
    extends State<StockUpdateRFIDScanningPage> {
  final ValueNotifier<bool> selectAll = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    ///Rfid init called
    context.read<StockUpdateRfidScanningBloc>().add(InitialScanningEvent());
    log("Init is called");
  }

  @override
  void dispose() {
    context.read<StockUpdateRfidScanningBloc>().add(DisposeScanningEvent());
    log("Dispose is called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.stockUpdate,
          actions: [
            GestureDetector(
              onTap:
                  () => context.push(
                    AppRoute.searchStockUpdateRfidListingPage.path,
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
                StockUpdateRfidScanningBloc,
                StockUpdateRfidScanningState
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

                  return Visibility(
                    visible: state.isScanning,
                    child: Row(
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
                                    !state.isLoading &&
                                    state.viewList.isNotEmpty &&
                                    state.continueEnable,
                                child: RoundedCheckBoxWidget(
                                  value: state.isCompleteSelected,
                                  onTap: () {
                                    context
                                        .read<StockUpdateRfidScanningBloc>()
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
                              SizedBox(width: 10),
                              Visibility(
                                visible:
                                    !state.isLoading &&
                                    state.viewList.isNotEmpty,
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
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.size12),

              BlocBuilder<
                StockUpdateRfidScanningBloc,
                StockUpdateRfidScanningState
              >(
                builder: (context, state) {
                  return Visibility(
                    visible: !state.continueEnable && !state.isScanning,
                    child: Column(
                      children: [
                        CommonReadRangeAdjustingWidget(
                          valuePassed: state.rangeValue,
                          onChanged: (value) {
                            log("range value $value");
                            context
                                .read<StockUpdateRfidScanningBloc>()
                                .add(
                              UpdateRangeEvent(range: value),
                            );
                          }),
                        SizedBox(height: AppSize.size10),
                      ],
                    ),
                  );
                },
              ),
              Expanded(child: ListingPage()),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<
          StockUpdateRfidScanningBloc,
          StockUpdateRfidScanningState
        >(
          builder: (context, state) {
            return Visibility(
              visible: !state.isLoading && state.continueEnable,
              child: CommonFloatingActionButton(
                onPressedAction: () {
                  context.push(AppRoute.stockUpdateAdd.path);
                },
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<
          StockUpdateRfidScanningBloc,
          StockUpdateRfidScanningState
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
                  //navigate to next page (Continue button enabled)
                  if (state.continueEnable && state.viewList.isNotEmpty) {
                    context.push(
                      AppRoute.stockUpdate.path,
                      extra:
                          state.viewList
                              .where((element) => element.isSelected == true)
                              .toList(),
                    );
                  }
                  log("start is called");
                  context.read<StockUpdateRfidScanningBloc>().add(
                    StopScanningEvent(),
                  );
                } else if(!state.continueEnable) {
                  log("start is called");
                  context.read<StockUpdateRfidScanningBloc>().add(
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
}

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      StockUpdateRfidScanningBloc,
      StockUpdateRfidScanningState
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
          itemCount: state.isLoading ? 9 : state.viewList.length,
          itemBuilder: (context, index) {
            if (state.isLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.padding4),
                child: ConsumptionRfidScanningPageShimmer(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: StockUpdateAddRfidScanListing(
                itemList: state.viewList[index],
                enableCheckBox: state.continueEnable,
                index: index,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox();
          },
        );
      },
    );
  }
}
