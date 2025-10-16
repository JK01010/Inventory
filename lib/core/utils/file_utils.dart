import 'dart:io';

import 'package:path/path.dart' as p;

class FileUtils{

  static String getFileType(File file) {
    final extension = p.extension(file.path).toLowerCase();

    if (['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'].contains(extension)) {
      return 'image';
    } else if (['.mp4', '.mov', '.avi', '.mkv'].contains(extension)) {
      return 'video';
    } else if (['.mp3', '.wav', '.aac', '.flac'].contains(extension)) {
      return 'audio';
    } else if (extension == '.pdf') {
      return 'pdf';
    } else if (['.doc', '.docx'].contains(extension)) {
      return 'word';
    } else if (['.xls', '.xlsx'].contains(extension)) {
      return 'excel';
    } else if (['.ppt', '.pptx'].contains(extension)) {
      return 'powerpoint';
    } else if (['.txt', '.json', '.csv', '.xml'].contains(extension)) {
      return 'text';
    } else {
      return 'unknown';
    }
  }
}