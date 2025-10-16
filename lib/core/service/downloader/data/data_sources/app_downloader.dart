
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entity/download_file_entity.dart';
import '../../downloader_isolate_helper.dart';
import '../exceptions/download_exceptions.dart';

abstract interface class AppDownloader {
  Future<String> downLoadFile({required DownloadFileEntity downloadFileData});
  Future<String> resumeDownload({required String taskId});
  Future<void> pauseDownload({required String taskId});
  Future<void> cancelDownload({required String taskId});
  Future<List<DownloadTask>> loadTaskWithRawQuery({
    required String taskId,
    String query,
  });
  Stream<DownloadProgressUpdated> downloadStream();
}

class AppDownloaderImpl implements AppDownloader {
  @override
  Future<String> downLoadFile({
    required DownloadFileEntity downloadFileData,
  }) async {
    final dir = await getApplicationSupportDirectory();
    final taskId = await FlutterDownloader.enqueue(
      url: downloadFileData.url,
      savedDir: dir.path,
      fileName: downloadFileData.fileName,
      showNotification: false,
      openFileFromNotification: false,
      allowCellular: true,
    );
    if (taskId != null) {
      return taskId;
    } else {
      throw DownloadException();
    }
  }

  @override
  Future<String> resumeDownload({required String taskId}) async {
    final newTaskId = await FlutterDownloader.resume(taskId: taskId);
    if (newTaskId == null) throw DownloadException();
    return newTaskId;
  }

  @override
  Future<void> pauseDownload({required String taskId}) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  @override
  Future<void> cancelDownload({required String taskId}) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  @override
  Future<List<DownloadTask>> loadTaskWithRawQuery({
    required String taskId,
    String query = "",
  }) async {
    String queryValue =
        query.isEmpty ? "SELECT * FROM task WHERE task_id='$taskId'" : query;
    final task = await FlutterDownloader.loadTasksWithRawQuery(
      query: queryValue,
    );

    return task ?? [];
  }

  @override
  Stream<DownloadProgressUpdated> downloadStream() async* {
    yield* DownloaderIsolateHelper.downloadProgressStream;
  }
}
