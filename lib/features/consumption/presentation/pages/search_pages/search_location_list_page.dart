import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../widgets/app_two_row_button_widget.dart';
import '../../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';
import '../../widgets/search_location_list_page_widget.dart';

class SearchLocationListPage extends StatefulWidget {
  const SearchLocationListPage({super.key, required this.selectedItemIndex});

  final int selectedItemIndex;

  @override
  State<SearchLocationListPage> createState() => _SearchLocationListPageState();
}

class _SearchLocationListPageState extends State<SearchLocationListPage> {
  List<String> selectedBreadcrumb = [];

  @override
  void initState() {
    super.initState();
    context.read<ConsumptionItemUpdateBloc>().add(
      LocationListGetAllDataEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l.searchLocation,
          onBack: () {
            context.read<ConsumptionItemUpdateBloc>().add(
              LocationDataResetEvent(),
            );
            context.pop();
          },
        ),
        body: SearchLocationListPageWidget(),
        bottomNavigationBar:
            BlocBuilder<ConsumptionItemUpdateBloc, ConsumptionItemUpdateState>(
              builder: (context, state) {
                return AppTwoRowButtonWidget(
                  buttonSecondTitle: context.l.select,
                  buttonSecondOnPress: () {
                    if (state.locationSaveEnabled) {
                      context.read<ConsumptionItemUpdateBloc>().add(
                        SelectedLocationFromListEvent(
                          selectedItemIndex: widget.selectedItemIndex,
                        ),
                      );

                      context.read<ConsumptionItemUpdateBloc>().add(
                        LocationDataResetEvent(),
                      );
                      context.pop();
                      showSuccessPopup(context.l.selectedLocation, context);
                    } else {
                      showSuccessPopup(context.l.selectItem, context);
                    }
                  },
                  buttonFirstTitle: context.l.cancel,
                  buttonFirstOnPress: () {
                    context.read<ConsumptionItemUpdateBloc>().add(
                      LocationDataResetEvent(),
                    );
                    context.pop();
                  },
                );
              },
            ),
      ),
    );
  }
}
