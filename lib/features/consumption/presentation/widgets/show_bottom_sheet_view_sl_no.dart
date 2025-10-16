import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';


Future showBottomSheetViewSlNo(BuildContext context,List<String> slNoList) {
  final TextTheme textTheme = Theme.of(context).textTheme;
  return  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: AppColor.colorWhite,
    builder: (context) {
      return SizedBox(
        height: AppHeight.iconSize280,
        child: Column(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //print mode area
                Padding(
                  padding: const EdgeInsets.all(AppPadding.padding20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        context.l.viewSlNo,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: SvgPicture.asset(
                          AppIcons.closeIcon,
                          height: AppSize.size29,
                          width: AppSize.size29,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    height: 190,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 60),
                      itemCount: slNoList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sl No.${index + 1}", style: textTheme.titleSmall?.copyWith(color: AppColor.colorBlack2)),
                              Text(slNoList[index], style: textTheme.titleSmall?.copyWith(color: AppColor.colorPrimary)),
                            ],
                          ),
                        );
                      },
                    )
                  ),
                )

              ],
            ),
          ],
        ),
      );
      // return GoodReceiptFilterWidget();
    },
  );
}