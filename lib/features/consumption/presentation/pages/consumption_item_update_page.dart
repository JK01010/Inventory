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
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../domin/entities/consumption_rfid_scanning_view_entity_model.dart';
import '../bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import '../widgets/consumption_list.dart';
import '../widgets/consumption_rfid_scanning_page_shimmer.dart';

class ConsumptionItemUpdatePage extends StatefulWidget {
  const ConsumptionItemUpdatePage({super.key, required this.selectedList});

  final List<ConsumptionRfidListingViewEntity> selectedList;

  @override
  State<ConsumptionItemUpdatePage> createState() =>
      _ConsumptionItemUpdatePageState();
}

class _ConsumptionItemUpdatePageState extends State<ConsumptionItemUpdatePage> {
  final bool isLoading = false;

  final List<TextEditingController> _remarkController = [];
  final List<TextEditingController> _robTextController = [];
  final List<TextEditingController> _newStockController = [];
  final List<TextEditingController> _reconditionStockController = [];

  @override
  void initState() {
    super.initState();
    context.read<ConsumptionItemUpdateBloc>().add(
      ReadPreviousPageDataEvent(selectedItemsList: widget.selectedList),
    );

    for (var item in widget.selectedList) {
      _remarkController.add(
        TextEditingController(text: item.remarkController ?? ''),
      );
      _robTextController.add(
        TextEditingController(text: item.robTextController ?? ''),
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
    for (var controller in _robTextController) {
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
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.consumption,
          actions: [
            GestureDetector(
              onTap:
                  () => context.push(
                    AppRoute.searchConsumptionItemUpdatePage.path,
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
        body: BlocConsumer<
          ConsumptionItemUpdateBloc,
          ConsumptionItemUpdateState
        >(
          listenWhen: (previous, current) {
            return (previous.isSaveCompleted != current.isSaveCompleted);
          },
          listener: (context, state) {
            if (state.isSaveCompleted) {
              _remarkController.clear();
              _robTextController.clear();
              _newStockController.clear();
              _reconditionStockController.clear();
              context.read<ConsumptionItemUpdateBloc>().add(ResetStateEvent());
              showSuccessPopup(context.l.savedSuccessfully, context);
              context
                ..pop()
                ..pop();
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.scaffoldPadding,
                right: AppPadding.scaffoldPadding,
                top: AppPadding.scaffoldPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<
                    ConsumptionItemUpdateBloc,
                    ConsumptionItemUpdateState
                  >(
                    builder: (context, state) {
                      String itemCount = "0 item(s)";
                      if (state.selectedRfidItemList.isNotEmpty) {
                        if (state.selectedRfidItemList.length < 9) {
                          itemCount =
                              "0${state.selectedRfidItemList.length} item(s)";
                        } else {
                          itemCount =
                              "${state.selectedRfidItemList.length} item(s)";
                        }
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.padding32,
                            ),
                            child: Visibility(
                              visible: state.selectedRfidItemList.isNotEmpty,
                              child: Text(itemCount),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: AppSize.size10),
                  Expanded(child: consumptionTab()),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Visibility(
          visible: !isLoading,
          child: AppTwoRowButtonWidget(
            buttonFirstTitle: context.l.tag,
            buttonFirstOnPress: () {
              context.push(AppRoute.consumptionRFIDScan.path);
            },
            buttonSecondTitle: context.l.save,
            buttonSecondOnPress: () {
              context.read<ConsumptionItemUpdateBloc>().add(
                SaveTransactionListEvent(),
              );
            },
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
 /*           // if (_remarkController.length != state.selectedRfidItemList.length) {
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
            // }

            // if (_consumedQtyController.length != state.selectedRfidItemList.length) {
            _consumedQtyController
              ..clear()
              ..addAll(
                List.generate(
                  state.selectedRfidItemList.length,
                  (index) => TextEditingController(
                    text:
                        state
                            .selectedRfidItemList[index]
                            .consumedQtyController ??
                        "",
                  ),
                ),
              );
            // }*/

            if (isLoading) {
              return ConsumptionRfidScanningPageShimmer();
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ConsumptionList(
                  index: index,
                  remarkController: _remarkController[index],
                  robTextController: _robTextController[index],
                  itemList: state.selectedRfidItemList[index],
                  newStockController: _newStockController[index],
                  reconditionStockController: _reconditionStockController[index],
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
