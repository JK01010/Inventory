import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/theme_extension.dart';

class DropDownModelValue {
  static const List<DropdownMenuItem<String>> data = [
    DropdownMenuItem(value: "1", child: Text("1")),
    DropdownMenuItem(value: "2", child: Text("2")),
    DropdownMenuItem(value: "3", child: Text("3")),
    DropdownMenuItem(value: "4", child: Text("4")),
    DropdownMenuItem(value: "5", child: Text("5")),
    DropdownMenuItem(value: "6", child: Text("6")),
    DropdownMenuItem(value: "7", child: Text("7")),
    DropdownMenuItem(value: "8", child: Text("8")),
    DropdownMenuItem(value: "9", child: Text("9")),
    DropdownMenuItem(value: "10", child: Text("10")),
    DropdownMenuItem(value: "11", child: Text("11")),
    DropdownMenuItem(value: "12", child: Text("12")),
  ];
}

class AppDropDownWidget<T> extends StatelessWidget {
  const AppDropDownWidget({
    super.key,
    this.hintText,
    this.validator,
    this.items,
    this.onChanged,
    this.onSaved,
    required this.labelText,
    this.selectedValue,
    this.fillColor,
    this.filled,
  });

  final String? hintText;
  final String? Function(T?)? validator;
  final String labelText;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final T? selectedValue;
  final Color? fillColor;
  final bool? filled;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return DropdownButtonFormField2<T>(
      isExpanded: true,
      alignment: Alignment.center,

      //style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        hintMaxLines: 1,
        contentPadding: const EdgeInsets.only(left: AppPadding.padding15),
        labelText: labelText,
        labelStyle: textTheme.titleLarge,
        hintText: hintText,
        hintStyle: Theme.of(
          context,
        ).inputDecorationTheme.hintStyle?.copyWith(color: AppColor.colorBlack2),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor:
            ((context.isDarkMode)
                ? fillColor ?? AppColor.darkFillColor
                : fillColor ?? AppColor.lightFillColor),
        filled: filled,
      ),
      items: items,
      value: selectedValue,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      buttonStyleData: const ButtonStyleData(height: AppSize.size48),

      iconStyleData: IconStyleData(
        icon: Padding(
          padding: EdgeInsets.only(right: AppPadding.padding20),
          child: Icon(
            Icons.keyboard_arrow_down,
            color:
                context.isDarkMode
                    ? AppColor.colorDividerLight
                    : AppColor.colorBlack2,
          ),
        ),
        iconSize: AppIconSize.size20,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
        ),
      ),
    );
  }
}
