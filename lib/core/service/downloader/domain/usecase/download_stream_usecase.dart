import 'package:fpdart/fpdart.dart';

import '../failures/download_failures.dart';
import '../repositories/download_repository.dart';

abstract interface class DownloadProgressStreamUseCase {
  Stream<Either<DownloadFailures, int>> call({required String taskId});
}

class DownloadProgressStreamUseCaseImpl implements DownloadProgressStreamUseCase {
  final DownloadRepository _downloadRepository;

  DownloadProgressStreamUseCaseImpl({required DownloadRepository downloadRepository})
    : _downloadRepository = downloadRepository;

  @override
  Stream<Either<DownloadFailures, int>> call({required String taskId}) async* {
    yield* _downloadRepository.downloadProgressStream();
  }
}
