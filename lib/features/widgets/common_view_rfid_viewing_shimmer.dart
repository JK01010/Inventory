import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/theme_extension.dart';

class CommonViewRfidViewingShimmer extends StatelessWidget {
  const CommonViewRfidViewingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode? AppColor.colorDarkProfileContainer:AppColor.colorBlack6,
      highlightColor: AppColor.colorIconBackgroundGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.padding4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                SizedBox(height: AppSize.size6),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.colorIconBackgroundGrey,
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderRadius5,
                    ),
                  ),
                  height: AppSize.size10,
                  width: AppSize.size155,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
