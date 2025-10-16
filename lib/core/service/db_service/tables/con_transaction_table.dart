import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConTransactionTable{
  static const tableName = 'consumptionTransaction';

  // Define column names
  static const transactionDtId = 'transactionDtId';
  static const itemId = 'itemId';
  static const quantity = 'quantity';
  static const storageLocationId = 'storageLocationId';
  static const remarks = 'remarks';
  static const modifiedOn = 'modifiedOn';
  static const syncStatus = 'syncStatus';
  static const syncMerge = 'syncMessage';
  static const transactionId = 'transactionId';
  static const tags = 'tags';
  static const locationId = 'locationId';
  static const equipmentId = 'equipmentId';

  static const totalRob = 'totalRob';
  static const totalNewStock = 'totalNewStock';
  static const totalReconditionStock = 'totalReconditionStock';

  static const currentRob = 'currentRob';
  static const newStock = 'newStock';
  static const reconditionStock = 'reconditionStock';

  static const createTableQuery = '''
  CREATE TABLE $tableName (
    $transactionDtId INTEGER PRIMARY KEY,
    $itemId INTEGER ,
    $quantity REAL ,
    $storageLocationId INTEGER ,
    $remarks TEXT ,
    $modifiedOn TEXT ,
    $syncStatus TEXT ,
    $syncMerge TEXT ,
    $transactionId INTEGER ,
    $tags TEXT ,
    $locationId INTEGER ,
    $equipmentId INTEGER ,
    $totalRob INTEGER ,
    $totalNewStock INTEGER ,
    $totalReconditionStock INTEGER ,
    
    $currentRob INTEGER ,
    $newStock INTEGER ,
    $reconditionStock INTEGER 
  )
''';


  static Future<void> onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    if (oldVersion < 2) {
      // Example migration: add new column
      await db.execute("ALTER TABLE $tableName ADD COLUMN email TEXT");
    }
  }
}