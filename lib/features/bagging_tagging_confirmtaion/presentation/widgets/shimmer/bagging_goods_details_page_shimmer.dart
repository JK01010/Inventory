import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';

class BaggingGoodsDetailsPageShimmer extends StatelessWidget {
  const BaggingGoodsDetailsPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppPadding.padding6),
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius15),
          ),
          child: Shimmer.fromColors(
            baseColor: AppColor.colorBlack6,
            highlightColor: AppColor.colorIconBackgroundGrey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSize.size10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size40,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size20,
                      ),
                      SizedBox(height: AppSize.size10),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(height: AppSize.size10),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.colorIconBackgroundGrey,
                              borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                            ),
                            height: AppSize.size10,
                            width: AppSize.size80,
                          ),
                          SizedBox(width: AppSize.size30),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.colorIconBackgroundGrey,
                              borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                            ),
                            height: AppSize.size10,
                            width: AppSize.size10,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size40,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size20,
                      ),
                      SizedBox(height: AppSize.size10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppSize.size5),
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppPadding.padding6),
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius15),
          ),
          child: Shimmer.fromColors(
            baseColor: AppColor.colorBlack6,
            highlightColor: AppColor.colorIconBackgroundGrey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size20,
                        width: AppSize.size150,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size10),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(width: AppSize.size60),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size10),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.borderRadius15,
                          ),
                        ),
                        height: AppSize.size50,
                        width: AppSize.size120,
                      ),
                      SizedBox(width: AppSize.size20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size100,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size10),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.borderRadius15,
                          ),
                        ),
                        height: AppSize.size50,
                        width: AppSize.size120,
                      ),
                      SizedBox(width: AppSize.size20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size100,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size10),
                  Divider(),
                  SizedBox(height: AppSize.size10),

                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(width: AppSize.size60),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size20),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.borderRadius15,
                          ),
                        ),
                        height: AppSize.size50,
                        width: AppSize.size120,
                      ),
                      SizedBox(width: AppSize.size20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size100,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size10),
                  Divider(),
                  SizedBox(height: AppSize.size10),

                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(width: AppSize.size60),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size10),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.borderRadius15,
                          ),
                        ),
                        height: AppSize.size50,
                        width: AppSize.size120,
                      ),
                      SizedBox(width: AppSize.size20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppSize.size5),
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppPadding.padding6),
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius15),
          ),
          child: Shimmer.fromColors(
            baseColor: AppColor.colorBlack6,
            highlightColor: AppColor.colorIconBackgroundGrey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSize.size10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size20,
                        width: AppSize.size50,
                      ),
                      SizedBox(height: AppSize.size15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size70,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size40,
                        width: AppSize.size50,
                      ),
                      SizedBox(height: AppSize.size10),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size100,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size20,
                        width: AppSize.size50,
                      ),
                      SizedBox(height: AppSize.size15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                      SizedBox(height: AppSize.size15),
                      Container(
                        color: AppColor.colorTransparent,
                        height: AppSize.size10,
                        width: AppSize.size40,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        color: AppColor.colorTransparent,
                        height: AppSize.size10,
                        width: AppSize.size20,
                      ),
                      SizedBox(height: AppSize.size10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
