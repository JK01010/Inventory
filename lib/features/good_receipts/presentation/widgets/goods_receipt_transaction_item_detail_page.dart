import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/features/widgets/custom_app_bar.dart';
import 'package:pal_ng_inventory/features/widgets/gradient_background_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../bagging_tagging_confirmtaion/presentation/page/bagging_tagging_details_page.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../domain/entities/split_location_entity.dart';
import '../goods_receipt_split_location_bloc/goods_receipt_split_location_bloc.dart';
import '../goods_receipt_transaction_detail_bloc/goods_receipts_transaction_detail_bloc.dart';
import 'add_location_bottom_bar_widget.dart';
import 'create_label_item_row_widget.dart';
import 'goods_receipts_transaction_item_detail_bottom_card_widget.dart';
import 'goods_receipts_transaction_item_detail_first_card_widget.dart';
import 'split_storage_location_bottom_bar_widget.dart';

class GoodsReceiptTransactionItemDetailPage extends StatelessWidget {
  GoodsReceiptTransactionItemDetailPage({
    super.key,
    required this.grnDtId,
    required this.selectedItemPosition,
  });

  final int grnDtId;
  final int selectedItemPosition;
  final GlobalKey<SplitStorageLocationWidgetState>
  _splitStorageLocationWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: BlocBuilder<
        GoodsReceiptsTransactionDetailBloc,
        GoodsReceiptsTransactionDetailState
      >(
        builder: (context, state) {
          if (state.isLoading == true) {
            return GradientBackground(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.colorPrimary,
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: CustomAppBar(
                title:
                    state
                        .goodsReceiptPurchaseItemDetailEntityList[selectedItemPosition]
                        .productName,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                  child: Column(
                    children: <Widget>[
                      //first card
                      GoodsReceiptsTransactionItemDetailFirstCardWidget(
                        selectedTransactionItemIndex: selectedItemPosition,
                      ),
                      //second card
                      SizedBox(height: AppSize.size15),
                      //Split storage
                      AppDecoratedBoxShadowWidget(
                        child: Padding(
                          padding: const EdgeInsets.all(
                            AppPadding.scaffoldPadding,
                          ),
                          child: SplitStorageLocationWidget(
                            key: _splitStorageLocationWidgetKey,
                            state
                                .goodsReceiptPurchaseItemDetailEntityList[selectedItemPosition],
                            grnDtId: grnDtId,
                          ),
                        ),
                      ),
                      //bottom card
                      SizedBox(height: AppSize.size15),
                      GoodsReceiptsTransactionItemDetailBottomCardWidget(
                        itemId:
                            '${state.goodsReceiptPurchaseItemDetailEntity.itemId}',
                      ),
                    ],
                  ),
                ),
              ),
              // bottomNavigationBar: Padding(
              //   padding: const EdgeInsets.only(
              //     left: AppPadding.scaffoldPadding,
              //     right: AppPadding.scaffoldPadding,
              //     bottom: AppPadding.scaffoldPadding,
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Expanded(
              //         child: AppFlatButton(
              //           backgroundColor: context.customThemeColor(
              //             light: AppColor.colorWhite,
              //             dark: AppColor.colorTransparent,
              //           ),
              //           textColor: AppColor.colorPrimary,
              //           text: context.l.cancel,
              //           onPressed: () {},
              //         ),
              //       ),
              //       SizedBox(width: AppSize.size8),
              //       Expanded(
              //         child: AppFlatButton(
              //           backgroundColor: AppColor.colorPrimary,
              //           textColor: AppColor.colorWhite,
              //           text: context.l.save,
              //           onPressed: onSaveTransactionDetail(),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            );
          }
        },
      ),
    );
  }

  GlobalKey<SplitStorageLocationWidgetState>
  get splitStorageLocationWidgetKey => _splitStorageLocationWidgetKey;

  // VoidCallback onSaveTransactionDetail() {
  //   return () {
  //     if (splitStorageLocationWidgetKey.currentState != null) {
  //       List<SplitLocationEntity>? splitLocationEntityList =
  //           _splitStorageLocationWidgetKey
  //               .currentState
  //               ?._splitStorageLocationEntityList;
  //
  //       if (splitLocationEntityList!.isNotEmpty) {
  //         sl<GoodsReceiptSplitLocationBloc>().add(
  //           UpdateSplitLocationInTableOnLabelDetailEvent(
  //             splitLocationEntityList,
  //           ),
  //         );
  //       }
  //     }
  //   };
  // }
}

