import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';


import '../../domin/entities/choose_items_list_entity_model_consumption.dart';
import '../bloc/consumption_add_page_bloc/consumption_add_page_bloc.dart';
import 'choose_item_search_consumption_widget.dart';
import 'item_selection_flat_button.dart';


Future consumptionItemSearchBottomSheet(BuildContext context) {
  TextEditingController searchController = TextEditingController();

  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.colorWhite,
    isScrollControlled: true,

    builder: (context) {
      return OrientationBuilder(
        builder: (context, orientation) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                // Filter heading
                Padding(
                  padding: const EdgeInsets.all(AppPadding.padding20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        context.l.chooseItem,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      BlocBuilder<ConsumptionAddPageBloc, ConsumptionAddPageState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              context.read<ConsumptionAddPageBloc>().add(
                                IsChooseItemSelectedEvent(
                                  index: -1,
                                  isSelectedValue: false,
                                  isClosed: true,
                                ),
                              );
                              context.pop();
                            },
                            child: SvgPicture.asset(
                              AppIcons.closeIcon,
                              height: AppSize.size29,
                              width: AppSize.size29,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),
                spaceNeed,

                //body section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.scaffoldPadding,
                      right: AppPadding.scaffoldPadding,
                      bottom: AppPadding.scaffoldPadding,
                    ),
                    child: Column(
                      children: [
                        //search section
                        BlocBuilder<ConsumptionAddPageBloc, ConsumptionAddPageState>(
                          builder: (context, state) {
                            return CustomTypeAheadFieldConsumption<ChooseItemsConEntity>(
                              label: context.l.search,
                              hint: context.l.searchHint,
                              controller: searchController,
                              errorText: '',
                            );
                          },
                        ),
                        SizedBox(height: 6),

                        //selection list
                        BlocBuilder<ConsumptionAddPageBloc, ConsumptionAddPageState>(
                          builder: (context, state) {
                            return Expanded(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: state.selectedChooseItems.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: ConsumptionFlatRadioCheckButton(
                                      index: index,
                                      text: state.selectedChooseItems[index].itemName,
                                      onPressed: () {},
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}




Widget spaceNeed = SizedBox(height: AppSize.size20);
Widget spaceNeed1 = SizedBox(height: AppSize.size10);
