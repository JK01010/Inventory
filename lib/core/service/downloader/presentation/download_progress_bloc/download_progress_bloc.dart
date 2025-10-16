import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../downloader_isolate_helper.dart';
import 'download_progress_event.dart';
import 'download_progress_state.dart';

class DownloadProgressBloc
    extends Bloc<DownloadProgressEvent, DownloadProgressState> {
  DownloadProgressBloc() : super(DownloadProgressInitial()) {
    on<DownloadProgressReceived>(_onProgressReceived);

    // Listen to IsolateHelper stream
    DownloaderIsolateHelper.downloadProgressStream.listen((update) {
      if (kDebugMode) {
        print(
          "update on task (${update.taskId}) : progress : ${update.progress}, status : ${update.status.name}",
        );
      }
      add(
        DownloadProgressReceived(
          taskId: update.taskId,
          status: update.status,
          progress: update.progress,
        ),
      );
    });
  }

  void _onProgressReceived(
    DownloadProgressReceived event,
    Emitter<DownloadProgressState> emit,
  ) {
    emit(
      DownloadProgressUpdate(
        taskId: event.taskId,
        status: event.status,
        progress: event.progress,
      ),
    );
  }
}
