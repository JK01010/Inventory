import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/theme/theme_bloc.dart';

extension ColorModeExtension on BuildContext {
  Color customThemeColor({required Color light, required Color dark}) {
    return Theme.of(this).brightness == Brightness.dark ? dark : light;
  }

  bool get isDarkMode => read<ThemeBloc>().state.themeMode == ThemeMode.dark;
}
