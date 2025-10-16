import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../good_receipts/domain/entities/split_location_entity.dart';
import '../../../good_receipts/presentation/goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';
import '../../../good_receipts/presentation/widgets/add_location_bottom_bar_widget.dart';
import '../../../good_receipts/presentation/widgets/create_label_item_row_widget.dart';
import '../bloc/bagging_tagging_split_location_bloc/bagging_tagging_split_location_bloc.dart';
import 'package:collection/collection.dart';

class CustomInfoCard extends StatefulWidget {
  final String heading1;
  final String damagedQty;
  final String storage;
  final String newQty;
  final String receivedQty;
  final List<SplitLocationEntity> newQuantityList;
  final List<SplitLocationEntity> damagedQuantity;
  final List<SplitLocationEntity> reconditionedQuantityList;
  final List<Map<String, dynamic>> newQuantityListTextControllerList;

  const CustomInfoCard({
    super.key,
    required this.heading1,
    required this.damagedQty,
    required this.storage,
    required this.newQty,
    required this.receivedQty,
    required this.newQuantityList,
    required this.damagedQuantity,
    required this.reconditionedQuantityList,
    required this.newQuantityListTextControllerList,
  });

  @override
  State<CustomInfoCard> createState() => _CustomInfoCardState();
}

class _CustomInfoCardState extends State<CustomInfoCard> {
  Widget buildSizedBox15() {
    return const SizedBox(height: 15);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return  ListView.builder(
    //     // padding: const EdgeInsets.all(8),
    //     itemCount:2,
    //     itemBuilder: (BuildContext context, int index) {

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.padding15,
        vertical: AppPadding.padding15,
      ),
      decoration: ShapeDecoration(
        color:
            context.isDarkMode
                ? AppColor.colorDarkProfileContainer
                : AppColor.colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.heading1,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                  fontSize: AppFontSize.fontSize14,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.size20),

          //Damage Qty
          Row(
            children: [
              //Received Qty
              SizedBox(
                width: AppSize.size114,
                child: Text(
                  widget.damagedQty,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.customThemeColor(
                      light: AppColor.colorCommonTextColor,
                      dark: AppColor.colorDividerLight,
                    ),
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize14,
                  ),
                ),
              ),

              //Storage
              SizedBox(width: AppSize.size29),
              Expanded(
                child: Text(
                  widget.storage,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.customThemeColor(
                      light: AppColor.colorCommonTextColor,
                      dark: AppColor.colorDividerLight,
                    ),
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize14,
                  ),
                ),
              ),
              //3 dot
              SizedBox(
                height: AppSize.size15,
                width: AppSize.size15,
                child: InkWell(
                  onHover: (bool hOver) {},
                  onTap: onTapEvent(context, context.l.damagedQuantity),
                  child: SvgPicture.asset(
                    AppIcons.burgerIcon,
                    height: AppSize.size15,
                    width: AppSize.size15,
                    colorFilter:
                        context.isDarkMode
                            ? const ColorFilter.mode(
                              AppColor.colorDividerLight,
                              BlendMode.srcIn,
                            )
                            : null,
                  ),
                ),
              ),
            ],
          ),

          BlocBuilder<
            BaggingTaggingSplitLocationBloc,
            BaggingTaggingSplitLocationState
          >(
            builder: (context, state) {
              return Column(
                children: getStorageLocationWidgets(
                  widget.damagedQuantity,
                  context.l.damagedQuantity,
                ),
              );
            },
          ),

          SizedBox(height: AppSize.size10),
          Divider(),
          SizedBox(height: AppSize.size10),
          //received qty
          Row(
            children: [
              //Received Qty
              SizedBox(
                width: AppSize.size114,
                child: Text(
                  widget.newQty,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.customThemeColor(
                      light: AppColor.colorCommonTextColor,
                      dark: AppColor.colorDividerLight,
                    ),
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize14,
                  ),
                ),
              ),

              //Storage
              SizedBox(width: AppSize.size29),
              Expanded(
                child: Text(
                  widget.storage,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.customThemeColor(
                      light: AppColor.colorCommonTextColor,
                      dark: AppColor.colorDividerLight,
                    ),
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize14,
                  ),
                ),
              ),
              //3 dot
              SizedBox(
                height: AppSize.size15,
                width: AppSize.size15,
                child: InkWell(
                  onHover: (bool hOver) {},
                  onTap: onTapEvent(context, context.l.newQuantity),
                  child: SvgPicture.asset(
                    AppIcons.burgerIcon,
                    height: AppSize.size15,
                    width: AppSize.size15,
                    colorFilter:
                        context.isDarkMode
                            ? const ColorFilter.mode(
                              AppColor.colorDividerLight,
                              BlendMode.srcIn,
                            )
                            : null,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSize.size6),
          BlocBuilder<
            BaggingTaggingSplitLocationBloc,
            BaggingTaggingSplitLocationState
          >(
            builder: (context, state) {
              return Column(
                children: getStorageLocationWidgets(
                  widget.newQuantityList,
                  context.l.newQuantity,
                ),
              );
            },
          ),
          SizedBox(height: AppSize.size10),

          Divider(),
          SizedBox(height: AppSize.size10),
          //received qty
          Row(
            children: [
              //Received Qty
              SizedBox(
                width: AppSize.size114,
                child: Text(
                  widget.receivedQty,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.customThemeColor(
                      light: AppColor.colorCommonTextColor,
                      dark: AppColor.colorDividerLight,
                    ),
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize14,
                  ),
                ),
              ),

              //Storage
              SizedBox(width: AppSize.size29),
              Expanded(
                child: Text(
                  widget.storage,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.customThemeColor(
                      light: AppColor.colorCommonTextColor,
                      dark: AppColor.colorDividerLight,
                    ),
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize14,
                  ),
                ),
              ),
              //3 dot
              SizedBox(
                height: AppSize.size15,
                width: AppSize.size15,
                child: InkWell(
                  onHover: (bool hOver) {},
                  onTap: onTapEvent(context, context.l.reconditionedQuantity),
                  child: SvgPicture.asset(
                    AppIcons.burgerIcon,
                    height: AppSize.size15,
                    width: AppSize.size15,
                    colorFilter:
                        context.isDarkMode
                            ? const ColorFilter.mode(
                              AppColor.colorDividerLight,
                              BlendMode.srcIn,
                            )
                            : null,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.size6),
          BlocBuilder<
            BaggingTaggingSplitLocationBloc,
            BaggingTaggingSplitLocationState
          >(
            builder: (context, state) {
              return Column(
                children: getStorageLocationWidgets(
                  widget.reconditionedQuantityList,
                  context.l.reconditionedQuantity,
                ),
              );
            },
          ),
          SizedBox(height: AppSize.size10),
        ],
      ),
    );
    //   }
    // );
  }

  VoidCallback onTapEvent(BuildContext context, String quantityType) {
    return () {
      debugPrint("tappeddd");
      showModalBottomSheet(
        context: context,
        showDragHandle: false,
        enableDrag: false,
        isScrollControlled: true,
        builder: (context) {
          return SafeArea(
            child: BlocBuilder<
              GoodsReceiptCreateLabelBloc,
              GoodsReceiptCreateLabelState
            >(
              builder: (context, state) {
                return AddLocationBottomBarWidget(
                  onTap: () {},
                  // TODO Commented for the GRPOLineItem model change
                  // onTap: () {
                  //   if (state.goodsReceiptPurchaseItemDetailEntity != null) {
                  //     context.read<BaggingTaggingSplitLocationBloc>().add(
                  //       AddEmptySplitStorageLocationWidgetEvent(
                  //         state.goodsReceiptPurchaseItemDetailEntity!.poId,
                  //         state.goodsReceiptPurchaseItemDetailEntity!.grnId,
                  //         state.goodsReceiptPurchaseItemDetailEntity!.itemId,
                  //         quantityType,
                  //       ),
                  //     );
                  //   }
                  //   context.pop();
                  // },
                  iconName: AppIcons.addIcon,
                  buttonName: context.l.add,
                );
              },
            ),
          );
        },
      );
    };
  }

  List<Widget> getStorageLocationWidgets(
    List<SplitLocationEntity> items,
    String robType,
  ) {
    return items.map((element) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        child: CreateLabelItemRowWidget(
          splitLocationEntity: element,
          quantityController:
              widget.newQuantityListTextControllerList.firstWhereOrNull(
                (element2) =>
                    element2.containsKey(element.locationId.toString()),
              )?[element.locationId.toString()] ?? TextEditingController(),
          // goodsReceiptPurchaseItemDetailEntity:
          //     state.goodsReceiptPurchaseItemDetailEntity!,
        ),
      );
      // return Container(child: Text(element.locationName));
    }).toList();

    // List<Widget> storageLocationWidgetList = [];
    // _splitStorageLocationTextControllerList.clear();
    // for (var element in states.splitLocationEntityList) {
    //   if (element.quantityType == robType) {
    //     TextEditingController textEditingController = TextEditingController(
    //       text: '${element.robQty}',
    //     );
    //     textEditingController.selection = TextSelection.fromPosition(
    //       TextPosition(offset: textEditingController.text.length),
    //     );
    //     // _splitStorageLocationTextControllerList.add(textEditingController);
    //     storageLocationWidgetList
    //       ..add(SizedBox(height: 7))
    //       ..add(
    //         BlocBuilder<
    //           GoodsReceiptCreateLabelBloc,
    //           GoodsReceiptCreateLabelState
    //         >(
    //           builder: (context, state) {
    //             debugPrint("test Datatattaa");
    //             return SizedBox();
    //             // TODO Commented for the GRPOLineItem model change
    //             // return CreateLabelItemRowWidget(
    //             //   splitLocationEntity: element,
    //             //   quantityController: textEditingController,
    //             //   goodsReceiptPurchaseItemDetailEntity:
    //             //       state.goodsReceiptPurchaseItemDetailEntity!,
    //             //   indexPosition: states.splitLocationEntityList.indexOf(
    //             //     element,
    //             //   ),
    //             // );
    //           },
    //         ),
    //       )
    //       ..add(SizedBox(height: 7));
    //   }
    // }
    // _splitStorageLocationEntityList = states.splitLocationEntityList;
    // return storageLocationWidgetList;
  }

  // List<SplitLocationEntity> get splitStorageLocationEntityList =>
  //     _splitStorageLocationEntityList;
  //
  // List<TextEditingController> get splitStorageLocationTextControllerList =>
  //     _splitStorageLocationTextControllerList;
}
