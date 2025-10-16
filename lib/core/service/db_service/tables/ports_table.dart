import 'package:sqflite/sqflite.dart';

class PortsTable {
  static const tableName = 'ports';

  static const id = 'id';
  static const code = 'code';
  static const portName = 'portName';
  static const countryID = 'countryID';
  static const countryName = 'countryName';
  static const airportID = 'airportID';
  static const timeZoneID = 'timeZoneID';
  static const latitude = 'latitude';
  static const latDegree = 'latDegree';
  static const latMinutes = 'latMinutes';
  static const latDirection = 'latDirection';
  static const longitude = 'longitude';
  static const lonDegree = 'lonDegree';
  static const lonMinutes = 'lonMinutes';
  static const lonDirection = 'lonDirection';
  static const unLoccode = 'unLoccode';
  static const isUnLoccodeRqd = 'isUnLoccodeRqd';
  static const subDevision = 'subDevision';
  static const transhipmentHub = 'transhipmentHub';
  static const sortOrder = 'sortOrder';
  static const remarks = 'remarks';
  static const isActive = 'isActive';
  static const isDeleted = 'isDeleted';
  static const createdByID = 'createdByID';
  static const createdOn = 'createdOn';
  static const modifiedByID = 'modifiedByID';
  static const modifiedOn = 'modifiedOn';
  static const versionIdentifier = 'versionIdentifier';
  static const operationType = 'operationType';

  static String createTableQuery = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY,
      $code TEXT,
      $portName TEXT,
      $countryID INTEGER,
      $countryName TEXT,
      $airportID INTEGER,
      $timeZoneID INTEGER,
      $latitude REAL,
      $latDegree INTEGER,
      $latMinutes REAL,
      $latDirection TEXT,
      $longitude REAL,
      $lonDegree REAL,
      $lonMinutes REAL,
      $lonDirection TEXT,
      $unLoccode TEXT,
      $isUnLoccodeRqd INTEGER,
      $subDevision TEXT,
      $transhipmentHub TEXT,
      $sortOrder INTEGER,
      $remarks TEXT,
      $isActive INTEGER,
      $isDeleted INTEGER,
      $createdByID INTEGER,
      $createdOn TEXT,
      $modifiedByID INTEGER,
      $modifiedOn TEXT,
      $versionIdentifier INTEGER,
      $operationType TEXT
    )
  ''';

  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // Sample migration: add new column
      await db.execute("ALTER TABLE $tableName ADD COLUMN email TEXT");
    }
  }
}
