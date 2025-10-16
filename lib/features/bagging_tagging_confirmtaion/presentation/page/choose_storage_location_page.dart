import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../common_feature/domain/entities/storage_location_entity.dart';
import '../../../consumption/presentation/bloc/consumption_add_page_bloc/consumption_add_page_bloc.dart';
import '../../../consumption/presentation/widgets/equipment_location_search_page_shimmer.dart';
import '../../../good_receipts/domain/entities/split_location_entity.dart';
import '../../../good_receipts/presentation/storage_location_bloc/storage_location_bloc.dart';
import '../../../stock_update/presentation/bloc/stock_update_add_page/stock_update_add_bloc.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../widgets/bottom_action_widget.dart';
import '../widgets/search_bar_section_widget.dart';
import '../widgets/storage_location_widget.dart';
import 'bagging_tagging_details_page.dart';

class ChooseStorageLocationPage extends StatefulWidget {
  const ChooseStorageLocationPage({super.key,required this.screenType});

  final String? screenType;

  @override
  State<ChooseStorageLocationPage> createState() =>
      _ChooseStorageLocationPageState();
}

class _ChooseStorageLocationPageState extends State<ChooseStorageLocationPage> {
  List<StorageLocationEntity> currentShelfSpaces = [];
  SplitLocationEntity? splitLocationEntity;
  StorageLocationEntity? selectedStorageLocationEntity;
  late StorageLocationBloc _storageLocationBloc;
  String isFromConsumption = '';

  @override
  void initState() {
    currentShelfSpaces = [];
    splitLocationEntity = null;
    selectedStorageLocationEntity = null;
    context.read<StorageLocationBloc>().add(
      FetchStorageLocationByParentIdEvent(0, null),
    );
    super.initState();
  }

