import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../features/common_feature/data/model/meta_local_params.dart';
import '../tables/time_stamp_meta_table.dart';

abstract interface class MetaLocalDataSource {
  Future<void> insertApiLastModifiedDate({
    required MetaLocalParams metaLocalParams,
  });

  Future<String?> fetchLastCallTime({required MetaLocalParams metaLocalParams});
}

class MetaLocalDataSourceImpl implements MetaLocalDataSource {
  MetaLocalDataSourceImpl({required this.db});

  final Database db;

  @override
  Future<void> insertApiLastModifiedDate({
    required MetaLocalParams metaLocalParams,
  }) async {
    int? count = Sqflite.firstIntValue(
      await db.rawQuery(
        "SELECT COUNT(*) FROM ${TimeStampMetaTable.tableName} WHERE ${TimeStampMetaTable.vesselId} = ? AND ${TimeStampMetaTable.code} = ?",
        [metaLocalParams.vesselId, metaLocalParams.code],
      ),
    );

    DateTime nowUtc = DateTime.now().toUtc();
    String microStr = nowUtc.microsecond.toString().padLeft(6, '0'); // 6 digits
    String formatted =
        '${DateFormat("yyyy-MM-dd HH:mm:ss").format(nowUtc)}.${microStr}0';

    if (count == 0) {
      await db.rawInsert(
        'INSERT OR REPLACE INTO ${TimeStampMetaTable.tableName} (${TimeStampMetaTable.code}, ${TimeStampMetaTable.vesselId}, ${TimeStampMetaTable.modifiedOn}) VALUES (?, ?, ?)',
        [metaLocalParams.code, metaLocalParams.vesselId, formatted],
      );
    } else {
      await db.rawUpdate(
        'UPDATE ${TimeStampMetaTable.tableName} SET ${TimeStampMetaTable.modifiedOn} = ? WHERE ${TimeStampMetaTable.vesselId} = ? AND ${TimeStampMetaTable.code} = ?',
        [formatted, metaLocalParams.vesselId, metaLocalParams.code],
      );
    }
  }

  @override
  Future<String?> fetchLastCallTime({
    required MetaLocalParams metaLocalParams,
  }) async {
    final result = await db.query(
      TimeStampMetaTable.tableName,
      where:
          '${TimeStampMetaTable.vesselId} = ? AND ${TimeStampMetaTable.code} = ?',
      whereArgs: [metaLocalParams.vesselId, metaLocalParams.code],
    );
    if (result.isEmpty) {
      return null;
    } else {
      String timeStamp = result.first[TimeStampMetaTable.modifiedOn] as String;
      return timeStamp;
    }
  }
}
