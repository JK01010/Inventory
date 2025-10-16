import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/app_bar_title_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/bagging_confirmation_list/bagging_confirmation_list_bloc.dart';
import '../bloc/bagging_tagging_confirmation_bloc/bagging_tagging_confirmation_bloc.dart';
import '../bloc/bagging_tagging_item_section/bagging_item_section_bloc.dart';
import '../bloc/bagging_tagging_item_sub_section/bagging_item_sub_section_bloc.dart';
import '../bloc/bagging_tagging_purchase_pending_bloc/bagging_tagging_purchase_pending_bloc.dart';
import '../bloc/fetch_imdg_class_bloc/fetch_imdg_class_bloc.dart';
import '../widgets/confirmation_card.dart';
import '../widgets/filter.dart';
import '../widgets/pending_card.dart';
import '../widgets/shimmer/bagging_confirmation_shimmer.dart';
import '../widgets/shimmer/bagging_pending_shimmer.dart';

class BagTagListingPage extends StatefulWidget {
  const BagTagListingPage({super.key});

  @override
  State<BagTagListingPage> createState() => _BagTagListingPageState();
}

class _BagTagListingPageState extends State<BagTagListingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<BaggingConfirmationListBloc>().add(
      BaggingConfirmationListGetAllDataEvent(),
    );

    context.read<BaggingItemSectionBloc>().add(ItemSectionInsertDataEvent());
    context.read<BaggingItemSubSectionBloc>().add(
      ItemSubSectionInsertDataEvent(),
    );
    context.read<BaggingTaggingPurchasePendingBloc>().add(
      FetchAllTransactionFromDb(),
    );
    context.read<BaggingTaggingConfirmationBloc>().add(
      FetchAllConfirmationTransactionFromDb(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColor.colorTransparent,
          appBar: AppBar(
            titleSpacing: AppSize.size0,
            title: Padding(
              padding: EdgeInsets.only(top: AppPadding.scaffoldPadding),
              child: AppBarTitleWidget(
                text:
                    AppLocalizations.of(
                      context,
                    )?.baggingAndTaggingConfirmation ??
                    "",
              ),
            ),

            leadingWidth: AppSize.appBarLeadingWidth,
            leading: InkWell(
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: AppPadding.scaffoldPadding,
                  left: AppPadding.scaffoldPadding,
                ),
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            actionsPadding: EdgeInsets.only(
              top: AppPadding.scaffoldPadding,
              right: AppPadding.scaffoldPadding,
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColor.colorWhite,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppBorderRadius.borderRadius20),
                      ),
                    ),
                    builder: (_) => BagTagFilterBottomSheet(),
                  );
                },
                child: SvgPicture.asset(
                  AppIcons.filterIcon,
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
              GestureDetector(
                onTap:
                    () =>
                        _tabController.index == 0
                            ? context.push(AppRoute.baggingPendingSearch.path)
                            : context.push(
                              AppRoute.baggingConfirmationSearch.path,
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
            bottom: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor:
                  context.isDarkMode
                      ? AppColor.colorButtonBorderColor
                      : AppColor.colorSecondary,
              labelColor:
                  context.isDarkMode
                      ? AppColor.colorButtonBorderColor
                      : AppColor.colorSecondary,

              labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: AppFontSize.fontSize14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(
                fontSize: AppFontSize.fontSize14,
                fontWeight: FontWeight.w400,
              ),
              controller: _tabController,
              unselectedLabelColor:
                  context.isDarkMode
                      ? AppColor.colorDividerLight
                      : AppColor.colorBlack,
              tabs: [
                Tab(text: AppLocalizations.of(context)!.pending),
                Tab(text: AppLocalizations.of(context)!.confirmation),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,

            physics: NeverScrollableScrollPhysics(),
            children: [
              PendingList(),
              ConfirmationList(), // Placeholder
            ],
          ),
        ),
      ),
    );
  }
}

class PendingList extends StatelessWidget {
  const PendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BaggingTaggingPurchasePendingBloc,
      BaggingTaggingPurchasePendingState
    >(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.all(AppPadding.padding12),
          itemCount: state.isLoading ? 3 : state.pendingEntity.length,
          itemBuilder: (context, index) {
            if (state.isLoading) {
              return BaggingPendingShimmer();
            }

            return PendingListCard(
              item: state.pendingEntity[index],
              onTap: () {
                context.push(
                  AppRoute.baggingTaggingDetails.path,
                  extra: state.pendingEntity[index],
                );
              },
            );
          },
        );
      },
    );
  }
}

class ConfirmationList extends StatelessWidget {
  const ConfirmationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BaggingTaggingConfirmationBloc,
      BaggingTaggingConfirmationState
    >(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.all(AppPadding.padding12),
          itemCount: state.isLoading ? 3 : state.pendingEntity.length,
          itemBuilder: (context, index) {
            return state.isLoading
                ? BaggingConfirmationShimmer()
                : ConfirmationCard(item: state.pendingEntity[index]);
          },
        );
      },
    );
  }
}
