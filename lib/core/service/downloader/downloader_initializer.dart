import 'package:flutter_downloader/flutter_downloader.dart';

import 'downloader_isolate_helper.dart';

class DownloaderInitializer {
  static Future<void>  initialize() async {
    await FlutterDownloader.initialize(debug: true);
    DownloaderIsolateHelper.initializeIsolate();
  }

  static void dispose() {
    DownloaderIsolateHelper.dispose();
  }
}
