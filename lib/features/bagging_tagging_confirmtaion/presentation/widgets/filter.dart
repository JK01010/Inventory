import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';


import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/dropdown_model.dart';
import '../bloc/bagging_tagging_listing/bagging_tagging_list_bloc.dart';
import 'custom_button.dart';
import 'custom_date_picker.dart';
import 'custom_dropdown.dart';
import 'custom_typeahead.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}

class BagTagFilterBottomSheet extends StatelessWidget {
  BagTagFilterBottomSheet({super.key});

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  String? selectedCategory;
  String? selectedPort;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppPadding.padding15,
            right: AppPadding.padding15,
            top: AppPadding.padding20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.loc.filter,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      // color: AppColor.colorBlack,
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      context.isDarkMode
                          ? AppIcons.closeDarkIcon
                          : AppIcons.closeIcon,
                      semanticsLabel: 'Scanner Icon',
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    color: Colors.black,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: AppSize.size10),
              Divider(height: 1),
              SizedBox(height: AppSize.size20),
              CustomTypeAheadField<DropDownModel>(
                label: context.loc.search,
                hint: context.loc.searchHint,
                controller: _searchController,
                errorText: '',
                suggestionsCallback: (pattern) {
                  return context.read<BaggingTaggingListBloc>().getSuggestions(
                    pattern,
                  );
                },
                displayStringForOption: (suggestion) => suggestion.title,
                onSelected: (suggestion) {
                  _searchController.text = suggestion.title;
                },
              ),
              dropDown(
                labelText: context.loc.category,
                hintText: context.loc.categoryHint,
                items: categoryList,
                value: null,
                context: context,
                onChanged: (value) {},
              ),
              SizedBox(height: AppSize.size10),
              dropDown(
                labelText: context.loc.deliveryPort,
                hintText: context.loc.deliveryPortHint,
                items: portsList,
                value: null,
                context: context,
                onChanged: (value) {},
              ),
              SizedBox(height: AppSize.size10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customDatePicker(
                    context: context,
                    labelText: context.loc.grnDateFrom,
                    onTap: () {
                      commonDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                    },
                    textEditingController: _fromDateController,
                  ),
                  customDatePicker(
                    context: context,
                    labelText: context.loc.grnDateTo,
                    onTap: () {
                      commonDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                    },
                    textEditingController: _toDateController,
                  ),
                ],
              ),
              SizedBox(height: AppSize.size16),
            ],
          ),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(color: AppColor.colorBackground),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                buttonName: context.loc.cancelButtonText,
                color: AppColor.colorWhite,
                buttonNameColor: AppColor.colorPrimary,
                onTap: () {},
              ),
              CustomButton(
                buttonName: context.loc.applyButtonText,
                color: AppColor.colorPrimary,
                buttonNameColor: AppColor.colorWhite,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final List<DropDownModel> portsList = [
  DropDownModel(id: 1, title: 'Port A'),
  DropDownModel(id: 2, title: 'Port B'),
  DropDownModel(id: 3, title: 'Port C'),
];

final List<DropDownModel> categoryList = [
  DropDownModel(id: 1, title: 'Medicine'),
  DropDownModel(id: 2, title: 'Equipment'),
  DropDownModel(id: 3, title: 'Consumables'),
];
