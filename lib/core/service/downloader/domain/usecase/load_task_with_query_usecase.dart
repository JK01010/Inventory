import 'package:fpdart/fpdart.dart';

import '../entity/app_downloaded_task_entity.dart';
import '../failures/download_failures.dart';
import '../repositories/download_repository.dart';

abstract interface class LoadTaskWithQuery {
  Future<Either<DownloadFailures, List<AppDownloadTaskEntity>>> call({
    required String taskId,
  });
}

class LoadTaskWithQueryImpl implements LoadTaskWithQuery {
  final DownloadRepository _downloadRepository;

  LoadTaskWithQueryImpl({required DownloadRepository downloadRepository})
    : _downloadRepository = downloadRepository;

  @override
  Future<Either<DownloadFailures, List<AppDownloadTaskEntity>>> call({
    required String taskId,
  }) async {
    return _downloadRepository.loadTaskWithRawQuery(taskId: taskId);
  }
}
