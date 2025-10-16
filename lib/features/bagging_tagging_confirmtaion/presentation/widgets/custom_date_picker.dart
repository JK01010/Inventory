import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';


Widget customDatePicker(
    {required BuildContext context,
      required String labelText,
      required void Function()? onTap,
      required TextEditingController? textEditingController,
      bool datePickerIsBig = false}) {

  return SizedBox(
    width:datePickerIsBig? MediaQuery.of(context).size.width: MediaQuery.of(context).size.width * 0.42,
    child: TextFormField(
      minLines: 1,
      // cursorColor: AppTheme.colorprimary,
      textAlign: TextAlign.start,
      maxLines: 1,
      onTap: onTap,
      readOnly: true,style: TextStyle( fontFamily: 'MaerskText'),
      decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          labelText: labelText,
          enabled: true,
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: AppColor.colorTextBlack2,
            size: 20,
          ),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.colorPrimary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.colorTextBlack2, width: 1),
        ),),
      controller: textEditingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
      },
      validator: (value) {},
    ),
  );
}

//CommonFunction
DateTime? commonDatePicker(
    {required BuildContext context,
      required DateTime firstDate,
      required DateTime lastDate}) {
  showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary:  AppColor.colorPrimary,
              onPrimary:AppColor.colorWhite,
              onSurface:  AppColor.colorBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      });
  return null;
}