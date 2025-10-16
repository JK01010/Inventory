import 'package:flutter_downloader/flutter_downloader.dart';

abstract class DownloadProgressState {}

class DownloadProgressInitial extends DownloadProgressState {}

class DownloadProgressUpdate extends DownloadProgressState {
  final String taskId;
  final DownloadTaskStatus status;
  final int progress;

  DownloadProgressUpdate({
    required this.taskId,
    required this.status,
    required this.progress,
  });
}
