import 'package:fpdart/fpdart.dart';

import '../failures/download_failures.dart';
import '../repositories/download_repository.dart';

abstract interface class ResumeDownloadUseCase {
  Future<Either<DownloadFailures, String>> call({required String taskId});
}

class ResumeDownloadUseCaseImpl implements ResumeDownloadUseCase {
  final DownloadRepository _downloadRepository;

  ResumeDownloadUseCaseImpl({required DownloadRepository downloadRepository})
    : _downloadRepository = downloadRepository;

  @override
  Future<Either<DownloadFailures, String>> call({
    required String taskId,
  }) async {
    return _downloadRepository.resumeDownload(taskId: taskId);
  }
}
