import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/service/other_service/attachment_picker_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../domain/entities/goods_receipt_attachment_entity.dart';
import '../../domain/entities/goods_receipt_label_attachment_entity.dart';
import '../goods_receipt_attachment_bloc/goods_receipt_attachment_bloc.dart';
import '../goods_receipt_label_attachment_bloc/goods_receipt_label_attachment_item_bloc.dart';

class UploadFileWidget extends StatelessWidget {
  const UploadFileWidget({
    super.key,
    required this.fromPage,
    required this.poId,
    required this.dtId,
    required this.itemId,
  });

  final String fromPage;
  final String dtId;
  final String poId;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Column(
        children: [
          BottomSheetHeaderWidget(
            title: context.l.uploadFile,
            onTap: () {
              context.pop();
            },
          ),
          SizedBox(height: AppSize.size20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UploadOption(
                  iconPath: AppIcons.cameraIcon,
                  label: context.l.camera,
                  textStyle: textStyle,
                  onTap: onUploadAction(context, AppString.camera),
                ),
                const UploadDivider(),
                UploadOption(
                  iconPath: AppIcons.galleryIcon,
                  label: context.l.gallery,
                  textStyle: textStyle,
                  onTap: onUploadAction(context, AppString.gallery),
                ),
                const UploadDivider(),
                UploadOption(
                  iconPath: AppIcons.fileIcon,
                  label: context.l.document,
                  textStyle: textStyle,
                  onTap: onUploadAction(context, AppString.folder),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  VoidCallback onUploadAction(BuildContext context, String fromSource) {
    return () async {
      try {
        getFiles(context, fromSource);
      } catch (e) {}
    };
  }

  void getFiles(BuildContext context, String fromSource) async {
    switch (fromSource) {
      case AppString.camera:
        await sl<AttachmentPickerService>()
            .pickFromCamera(attachmentType: AttachmentType.image)
            .then((fileList) {
              processFiles(context, fileList, fromSource);
            });
        break;
      case AppString.gallery:
        await sl<AttachmentPickerService>()
            .pickFromGallery(attachmentType: AttachmentType.image)
            .then((fileList) {
              processFiles(context, fileList, fromSource);
            });
        break;
      case AppString.folder:
        await sl<AttachmentPickerService>()
            .pickFromFiles(allowMultiple: true)
            .then((fileList) {
              processFiles(context, fileList, fromSource);
            });
        break;
    }
  }

  void processFiles(
    BuildContext context,
    List<PlatformFile>? fileList,
    String fromSource,
  ) {
    try {
      if (fileList != null && fileList.isNotEmpty) {
        List<GoodsReceiptAttachmentEntity> attachmentEntityList = [];
        List<GoodsReceiptLabelAttachmentEntity> attachmentLabelEntityList = [];
        for (var platformFile in fileList) {
          File file = File(platformFile.path.toString());
          copyFileToAppFolder(file, fromSource).then((newFile) {
            getFileSize(newFile).then((fileSize) {
              switch (fromPage) {
                case AppString.goodsReceipt:
                  attachmentEntityList.add(
                    createAttachmentEntity(fileSize, newFile),
                  );
                  break;
                case AppString.createLabel:
                  attachmentLabelEntityList.add(
                    createLabelAttachmentEntity(fileSize, newFile),
                  );
                  break;
              }
            });
          });
        }
        switch (fromPage) {
          case AppString.goodsReceipt:
            context.read<GoodsReceiptAttachmentBloc>().add(
              InsertCapturedOrSelectedAttachmentEvent(attachmentEntityList),
            );
            break;
          case AppString.createLabel:
            context.read<GoodsReceiptLabelAttachmentItemBloc>().add(
              InsertCapturedOrSelectedLabelAttachmentEvent(
                attachmentLabelEntityList,
              ),
            );
            break;
        }

        context.pop();
      }
    } on PlatformException catch (e) {
    } catch (e) {}
  }

  Future<File> copyFileToAppFolder(File mediaFile, String fromSource) async {
    var dir =
        Platform.isIOS
            ? await path_provider.getApplicationDocumentsDirectory()
            : await path_provider.getApplicationDocumentsDirectory();
    var fileName =
        (fromSource == AppString.camera)
            ? "img_${DateFormat("ddMMyyyy_HHmmss").format(DateTime.now())}"
            : p.basename(mediaFile.path);
    final String newFilePath = p.join(
      dir.absolute.path,
      (fromSource == AppString.camera)
          ? '$fileName${p.extension(mediaFile.path)}'
          : fileName,
    );
    File newFile = await mediaFile.copy(newFilePath);
    return newFile;
  }

  Future<String> getFileSize(File sourceFile) async {
    return sourceFile.length().then((fileSizeInBytes) {
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      return '${fileSizeInMB.toStringAsFixed(2)} Mb';
    });
  }

  GoodsReceiptAttachmentEntity createAttachmentEntity(
    String fileSize,
    File mediaFile,
  ) {
    GoodsReceiptAttachmentEntity? attachmentEntity =
        GoodsReceiptAttachmentEntity(
          poHDId: poId,
          fileName: p.basename(mediaFile.path),
          url: mediaFile.path,
          fileType: FileUtils.getFileType(mediaFile),
          fileSize: fileSize,
          date: DateFormat("dd MMM yyyy | hh:mm:ss").format(DateTime.now()),
          localUrl: mediaFile.path,
          isSync: 'N',
        );
    return attachmentEntity;
  }

  GoodsReceiptLabelAttachmentEntity createLabelAttachmentEntity(
    String fileSize,
    File mediaFile,
  ) {
    GoodsReceiptLabelAttachmentEntity? labelAttachmentEntity =
        GoodsReceiptLabelAttachmentEntity(
          dtId: dtId,
          fileName: p.basename(mediaFile.path),
          itemId: itemId,
          poId: poId,
          url: mediaFile.path,
          localUrl: mediaFile.path,
          fileType: FileUtils.getFileType(mediaFile),
          fileSize: fileSize,
          date: DateFormat("dd MMM yyyy | hh:mm:ss").format(DateTime.now()),
          transactionDtId: dtId,
          isSync: "N",
        );
    return labelAttachmentEntity;
  }
}

class UploadOption extends StatelessWidget {
  const UploadOption({
    super.key,
    required this.iconPath,
    required this.label,
    this.textStyle,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final TextStyle? textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (bool) {},
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(height: AppSize.size8),
          Text(label, style: textStyle),
        ],
      ),
    );
  }
}

class UploadDivider extends StatelessWidget {
  const UploadDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.size60,
      child: VerticalDivider(color: AppColor.colorBlack3),
    );
  }
}
