import 'package:flutter/material.dart';

extension ThemeContextHelper on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }
}
