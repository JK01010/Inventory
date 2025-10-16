import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../../good_receipts/presentation/widgets/create_label_slider_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_flat_button.dart';
import '../../../widgets/chip_icon_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../../../widgets/wifi_animation_widget.dart';
import 'bottom_button_widget.dart';

class ViewRfidListDetailsPage extends StatelessWidget {
  const ViewRfidListDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(title: context.l.viewRfid),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          RoundedCheckBoxWidget(value: false, onTap: () {}),
                          SizedBox(width: AppSize.size6),
                          Text(
                            "08${context.l.itemsFound}",
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          WifiScanAnimation(),
                          Text(
                            context.l.rfIdScanning,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: AppFontSize.fontSize14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppSize.size10),
                AppDecoratedBoxShadowWidget(
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
                        // CreateLabelSliderWidget(),

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
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSize.size20),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: AppDecoratedBoxShadowWidget(
                    child: ListView.separated(
                      padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                      itemBuilder: (context, index) {
                        return ListingDetailsRfidWidget();
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: AppSize.size13),
                      itemCount: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomButtonWidget(
          buttonFirstTitle: context.l.close,
          buttonFirstOnPress: () {
            context.pop();
          },
          buttonSecondTitle: context.l.save,
          buttonSecondOnPress: () {
            context.pop();
          },
        ),
      ),
    );
  }
}

class ListingDetailsRfidWidget extends StatelessWidget {
  const ListingDetailsRfidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppPadding.padding8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RoundedCheckBoxWidget(value: true, onTap: () {}),

          SizedBox(width: AppSize.size10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "RFID 1",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: AppFontSize.fontSize13,
                    ),
                  ),
                  SizedBox(width: AppSize.size6),
                  ChipWidget(
                    chipText: "Tagged With Another",
                    color: AppColor.colorYellow,
                  ),
                ],
              ),
              Text(
                "A9776123-12122024-JAX-30087GRN24",
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColor.colorPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
