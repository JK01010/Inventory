import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_images.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(this.profileImage, {super.key});

  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoute.profileDetailPage.path);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.customThemeColor(
              light: AppColor.colorWhite,
              dark: AppColor.colorBlack,
            ),
            width: AppSize.borderWidth,
          ),
        ),
        child: Center(
          child:
              profileImage.isEmpty
                  ? ClipOval(
                    child: Image.asset(
                      AppImage.personImage,
                      width: AppSize.profileImageRadius * 2,
                      height: AppSize.profileImageRadius * 2,
                      fit:
                          BoxFit
                              .cover, // or BoxFit.contain depending on your need
                    ),
                  )
                  : Image.network(
                    profileImage,
                    width: AppSize.profileImageRadius * 2,
                    height: AppSize.profileImageRadius * 2,
                  ),
        ),
      ),
    );
  }
}
