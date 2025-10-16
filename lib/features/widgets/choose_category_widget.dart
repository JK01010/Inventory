import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_size.dart';

class ChooseCategoryWidget extends StatelessWidget {
  ChooseCategoryWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.suffixIcon,
    required this.suffixIconBoxConstraints,
    this.controller,
    this.onTap,
  });

  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconBoxConstraints;
  final TextEditingController? controller;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TextField(
      readOnly: true,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: textTheme.titleMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconBoxConstraints,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
