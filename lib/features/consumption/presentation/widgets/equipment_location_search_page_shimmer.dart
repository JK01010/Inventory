import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/common_shimmer_box_decoration.dart';

class EquipmentLocationSearchPageShimmer extends StatelessWidget {
  const EquipmentLocationSearchPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    children: [
                      Container(
                        decoration: commonShimmerDecoration(),
                        height: AppSize.size20,
                        width: AppSize.size20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        child: Column(
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