  void navigateToStorageLocation(StorageLocationEntity storageLocation) {
    context.read<StorageLocationBloc>().add(
      NavigateToStorageLocationEvent(storageLocation),
    );
    setState(() {
      currentShelfSpaces = [];
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _storageLocationBloc = context.read<StorageLocationBloc>();
  }

  void openShelves(
    StorageLocationEntity storageLocation,
    List<StorageLocationEntity> childLocationList,
  ) {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentShelfSpaces = childLocationList;
      });
    });
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    // splitLocationEntity = extra?['splitLocationEntity'];
    isFromConsumption = extra?['screenType'];



    return BlocBuilder<StorageLocationBloc, StorageLocationState>(
      builder: (context, state) {
       /* if (state.isLoading) {
          // return CircularProgressIndicator();
        } else {*/
          return GradientBackground(
            child: Scaffold(
              backgroundColor: AppColor.colorTransparent,
              appBar: AppBar(
                leadingWidth: 60,
                titleSpacing: 0,
                title: Text(
                  context.loc.chooseStorageLocation,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize17,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.padding15,
                  vertical: AppPadding.padding15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        BreadCrumb(
                          divider: Icon(
                            Icons.chevron_right,
                            color: AppColor.colorTextBlack2,
                            size: AppSize.size25,
                          ),
                          items: getBreadCrumbItems(state.breadCrumbEntityList),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.size18),
                    Flexible(
                      child: Column(
                        children: [
                          SearchBarSection(
                            label: context.l.search,
                            hint: context.l.searchHint,
                            controller: searchController,
                            errorText: '',
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.padding15,
                                vertical: AppPadding.padding22,
                              ),
                              decoration: ShapeDecoration(
                                color:
                                    context.isDarkMode
                                        ? AppColor.colorDarkProfileContainer
                                        : AppColor.colorWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                      AppBorderRadius.borderRadius15,
                                    ),
                                    bottomRight: Radius.circular(
                                      AppBorderRadius.borderRadius15,
                                    ),
                                  ),
                                ),
                              ),
                              child:
                                  state.isLoading ||
                                          state
                                              .storageLocationViewListEntity
                                              .isNotEmpty
                                      ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        itemCount:
                                            state.isLoading
                                                ? 3
                                                : state
                                                    .storageLocationViewListEntity
                                                    .length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          if (state.isLoading) {
                                            return EquipmentLocationSearchPageShimmer();
                                          }
                                          return StorageLocationWidget(
                                            titleLabel:
                                                state
                                                    .storageLocationViewListEntity[index]
                                                    .locName,
                                            isSelected:
                                                selectedStorageLocationEntity
                                                    ?.id ==
                                                state
                                                    .storageLocationViewListEntity[index]
                                                    .id,
                                            onTap: () {
                                              selectedStorageLocationEntity =
                                                  state
                                                      .storageLocationViewListEntity[index];
                                              context.read<StorageLocationBloc>().add(
                                                FetchStorageLocationByParentIdEvent(
                                                  state
                                                      .storageLocationViewListEntity[index]
                                                      .id,
                                                  state
                                                      .storageLocationViewListEntity[index],
                                                ),
                                              );
                                              // Future.delayed(
                                              //   Duration(seconds: 2),
                                              //   () {
                                              currentShelfSpaces =
                                                  state
                                                      .storageLocationViewListEntity;
                                              // },
                                              // );
                                            },
                                          );
                                        },
                                      )
                                      : commonNoDataFoundTwo(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomActionWidget(
                onCancelTapCallback: handleCancelLocation,
                onSelectTapCallback: isFromConsumption == "consumption"?handleSelectLocationForConsumption:
                isFromConsumption == "stockUpdate" ?handleSelectLocationForStockUpdate:handleSelectLocation,
              ),
            ),
          );
        // }
      },
    );
  }

  List<BreadCrumbItem> getBreadCrumbItems(
    List<StorageLocationEntity> breadCrumbEntityList,
  ) {
    List<BreadCrumbItem> items = [];
    if (breadCrumbEntityList.isNotEmpty) {
      for (StorageLocationEntity storageLocation in breadCrumbEntityList) {
        items.add(
          BreadCrumbItem(
            content: GestureDetector(
              onTap: () {
                navigateToStorageLocation(storageLocation);
              },
              child: Text(
                storageLocation.locName,
                style: TextStyle(
                  color: AppColor.colorCommonTextColor,
                  fontSize: AppFontSize.fontSize14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.colorTextBlack3,
                  decorationThickness: 2,
                ),
              ),
            ),
          ),
        );
      }
    }
    return items;
  }

  void handleCancelLocation() {
    selectedStorageLocationEntity = null;
    _storageLocationBloc.add(FetchStorageLocationByParentIdEvent(0, null));
    context.pop();
  }

  void handleSelectLocation() {
    if (selectedStorageLocationEntity != null) {
      // splitLocationEntity?.locationId = selectedStorageLocationEntity!.id;
      // splitLocationEntity?.locationName = selectedStorageLocationEntity!.code;
      // context.read<GoodsReceiptSplitLocationBloc>().add(
      //   UpdateSplitLocationEntityWithSelectedLocationEvent(
      //     splitLocationEntity!,
      //   ),
      // );
      context.pop({
        "location_id": selectedStorageLocationEntity!.id,
        "location_name": selectedStorageLocationEntity!.code,
      });
    }
  }

  void handleSelectLocationForConsumption() {
    if (selectedStorageLocationEntity != null) {
      splitLocationEntity?.locationId = selectedStorageLocationEntity!.id;
      splitLocationEntity?.locationName = selectedStorageLocationEntity!.code;
      context.read<ConsumptionAddPageBloc>().add(
        UpdateSplitLocationEntityWithSelectedLocationConsumptionEvent(
          selectedStorageLocationEntity!.locName,
          selectedStorageLocationEntity!.id,
        ),
      );
    }
    _storageLocationBloc.add(FetchStorageLocationByParentIdEvent(0, null));
    context.pop();
  }

  void handleSelectLocationForStockUpdate() {
    if (selectedStorageLocationEntity != null) {
      splitLocationEntity?.locationId = selectedStorageLocationEntity!.id;
      splitLocationEntity?.locationName = selectedStorageLocationEntity!.code;
      context.read<StockUpdateAddBloc>().add(
        UpdateSplitLocationEntityWithSelectedLocationStockUpdateEvent(
          selectedStorageLocationEntity!.locName,
          selectedStorageLocationEntity!.id,
        ),
      );
    }
    _storageLocationBloc.add(FetchStorageLocationByParentIdEvent(0, null));
    context.pop();
  }

  @override
  void dispose() {
    _storageLocationBloc.add(ResetStorageLocationEvent());
    super.dispose();
  }
}
