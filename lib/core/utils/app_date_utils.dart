import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  ///Formats a [date] to 'dd-MMM-yyyy',eg 15-May-2025

  static String formatDateDdMMMyyyy({required DateTime date}) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static Future<DateTime?> appDatePicker({
    required BuildContext context,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime?initialDate,
  }) async {
    firstDate ??= DateTime(1900);
    lastDate ??= DateTime(2050);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: initialDate,
    );
    return pickedDate;
  }

  static DateTime parseDateFromString(String dateString) {
    final format = DateFormat('dd-MMM-yyyy');
    return format.parse(dateString);
  }

  static DateTime getDateTimeFromString(String dateString, String formatStr) {
    final format = DateFormat(formatStr);
    return format.parse(dateString);
  }

  static String getStringFromDateWithFormat(
    DateTime dateTime,
    String outputFormat,
  ) {
    return DateFormat(outputFormat).format(dateTime);
  }
}
