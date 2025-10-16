import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/widgets/custom_app_bar.dart';
import 'package:pal_ng_inventory/features/widgets/gradient_background_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/app_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/full_screen_image_viewer.dart';
import '../../domain/entities/goods_receipt_attachment_entity.dart';
import 'attachment_tile_widget.dart';

class AttachmentsListingWidgetPage extends StatefulWidget {
  const AttachmentsListingWidgetPage({
    super.key,
    required this.attachmentList,
    required this.initialIndex,
  });

  final List<GoodsReceiptAttachmentEntity> attachmentList;
  final int initialIndex;

  @override
  State<AttachmentsListingWidgetPage> createState() =>
      _AttachmentsListingWidgetPageState();
}

class _AttachmentsListingWidgetPageState
    extends State<AttachmentsListingWidgetPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "${context.l.attachments} (${widget.attachmentList.length})",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: AppDecoratedBoxShadowWidget(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: ListView.builder(
                  itemCount: widget.attachmentList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: AppSize.size10),
                        child: Shimmer.fromColors(
                          baseColor: AppColor.colorBlack6,
                          highlightColor: AppColor.colorGrey,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.colorGrey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      AppBorderRadius.borderRadius8,
                                    ),
                                  ),
                                ),
                                height: AppSize.size48,
                                width: AppSize.size48,
                              ),
                              SizedBox(width: AppSize.size10),
                              Column(
                                children: [
                                  Container(
                                    color: AppColor.colorGrey,
                                    height: AppSize.size10,
                                    width: AppSize.size200,
                                  ),
                                  SizedBox(height: AppSize.size10),
                                  Container(
                                    color: AppColor.colorGrey,
                                    height: AppSize.size10,
                                    width: AppSize.size200,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSize.size10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => FullScreenImageViewer(
                                      attachmentList: widget.attachmentList,
                                      initialIndex: index,
                                    ),
                              ),
                            );
                          },
                          child: AttachmentTileWidget(
                            imagePath: widget.attachmentList[index].getThumbnailImage(),
                            subtitle: '${widget.attachmentList[index].date}|${widget.attachmentList[index].fileSize}',
                            title: widget.attachmentList[index].fileName,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
