import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/theme_extension.dart';

class AppTextFormFieldWithButtonWidget extends StatelessWidget {
  const AppTextFormFieldWithButtonWidget({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.enabled = true,
    this.labelText,
    this.maxLine,
    this.borderRadius,
    this.fixedHeight,
    this.fillColor,
    this.filled,
    this.onTap,
    this.buttonWidget,
    this.readOnly = false,
    this.onTextFieldTap
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool enabled;
  final String? labelText;
  final int? maxLine;
  final BorderRadius? borderRadius;
  final double? fixedHeight;
  final Color? fillColor;
  final bool? filled;
  final void Function()? onTap;
  final Widget? buttonWidget;
  final bool readOnly;

  final void Function()? onTextFieldTap;


  OutlineInputBorder? _updateBorder(InputBorder? inputBorder) {
    if (inputBorder is OutlineInputBorder) {
      return inputBorder.copyWith(
        borderRadius:
            borderRadius != null
                ? const BorderRadius.only(
                  topLeft: Radius.circular(AppBorderRadius.borderRadius12),
                  bottomLeft: Radius.circular(AppBorderRadius.borderRadius12),
                )
                : null,
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              obscureText: obscureText,
              maxLines: maxLine,
              validator: validator,
              onTap: onTextFieldTap,
              keyboardType: keyboardType,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: onChanged,
              enabled: enabled,
              decoration: InputDecoration(
                hintText: hintText,
                labelText: labelText,
                labelStyle: textTheme.titleMedium,
                hintStyle: inputDecorationTheme.hintStyle,
                contentPadding: inputDecorationTheme.contentPadding,

                border: _updateBorder(inputDecorationTheme.border),
                enabledBorder: _updateBorder(
                  inputDecorationTheme.enabledBorder,
                ),
                focusedBorder: _updateBorder(
                  inputDecorationTheme.focusedBorder,
                ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                fillColor:
                    ((context.isDarkMode)
                        ? fillColor ?? AppColor.darkFillColor
                        : fillColor ?? AppColor.lightFillColor),
                filled: filled,
              ),
              style: textTheme.titleMedium,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: AppSize.size48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color:
                      filled == true
                          ? ((context.isDarkMode)
                              ? fillColor ?? AppColor.darkFillColor
                              : fillColor ?? AppColor.lightFillColor)
                          : AppColor.colorTransparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                      AppBorderRadius.borderRadius15,
                    ),
                    topRight: Radius.circular(AppBorderRadius.borderRadius15),
                  ),

                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color:
                          context.isDarkMode
                              ? AppColor.createLabelBorderDarkColor
                              : AppColor.colorBlack3,
                    ),
                    right: BorderSide(
                      color:
                          context.isDarkMode
                              ? AppColor.createLabelBorderDarkColor
                              : AppColor.colorBlack3,
                    ),
                    top: BorderSide(
                      color:
                          context.isDarkMode
                              ? AppColor.createLabelBorderDarkColor
                              : AppColor.colorBlack3,
                    ),
                  ),
                ),
                child: Center(child: buttonWidget),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
