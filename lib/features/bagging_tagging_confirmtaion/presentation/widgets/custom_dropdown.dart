import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/dropdown_model.dart';

Widget dropDown({
  required String? labelText,
  required String? hintText,
  String? errorText,
  required List<DropDownModel> items,
  required int? value,
  required BuildContext context,
  void Function(int?)? onChanged,
}) {
  final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: DropdownButtonFormField2(
      iconStyleData: IconStyleData(
        icon: SvgPicture.asset(AppIcons.dropDownArrow),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.colorWhite,
        ),
      ),
      isExpanded: true,
      // borderRadius: BorderRadius.circular(20),
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColor.colorBlack2,
        fontSize: 15,
      ),
      hint: Text(hintText ?? "Select Any",style: inputDecorationTheme.hintStyle),
      value: value,
      items:
          items.map<DropdownMenuItem<int>>((dynamic items) {
            return DropdownMenuItem(
              value: items.vesselStructureId,
              child: Text(items.title.toString()),
            );
          }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        labelText: labelText,
        hintStyle: inputDecorationTheme.hintStyle,
        labelStyle: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: AppColor.colorTextBlack2),
        border: inputDecorationTheme.border,
        enabledBorder: inputDecorationTheme.enabledBorder,
        focusedBorder: inputDecorationTheme.focusedBorder,
        errorText: errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    ),
  );
}
