import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sqlcipher/sqflite.dart' as sqlcipher;

import '../../constants/constant.dart';
import '../../utils/password_generator.dart';
import 'db_schema.dart';

class AppDatabase {
  static const _dbName = AppConstant.databaseName;
  static const _passwordKey = AppConstant.encryptionKey;
  static const _dbVersion = AppConstant.databaseVersion;
  static const _secureStorage = FlutterSecureStorage();
  static Database? _db;

  static Future<Database> getInstance() async {
    if (_db != null) {
      return _db!;
    }

    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$_dbName';

    // if (kReleaseMode) {
    //   final password = await _getOrGeneratePassword();
    //   _db = await sqlcipher.openDatabase(
    //     path,
    //     version: _dbVersion,
    //     password: password,
    //     onCreate: onCreateSchema,
    //     onUpgrade: onUpgradeSchema
    //   );
    // } else {
      // Debug mode — no encryption
      _db = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: onCreateSchema,
          onUpgrade: onUpgradeSchema
      );
    // }

    return _db!;
  }

  static Future<String> _getOrGeneratePassword() async {
    String? password = await _secureStorage.read(key: _passwordKey);
    if (password == null) {
      password = generateRandomPassword(32);
      await _secureStorage.write(key: _passwordKey, value: password);
    }
    return password;
  }
}
