import 'dart:io';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
logIRT(String log) {
  Logger(filter: DevelopmentFilter()).w(log);
}

String generateFormattedUTC(){
  DateTime nowUtc = DateTime.now().toUtc();
  String microStr = nowUtc.microsecond.toString().padLeft(6, '0'); // 6 digits
  return '${DateFormat("yyyy-MM-dd HH:mm:ss").format(nowUtc)}.${microStr}0';
}

Future<void> addNewLog({required String name,required String log,required String irtID})async {
  final folderName = 'INS_$irtID';
  // Get base document directory
  final appDocDir = await getApplicationDocumentsDirectory();
  final logsPath = p.join(appDocDir.path, 'Attachment', folderName, 'logs');
  final logsDir = Directory(logsPath);
  if (!await logsDir.exists()) {
    await logsDir.create(recursive: true);
  }
  String time =generateFormattedUTC();
  String todayDate = DateFormat("yyyyMMdd").format(
      DateTime.now().toUtc()).toString();
  File logFile =  File('${logsDir.path}/LOG_$todayDate.txt');

  await logFile.writeAsString(
      """\n
      =================================================================================\n
      $time\n
      $name:\n
      $log\n
      =================================================================================
      \n""",
      mode: FileMode.append
  );
}


Future<void> logException({required String name,required String log})async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final exceptionPath = p.join(appDocDir.path, 'Attachment','Exception');
  final exceptionDir = Directory(exceptionPath);
  if (!await exceptionDir.exists()) {
    await exceptionDir.create(recursive: true);
  }
  String time =generateFormattedUTC();
  String todayDate = DateFormat("yyyyMMdd").format(
      DateTime.now().toUtc()).toString();
  File logFile =  File('${exceptionDir.path}/LOG_$todayDate.txt');

  await logFile.writeAsString(
      """\n
      =================================================================================\n
      $time\n
      $name:\n
      $log\n
      =================================================================================
      \n""",
      mode: FileMode.append
  );
}

Future<void> addCommonLog({required String name,required String log})async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final exceptionPath = p.join(appDocDir.path, 'Attachment','Common Logs');
  final exceptionDir = Directory(exceptionPath);
  if (!await exceptionDir.exists()) {
    await exceptionDir.create(recursive: true);
  }
  String time =generateFormattedUTC();
  String todayDate = DateFormat("yyyyMMdd").format(
      DateTime.now().toUtc()).toString();
  File logFile =  File('${exceptionDir.path}/LOG_$todayDate.txt');

  await logFile.writeAsString(
      """\n
      =================================================================================\n
      $time\n
      $name:\n
      $log\n
      =================================================================================
      \n""",
      mode: FileMode.append
  );
}