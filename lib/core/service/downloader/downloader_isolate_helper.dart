import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';

class DownloaderIsolateHelper {
  static final ReceivePort _port = ReceivePort();
  static final _downloadProgressController =
      StreamController<DownloadProgressUpdated>.broadcast();

  /// Public stream to listen to download updates.
  static Stream<DownloadProgressUpdated> get downloadProgressStream =>
      _downloadProgressController.stream;

  static void initializeIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );

    _port.listen((dynamic data) {
      log(data.toString());
      final id = data[0];
      final status = data[1];
      final progress = data[2];
      // log('Download [$id] - Status: $status, Progress: $progress%');
      _downloadProgressController.add(
        DownloadProgressUpdated(
          taskId: id,
          status: DownloadTaskStatus.fromInt(status),
          progress: progress,
        ),
      );
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _downloadProgressController.close();
  }
}

@pragma('vm:entry-point')
void downloadCallback(String id, int status, int progress) async {
  final SendPort? send = IsolateNameServer.lookupPortByName(
    'downloader_send_port',
  );
  send?.send([id, status, progress]);
}

class DownloadProgressUpdated {
  final String taskId;
  final DownloadTaskStatus status;
  final int progress;

  DownloadProgressUpdated({
    required this.taskId,
    required this.status,
    required this.progress,
  });
}
