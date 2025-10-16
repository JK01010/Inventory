import 'package:flutter_downloader/flutter_downloader.dart';

abstract class DownloadProgressEvent {}

class DownloadProgressReceived extends DownloadProgressEvent {
  final String taskId;
  final DownloadTaskStatus status;
  final int progress;

  DownloadProgressReceived({
    required this.taskId,
    required this.status,
    required this.progress,
  });
}
