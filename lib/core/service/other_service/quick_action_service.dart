import 'dart:io';

import 'package:quick_actions/quick_actions.dart';
import 'package:share_plus/share_plus.dart';

import 'file_logger_service.dart';
import '../../utils/app_logger.dart';

class QuickActionService {
  QuickActionService({
    required this.fileLoggerService,
    required this.appLogger,
  });

  final FileLoggerService fileLoggerService;
  final AppLogger appLogger;
  void initialize() {
    final _ =
        const QuickActions()
          ..initialize((shortcutType) async {
            if (shortcutType == 'share_logs') {
              final logFile =
                  await fileLoggerService.getTodayLogFile() ?? File("");

              if (await logFile.exists()) {
                final params = ShareParams(
                  text: 'PalNG-Inventory-Log',
                  files: [XFile(logFile.path)],
                );
                await SharePlus.instance.share(params);
              } else {
                appLogger.debug("Log file not found at ${logFile.path}");
              }
            }
          })
          ..setShortcutItems(const [
            ShortcutItem(
              type: 'share_logs',
              localizedTitle: 'Share Logs',
              icon: 'share', //android/app/src/main/res/drawable/share.png
            ),
          ]);
  }
}
