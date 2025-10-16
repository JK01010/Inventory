import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/extensions/theme_extension.dart';

Widget dropDownPageNavigator({
  required String? labelText,
  required String? hintText,
  String? errorText,
  TextEditingController? controller,
  // required List<DropDownModel> items,
  required int? value,
  required BuildContext context,
  required VoidCallback onPressed, // Changed from onChanged to onPressed
  final Color? fillColor,
  final bool? filled,
}) {
  final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
  final TextTheme textTheme = Theme.of(context).textTheme;
  // final selectedItem = items.firstWhere((item) => item.id == value, orElse: () => items.first);

  return InkWell(
    onTap: onPressed,
    child: InputDecorator(
      decoration: InputDecoration(
        contentPadding: inputDecorationTheme.contentPadding,
        labelText: labelText,
        labelStyle: textTheme.titleMedium,

        filled: filled,
        fillColor:
            ((context.isDarkMode)
                ? fillColor ?? AppColor.darkFillColor
                : fillColor ?? AppColor.lightFillColor),
        hintText: hintText ?? "Select Any",
        hintStyle: inputDecorationTheme.hintStyle,
        border: inputDecorationTheme.border,
        enabledBorder: inputDecorationTheme.enabledBorder,
        focusedBorder: inputDecorationTheme.focusedBorder,
        errorText: errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SvgPicture.asset(AppIcons.dropDownArrow),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 5),
          Text(
              controller?.text != null && controller!.text.trim() != "" ? controller.text : hintText!,
            style:  controller?.text != null && controller?.text.trim() != "" ?Theme.of(context).textTheme.titleLarge:Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColor.colorBlack3,
              fontSize: 15,
            )
          ),
        ],
      ),
    ),
  );
}
