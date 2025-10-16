import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/common_shimmer_box_decoration.dart';

class ConsumptionTransactionPageShimmer extends StatelessWidget {
  const ConsumptionTransactionPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
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
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size150,
                      ),
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size20,
                        width: AppSize.size20,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size18),
                  // GRN no and category row
                  Row(
                    children: [
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size40,
                      ),
                      SizedBox(width: AppSize.size120),
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size5),
                  //consumed Qty
                  Row(
                    children: [
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size120,
                      ),
                      SizedBox(width: AppSize.size40),
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size80,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size13),
                  // default storage
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size50,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size120,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.size13),
                  // remark
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size50,
                      ),
                      SizedBox(height: AppSize.size5),
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size10,
                        width: AppSize.size120,
                      ),
                    ],
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
