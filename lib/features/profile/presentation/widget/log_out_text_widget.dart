import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';

import '../../../../core/routes/route_name.dart';

class LogOutTextWidget extends StatelessWidget {
  const LogOutTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppSize.size50,
      left: AppSize.size0,
      right: AppSize.size0,
      child: InkWell(
        onTap: (){
          context.push(AppRoute.login.path);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.l.logout,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColor.redColor),
            ),
            SizedBox(width: AppSize.size6),
            SvgPicture.asset(AppIcons.logOutIcon),
          ],
        ),
      ),
    );
  }
}
