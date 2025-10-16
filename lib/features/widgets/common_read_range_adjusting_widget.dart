import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/localization_extension.dart';
import '../../core/extensions/text_theme_extension.dart';
import '../good_receipts/presentation/widgets/create_label_slider_widget.dart';
import 'app_decorated_box_shadow_widget.dart';

class CommonReadRangeAdjustingWidget extends StatelessWidget {
  const CommonReadRangeAdjustingWidget({
    super.key,
    required this.valuePassed,
    required this.onChanged,
  });

  final double valuePassed;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return  AppDecoratedBoxShadowWidget(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l.readRange,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
              CreateLabelSliderWidget(
                valuePassed: valuePassed,
                onChanged: onChanged,
              ),
          /*  SizedBox(height: AppSize.size6),
            Align(
              alignment: Alignment.centerRight,
              child: AppFlatButton(
                text: context.l.apply,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: AppPadding.padding30,
                ),
                textColor: AppColor.colorPrimary,
                onPressed: () {},
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
