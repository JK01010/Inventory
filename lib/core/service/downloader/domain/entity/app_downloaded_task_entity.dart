import 'package:equatable/equatable.dart';

enum AppDownloadTaskStatus {
  undefined,
  enqueued,
  running,
  complete,
  failed,
  canceled,
  paused;

  factory AppDownloadTaskStatus.fromInt(int value) {
    switch (value) {
      case 0:
        return AppDownloadTaskStatus.undefined;
      case 1:
        return AppDownloadTaskStatus.enqueued;
      case 2:
        return AppDownloadTaskStatus.running;
      case 3:
        return AppDownloadTaskStatus.complete;
      case 4:
        return AppDownloadTaskStatus.failed;
      case 5:
        return AppDownloadTaskStatus.canceled;
      case 6:
        return AppDownloadTaskStatus.paused;
      default:
        throw ArgumentError('Invalid value: $value');
    }
  }
}

class AppDownloadTaskEntity extends Equatable {
  final int progress;

  final String url;

  final String? filename;

  final String savedDir;

  final int timeCreated;

  final bool allowCellular;
  final AppDownloadTaskStatus appDownloadTaskStatus;

  const AppDownloadTaskEntity({
    required this.progress,
    required this.url,
    required this.filename,
    required this.savedDir,
    required this.timeCreated,
    required this.allowCellular,
    required this.appDownloadTaskStatus,
  });

  @override
  List<Object?> get props => [
    progress,
    url,
    filename,
    savedDir,
    timeCreated,
    allowCellular,
    appDownloadTaskStatus,
  ];
}
