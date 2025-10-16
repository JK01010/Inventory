import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service/other_service/shared_preferences_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeMode.light)) {
    on<ToggleThemeEvent>(_onToggleTheme);
    _loadInitialTheme(); // Load persisted theme
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeState(event.themeMode));
    await AppPreferences.setDarkMode(event.themeMode == ThemeMode.dark);
  }

  void _loadInitialTheme() async {
    final isDark = await AppPreferences.isDarkMode();
    final mode = isDark ? ThemeMode.dark : ThemeMode.light;
    add(ToggleThemeEvent(mode));
  }
}
