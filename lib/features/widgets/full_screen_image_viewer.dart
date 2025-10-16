import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/app_extension.dart';
import '../good_receipts/domain/entities/goods_receipt_attachment_entity.dart';
import '../good_receipts/domain/entities/goods_receipt_common_attachment.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List<GoodsReceiptCommonAttachment> attachmentList;
  final int initialIndex;
  final bool? needsDeleteIcon;

  const FullScreenImageViewer({
    super.key,
    required this.attachmentList,
    required this.initialIndex, this.needsDeleteIcon = true,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorSecondary,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.attachmentList.length,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              itemBuilder: (context, index) {
                return Center(
                  child: File(widget.attachmentList[index].getThumbnailImage()).existsSync()?
                  Image.file(File(widget.attachmentList[index].getThumbnailImage()),fit: BoxFit.cover):
                  Image.asset(widget.attachmentList[index].getThumbnailImage()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.padding10,
                vertical: AppPadding.padding10,
              ),
              child: Row(
                mainAxisAlignment: widget.needsDeleteIcon == false
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if(widget.needsDeleteIcon == true)
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: SvgPicture.asset(
                      AppIcons.deleteIcon,
                      height: AppSize.size30,
                      width: AppSize.size30,
                      semanticsLabel: 'Delete Icon',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.colorWhite,
                      size: AppSize.size30,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
