import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/routes/route_name.dart';

import '../../../bagging_tagging_confirmtaion/data/model/rfid_screen_type.dart';
import '../../../widgets/App_item_detail_row_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_heading_widget.dart';
import '../../../widgets/app_title_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import 'create_label_details_bottom_button_widget.dart';
import 'goods_receipt_value_widget.dart';
import 'serial_number_widget.dart';
import 'square_checkbox_widget.dart';
import 'view_rfid_widget.dart';

class CreateLabelDetailsPage extends StatelessWidget {
  const CreateLabelDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(title: context.l.createLabel),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: SingleChildScrollView(
            child: Column(children: [PrintRfidCardWidget()]),
          ),
        ),
        bottomNavigationBar: CreateLabelDetailsBottomButtonWidget(
          buttonSecondTitle: context.l.print,
        ),
      ),
    );
  }
}

class PrintRfidCardWidget extends StatelessWidget {
  const PrintRfidCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppHeadingWidget(text: "Enamel - Green"),
                SizedBox(height: AppSize.size10),
                // GRN no and category row
                AppItemDetailRowWidget(
                  titleFirst: context.l.serialNo,
                  valueFirst: "1055",
                  titleSecond: context.l.storageLocation,
                  valueSecond: "Bosun Store",
                  viewSlNoWidget: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,

                        backgroundColor: AppColor.colorWhite,
                        builder: (context) {
                          return SerialNumberWidget();
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          context.l.viewSlNo,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: AppColor.colorPrimary),
                        ),
                        SizedBox(width: AppSize.size6),
                        SvgPicture.asset(AppIcons.eyeIcon),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSize.size10),

                AppItemDetailRowWidget(
                  titleFirst: context.l.rfidId,
                  valueFirst: "9876123",
                  titleSecond: context.l.articleName,
                  valueSecond: "Exact Value",
                ),

                SizedBox(height: AppSize.size10),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTitleWidget(text: context.l.receivedQty),
                          GoodsReceiptValueWidget(text: "11"),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSize.size36),
                    SizedBox(
                      width: AppSize.size133,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // AppTitleWidget(text: titleSecond),
                          // GoodsReceiptValueWidget(text: "valueSecond"),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColor.colorWhite,
                                builder: (context) {
                                  return ViewRfidWidget();
                                },
                              );
                            },
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.push(
                                      AppRoute.viewRfidListViewing.path,
                                      extra: RfidScreenType.baggingTagging,
                                    );
                                  },
                                  child: Text(
                                    context.l.viewRfid,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge?.copyWith(
                                      color: AppColor.colorPrimary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: AppSize.size6),
                                SvgPicture.asset(AppIcons.eyeIcon),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
                Row(
                  children: [
                    SquareCheckboxWidget(value: false, onTap: () {  },),
                    SizedBox(width: AppSize.size10),
                    Text(
                      "Exclude Label Text",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColor.colorBlack2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
