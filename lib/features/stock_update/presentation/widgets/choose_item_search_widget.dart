import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/stock_update_add_page/stock_update_add_bloc.dart';

class CustomTypeAheadFieldStockUpdate<T> extends StatelessWidget {

  const CustomTypeAheadFieldStockUpdate({
    super.key,
    required this.label,
    required this.hint,
    required this.suggestionsCallback,
    required this.displayStringForOption,
    required this.onSelected,
    required this.controller,
    this.errorText,
  });

  final String label;
  final String hint;
  final Future<List<T>> Function(String) suggestionsCallback;
  final String Function(T) displayStringForOption;
  final void Function(T) onSelected;
  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockUpdateAddBloc, StockUpdateAddState>(
     builder: (context, state) {
    return TextFormField(

      onChanged: (value) {
      return context.read<StockUpdateAddBloc>().add(ChooseItemListSearchEvent(searchText:value));

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
        suffixIcon: Icon(Icons.search, color: AppColor.colorTextBlack2),
      ),
    );
  },
);
  }
}