class SplitStorageLocationWidget extends StatefulWidget {
  SplitStorageLocationWidget(
    this.goodsReceiptPurchaseItemDetailEntity, {
    required GlobalKey<SplitStorageLocationWidgetState> key,
    required this.grnDtId,
  }) : super(key: key);

  GoodsReceiptPurchaseItemDetailEntity? goodsReceiptPurchaseItemDetailEntity;
  final int grnDtId;

  @override
  State<SplitStorageLocationWidget> createState() =>
      SplitStorageLocationWidgetState();
}

class SplitStorageLocationWidgetState
    extends State<SplitStorageLocationWidget> {
  List<SplitLocationEntity> _splitStorageLocationEntityList = [];

  List<TextEditingController> _splitStorageLocationTextControllerList = [];

  @override
  void initState() {
    _splitStorageLocationTextControllerList = [];
    if (context.mounted) {
      context.read<GoodsReceiptSplitLocationBloc>().add(
        TransactionItemSplitLocationEvent(
          grnDtId: widget.goodsReceiptPurchaseItemDetailEntity?.grnDtId ?? -1,
          grnHdId: widget.goodsReceiptPurchaseItemDetailEntity?.grnId ?? -1,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context
                    .loc
                    .splitStorageLocation, // Make sure loc extension is defined
                style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: SizedBox(
                height: AppSize.size18,
                width: AppSize.size18,
                child: InkWell(
                  child: SvgPicture.asset(
                    AppIcons.addIcon,
                    height: AppSize.size18,
                    width: AppSize.size18,
                  ),
                  onHover: (bool hOver) {},
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      showDragHandle: false,
                      enableDrag: false,
                      isScrollControlled: true,
                      builder: (context) {
                        return SplitStorageLocationBottomBarWidget();
                      },
                    );
                  },
                ),
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
                context.l.damagedQty,
                style: getSplitTextStyle(context),
              ),
            ),

            //Storage
            SizedBox(width: AppSize.size29),
            Expanded(
              child: Text(context.l.storage, style: getSplitTextStyle(context)),
            ),
            //3 dot
            // SizedBox(
            //   height: AppSize.size15,
            //   width: AppSize.size15,
            //   child: InkWell(
            //     onHover: (bool hOver) {},
            //     onTap: onTapEvent(context, context.l.damagedQuantity),
            //     child: SvgPicture.asset(
            //       AppIcons.burgerIcon,
            //       height: AppSize.size15,
            //       width: AppSize.size15,
            //     ),
            //   ),
            // ),
          ],
        ),

        BlocBuilder<
          GoodsReceiptSplitLocationBloc,
          GoodsReceiptSplitLocationState
        >(
          builder: (context, state) {
            return Column(children: getStorageLocationWidgets(state, 1));
          },
        ),

        SizedBox(height: AppSize.size10),
        Divider(
          color:
              context.isDarkMode
                  ? AppColor.colorDarkDivider
                  : AppColor.closeButtonColor,
        ),
        SizedBox(height: AppSize.size10),
        //received qty
        Row(
          children: [
            //Received Qty
            SizedBox(
              width: AppSize.size114,
              child: Text(context.l.newQty, style: getSplitTextStyle(context)),
            ),

            //Storage
            SizedBox(width: AppSize.size29),
            Expanded(
              child: Text(context.l.storage, style: getSplitTextStyle(context)),
            ),
            //3 dot
            // SizedBox(
            //   height: AppSize.size15,
            //   width: AppSize.size15,
            //   child: InkWell(
            //     onHover: (bool hOver) {},
            //     onTap: onTapEvent(context, context.l.newQuantity),
            //     child: SvgPicture.asset(
            //       AppIcons.burgerIcon,
            //       height: AppSize.size15,
            //       width: AppSize.size15,
            //     ),
            //   ),
            // ),
          ],
        ),

        SizedBox(height: AppSize.size6),
        BlocBuilder<
          GoodsReceiptSplitLocationBloc,
          GoodsReceiptSplitLocationState
        >(
          builder: (context, state) {
            return Column(children: getStorageLocationWidgets(state, 2));
          },
        ),
        SizedBox(height: AppSize.size10),

        Divider(
          color:
              context.isDarkMode
                  ? AppColor.colorDarkDivider
                  : AppColor.closeButtonColor,
        ),
        SizedBox(height: AppSize.size10),
        //received qty
        Row(
          children: [
            //Received Qty
            SizedBox(
              width: AppSize.size114,
              child: Text(
                context.l.receivedQty,
                style: getSplitTextStyle(context),
              ),
            ),

            //Storage
            SizedBox(width: AppSize.size29),
            Expanded(
              child: Text(context.l.storage, style: getSplitTextStyle(context)),
            ),
            //3 dot
            // SizedBox(
            //   height: AppSize.size15,
            //   width: AppSize.size15,
            //   child: InkWell(
            //     onHover: (bool hOver) {},
            //     onTap: onTapEvent(context, context.l.reconditionedQuantity),
            //     child: SvgPicture.asset(
            //       AppIcons.burgerIcon,
            //       height: AppSize.size15,
            //       width: AppSize.size15,
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(height: AppSize.size6),
        BlocBuilder<
          GoodsReceiptSplitLocationBloc,
          GoodsReceiptSplitLocationState
        >(
          builder: (context, state) {
            return Column(children: getStorageLocationWidgets(state, 3));
          },
        ),
        SizedBox(height: AppSize.size10),
      ],
    );
  }

  VoidCallback onTapEvent(BuildContext context, String quantityType) {
    return () {
      showModalBottomSheet(
        context: context,
        showDragHandle: false,
        enableDrag: false,
        isScrollControlled: true,
        builder: (context) {
          return AddLocationBottomBarWidget(
            onTap: () {
              if (widget.goodsReceiptPurchaseItemDetailEntity != null) {
                context.read<GoodsReceiptSplitLocationBloc>().add(
                  AddEmptySplitStorageLocationWidgetEvent(
                    widget.goodsReceiptPurchaseItemDetailEntity!.poId,
                    widget.goodsReceiptPurchaseItemDetailEntity!.grnId,
                    widget.goodsReceiptPurchaseItemDetailEntity!.itemId,
                    12,
                  ),
                );
              }
              context.pop();
            },
            iconName: AppIcons.addIcon,
            buttonName: context.l.add,
          );
        },
      );
    };
  }

  List<Widget> getStorageLocationWidgets(
    GoodsReceiptSplitLocationState state,
    int typeId,
  ) {
    List<Widget> storageLocationWidgetList = [];
    _splitStorageLocationTextControllerList.clear();
    for (var element in state.splitLocationEntityList) {
      if (element.typeId == typeId) {
        TextEditingController textEditingController = TextEditingController(
          text: '${element.quantity}',
        );
        try {
          textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: element.cursorPosition ?? 0),
          );
        } catch (e) {
        }
        _splitStorageLocationTextControllerList.add(textEditingController);
        storageLocationWidgetList
          ..add(SizedBox(height: 7))
          ..add(
            CreateLabelItemRowWidget(
              splitLocationEntity: element,
              quantityController: textEditingController,
              onQuantityControllerChanged: (value) {
                // if (value.isNotEmpty) {
                //   final cursorPos = textEditingController.selection.baseOffset;
                //   context.read<GoodsReceiptSplitLocationBloc>().add(
                //     OnChangeSplitLocationQuantityEvent(
                //       cursorPosition: cursorPos,
                //       quantity: double.parse(value),
                //       splitLocationEntity: element,
                //     ),
                //   );
                // }
              },
              // goodsReceiptPurchaseOrderLineItemEntity:
              //     widget.goodsReceiptPurchaseOrderLineItemEntity!,
              // indexPosition: state.splitLocationEntityList.indexOf(element),
            ),
          )
          ..add(SizedBox(height: 7));
      }
    }
    _splitStorageLocationEntityList = state.splitLocationEntityList;
    return storageLocationWidgetList;
  }

  TextStyle? getSplitTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
      color: context.customThemeColor(
        light: AppColor.colorCommonTextColor,
        dark: AppColor.colorDividerLight,
      ),
    );
  }

  List<SplitLocationEntity> get splitStorageLocationEntityList =>
      _splitStorageLocationEntityList;

  List<TextEditingController> get splitStorageLocationTextControllerList =>
      _splitStorageLocationTextControllerList;
}
