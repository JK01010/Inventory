import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  final bool isCheck;
  final Function()? onTap;

  const CustomCheckBoxWidget({super.key, required this.isCheck, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSize.size20,
        height: AppSize.size20,

        child:
            isCheck
                ? DecoratedBox(
                  decoration: BoxDecoration(
                    color:
                        isCheck ? AppColor.colorPrimary : AppColor.colorWhite,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColor.colorPrimaryDark,
                      width: 2,
                    ),
                  ),
                  child: Icon(Icons.done, size: 15, color: AppColor.colorWhite),
                )
                : DecoratedBox(
                  decoration: BoxDecoration(
                    color:
                        isCheck ? AppColor.colorPrimary : AppColor.colorWhite,
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderRadius5,
                    ),
                    border: Border.all(color: AppColor.colorBlack2, width: 2),
                  ),
                ),
      ),
    );
  }
}
