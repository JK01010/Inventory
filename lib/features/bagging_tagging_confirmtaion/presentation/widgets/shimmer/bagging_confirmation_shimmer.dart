import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/theme_extension.dart';

class BaggingConfirmationShimmer extends StatelessWidget {
  const BaggingConfirmationShimmer({super.key});

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
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: AppSize.size5),
                Container(
                  height: AppSize.size12,
                  width: AppSize.size180,
                  decoration: BoxDecoration(
                    color: AppColor.colorIconBackgroundGrey,
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderRadius5,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.size18),
                // GRN no and category row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.colorIconBackgroundGrey,
                            borderRadius: BorderRadius.circular(
                              AppBorderRadius.borderRadius5,
                            ),
                          ),
                          height: AppSize.size10,
                          width: AppSize.size40,
                        ),
                        SizedBox(height: AppSize.size5),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.colorIconBackgroundGrey,
                            borderRadius: BorderRadius.circular(
                              AppBorderRadius.borderRadius5,
                            ),
                          ),
                          height: AppSize.size10,
                          width: AppSize.size80,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.colorIconBackgroundGrey,
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.borderRadius5,
                        ),
                      ),
                      height: AppSize.size30,
                      width: AppSize.size30,
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
