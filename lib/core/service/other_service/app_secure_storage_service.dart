import 'package:encrypt_shared_preferences/provider.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AppSecureStorageService {
  Future<Unit> write({required String key, required String value});

  Future<String?> read({required String key});

  Future<Unit> delete({required String key});

  Future<Unit> deleteAll();
}

class AppSecureStorageServiceImpl implements AppSecureStorageService {
  AppSecureStorageServiceImpl({
    required EncryptedSharedPreferences encryptedSharedPreferences,
  }) : _encryptedSharedPreferences = encryptedSharedPreferences;
  final EncryptedSharedPreferences _encryptedSharedPreferences;

  @override
  Future<Unit> write({required String key, required String value}) async {
    await _encryptedSharedPreferences.setString(key, value);
    return unit;
  }

  @override
  Future<String?> read({required String key}) async {
    return _encryptedSharedPreferences.getString(key);
  }

  @override
  Future<Unit> delete({required String key}) async {
    await _encryptedSharedPreferences.remove(key);
    return unit;
  }

  @override
  Future<Unit> deleteAll() async {
    await _encryptedSharedPreferences.clear();
    return unit;
  }
}
