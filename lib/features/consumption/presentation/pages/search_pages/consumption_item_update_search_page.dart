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
import '../../../../widgets/gradient_background_widget.dart';
import '../../bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import '../../widgets/consumption_list.dart';

class ConsumptionItemUpdateSearchWidget extends StatefulWidget {
  const ConsumptionItemUpdateSearchWidget({super.key});

  @override
  State<ConsumptionItemUpdateSearchWidget> createState() =>
      _ConsumptionItemUpdateSearchWidgetState();
}

class _ConsumptionItemUpdateSearchWidgetState
    extends State<ConsumptionItemUpdateSearchWidget>
    with WidgetsBindingObserver {
  TextEditingController searchText = TextEditingController();

  final List<TextEditingController> _remarkController = [];
  final List<TextEditingController> _robTextController = [];
  final List<TextEditingController> _newStockController = [];
  final List<TextEditingController> _reconditionStockController = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    searchText.addListener(() {
      context.read<ConsumptionItemUpdateBloc>().add(
        ConsumptionListSearchEvent(searchText: searchText.text, isSearch: true),
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
        context.read<ConsumptionItemUpdateBloc>().add(
          ConsumptionListSearchEvent(searchText: '', isSearch: false),
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
                              context.read<ConsumptionItemUpdateBloc>().add(
                                ConsumptionListSearchEvent(
                                  searchText: '',
                                  isSearch: false,
                                ),
                              );
                              context.pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: context.customThemeColor(
                                light: AppColor.colorBlack,
                                dark: AppColor.colorWhite,
                              ),
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
                      Expanded(child: consumptionTab()),
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

  Widget consumptionTab() {
    return BlocBuilder<ConsumptionItemUpdateBloc, ConsumptionItemUpdateState>(
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.selectedRfidItemList.length,
          itemBuilder: (context, index) {
            if (_remarkController.length != state.selectedRfidItemList.length) {
              _remarkController
                ..clear()
                ..addAll(
                  List.generate(
                    state.selectedRfidItemList.length,
                    (index) => TextEditingController(
                      text:
                          state.selectedRfidItemList[index].remarkController ??
                          "",
                    ),
                  ),
                );
            }

            if (_robTextController.length !=
                state.selectedRfidItemList.length) {
              _robTextController
                ..clear()
                ..addAll(
                  List.generate(
                    state.selectedRfidItemList.length,
                    (index) => TextEditingController(
                      text:
                          state
                              .selectedRfidItemList[index]
                              .robTextController ??
                          "",
                    ),
                  ),
                );
            }

            if (_reconditionStockController.length !=
                state.selectedRfidItemList.length) {
              _reconditionStockController
                ..clear()
                ..addAll(
                  List.generate(
                    state.selectedRfidItemList.length,
                        (index) => TextEditingController(
                      text:
                      state
                          .selectedRfidItemList[index]
                          .reconditionStockController ??
                          "",
                    ),
                  ),
                );
            }

            if (_newStockController.length !=
                state.selectedRfidItemList.length) {
              _newStockController
                ..clear()
                ..addAll(
                  List.generate(
                    state.selectedRfidItemList.length,
                        (index) => TextEditingController(
                      text:
                      state
                          .selectedRfidItemList[index]
                          .newStockController ??
                          "",
                    ),
                  ),
                );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ConsumptionList(
                index: index,
                remarkController: _remarkController[index],
                robTextController: _robTextController[index],
                itemList: state.selectedRfidItemList[index],
                newStockController: _newStockController[index],
                reconditionStockController: _newStockController[index],
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
