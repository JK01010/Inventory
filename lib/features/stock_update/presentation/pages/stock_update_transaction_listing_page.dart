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
import '../../../consumption/presentation/widgets/consumption_transaction_page_shimmer.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/common_floating_action_button.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/stock_update_transaction_listing_bloc/stock_update_transaction_listing_bloc.dart';
import '../widgets/stock_update_listing_page_filter.dart';
import '../widgets/stock_update_transaction_list.dart';

class StockUpdateTransactionListingPage extends StatefulWidget {
  const StockUpdateTransactionListingPage({super.key});

  @override
  State<StockUpdateTransactionListingPage> createState() =>
      _StockUpdateTransactionListingPageState();
}

class _StockUpdateTransactionListingPageState
    extends State<StockUpdateTransactionListingPage> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController articleNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //fetch listing data from db
    context.read<StockUpdateTransactionListingBloc>().add(
      StockUpdateTransactionListingFetchViewEvent(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.stockUpdate,
          actions: [
            GestureDetector(
              onTap: () {
                stockUpdateListingPageFilter(
                  context: context,
                  onApply: () {
                    if (itemNameController.text.trim().isNotEmpty ||
                        itemNameController.text.trim().isNotEmpty) {
                      context.read<StockUpdateTransactionListingBloc>().add(
                        StockUpdateFilterFetchDataEvent(
                          itemName: itemNameController.text,
                          articleNo: articleNumberController.text,
                        ),
                      );
                      context.pop();
                    } else {
                      showSuccessPopup(context.l.enterFilterValues, context);
                    }
                  },
                  onCancel: () {
                    context.read<StockUpdateTransactionListingBloc>().add(
                      StockUpdateTransactionListingFetchViewEvent(),
                    );
                    itemNameController.clear();
                    articleNumberController.clear();
                    context.pop();
                  },
                  textOne: itemNameController,
                  textTwo: articleNumberController,
                );
              },
              child: BlocBuilder<
                StockUpdateTransactionListingBloc,
                StockUpdateTransactionListingState
              >(
                builder: (context, state) {
                  return SvgPicture.asset(
                    state.isFilterActive
                        ? AppIcons.filterActiveIcon
                        : AppIcons.filterIcon,
                    height: AppSize.size45,
                    width: AppSize.size45,
                    colorFilter:
                        context.isDarkMode
                            ? const ColorFilter.mode(
                              AppColor.colorWhite,
                              BlendMode.srcIn,
                            )
                            : null,
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push(AppRoute.searchStockUpdateTransactionPage.path);
              },
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.padding32,
                ),
                child: BlocBuilder<
                  StockUpdateTransactionListingBloc,
                  StockUpdateTransactionListingState
                >(
                  builder: (context, state) {
                    String itemCount = "0 item(s)";
                    int itemLength = state.stockUpdateViewList.length;
                    if (itemLength != 0 && itemLength < 10) {
                      itemCount = "0$itemLength item(s)";
                    } else if (itemLength != 0) {
                      itemCount = "$itemLength item(s)";
                    }
                    return Visibility(
                      visible:
                          !state.isLoading &&
                          state.stockUpdateViewList.isNotEmpty,
                      child: Text(itemCount),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Expanded(child: transactionListView()),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<
          StockUpdateTransactionListingBloc,
          StockUpdateTransactionListingState
        >(
          builder: (context, state) {
            return Visibility(
              visible: !state.isLoading,
              child: CommonFloatingActionButton(
                onPressedAction: () async {
                  await context.push(AppRoute.stockUpdateRFIDScan.path);
                  if (context.mounted) {
                    context.read<StockUpdateTransactionListingBloc>().add(
                      StockUpdateTransactionListingFetchViewEvent(),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget transactionListView() {
    return BlocBuilder<
      StockUpdateTransactionListingBloc,
      StockUpdateTransactionListingState
    >(
      builder: (context, state) {
        if (!state.isLoading && state.stockUpdateViewList.isEmpty) {
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
          itemCount: state.isLoading ? 4 : state.stockUpdateViewList.length,
          itemBuilder: (context, index) {
            if (state.isLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.padding4),
                child: ConsumptionTransactionPageShimmer(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: StockUpdateTransactionList(
                itemList: state.stockUpdateViewList[index],
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
