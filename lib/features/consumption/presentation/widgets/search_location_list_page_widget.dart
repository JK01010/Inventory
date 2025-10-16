import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../domin/entities/consumption_location_entity.dart';
import '../bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import 'equipment_location_search_page_shimmer.dart';
import 'location_list.dart';

class SearchLocationListPageWidget extends StatefulWidget {
  const SearchLocationListPageWidget({super.key});

  @override
  State<SearchLocationListPageWidget> createState() =>
      _SearchLocationListPageWidgetState();
}

class _SearchLocationListPageWidgetState
    extends State<SearchLocationListPageWidget> {
  final TextEditingController searchController = TextEditingController();

  ConsumptionLocationEntity? selectedItem;

  String currentParentId = "0";
  List<ConsumptionLocationEntity> parentStack = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.padding15,
        vertical: AppPadding.padding15,
      ),
      child: BlocBuilder<ConsumptionItemUpdateBloc, ConsumptionItemUpdateState>(
        builder: (context, state) {
          return AppDecoratedBoxShadowWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Breadcrumb at the top using package
                if (state.locationBreadCrumbList.isNotEmpty)
                  Visibility(
                    visible: state.locationBreadCrumbList.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: BreadCrumb(
                        items:
                            state.locationBreadCrumbList.map((item) {
                              return BreadCrumbItem(
                                content: Text(
                                  item.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {
                                  context.read<ConsumptionItemUpdateBloc>().add(
                                    LocationSelectedEvent(currentItem: item),
                                  );
                                },
                              );
                            }).toList(),
                        divider: Icon(
                          Icons.chevron_right,
                          color: context.customThemeColor(
                            light: AppColor.colorBlack,
                            dark: AppColor.colorWhite,
                          ),
                          size: AppSize.size25,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: AppSize.size18),

                ///search section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AppTextFormField(
                    filled: true,
                    labelText: context.l.search,
                    hintText: context.l.searchHint,
                    controller: searchController,
                  ),
                ),

                /// Equipment List
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.padding15,
                      vertical: AppPadding.padding22,
                    ),
                    child:
                        state.isLoading || state.locationListEntity.isNotEmpty
                            ? ListView.builder(
                              itemCount:
                                  state.isLoading
                                      ? 3
                                      : state.locationListEntity.length,
                              itemBuilder: (context, index) {
                                //hasChildren check (no need of left arrow)
                                final hasChildren = state.allLocationEntity.any(
                                  (e) =>
                                      e.parentId ==
                                      state.locationListEntity[index].id,
                                );
                                if (state.isLoading) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppPadding.padding8,
                                    ),
                                    child: EquipmentLocationSearchPageShimmer(),
                                  );
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.padding8,
                                  ),
                                  child: LocationList(
                                    locationEntity:
                                        state.locationListEntity[index],
                                    showArrow: hasChildren,
                                    index: index,
                                    onTap: () {
                                      context
                                          .read<ConsumptionItemUpdateBloc>()
                                          .add(
                                            LocationSelectedEvent(
                                              currentItem:
                                                  state
                                                      .locationListEntity[index],
                                            ),
                                          );
                                    },
                                  ),
                                );
                              },
                            )
                            : commonNoDataFoundTwo(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
