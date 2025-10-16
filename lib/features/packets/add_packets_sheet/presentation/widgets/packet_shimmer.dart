import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';

class PacketsCardShimmer extends StatelessWidget {
  const PacketsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
          context.isDarkMode
              ? AppColor.colorDarkProfileContainer
              : AppColor.colorBlack6,
      highlightColor: AppColor.colorIconBackgroundGrey,
      child: AppDecoratedBoxShadowWidget(
        boxBorder: Border.all(
          color:
              context.isDarkMode
                  ? AppColor.colorDarkProfileContainer
                  : AppColor.colorGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.padding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title shimmer
              Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: AppSize.size16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: _buildShimmerColumn()),
                  SizedBox(
                    width: AppSize.size133,
                    child: _buildShimmerColumn(),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: AppSize.size9),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: _buildShimmerColumn()),
                  SizedBox(
                    width: AppSize.size133,
                    child: _buildShimmerColumn(),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: AppSize.size9),

              _buildShimmerColumn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title placeholder
        Container(
          width: 60,
          height: 16,
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        // Value placeholder
        Container(
          width: 80,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
