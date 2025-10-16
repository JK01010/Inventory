import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import '../../../../core/constants/app_colors.dart';


class CustomButton extends StatelessWidget {
  final String buttonName;
  final Color? buttonNameColor;
  final Color? color;
  final bool isButtonLarge;
  final void Function() onTap;

  const CustomButton({super.key,
    required this.buttonName,
    this.buttonNameColor = AppColor.colorPrimary,
    this.color = AppColor.colorPrimary,
    this.isButtonLarge = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      /*splashColor: Colors.blue.withAlpha(0.3),
      highlightColor: Colors.blue.withOpacity(0.1),*/
      borderRadius: BorderRadius.circular(12),
      child: Container(
          width: isButtonLarge
              ? MediaQuery.of(context).size.width * 0.8
              : MediaQuery.of(context).size.width * 0.4,
          height: AppSize.size45,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.colorButtonBorderColor2, width: 1.5)),
          child: Center(
              child: CustomText(
                text: buttonName,
                color: buttonNameColor,
              ))),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? weight;
  final Color? color;
  final double? fontSize;

  const CustomText({
    required this.text,
    this.weight ,
    this.color,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: color,
        ),
      ),
    );
  }
}