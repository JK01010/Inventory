
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entity/app_downloaded_task_entity.dart';
import '../../domain/entity/download_file_entity.dart';
import '../../domain/failures/download_failures.dart';
import '../../domain/repositories/download_repository.dart';
import '../../downloader_isolate_helper.dart';
import '../data_sources/app_downloader.dart';



class DownloadRepositoryImpl implements DownloadRepository {
  final AppDownloader _appDownloader;

  DownloadRepositoryImpl({required AppDownloader appDownloader})
    : _appDownloader = appDownloader;

  @override
  Future<Either<DownloadFailures, String>> initializeDownload({
    required DownloadFileEntity downloadFileData,
  }) async {
    try {
      final taskId = await _appDownloader.downLoadFile(
        downloadFileData: downloadFileData,
      );
      return right(taskId);
    } catch (e) {
      return left(DownloadDataFailure(failedValue: e.toString()));
    }
  }

  @override
  Future<Either<DownloadFailures, Unit>> cancelDownload({
    required String taskId,
  }) async {
    try {
      await _appDownloader.cancelDownload(taskId: taskId);
      return right(unit);
    } catch (e) {
      return left(DownloadDataFailure(failedValue: e.toString()));
    }
  }

  @override
  Future<Either<DownloadFailures, List<AppDownloadTaskEntity>>>
  loadTaskWithRawQuery({required String taskId, String query = ""}) async {
    try {
      final downloadedTask = await _appDownloader.loadTaskWithRawQuery(
        taskId: taskId,
      );
      final downloadedEntity =
          downloadedTask
              .map(
                (e) => AppDownloadTaskEntity(
                  allowCellular: e.allowCellular,
                  filename: e.filename,
                  progress: e.progress,
                  savedDir: e.savedDir,
                  timeCreated: e.timeCreated,
                  url: e.url,
                  appDownloadTaskStatus: AppDownloadTaskStatus.fromInt(
                    e.status.index,
                  ),
                ),
              )
              .toList();
      return right(downloadedEntity);
    } catch (e) {
      return left(DownloadDataFailure(failedValue: e.toString()));
    }
  }

  @override
  Future<Either<DownloadFailures, Unit>> pauseDownload({
    required String taskId,
  }) async {
    try {
      await _appDownloader.pauseDownload(taskId: taskId);
      return right(unit);
    } catch (e) {
      return left(DownloadDataFailure(failedValue: e.toString()));
    }
  }

  @override
  Future<Either<DownloadFailures, String>> resumeDownload({
    required String taskId,
  }) async {
    try {
      final newTaskId = await _appDownloader.resumeDownload(taskId: taskId);
      return right(newTaskId);
    } catch (e) {
      return left(DownloadDataFailure(failedValue: e.toString()));
    }
  }

  @override
  Stream<Either<DownloadFailures, int>> downloadProgressStream() async* {
    yield* _appDownloader
        .downloadStream()
        .map<Either<DownloadFailures, int>>((event) {
          return right(event.progress);
        })
        .onErrorReturnWith(
          (error, stackTrace) =>
              left(DownloadDataFailure(failedValue: error.toString())),
        );
  }

  @override
  Future<Either<DownloadFailures, int>> awaitDownloadCompletion({
    required String taskId,
  }) async {
    try {
      await for (final DownloadProgressUpdated progress
          in _appDownloader.downloadStream()) {
        if (progress.taskId == taskId) {
          if (progress.status == DownloadTaskStatus.complete) return right(0);
          if (progress.status == DownloadTaskStatus.paused) return right(-1);
        }
      }
      return right(0);
    } catch (e) {
      return left(DownloadDataFailure(failedValue: e.toString()));
    }
  }
}
