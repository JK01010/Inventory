import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_icon.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_to_text_listening_widget.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/common_app_search_widget_text_field.dart';
import '../../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../../widgets/gradient_background_widget.dart';

import '../../bloc/consumption_transaction_bloc/consumption_transaction_bloc.dart';
import '../../bloc/consumption_transaction_bloc/consumption_transaction_event.dart';
import '../../widgets/consumption_transaction_list.dart';
import '../../widgets/consumption_transaction_page_shimmer.dart';

class ConsumptionTranSearchWidget extends StatefulWidget {
  const ConsumptionTranSearchWidget({super.key});

  @override
  State<ConsumptionTranSearchWidget> createState() =>
      _ConsumptionTranSearchWidgetState();
}

class _ConsumptionTranSearchWidgetState
    extends State<ConsumptionTranSearchWidget>
    with WidgetsBindingObserver {
  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    searchText.addListener(() {
      context.read<ConsumptionTransactionBloc>().add(
        ConsumptionTransactionSearchEvent(
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
        context.read<ConsumptionTransactionBloc>().add(
          ConsumptionTransactionSearchEvent(searchText: '', isSearch: false),
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
                              context.read<ConsumptionTransactionBloc>().add(
                                ConsumptionTransactionSearchEvent(
                                  searchText: '',
                                  isSearch: false,
                                ),
                              );
                              context.pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
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
                                  color:
                                      context.isDarkMode
                                          ? AppColor.colorWhite
                                          : AppColor.colorBlack3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppPadding.bottomPaddingNoDataFound),
                      transactionListView(),
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

  Widget transactionListView() {
    return BlocBuilder<ConsumptionTransactionBloc, ConsumptionTransactionState>(
      builder: (context, state) {
        if (!state.isLoading && state.searchTransactionList.isEmpty) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: AppPadding.bottomPaddingNoDataFound,
              ),
                child: commonNoDataFoundTwo(context),
            ),
          );
        }
        return Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 100),
            shrinkWrap: true,
            itemCount: state.isLoading ? 5 : state.searchTransactionList.length,
            itemBuilder: (context, index) {
              if (state.isLoading) {
                return ConsumptionTransactionPageShimmer();
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ConsumptionTransactionList(
                    itemList: state.searchTransactionList[index],
                  ),
                );
              }
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
