import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_dot_container_widget.dart';
import '../purchase_order_detail_bloc/purchase_order_item_detail_bloc.dart';
import '../purchase_order_detail_bloc/purchase_order_item_detail_bloc_state.dart';

class PurchaseOrderItemDetailAttachmentWidget extends StatelessWidget {
  const PurchaseOrderItemDetailAttachmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      PurchaseOrderItemDetailBloc,
      PurchaseOrderItemDetailBlocState
    >(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return AppDecoratedBoxShadowWidget(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //attachment
                  Row(
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
                        "${context.l.attachment} (0)",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSize.size20),

                  //upload button
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,

                        builder: (context) {
                          return SizedBox();
                          // return SizedBox(
                          //   height: MediaQuery.of(context).size.height * .30,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(
                          //       AppPadding.scaffoldPadding,
                          //     ),
                          //     child: UploadFileWidget(
                          //       fromPage: AppString.createLabel,
                          //       poId: poId,
                          //       dtId: dtId,
                          //       itemId: itemId,
                          //     ),
                          //   ),
                          // );
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
                            SvgPicture.asset(
                              AppIcons.uploadIcon,
                              height: AppSize.size22,
                              width: AppSize.size22,
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
                  // ListView.builder(
                  //   itemCount: state.goodsReceiptLabelAttachmentEntityList.length,
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(bottom: AppSize.size10),
                  //       child: InkWell(
                  //         //R.L TODO
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder:
                  //                   (_) => FullScreenImageViewer(
                  //                 attachmentList:
                  //                 state
                  //                     .goodsReceiptLabelAttachmentEntityList,
                  //                 initialIndex: index,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         child: AttachmentTileWidget(
                  //           imagePath:
                  //           (state.goodsReceiptLabelAttachmentEntityList[index])
                  //               .getThumbnailImage(),
                  //           subtitle:
                  //           state
                  //               .goodsReceiptLabelAttachmentEntityList[index]
                  //               .transactionDtId,
                  //           title:
                  //           state
                  //               .goodsReceiptLabelAttachmentEntityList[index]
                  //               .fileName,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
