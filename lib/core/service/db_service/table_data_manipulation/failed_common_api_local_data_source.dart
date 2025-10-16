import 'package:sqflite/sqflite.dart';

import '../../../../features/common_feature/data/model/failed_common_api_model.dart';
import '../tables/failed_common_api_meta_table.dart';

abstract interface class FailedCommonApiLocalDataSource {
  Future<void> insertFailedApiWithPayLoad({
    required FailedCommonApiModel failedCommonApiModel,
  });

  Future<List<FailedCommonApiModel>> fetchApiListViaEndPoint({
    required String endPoint,
  });

  Future<void> updateExecutedAt({required int id});
}

class FailedCommonApiLocalDataSourceImpl
    implements FailedCommonApiLocalDataSource {
  FailedCommonApiLocalDataSourceImpl({required this.db});

  final Database db;

  @override
  Future<List<FailedCommonApiModel>> fetchApiListViaEndPoint({
    required String endPoint,
  }) async {
    List<Map<String, dynamic>> data = await db.query(
      FailedCommonApiMetaTable.tableName,
      where:
          '${FailedCommonApiMetaTable.apiEndPoint} = ? AND ${FailedCommonApiMetaTable.executedAt} IS NULL',
      whereArgs: [endPoint],
    );
    if (data.isEmpty) {
      return [];
    } else {
      final List<FailedCommonApiModel> failedCommonApiModelList =
          data.map(FailedCommonApiModel.fromJson).toList();
      return failedCommonApiModelList;
    }
  }

  @override
  Future<void> insertFailedApiWithPayLoad({
    required FailedCommonApiModel failedCommonApiModel,
  }) async {
    await db.rawInsert(
      'INSERT INTO ${FailedCommonApiMetaTable.tableName} (${FailedCommonApiMetaTable.apiEndPoint}, ${FailedCommonApiMetaTable.apiPayLoad}) VALUES (?, ?)',
      [failedCommonApiModel.apiEndPoint, failedCommonApiModel.apiPayLoad],
    );
  }

  @override
  Future<void> updateExecutedAt({required int id}) async {
    await db.rawUpdate(
      'UPDATE ${FailedCommonApiMetaTable.tableName} SET ${FailedCommonApiMetaTable.executedAt} = ? WHERE ${FailedCommonApiMetaTable.id} = ?',
      [DateTime.now().millisecondsSinceEpoch.toString(), id],
    );
  }
}
