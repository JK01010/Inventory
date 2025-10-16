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
import '../../../bagging_tagging_confirmtaion/data/model/rfid_screen_type.dart';
import '../../../consumption/presentation/bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import '../../../consumption/presentation/bloc/consumption_location_bloc/consumption_location_bloc.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../widgets/item_master_list.dart';
import '../widgets/shimmer/item_master_list_shimmer.dart';
import '../widgets/show_bottom_sheet_item_master_filter.dart';

class ItemMasterListingPage extends StatefulWidget {
  const ItemMasterListingPage({super.key});

  @override
  State<ItemMasterListingPage> createState() => _ItemMasterListingPageState();
}

class _ItemMasterListingPageState extends State<ItemMasterListingPage> {
  final TextEditingController itemName = TextEditingController();
  final TextEditingController equipmentName = TextEditingController();
  final TextEditingController partNo = TextEditingController();
  final TextEditingController articleName = TextEditingController();

  late final ScrollController _scrollController;


  @override
  void initState()  {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    // context.read<ItemMasterBloc>().add(InsertItemMasterEvent());
    context.read<ItemMasterBloc>().add(FetchAllDataItemMasterEvent());
    // context.read<ConsumptionItemUpdateBloc>().add(EquipmentListInsertDataEvent());
    // context.read<ConsumptionLocationBloc>().add(InsertLocationDataEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ItemMasterBloc>().add(LazyLoadingItemMasterEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll;
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.itemMaster,
          actions: [
            GestureDetector(
              onTap: () async {
                await itemMasterListingPageFilter(
                  context: context,
                  textOne: itemName,
                  textTwo: equipmentName,
                  textThree: partNo,
                  textFour: articleName,
                  onApply: () {
                    context.read<ItemMasterBloc>().add(
                      ApplyFilterItemMasterEvent(
                        itemName.text,
                        equipmentName.text,
                        partNo.text,
                        articleName.text,
                      ),
                    );
                    context.pop();
                  },
                  onCancel: () {
                    itemName.clear();
                    equipmentName.clear();
                    partNo.clear();
                    articleName.clear();
                    // context.read<ItemMasterBloc>().add(FetchAllDataItemMasterEvent());
                    context.pop();
                  },
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
              onTap: (){
                context.push(AppRoute.searchItemPage.path);
              } ,
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
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [itemCount(context), itemList()],
          ),
        ),
      ),
    );
  }

  Widget itemCount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.padding14,
        bottom: AppPadding.padding8,
      ),
      child: BlocBuilder<ItemMasterBloc, ItemMasterState>(
        builder: (context, state) {
          String itemsCount;
          if (state.itemMasterList.isNotEmpty) {
            if (state.itemMasterList.length < 10) {
              itemsCount = "0${state.itemMasterList.length}";
            } else {
              itemsCount = state.itemMasterList.length.toString();
            }
          } else {
            itemsCount = "0";
          }
          return Visibility(
            visible: !state.isLoading && state.itemMasterList.isNotEmpty,
            child: Text(
              "$itemsCount item(s)",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        },
      ),
    );
  }

  Widget itemList() {
    return BlocBuilder<ItemMasterBloc, ItemMasterState>(
      builder: (context, state) {
        if(!state.isLoading && state.itemMasterList.isEmpty){
          return commonNoDataFound(context);
        }
        return Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: state.isLoading ? 5 : state.itemMasterList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.padding4,
                ),
                child:
                    state.isLoading
                        ? ItemMasterListShimmer()
                        : ItemMasterList(
                          itemList: state.itemMasterList[index],
                          onTap: () {
                            context.push(
                              AppRoute.itemMasterViewRfidListViewing.path,
                              extra: {
                                'selectedItemId': state.itemMasterList[index].itemId,
                                'screenType': RfidScreenType.itemMaster,
                              },
                            );
                          },
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
