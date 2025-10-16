import 'package:flutter/material.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../l10n/app_localizations.dart';

class NameWidget extends StatelessWidget {
  const NameWidget(this.userName, {super.key});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppLocalizations.of(context)?.hi ?? "",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.normal),
          ),
          WidgetSpan(child: SizedBox(width: AppSize.size6)),
          TextSpan(
            text: userName.isNotEmpty ? userName : "Mari Apps",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
