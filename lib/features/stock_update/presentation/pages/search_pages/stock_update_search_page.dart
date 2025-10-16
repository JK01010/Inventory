import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_icon.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_to_text_listening_widget.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/common_app_search_widget_text_field.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../bloc/stock_update_page_bloc/stock_update_page_bloc.dart';
import '../../widgets/stock_update_list.dart';

class StockUpdateSearchWidget extends StatefulWidget {
  const StockUpdateSearchWidget({super.key});

  @override
  State<StockUpdateSearchWidget> createState() =>
      _StockUpdateSearchWidgetState();
}

class _StockUpdateSearchWidgetState extends State<StockUpdateSearchWidget>
    with WidgetsBindingObserver {
  TextEditingController searchText = TextEditingController();

  final List<TextEditingController> _remarkController = [];
  final List<TextEditingController> _newStockController = [];
  final List<TextEditingController> _reconditionStockController = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    searchText.addListener(() {
      context.read<StockUpdatePageBloc>().add(
        StockUpdateListSearchEvent(searchText: searchText.text, isSearch: true),
      );
    });

    for (var item in context.read<StockUpdatePageBloc>().state.selectedRfidItemList) {
      _remarkController.add(
        TextEditingController(text: item.remarkController ?? ''),
      );
      _newStockController.add(
        TextEditingController(text: item.newStockController ?? ''),
      );
      _reconditionStockController.add(
        TextEditingController(text: item.reconditionStockController ?? ''),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _remarkController) {
      controller.dispose();
    }
    for (var controller in _newStockController) {
      controller.dispose();
    }
    for (var controller in _reconditionStockController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        context.read<StockUpdatePageBloc>().add(
          StockUpdateListSearchEvent(searchText: '', isSearch: false),
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
                              context.read<StockUpdatePageBloc>().add(
                                StockUpdateListSearchEvent(
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
                      Expanded(child: stockUpdateList()),
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

  Widget stockUpdateList() {
    return BlocBuilder<StockUpdatePageBloc, StockUpdatePageState>(
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.selectedRfidItemList.length,
          itemBuilder: (context, index) {
       /*     if (_remarkController.length != state.selectedRfidItemList.length) {
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
            if (_consumedQtyController.length !=
                state.selectedRfidItemList.length) {
              _consumedQtyController
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
            }*/

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: StockUpdateList(
                index: index,
                newStockController: _newStockController[index],
                reconditionStockController: _reconditionStockController[index],
                remarkController: _remarkController[index],
                itemList: state.selectedRfidItemList[index],
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
