import 'package:flutter/material.dart';

import '../di/service_locator.dart';
import '../service/other_service/shared_preferences_service.dart';

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppPreferences.init();
    await initializeServiceLocator();

    // Add other initializations here (DI, Firebase,)
  }
}
