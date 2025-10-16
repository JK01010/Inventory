import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../core/constants/app_colors.dart';

class CustomTypeAheadField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final Future<List<T>> Function(String) suggestionsCallback;
  final String Function(T) displayStringForOption;
  final void Function(T) onSelected;
  final TextEditingController controller;
  final String? errorText;

  const CustomTypeAheadField({
    Key? key,
    required this.label,
    required this.hint,
    required this.suggestionsCallback,
    required this.displayStringForOption,
    required this.onSelected,
    required this.controller,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      builder: (context, textController, focusNode) {
        return TextField(
          controller: textController,
          focusNode: focusNode,
          cursorColor: Colors.blue,
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
            errorText: errorText,
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(12),
            //   borderSide: const BorderSide(color: Colors.red, width: 1),
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.colorPrimary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.colorTextBlack2, width: 1),
            ),
            suffixIcon: Icon(Icons.search, color: AppColor.colorTextBlack2),
          ),
        );
      },controller: controller,
      suggestionsCallback: suggestionsCallback,
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(displayStringForOption(suggestion)),
        );
      },
      onSelected: onSelected,
      decorationBuilder: (context, child) {
        return Material(
          borderRadius: BorderRadius.circular(8.0),
          elevation: 4.0,
          child: child,
        );
      },
      loadingBuilder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
