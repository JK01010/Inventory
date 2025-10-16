import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/extensions/theme_extension.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
    this.labelText,
    this.maxLine,
    this.suffixIconConstraints,
    this.fillColor,
    this.filled,
    this.initialValue,
    this.onTap,
    this.readOnly = false,
    this.hintStyle,
    this.style,
    this.labelStyle,
    this.errorText,
  });
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool enabled;
  final String? labelText;
  final int? maxLine;
  final BoxConstraints? suffixIconConstraints;
  final Color? fillColor;
  final bool? filled;
  final String? initialValue;
  final Function()? onTap;
  final bool readOnly;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final String? errorText;

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
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      enabled: enabled,
      onTap: onTap,
      initialValue: initialValue,
      readOnly: readOnly,
      onTapOutside: (event) {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: InputDecoration(
        errorText: errorText,
        hintText: hintText,
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
      style: style,
    );
  }
}
