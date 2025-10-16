import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/theme_extension.dart';

class CommonAppSearchWidget extends StatelessWidget {
  const CommonAppSearchWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.suffixIconBoxConstraints,
    this.prefixIcon,
    this.onChanged,
  });

  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxConstraints? suffixIconBoxConstraints;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius30),
          borderSide: BorderSide(color: AppColor.colorTransparent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius30),
          borderSide: BorderSide(color: AppColor.colorTransparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius30),
          borderSide: BorderSide(color: AppColor.colorTransparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius30),
          borderSide: BorderSide(color: AppColor.colorTransparent),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
        labelStyle: textTheme.titleMedium,
        fillColor:
            context.isDarkMode
                ? AppColor.colorDarkProfileContainer
                : AppColor.colorWhite,
        filled: true,
      ),
      onChanged: onChanged,
    );
  }
}
