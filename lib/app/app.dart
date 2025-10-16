import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kdcreader/kdcreader.dart';

import '../core/constants/constant.dart';
import '../core/routes/app_routes.dart';
import '../core/theme/theme/app_theme.dart';
import '../features/theme/theme_bloc.dart';
import '../l10n/app_localizations.dart';

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key});

  @override
  Widget build(BuildContext context) {



    final ThemeMode themeMode = context.select<ThemeBloc, ThemeMode>(
      (ThemeBloc bloc) => bloc.state.themeMode,
    );
    return MaterialApp.router(
      title: AppConstant.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
      ],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
