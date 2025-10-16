import 'package:fpdart/fpdart.dart';

import '../failures/download_failures.dart';
import '../repositories/download_repository.dart';

abstract interface class PauseDownloadUseCase {
  Future<Either<DownloadFailures, Unit>> call({required String taskId});
}

class PauseDownloadUseCaseImpl implements PauseDownloadUseCase {
  final DownloadRepository _downloadRepository;

  PauseDownloadUseCaseImpl({required DownloadRepository downloadRepository})
    : _downloadRepository = downloadRepository;

  @override
  Future<Either<DownloadFailures, Unit>> call({required String taskId}) async {
    return _downloadRepository.pauseDownload(taskId: taskId);
  }
}
