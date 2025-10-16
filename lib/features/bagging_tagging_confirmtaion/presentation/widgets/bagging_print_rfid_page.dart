import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../good_receipts/presentation/widgets/goods_receipt_value_widget.dart';
import '../../../widgets/App_item_detail_row_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_heading_widget.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/app_title_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../../data/model/rfid_screen_type.dart';
import '../../domain/entities/bagging_tagging_purchase_list_view_entity.dart';
import '../bloc/bagging_tagging_purchase_list/bagging_tagging_purchase_list_bloc.dart';
import 'bagging_serial_number_widget.dart';
import 'bottom_button_widget.dart';

class BaggingPrintRfidPage extends StatefulWidget {
  const BaggingPrintRfidPage({super.key});

  @override
  State<BaggingPrintRfidPage> createState() => _BaggingPrintRfidPageState();
}

class _BaggingPrintRfidPageState extends State<BaggingPrintRfidPage> {
  @override
  void initState() {
    super.initState();
    // context.read<BaggingTaggingPurchaseListBloc>().add(BaggingTaggingPurchaseInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: AppColor.colorTransparent,
        appBar: CustomAppBar(title: context.l.printRfid),
        body: BlocBuilder<
          BaggingTaggingPurchaseListBloc,
          BaggingTaggingPurchaseListState
        >(
          builder: (context, state) {
            return Column(
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
                        value: state.isCompleteSelected,
                        onTap: () {
                          context.read<BaggingTaggingPurchaseListBloc>().add(
                            IsAllItemsSelectEvent(
                              isSelected: !state.isCompleteSelected,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: AppSize.size18),
                      Text(
                        "${'${state.baggingTaggingPurchaseList.length}'.padLeft(2, '0')}${context.l.numberItems}",
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: state.baggingTaggingPurchaseList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                      child: BaggingPrintRfidCardWidget(
                        entity: state.baggingTaggingPurchaseList[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ],
            );
          },
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

class BaggingPrintRfidCardWidget extends StatelessWidget {
  final BaggingTaggingPurchaseListViewEntity entity;
  final int index;

  const BaggingPrintRfidCardWidget({
    super.key,
    required this.entity,
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
                  text: entity.itemName,
                  labelCheckbox: entity.isSelected,
                  showCheckBox: true,
                  onTapCheckBox: () {
                    context.read<BaggingTaggingPurchaseListBloc>().add(
                      IsCheckBoxSelectedEvent(
                        index: index,
                        isSelectedValue: !entity.isSelected,
                      ),
                    );
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

                        backgroundColor:
                            context.isDarkMode
                                ? AppColor.colorBGBlack
                                : AppColor.colorWhite,
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.8,
                            child: BaggingSerialNumberWidget(),
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
                        SvgPicture.asset(
                          AppIcons.eyeIcon,
                          colorFilter:
                              context.isDarkMode
                                  ? const ColorFilter.mode(
                                    AppColor.colorPrimary,
                                    BlendMode.srcIn,
                                  )
                                  : null,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSize.size10),
                AppItemDetailRowWidget(
                  titleFirst: context.l.rfidId,
                  valueFirst: entity.remark,
                  titleSecond: context.l.articleName,
                  valueSecond: entity.articleNumber,
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
                                text: entity.receivedQty.toString(),
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
                            color:
                                context.isDarkMode
                                    ? AppColor.colorTransparent
                                    : AppColor.colorWhite,
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
                                    'itemId': entity.itemId,
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
                            SvgPicture.asset(
                              AppIcons.eyeIcon,
                              colorFilter:
                                  context.isDarkMode
                                      ? const ColorFilter.mode(
                                        AppColor.colorPrimary,
                                        BlendMode.srcIn,
                                      )
                                      : null,
                            ),
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
