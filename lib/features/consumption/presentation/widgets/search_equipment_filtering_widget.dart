import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';

class SearchEquipmentFilteringWidget<T> extends StatelessWidget {

  const SearchEquipmentFilteringWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.suggestionsCallback,
    required this.displayStringForOption,
    required this.onSelected,
    required this.controller,
    this.errorText, required this.onChanged,
  });

  final String label;
  final String hint;
  final Future<List<T>> Function(String) suggestionsCallback;
  final String Function(T) displayStringForOption;
  final void Function(T) onSelected;
  final TextEditingController controller;
  final String? errorText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            left: AppPadding.padding15,
            right: AppPadding.padding15,
            top: AppPadding.padding22,
          ),
          decoration: ShapeDecoration(
            color: AppColor.colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppBorderRadius.borderRadius15),
                topRight: Radius.circular(AppBorderRadius.borderRadius15),
              ),
            ),
          ),
          child: TextFormField(

            onChanged: onChanged,

            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColor.colorTextBlack3),
              labelStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColor.colorTextBlack2),
              suffixIcon: Icon(Icons.search, color: AppColor.colorTextBlack2),
            ),
          ),
        );
  }
}


