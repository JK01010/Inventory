import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../consumption/presentation/widgets/consumption_rfid_scanning_page_shimmer.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../domin/entities/stock_update_rfid_scanning_view_entity_model.dart';
import '../bloc/stock_update_page_bloc/stock_update_page_bloc.dart';
import '../widgets/show_bottom_sheet_filter.dart';
import '../widgets/stock_update_list.dart';

class StockUpdatePage extends StatefulWidget {
  const StockUpdatePage({super.key, required this.selectedList});

  final List<StockUpdateRfidListingViewEntity>
  selectedList; //list from rfid scanning page

  @override
  State<StockUpdatePage> createState() => _StockUpdatePageState();
}

class _StockUpdatePageState extends State<StockUpdatePage> {
  final isLoading = false;

  final List<TextEditingController> _remarkController = [];
  final List<TextEditingController> _newStockController = [];
  final List<TextEditingController> _reconditionController = [];

  @override
  void initState() {
    super.initState();
    context.read<StockUpdatePageBloc>().add(
      ReadPreviousPageDataEvent(selectedItemsList: widget.selectedList),
    );

    for (var item in widget.selectedList) {
      _remarkController.add(
        TextEditingController(text: item.remarkController ?? ''),
      );
      _newStockController.add(
        TextEditingController(text: item.newStockController ?? ''),
      );
      _reconditionController.add(
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
    for (var controller in _reconditionController) {
      controller.dispose();
    }
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
              onTap: () => context.push(AppRoute.searchStockUpdatePage.path),
              child: SvgPicture.asset(
                AppIcons.searchIcon,
                height: AppSize.size45,
                width: AppSize.size45,
              ),
            ),
          ],
        ),
        body: BlocConsumer<StockUpdatePageBloc, StockUpdatePageState>(
          listenWhen: (previous, current) {
            return (previous.isSaveCompleted != current.isSaveCompleted);
          },
          listener: (context, state) {
            if (state.isSaveCompleted) {
              _remarkController.clear();
              _newStockController.clear();
              _reconditionController.clear();
              context.read<StockUpdatePageBloc>().add(ResetStateEvent());
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
                  BlocBuilder<StockUpdatePageBloc, StockUpdatePageState>(
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
                  Expanded(child: stockUpdateList()),
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
              context.read<StockUpdatePageBloc>().add(
                SaveTransactionListEvent(),
              );
            },
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
          itemCount: isLoading ? 5 : state.selectedRfidItemList.length,
          itemBuilder: (context, index) {
            if (isLoading) {
              return ConsumptionRfidScanningPageShimmer();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: StockUpdateList(
                index: index,
                newStockController: _newStockController[index],
                reconditionStockController: _reconditionController[index],
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
