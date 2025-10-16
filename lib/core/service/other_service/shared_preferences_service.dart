import 'package:encrypt_shared_preferences/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constant.dart';

class AppPreferences {
  static SharedPreferences? _prefs;
  static const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  static Future<void> initPreference() async {
    await EncryptedSharedPreferences.initialize("bWJ3za7QJwUnNngD");
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    initPreference();
  }

  /// Theme
  static Future<void> setDarkMode(bool isDark) async {
    await _prefs?.setBool(AppConstant.isDarkTheme, isDark);
  }

  static bool isDarkMode() {
    return _prefs?.getBool(AppConstant.isDarkTheme) ?? false;
  }
}
