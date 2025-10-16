import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/extensions/theme_extension.dart';

class AppTextFormFieldNonEditable extends StatelessWidget {
  const AppTextFormFieldNonEditable({
    super.key,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.enabled = true,
    this.labelText,
    this.maxLine,
    this.suffixIconConstraints,
    this.fillColor,
    this.filled,
    this.initialValue,
  });

  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool enabled;
  final String? labelText;
  final int? maxLine;
  final BoxConstraints? suffixIconConstraints;
  final Color? fillColor;
  final bool? filled;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLine,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      enabled: enabled,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: "",
        labelText: labelText,
        labelStyle: textTheme.titleLarge,
        hintStyle: inputDecorationTheme.hintStyle,
        contentPadding: inputDecorationTheme.contentPadding,
        border: inputDecorationTheme.border,
        enabledBorder: inputDecorationTheme.enabledBorder,
        focusedBorder: inputDecorationTheme.focusedBorder,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        fillColor:
            ((context.isDarkMode)
                ? fillColor ?? AppColor.darkFillColor
                : fillColor ?? AppColor.lightFillColor),
        filled: filled,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: inputDecorationTheme.hintStyle,
    );
  }
}
