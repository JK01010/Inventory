import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/theme_extension.dart';

class CustomTypeAheadFieldBottomSheet extends StatelessWidget {
  const CustomTypeAheadFieldBottomSheet({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.errorText,
    this.onTap, // New: Add onTap for navigation
    this.suffixIcon = const Icon(Icons.search, color: AppColor.colorBlack2),
    this.fillColor,
    this.filled, // Customizable suffix
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? errorText;
  final VoidCallback? onTap; // Navigation callback
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool? filled;

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap ?? () {},
      child: IgnorePointer(
        // Disable text field interaction (acts as a button)
        child: TextField(
          controller: controller,
          cursorColor: Colors.transparent, // Hide cursor
          readOnly: true, // Prevent keyboard
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: inputDecorationTheme.hintStyle,
            labelStyle: textTheme.titleMedium,
            contentPadding: inputDecorationTheme.contentPadding,
            border: inputDecorationTheme.border,
            errorText: errorText,
            enabledBorder: inputDecorationTheme.enabledBorder,
            focusedBorder: inputDecorationTheme.focusedBorder,
            suffixIcon: suffixIcon,
            filled: filled,
            fillColor:
                ((context.isDarkMode)
                    ? fillColor ?? AppColor.darkFillColor
                    : fillColor ?? AppColor.lightFillColor),
          ),
        ),
      ),
    );
  }
}
