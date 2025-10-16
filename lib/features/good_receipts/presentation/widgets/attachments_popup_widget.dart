import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/app_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../../widgets/full_screen_image_viewer.dart';
import '../goods_receipt_label_ihm_attachment_bloc/goods_receipt_label_ihm_attachment_bloc.dart';
import 'attachment_tile_widget.dart';
import 'number_of_packets_widget.dart';

class AttachmentsPopupWidget extends StatelessWidget {
  const AttachmentsPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GoodsReceiptLabelIhmAttachmentBloc,
      GoodsReceiptLabelIhmAttachmentState
    >(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: const CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.padding2),
                child: BottomSheetHeaderWidget(
                  title:
                      "${context.l.attachments}(${state.goodsReceiptIhmAttachmentEntityList.length})",
                  onTap: () {
                    context.pop();
                  },
                ),
              ),
              Divider(
                color:
                    context.isDarkMode
                        ? AppColor.colorDarkDivider
                        : AppColor.closeButtonColor,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: packageListValue,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount:
                          state.goodsReceiptIhmAttachmentEntityList.length,
                      padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSize.size10,
                              ),
                              child: AttachmentTileWidget(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => FullScreenImageViewer(
                                            attachmentList:
                                                state
                                                    .goodsReceiptIhmAttachmentEntityList,
                                            initialIndex: index,
                                            needsDeleteIcon: false,
                                          ),
                                    ),
                                  );
                                },
                                imagePath:
                                    (state.goodsReceiptIhmAttachmentEntityList[index])
                                        .getThumbnailImage(),
                                subtitle:
                                    '${state.goodsReceiptIhmAttachmentEntityList[index].createdDate}|${state.goodsReceiptIhmAttachmentEntityList[index].fileSize}',
                                title:
                                    state
                                        .goodsReceiptIhmAttachmentEntityList[index]
                                        .attachmentName,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
