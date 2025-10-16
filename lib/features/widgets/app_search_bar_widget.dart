import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/theme_extension.dart';

class AppSearchBarSampleData {
  static final List<String> data = ["1", "2", "3", "4", "5"];
}

class AppSearchBar<T> extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.items,
    required this.itemToString,
    this.onSelected,
    this.suffixIcon,
    this.suffixIconBoxConstraints,
    this.direction,
    this.onChanged,
    this.fillColor,
    this.filled,
    required this.suggestionsCallback,
  });

  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final List<T>? items;
  final String Function(T) itemToString;
  final void Function(T)? onSelected;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconBoxConstraints;
  final VerticalDirection? direction;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final bool? filled;
  final Future<List<T>?> Function(String) suggestionsCallback;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TypeAheadField<T>(
      direction: direction,
      controller: controller,
      decorationBuilder: (context, child) {
        return Material(
          color:
              context.isDarkMode
                  ? AppColor.colorBGBlackEnd
                  : AppColor.colorBackground,
          elevation: 2,
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.borderRadius12),
          ),
          child: child,
        );
      },

      suggestionsCallback: suggestionsCallback,
      builder: (context, textEditingController, focusNode) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: onChanged,
          style: textTheme.titleMedium,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            contentPadding: EdgeInsets.all(14.0),
            labelStyle: textTheme.titleLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppBorderRadius.borderRadius12,
              ),
            ),
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconBoxConstraints,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor:
                ((context.isDarkMode)
                    ? fillColor ?? AppColor.darkFillColor
                    : fillColor ?? AppColor.lightFillColor),
            filled: filled,
          ),
        );
      },
      itemBuilder: (context, suggestion) {
        return Padding(
          padding: const EdgeInsets.all(AppPadding.padding4),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: context.customThemeColor(
                  dark: AppColor.colorDividerLight,
                  light: AppColor.colorTextBlack2,
                ),
              ),
              SizedBox(width: AppSize.size6),
              Text(
                itemToString(suggestion),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.fontSize14,
                ),
              ),
            ],
          ),
        );
      },
      onSelected: onSelected ?? (_) {},
    );
  }
}
