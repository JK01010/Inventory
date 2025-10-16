import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_enum.dart';
import '../../utils/app_logger.dart';

abstract class AttachmentPickerService {
  Future<List<PlatformFile>?> pickFromGallery({
    required AttachmentType attachmentType,
    bool allowMultiple = false,
  });

  Future<List<PlatformFile>?> pickFromCamera({
    required AttachmentType attachmentType,
  });

  Future<List<PlatformFile>?> pickFromFiles({bool allowMultiple = false});
}

class AttachmentPickerServiceImpl implements AttachmentPickerService {
  AttachmentPickerServiceImpl({
    required this.imagePicker,
    required this.appLogger,
    required this.filePicker,
  });

  final ImagePicker imagePicker;
  final AppLogger appLogger;
  final FilePicker filePicker;

  static const List<String> allowedImageExtensions = ['.png', '.jpg', '.jpeg'];
  static const List<String> allowedVideoExtensions = ['.mp4', '.mov', '.avi'];
  static const List<String> allowedFileExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
  ];

  @override
  Future<List<PlatformFile>?> pickFromGallery({
    required AttachmentType attachmentType,
    bool allowMultiple = false,
  }) async {
    try {
      List<XFile> pickedFiles = [];

      if (allowMultiple &&
          (attachmentType == AttachmentType.image ||
              attachmentType == AttachmentType.all)) {
        pickedFiles = await imagePicker.pickMultiImage();
      } else {
        final XFile? picked =
            (attachmentType == AttachmentType.video)
                ? await imagePicker.pickVideo(source: ImageSource.gallery)
                : await imagePicker.pickImage(source: ImageSource.gallery);
        if (picked != null) {
          pickedFiles.add(picked);
        }
      }

      // Filter based on file extension
      final filteredFiles =
          pickedFiles.where((file) {
            final ext = file.name.toLowerCase();
            if (attachmentType == AttachmentType.video) {
              return allowedVideoExtensions.any(ext.endsWith);
            } else {
              return allowedImageExtensions.any(ext.endsWith);
            }
          }).toList();

      return filteredFiles.isNotEmpty
          ? _xFilesToPlatformFiles(filteredFiles)
          : null;
    } catch (e, stackTrace) {
      appLogger.error('Gallery pick error', e, stackTrace);
      return null;
    }
  }

  @override
  Future<List<PlatformFile>?> pickFromCamera({
    required AttachmentType attachmentType,
  }) async {
    try {
      final XFile? xFile =
          (attachmentType == AttachmentType.video)
              ? await imagePicker.pickVideo(source: ImageSource.camera)
              : await imagePicker.pickImage(source: ImageSource.camera);

      return xFile != null ? _xFilesToPlatformFiles([xFile]) : null;
    } catch (e, stackTrace) {
      appLogger.error('Camera pick error', e, stackTrace);
      return null;
    }
  }

  @override
  Future<List<PlatformFile>?> pickFromFiles({
    bool allowMultiple = false,
  }) async {
    try {
      final result = await filePicker.pickFiles(
        allowMultiple: allowMultiple,
        type: FileType.custom,
        allowedExtensions: allowedFileExtensions,
      );
      return result?.files;
    } catch (e, stackTrace) {
      appLogger.error('File picker error', e, stackTrace);
      return null;
    }
  }

  List<PlatformFile> _xFilesToPlatformFiles(List<XFile> xFiles) {
    return xFiles
        .map(
          (xFile) => PlatformFile(name: xFile.name, path: xFile.path, size: 0),
        )
        .toList();
  }
}
