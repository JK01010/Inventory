import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../l10n/app_localizations_en.dart';


extension BuildContextHelper on BuildContext {
  AppLocalizations get l {
    return AppLocalizations.of(this) ?? AppLocalizationsEn();
  }
}
