import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/routes/route_name.dart';
import '../../bagging_tagging_confirmtaion/data/model/rfid_screen_type.dart';
import '../../bagging_tagging_confirmtaion/presentation/widgets/bottom_button_widget.dart';
import '../../widgets/app_decorated_box_shadow_widget.dart';
import '../../widgets/app_heading_widget.dart';
import '../../widgets/app_item_detail_row_widget.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/app_title_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_background_widget.dart';
import '../../widgets/rounded_check_box_widget.dart';
import 'widgets/goods_receipt_value_widget.dart';
import 'widgets/serial_number_widget.dart';

class PrintRfidPage extends StatelessWidget {
  const PrintRfidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(title: context.l.printRfid),
        body:
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.padding20,
                    right: AppPadding.scaffoldPadding,
                    top: AppPadding.scaffoldPadding,
                  ),
                  child: Row(
                    children: [
                      RoundedCheckBoxWidget(
                        value: true,
                        onTap: () {
                        },
                      ),
                      SizedBox(width: AppSize.size18),
                      Text(
                        "${'${2}'.padLeft(2, '0')}${context.l.numberItems}",
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                      child: PrintRfidCardWidget(
                        index: index,
                      ),
                    );
                  },
                ),
              ],
            ),

        bottomNavigationBar: BottomButtonWidget(
          buttonSecondOnPress: () {},
          buttonSecondTitle: context.l.print,
        ),
        // PrintRfIdBottomButtonWidget(
        //   buttonSecondTitle: context.l.print,
        // ),
      ),
    );
  }
}

class PrintRfidCardWidget extends StatelessWidget {
  final int index;

  const PrintRfidCardWidget({
    super.key,
    required this.index,
  });

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
                AppHeadingWidget(
                  text:" entity.itemName",
                  labelCheckbox: true,
                  showCheckBox: true,
                  onTapCheckBox: () {
                  },
                ),
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
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.8,
                            child: SerialNumberWidget(),
                          );
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
                  valueFirst: "entity.remark",
                  titleSecond: context.l.articleName,
                  valueSecond: "entity.articleNumber",
                ),

                SizedBox(height: AppSize.size10),
                // Category
                Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppTitleWidget(text: context.l.receivedQty),
                              GoodsReceiptValueWidget(
                                text: "entity.receivedQty.toString()",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.size10),
                    Row(
                      children: [
                        Container(
                          width: AppSize.size160,
                          height: AppSize.size45,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              /* side: const BorderSide(
                              width: 1,
                              color: AppColor.colorBlack2,
                            ),*/
                              borderRadius: BorderRadius.circular(
                                AppBorderRadius.borderRadius12,
                              ),
                            ),
                          ),
                          child: AppTextFormField(
                            hintText: "01",
                            labelText: context.l.printQty,
                          ),
                        ),
                        SizedBox(width: AppSize.size20),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.push(
                                  AppRoute.viewRfidListViewing.path,
                                  extra: {
                                    'itemId': 1,
                                    'screenType': RfidScreenType.baggingTagging,
                                  },
                                );
                              },
                              child: Text(
                                context.l.viewRfid,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(color: AppColor.colorPrimary),
                              ),
                            ),
                            SizedBox(width: AppSize.size6),
                            SvgPicture.asset(AppIcons.eyeIcon),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
