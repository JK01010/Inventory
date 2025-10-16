import 'package:flutter/material.dart';

import '../constants/app_size.dart';

extension NavigationModeExtension on BuildContext {
  /// Returns true only when the bottom system bar (like in 3-button nav) is large enough.
  /// This avoids false positives in gesture navigation mode with the thin gesture pill.
  bool get isButtonNavigationMode =>
      MediaQuery.of(this).padding.bottom >= AppPadding.padding25;
}
