import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';

class CustomTypeAheadFieldLocation<T> extends StatelessWidget {

  const CustomTypeAheadFieldLocation({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.errorText,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsumptionItemUpdateBloc, ConsumptionItemUpdateState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) {
            return context.read<ConsumptionItemUpdateBloc>().add(LocationListSearchEvent(searchText:value));
          },
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.colorTextBlack2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.colorPrimary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.colorTextBlack2),
            ),
            suffixIcon:  Padding(
              padding: const EdgeInsets.only(right: AppPadding.padding5),
              child: SvgPicture.asset(
                AppIcons.greySearchIcon,
                height: AppSize.size35,
                width: AppSize.size35,
              ),
            ),
          ),
        );
      },
    );
  }
}
