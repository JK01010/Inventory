import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/widgets/custom_pre_image_button.dart';

import '../../../../core/routes/route_name.dart';

class SplitStorageLocationBottomBarWidget extends StatelessWidget {
  const SplitStorageLocationBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius20),
              color: AppColor.colorIconBackgroundGrey),
          child: Column(
          children: [
            SizedBox(height: AppSize.size10,),
            Container(height: AppSize.size4,
              width: AppSize.size70,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
                  color: AppColor.colorGrey3),
            ),
            SizedBox(height: AppSize.size30,),
            Column(
              children: [
                CustomPreImageButton(buttonName: context.l.damagedQuantity,
                  onTap: (){
                    context.pop();
                  },
                  iconName: AppIcons.damagedQuantityIcon,
                  color: AppColor.colorWhite,
                  buttonNameColor: AppColor.colorTextBlack2,),
                SizedBox(height: 8,),
                CustomPreImageButton(buttonName: context.l.newQuantity,
                  onTap: (){
                    context.pop();
                  },
                  iconName: AppIcons.newQuantityIcon,
                  color: AppColor.colorWhite,
                  buttonNameColor: AppColor.colorTextBlack2,),
                SizedBox(height: 8,),
                CustomPreImageButton(buttonName: context.l.reconditionedQuantity,
                  onTap: (){
                    context.pop();
                  },
                  iconName: AppIcons.reConditionedQuantityIcon,
                  color: AppColor.colorWhite,
                  buttonNameColor: AppColor.colorTextBlack2,),
              ],
            ),
            SizedBox(height: AppSize.size20,)
          ],
         ),
        )],
    );
  }
}
