import 'package:sqflite/sqflite.dart';
import '../../../../features/common_feature/data/model/fetch_imdg_class_model.dart';
import '../tables/fetch_imdg_class_table.dart';

abstract interface class ImdgClassTableDataProcessor {
  Future<void> insertImdgClassList({
    required List<ImdgClassData> imdgClassData,
  });

  Future<List<Map<String, dynamic>>> getImdgClass();
}

class ImdgClassTableDataProcessorImpl implements ImdgClassTableDataProcessor {
  ImdgClassTableDataProcessorImpl({required this.db});

  final Database db;

  @override
  Future<void> insertImdgClassList({
    required List<ImdgClassData> imdgClassData,
  }) async {
    final Batch batch = db.batch();

    for (var element in imdgClassData) {
      final existing = await db.query(
        IMDGClassTable.tableName,
        where: '${IMDGClassTable.id} = ?',
        whereArgs: [element.id],
        limit: 1,
      );
      if (existing.isEmpty) {
        batch.insert(
          IMDGClassTable.tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        batch.rawQuery(
          """
        UPDATE ${IMDGClassTable.tableName} SET ${IMDGClassTable.isActive} = ? WHERE ${IMDGClassTable.id} = ?
        """,
          [element.isActive == true ? 1 : 0],
        );
      }
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> getImdgClass() async {
    return db.query(
      IMDGClassTable.tableName,
      where: "${IMDGClassTable.isActive} = ?",
      whereArgs: [1],
    );
  }
}
