import 'package:fpdart/fpdart.dart';

import '../entity/download_file_entity.dart';
import '../failures/download_failures.dart';
import '../repositories/download_repository.dart';

abstract interface class InitializeDownloadUsecase {
  Future<Either<DownloadFailures, String>> call({
    required DownloadFileEntity downloadFileData,
  });
}

class InitializeDownloadUsecaseImpl implements InitializeDownloadUsecase {
  final DownloadRepository _downloadRepository;

  InitializeDownloadUsecaseImpl({required DownloadRepository downloadRepository})
    : _downloadRepository = downloadRepository;

  @override
  Future<Either<DownloadFailures, String>> call({
    required DownloadFileEntity downloadFileData,
  }) async {
    return _downloadRepository.initializeDownload(
      downloadFileData: downloadFileData,
    );
  }
}
