import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/theme_extension.dart';

class TransactionDetailsShimmer extends StatelessWidget {
  const TransactionDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppPadding.padding14),
        child: Shimmer.fromColors(
          baseColor:
          context.isDarkMode
              ? AppColor.colorDarkProfileContainer
              : AppColor.colorBlack6,
          highlightColor: AppColor.colorIconBackgroundGrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: AppSize.size15),
                    Container(
                      color: AppColor.colorIconBackgroundGrey,
                      height: AppSize.size20,
                      width: AppSize.size150,
                    ),
                    SizedBox(height: AppSize.size15),
                    //Equipment name
                    Row(
                      children: [
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size80,
                        ),
                        SizedBox(width: AppSize.size50),
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size80,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.size5),
                    Row(
                      children: [
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size80,
                        ),
                        SizedBox(width: AppSize.size50),
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size50,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.size15),
                    //Part No
                    Row(
                      children: [
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size50,
                        ),
                        SizedBox(width: AppSize.size30),
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size30,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.size5),
                    Row(
                      children: [
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size50,
                        ),
                        SizedBox(width: AppSize.size30),
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size20,
                        ),
                      ],
                    ),

                    SizedBox(height: AppSize.size15),
                    // Article section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size70,
                        ),
                        SizedBox(height: AppSize.size5),
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size60,
                        ),
                        SizedBox(height: AppSize.size15),
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size90,
                        ),
                        SizedBox(height: AppSize.size5),
                        Container(
                          color: AppColor.colorIconBackgroundGrey,
                          height: AppSize.size10,
                          width: AppSize.size250,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.size15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
