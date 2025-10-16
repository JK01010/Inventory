
import 'package:fpdart/fpdart.dart';

import '../failures/download_failures.dart';
import '../repositories/download_repository.dart';

abstract interface class AwaitDownloadUseCase {
  Future<Either<DownloadFailures, int>> call({required String taskId});
}

class AwaitDownloadUseCaseImpl implements AwaitDownloadUseCase {
  final DownloadRepository _downloadRepository;

  AwaitDownloadUseCaseImpl({required DownloadRepository downloadRepository})
    : _downloadRepository = downloadRepository;

  @override
  Future<Either<DownloadFailures, int>> call({required String taskId}) async {
    return _downloadRepository.awaitDownloadCompletion(taskId: taskId);
  }
}
