import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class DashboardHeading extends StatelessWidget {
  const DashboardHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.dashBoard,
      style: Theme.of(
        context,
      ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
    );
  }
}
