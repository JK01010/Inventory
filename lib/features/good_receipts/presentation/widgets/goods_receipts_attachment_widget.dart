import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/extensions/app_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../widgets/app_dot_container_widget.dart';
import '../../../widgets/full_screen_image_viewer.dart';
import '../../data/models/attachments_arguments_model.dart';
import '../goods_receipt_attachment_bloc/goods_receipt_attachment_bloc.dart';
import 'attachment_tile_widget.dart';
import 'upload_file_widget.dart';

class GoodsReceiptsAttachmentWidget extends StatelessWidget {
  const GoodsReceiptsAttachmentWidget({required this.poId});

  final String poId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsReceiptAttachmentBloc, GoodsReceiptAttachmentState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //attachment
              (state.goodsReceiptAttachmentEntityList.isNotEmpty)
                  ? Row(
                    children: [
                      Transform.rotate(
                        angle: pi / 5,
                        child: SvgPicture.asset(
                          AppIcons.attachmentIcon,
                          height: AppSize.size25,
                          width: AppSize.size25,
                          colorFilter: ColorFilter.mode(
                            context.isDarkMode
                                ? AppColor.colorPrimaryDark
                                : AppColor.colorBlack2,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(width: AppSize.size6),
                      Text(
                        "${context.l.attachment} (${state.goodsReceiptAttachmentEntityList.length})",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                  : SizedBox(height: AppSize.size2),

              SizedBox(height: AppSize.size20),

              //upload button
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * .30,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            AppPadding.scaffoldPadding,
                          ),
                          child: UploadFileWidget(
                            fromPage: AppString.goodsReceipt,
                            poId: poId,
                            dtId: '0',
                            itemId: '0',
                          ),
                        ),
                      );
                    },
                  );
                },
                child: AppDottedBorderContainer(
                  color: AppColor.colorPrimary,
                  childDecoration: BoxDecoration(
                    color: AppColor.colorPrimary.withValues(alpha: 0.05),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.padding18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: AppColor.colorPrimary,
                        ),
                        SizedBox(width: AppSize.size6),
                        Text(
                          context.l.upload,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: AppColor.colorPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //uploaded list
              SizedBox(height: AppSize.size20),
              ListView.builder(
                itemCount:
                    (state.goodsReceiptAttachmentEntityList.length >= 3)
                        ? 3
                        : state.goodsReceiptAttachmentEntityList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSize.size10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => FullScreenImageViewer(
                                  attachmentList:
                                      state.goodsReceiptAttachmentEntityList,
                                  initialIndex: index,
                                ),
                          ),
                        );
                      },
                      child: AttachmentTileWidget(
                        imagePath:
                            (state.goodsReceiptAttachmentEntityList[index])
                                .getThumbnailImage(),
                        subtitle:
                            '${state.goodsReceiptAttachmentEntityList[index].date}|${state.goodsReceiptAttachmentEntityList[index].fileSize}',
                        title:
                            state
                                .goodsReceiptAttachmentEntityList[index]
                                .fileName,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.size9),
              if (state.goodsReceiptAttachmentEntityList.length > 3)
                InkWell(
                  onTap: () {
                    context.push(
                      AppRoute.attachmentsListingWidgetPage.path,
                      extra: AttachmentsArguments(
                        attachmentList: state.goodsReceiptAttachmentEntityList,
                        initialIndex: 0,
                      ),
                    );
                  },
                  child: Text(
                    "${state.goodsReceiptAttachmentEntityList.length - 3} ${context.l.moreItems}",
                    style: TextStyle(color: AppColor.colorPrimary),
                  ),
                ),
              SizedBox(height: AppSize.size30),
            ],
          );
        }
      },
    );
  }
}
