import 'dart:io';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/app_logger.dart';

abstract interface class FileLoggerService {
  Future<void> logToFile({
    required String pageType,
    required String logText,
    String? apiName,
    String? dbTable,
    String? userId,
    String? extraInfo,
  });
  Future<void> cleanOldLogs({int days = 7});
  Future<File?> getTodayLogFile();
}

class FileLoggerServiceImpl implements FileLoggerService {
  FileLoggerServiceImpl({required this.appLogger});

  final AppLogger appLogger;

  /// Writes a log entry to the app's internal log file.
  @override
  Future<void> logToFile({
    required String pageType,
    required String logText,
    String? apiName,
    String? dbTable,
    String? userId,
    String? extraInfo,
  }) async {
    try {
      final now = DateTime.now();
      final dateStr = DateFormat('yyyy-MM-dd').format(now);

      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');
      if (!await logDir.exists()) {
        await logDir.create(recursive: true);
      }

      final logFile = File('${logDir.path}/log_$dateStr.txt');

      final packageInfo = await PackageInfo.fromPlatform();

      final log =
          StringBuffer()
            ..writeln('---')
            ..writeln(
              'Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(now)}, App Version: ${packageInfo.version}+${packageInfo.buildNumber}',
            )
            ..writeln('Page: $pageType, Action: $logText');

      if ((userId?.trim() ?? '').isNotEmpty)
        log.writeln('User: ${userId!.trim()}');
      if ((apiName?.trim() ?? '').isNotEmpty)
        log.writeln('API: ${apiName!.trim()}');
      if ((dbTable?.trim() ?? '').isNotEmpty)
        log.writeln('DB Table: ${dbTable!.trim()}');
      if ((extraInfo?.trim() ?? '').isNotEmpty)
        log.writeln('Extra: ${extraInfo!.trim()}');

      await logFile.writeAsString(log.toString(), mode: FileMode.append);
    } catch (e, st) {
      appLogger.error("Failed to write to log file", e, st);
    }
  }

  /// Deletes logs older than [days] from the app's private log directory
  @override
  Future<void> cleanOldLogs({int days = 7}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');

      if (!await logDir.exists()) {
        return;
      }

      final now = DateTime.now();

      for (final entity in logDir.listSync()) {
        if (entity is File && entity.path.contains('log_')) {
          final stat = await entity.stat();
          final age = now.difference(stat.modified);
          if (age.inDays > days) {
            await entity.delete();
          }
        }
      }
    } catch (e, st) {
      appLogger.error("Failed to clean old logs", e, st);
    }
  }

  /// Returns today's log file if it exists
  @override
  Future<File?> getTodayLogFile() async {
    final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final directory = await getApplicationDocumentsDirectory();
    final logFile = File('${directory.path}/logs/log_$dateStr.txt');
    return await logFile.exists() ? logFile : null;
  }
}
