import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../common_feature/domain/entities/equipment_list_entity.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import '../widgets/equipment_list.dart';
import 'equipment_location_search_page_shimmer.dart';

class SearchEquipmentListPageWidget extends StatefulWidget {
  const SearchEquipmentListPageWidget({super.key});

  @override
  State<SearchEquipmentListPageWidget> createState() =>
      _SearchEquipmentListPageWidgetState();
}

class _SearchEquipmentListPageWidgetState
    extends State<SearchEquipmentListPageWidget> {
  final TextEditingController searchController = TextEditingController();

  EquipmentListEntity? selectedItem;

  String currentParentId = "0";
  List<EquipmentListEntity> parentStack = [];

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
                if (state.breadCrumbList.isNotEmpty)
                  Visibility(
                    visible: state.breadCrumbList.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: BreadCrumb(
                        items:
                            state.breadCrumbList.map((item) {
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
                                    EquipmentSelectedEvent(currentItem: item),
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
                        state.isLoading || state.equipmentListEntity.isNotEmpty
                            ? ListView.builder(
                              itemCount:
                                  state.isLoading
                                      ? 3
                                      : state.equipmentListEntity.length,
                              itemBuilder: (context, index) {
                                //hasChildren check (no need of left arrow)
                                final hasChildren = state.allEquipmentListEntity
                                    .any(
                                      (e) =>
                                          e.parentId ==
                                          state.equipmentListEntity[index].id,
                                    );

                                if (state.isLoading) {
                                  return EquipmentLocationSearchPageShimmer();
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.padding8,
                                  ),
                                  child: EquipmentList(
                                    equipmentEntity: state.equipmentListEntity[index],
                                    showArrow: hasChildren,
                                    index: index,
                                    // highlight if this is the selected one
                                    onTap: () {
                                      log("item tapped --- ${state.equipmentListEntity[index]}");

                                      context
                                          .read<ConsumptionItemUpdateBloc>()
                                          .add(
                                            EquipmentSelectedEvent(
                                              currentItem:
                                                  state
                                                      .equipmentListEntity[index],
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
