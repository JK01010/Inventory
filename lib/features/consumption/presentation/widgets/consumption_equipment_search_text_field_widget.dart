
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';

class ConsumptionAppSearchWidget<T> extends StatelessWidget {
  const ConsumptionAppSearchWidget({
    super.key,
    this.hintText,
    this.validator,
    this.items,
    this.onChanged,
    this.onSaved,
    required this.labelText,
    this.selectedValue,
  });
  final String? hintText;
  final String? Function(T?)? validator;
  final String labelText;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      hint: Text(hintText??"",textAlign: TextAlign.left),
      decoration: InputDecoration(
        isDense: true,
        hintMaxLines: 1,
        contentPadding: const EdgeInsets.only(left: AppPadding.padding15),
        labelText: labelText,
        labelStyle: Theme.of(
          context,
        ).inputDecorationTheme.hintStyle?.copyWith(color: AppColor.colorBlack2),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      items: items,
      value: selectedValue,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      buttonStyleData: const ButtonStyleData(height: AppSize.size48),
      iconStyleData: IconStyleData(
        icon: Padding(
          padding: const EdgeInsets.only(right: AppPadding.padding5),
          child: SvgPicture.asset(
            AppIcons.greySearchIcon,
            height: AppSize.size35,
            width: AppSize.size35,
          ),
        ),
        // iconSize: AppIconSize.size20,
      ),
    );
  }
}
