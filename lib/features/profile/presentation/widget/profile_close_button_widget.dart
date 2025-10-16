import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import '../../../../core/extensions/theme_extension.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: AppSize.size0,
      top: ((height * .14) + kToolbarHeight) - AppSize.profileImageRadius,
      child: CloseButton(
        color: context.isDarkMode
        ?AppColor.colorCloseGrey
        :AppColor.colorBlack2,
        onPressed: () {
          Scaffold.of(context).closeDrawer();
        },
      ),
    );
  }
}
