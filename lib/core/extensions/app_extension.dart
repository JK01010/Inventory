
import '../../features/good_receipts/domain/entities/goods_receipt_common_attachment.dart';
import '../constants/app_enum.dart';

extension AttachmentTypeParser on String {
  AttachmentType toAttachmentType() {
    return AttachmentType.values.firstWhere(
          (e) => e.name == this,
      orElse: () => AttachmentType.all, // Default fallback if string doesn't match
    );
  }
}

extension GoodsReceiptAttachmentEntityExtension on GoodsReceiptCommonAttachment {
  String getThumbnailImage() {
    AttachmentType attachmentType = AttachmentType.noImage;

    if (type.isNotEmpty) {
      attachmentType = type.toAttachmentType(); // Assuming typeStr is the string field
    }

    switch (attachmentType) {
      case AttachmentType.image:
        return url;
      case AttachmentType.pdf:
        return 'assets/images/pdf_file_icon.png';
      case AttachmentType.word:
        return 'assets/images/pdf_file_icon.png';
      case AttachmentType.excel:
        return 'assets/images/pdf_file_icon.png';
      case AttachmentType.ppt:
        return 'assets/images/pdf_file_icon.png';
      default:
        return 'assets/images/image_place_holder.png';
    }
  }
}


