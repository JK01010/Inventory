import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/theme_extension.dart';

class BaggingPendingDetailsShimmer extends StatelessWidget {
  const BaggingPendingDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
      context.isDarkMode
          ? AppColor.colorDarkProfileContainer
          : AppColor.colorBlack6,
      highlightColor: AppColor.colorIconBackgroundGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.colorIconBackgroundGrey,
              borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
            ),
            height: AppSize.size20,
            width: AppSize.size150,
          ),
          SizedBox(height: AppSize.size15),
          Container(
            decoration: BoxDecoration(
              color: AppColor.colorIconBackgroundGrey,
              borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
            ),
            height: AppSize.size20,
            width: AppSize.size80,
          ),
          SizedBox(height: AppSize.size15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(height: AppSize.size10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size15,
                    width: AppSize.size100,
                  ),
                  SizedBox(height: AppSize.size15),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size10,
                    width: AppSize.size100,
                  ),
                  SizedBox(height: AppSize.size10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size15,
                    width: AppSize.size30,
                  ),
                  SizedBox(height: AppSize.size15),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size10,
                    width: AppSize.size100,
                  ),
                  SizedBox(height: AppSize.size10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size15,
                    width: AppSize.size30,
                  ),
                  SizedBox(height: AppSize.size20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSize.size6,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size180,
                      ),
                      //yes
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorIconBackgroundGrey,
                          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                        ),
                        height: AppSize.size10,
                        width: AppSize.size30,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(height: AppSize.size10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size15,
                    width: AppSize.size100,
                  ),
                  SizedBox(height: AppSize.size15),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size10,
                    width: AppSize.size100,
                  ),
                  SizedBox(height: AppSize.size10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size15,
                    width: AppSize.size30,
                  ),
                  SizedBox(height: AppSize.size15),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size10,
                    width: AppSize.size100,
                  ),
                  SizedBox(height: AppSize.size10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorIconBackgroundGrey,
                      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius5),
                    ),
                    height: AppSize.size15,
                    width: AppSize.size30,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
