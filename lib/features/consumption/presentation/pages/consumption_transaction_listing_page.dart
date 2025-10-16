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
import '../../../widgets/common_floating_action_button.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/consumption_transaction_bloc/consumption_transaction_bloc.dart';
import '../bloc/consumption_transaction_bloc/consumption_transaction_event.dart';
import '../widgets/consumption_listing_page_filter.dart';
import '../widgets/consumption_transaction_list.dart';
import '../widgets/consumption_transaction_page_shimmer.dart';

class ConsumptionTransactionListingPage extends StatefulWidget {
  const ConsumptionTransactionListingPage({super.key});

  @override
  State<ConsumptionTransactionListingPage> createState() =>
      _ConsumptionTransactionListingPageState();
}

class _ConsumptionTransactionListingPageState
    extends State<ConsumptionTransactionListingPage> {
  final TextEditingController itemName = TextEditingController();
  final TextEditingController articleNumber = TextEditingController();

  @override
  void initState() {
    //listing data from db
    context.read<ConsumptionTransactionBloc>().add(
      ConsumptionTransactionFetchDataEvent(),
    );
   /* context.read<ConsumptionTransactionBloc>().add(
      ConsumptionTransactionInsertDataEvent(),
    );*/
    // context.read<StorageLocationBloc>().add(InsertStorageLocationEvent());
    // context.read<ConsumptionItemUpdateBloc>().add(EquipmentListInsertDataEvent());
    // context.read<ConsumptionLocationBloc>().add(InsertLocationDataEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.consumption,
          actions: [
            GestureDetector(
              onTap: () {
                consumptionListingPageFilter(
                  context: context,
                  textOne: itemName,
                  textTwo: articleNumber,
                  onApply: () {
                    context.read<ConsumptionTransactionBloc>().add(
                      ConsumptionTransactionFilterEvent(
                        itemName.text,
                        articleNumber.text,
                      ),
                    );
                    context.pop();
                  },
                  onCancel: () {
                    context.read<ConsumptionTransactionBloc>().add(
                      ConsumptionTransactionFetchDataEvent(),
                    );
                    itemName.clear();
                    articleNumber.clear();
                    context.pop();
                  },
                );
              },
              child: BlocBuilder<
                ConsumptionTransactionBloc,
                ConsumptionTransactionState
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
              onTap:
                  () => context.push(
                    AppRoute.searchConsumptionTransactionPage.path,
                  ),
              child: SvgPicture.asset(
                AppIcons.searchIcon,
                height: AppSize.size45,
                width: AppSize.size45,
                colorFilter:
                    context.isDarkMode
                        ? const ColorFilter.mode(
                          AppColor.colorBlack5,
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
                  ConsumptionTransactionBloc,
                  ConsumptionTransactionState
                >(
                  builder: (context, state) {
                    String itemCount = "0 item(s)";
                    int itemLength = state.transactionList.length;
                    if (itemLength != 0 && itemLength < 10) {
                      itemCount = "0$itemLength item(s)";
                    } else if (itemLength != 0) {
                      itemCount = "$itemLength item(s)";
                    }
                    return Visibility(
                      visible:
                          !state.isLoading && state.transactionList.isNotEmpty,
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
          ConsumptionTransactionBloc,
          ConsumptionTransactionState
        >(
          builder: (context, state) {
            return Visibility(
              visible: !state.isLoading,
              child: CommonFloatingActionButton(
                onPressedAction: () async {
                  await context.push(AppRoute.consumptionRFIDScan.path);
                  if (context.mounted) {
                    context.read<ConsumptionTransactionBloc>().add(
                      ConsumptionTransactionFetchDataEvent(),
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
    return BlocBuilder<ConsumptionTransactionBloc, ConsumptionTransactionState>(
      builder: (context, state) {
        if (!state.isLoading && state.transactionList.isEmpty) {
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
          itemCount: state.isLoading ? 4 : state.transactionList.length,
          itemBuilder: (context, index) {
            if (state.isLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ConsumptionTransactionPageShimmer(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ConsumptionTransactionList(
                  itemList: state.transactionList[index],
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
