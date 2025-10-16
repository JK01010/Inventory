import 'package:fpdart/fpdart.dart';

import '../failures/download_failures.dart';
import '../repositories/download_repository.dart';

abstract interface class CancelDownloadUseCase {
  Future<Either<DownloadFailures, Unit>> call({required String taskId});
}

class CancelDownloadUseCaseImpl implements CancelDownloadUseCase {
  final DownloadRepository _downloadRepository;

  CancelDownloadUseCaseImpl({required DownloadRepository downloadRepository})
    : _downloadRepository = downloadRepository;

  @override
  Future<Either<DownloadFailures, Unit>> call({required String taskId}) async {
    return _downloadRepository.cancelDownload(taskId: taskId);
  }
}
