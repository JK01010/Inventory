import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_icon.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_to_text_listening_widget.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/common_app_search_widget_text_field.dart';
import '../../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../../widgets/gradient_background_widget.dart';

import '../../bloc/consumption_rfid_scanning_bloc/consumption_rfid_scanning_bloc.dart';
import '../../widgets/consumption_add_rfid_scan_listing.dart';

class ConsumptionTrnRfidListingSearchWidget extends StatefulWidget {
  const ConsumptionTrnRfidListingSearchWidget({super.key});

  @override
  State<ConsumptionTrnRfidListingSearchWidget> createState() =>
      _ConsumptionTrnRfidListingSearchWidgetState();
}

class _ConsumptionTrnRfidListingSearchWidgetState
    extends State<ConsumptionTrnRfidListingSearchWidget>
    with WidgetsBindingObserver {
  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    searchText.addListener(() {
      context.read<ConsumptionRfidScanningBloc>().add(
        StockUpdateListingSearchEvent(
          searchText: searchText.text,
          isSearch: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        context.read<ConsumptionRfidScanningBloc>().add(
          StockUpdateListingSearchEvent(searchText: '', isSearch: false),
        );
        context.pop();
      },
      child: GradientBackground(
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<ConsumptionRfidScanningBloc>().add(
                                StockUpdateListingSearchEvent(
                                  searchText: '',
                                  isSearch: false,
                                ),
                              );
                              context.pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColor.colorBlack,
                              size: AppFontSize.fontSize18,
                            ),
                          ),
                          SizedBox(width: 5),
                          //search field
                          Expanded(
                            child: AppDecoratedBoxShadowWidget(
                              borderRadius: AppBorderRadius.borderRadius30,
                              child: CommonAppSearchWidget(
                                controller: searchText,
                                hintText: 'Search by item name',
                                suffixIcon: SpeechToTextMicWidget(),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColor.colorBlack3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppPadding.bottomPaddingNoDataFound),
                      listingPage(),
                    ],
                  ),
                ),

                ///widget for showing microphone interaction
                SpeechToTextListeningWidget(textEditingController: searchText),
              ],
            ),
          ),
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
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: AppPadding.bottomPaddingNoDataFound,
              ),
              child: AppDecoratedBoxShadowWidget(
                child: commonNoDataFoundTwo(context),
              ),
            ),
          );
        }
        return Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 100),
            shrinkWrap: true,
            itemCount: state.isLoading ? 2 : state.viewList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ConsumptionAddRfidScanListing(
                  itemList: state.viewList[index],
                  enableCheckBox: state.continueEnable,
                  index: index,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox();
            },
          ),
        );
      },
    );
  }
}
