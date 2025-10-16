import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/extensions/theme_extension.dart';
import '../../../core/routes/route_name.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_background_widget.dart';
import '../purchase_order/presentation/bloc/purchase_order_bloc/purchase_order_bloc.dart';
import '../purchase_order/presentation/widgets/purchase_order_body_widget.dart';
import '../purchase_order/presentation/widgets/purchase_order_filter_widget.dart';
import '../transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import '../transaction/presentation/bloc/transaction_filter_bloc/transaction_filter_bloc.dart';
import '../transaction/presentation/widgets/transaction_widget.dart';
import '../transaction/presentation/widgets/transaction_filter_widget.dart';
import 'widgets/goods_receipts_page/goods_receipts_item_count_widget.dart';

class GoodsReceiptsPage extends StatefulWidget {
  const GoodsReceiptsPage({super.key});

  @override
  State<GoodsReceiptsPage> createState() => _GoodsReceiptsPageState();
}

class _GoodsReceiptsPageState extends State<GoodsReceiptsPage>
    with SingleTickerProviderStateMixin {
  //tab controller added for tab switch time transaction page state reset
  late TabController _tabController;

  //global bloc added for back button press time transaction page state reset

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    context.read<PurchaseOrderBloc>().add(GetPurchaseOrderFromDb());
    context.read<TransactionBloc>().add(GetAllTransactionFromDb());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {},
      child: GradientBackground(
        child: DefaultTabController(
          length: 2,

          child: PopScope(
            onPopInvokedWithResult: (didPop, result) {},
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: CustomAppBar(
                title: context.l.goodsReceipts,
                actions: <Widget>[
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: false,
                            backgroundColor: AppColor.colorTransparent,
                            builder: (context) {
                              final Widget filterWidget =
                                  _tabController.index == 0
                                      ? PurchaseOrderFilterWidget()
                                      : GoodReceiptTransactionFilterWidget();
                              return SafeArea(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color:
                                          context.isDarkMode
                                              ? AppColor.colorBGBlack
                                              : AppColor.colorBackground,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(
                                          AppBorderRadius.borderRadius20,
                                        ),
                                      ),
                                    ),
                                    child: SingleChildScrollView(
                                      child: filterWidget,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          AppIcons.filterIcon,
                          height: AppSize.size45,
                          width: AppSize.size45,
                          colorFilter:
                              context.isDarkMode
                                  ? ColorFilter.mode(
                                    AppColor.colorWhite,
                                    BlendMode.srcIn,
                                  )
                                  : null,
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_tabController.index == 0) {
                        context.push(AppRoute.goodsReceiptsSearch.path);
                      } else {
                        context.push(AppRoute.transactionSearch.path);
                      }
                    },
                    child: SvgPicture.asset(
                      AppIcons.searchIcon,
                      height: AppSize.size45,
                      width: AppSize.size45,
                      colorFilter:
                          context.isDarkMode
                              ? ColorFilter.mode(
                                AppColor.colorWhite,
                                BlendMode.srcIn,
                              )
                              : null,
                    ),
                  ),
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Item count widget
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.padding30,
                      right: AppPadding.padding30,
                      top: AppPadding.scaffoldPadding,
                    ),
                    child: ItemCountWidget(tabController: _tabController),
                  ),

                  //tab bar
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    onTap: (value) {
                      // if (value == 1) {
                      //   context.read<GoodsReceiptsTransactionBloc>().add(
                      //     ClearSyncList(),
                      //   );
                      //   context.read<GoodsReceiptsTransactionBloc>().add(
                      //     ChangeSelectionMode(value: false),
                      //   );
                      // }
                    },
                    labelStyle: Theme.of(context).textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
                    tabs: [
                      Tab(text: context.l.pendingPos),
                      Tab(text: context.l.transactions),
                    ],
                    tabAlignment: TabAlignment.start,
                    indicatorColor:
                        Theme.of(context).textTheme.labelLarge?.color,
                  ),
                  SizedBox(height: AppSize.size10),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppPadding.scaffoldPadding,
                        right: AppPadding.scaffoldPadding,
                        // bottom: AppPadding.scaffoldPadding,
                      ),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          PurchaseOrderBodyWidget(),
                          TransactionBodyWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //sync bottom navigation bar
              // bottomNavigationBar:
              //     BlocSelector<TransactionBloc, TransactionState, bool>(
              //       selector: (state) {
              //         return state.isSelectionModeEnabled;
              //       },
              //       builder: (context, state) {
              //         if (state) {
              //           return ColoredBox(
              //             color: AppColor.colorWhite,
              //             child: SafeArea(
              //               top: false,
              //               child: GestureDetector(
              //                 onTap: () {
              //                   // context
              //                   //     .read<GoodsReceiptsTransactionBloc>()
              //                   //     .add(SyncTransactionList());
              //                 },
              //                 child: SyncToWebWidget(),
              //               ),
              //             ),
              //           );
              //         } else {
              //           return SizedBox();
              //         }
              //       },
              //     ),
            ),
          ),
        ),
      ),
    );
  }
}
