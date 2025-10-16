import 'package:fpdart/fpdart.dart';

import '../entity/app_downloaded_task_entity.dart';
import '../entity/download_file_entity.dart';
import '../failures/download_failures.dart';

abstract class DownloadRepository {
  Future<Either<DownloadFailures, String>> initializeDownload({
    required DownloadFileEntity downloadFileData,
  });
  Future<Either<DownloadFailures, int>> awaitDownloadCompletion({
    required String taskId,
  });
  Future<Either<DownloadFailures, String>> resumeDownload({
    required String taskId,
  });
  Future<Either<DownloadFailures, Unit>> pauseDownload({
    required String taskId,
  });
  Future<Either<DownloadFailures, Unit>> cancelDownload({
    required String taskId,
  });
  Future<Either<DownloadFailures, List<AppDownloadTaskEntity>>>
  loadTaskWithRawQuery({required String taskId, String query});

  Stream<Either<DownloadFailures, int>> downloadProgressStream();
}
