import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/theme_extension.dart';

class PurchaseOrderShimmerWidget extends StatelessWidget {
  const PurchaseOrderShimmerWidget({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.colorIconBackgroundGrey,
                            borderRadius: BorderRadius.circular(
                              AppBorderRadius.borderRadius5,
                            ),
                          ),
                          height: AppSize.size20,
                          width: AppSize.size150,
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
                    SizedBox(height: AppSize.size15),
                    // GRN no and category row
                    Row(
                      children: [
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
                        SizedBox(width: AppSize.size30),
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
                    SizedBox(height: AppSize.size10),
                    Row(
                      children: [
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
                        SizedBox(width: AppSize.size30),
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

                    SizedBox(height: AppSize.size10),
                    // Title section
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
                          width: AppSize.size50,
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
                          width: AppSize.size120,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Title
              Divider(height: AppSize.size0, color: AppColor.colorBlack5),
              Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.colorIconBackgroundGrey,
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.borderRadius5,
                        ),
                      ),
                      height: AppSize.size15,
                      width: AppSize.size40,
                    ),
                    SizedBox(width: AppSize.size10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.colorIconBackgroundGrey,
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.borderRadius5,
                        ),
                      ),
                      height: AppSize.size15,
                      width: AppSize.size40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
