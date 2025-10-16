import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';

class UnlockBottomSheetWidget extends StatelessWidget {
  const UnlockBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: BottomSheetHeaderWidget(title: context.l.selectCategory),
        ),
        Divider(color: AppColor.closeButtonColor),
        Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.padding10,
                      right: AppPadding.padding10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("store"),
                        RoundedCheckBoxWidget(value: true, onTap: () {}),
                      ],
                    ),
                  ),
                  Divider(color: AppColor.colorBlack5),
                ],
              );
            },
          ),
        ),
        SizedBox(height: AppSize.size10,),
        AppTwoRowButtonWidget(buttonFirstTitle: context.l.clear,buttonSecondTitle: context.l.apply),
      ],
    );
  }
}