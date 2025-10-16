import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../good_receipts/presentation/widgets/yes_no_widget.dart';

class CustomizableColumn extends StatelessWidget {
  final String titleText;
  final String yesNoText;
  final Color yesNoTextColor;
  final Color bgColor;

  const CustomizableColumn({
    super.key,
    this.titleText = 'Required', // Default value for context.loc.mdRequired
    this.yesNoText = 'No', // Default value for 'No' text
    this.yesNoTextColor =
        AppColor.colorHeadline3, // Default for AppColor.colorHeadline3
    this.bgColor = AppColor.colorGrey2, // Default for AppColor.colorGrey2
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First Text Widget
        Text(
          titleText, // Customizable text
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
            fontSize: AppFontSize.fontSize13, // Fixed font size as per original
          ),
        ),
        SizedBox(height: AppSize.size6),

        //Yes No text
        yesNoText == 'Y' ? YesNoWidget.yes(context) : YesNoWidget.no(context),
      ],
    );
  }
}
