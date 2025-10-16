import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/extensions/localization_extension.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/create_label_attachment_widget.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/create_label_bottom_card_widget.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/create_label_first_card_widget.dart';
import 'package:pal_ng_inventory/features/good_receipts/presentation/widgets/create_label_second_card_widget.dart';
import 'package:pal_ng_inventory/features/widgets/app_flat_button.dart';
import 'package:pal_ng_inventory/features/widgets/custom_app_bar.dart';
import 'package:pal_ng_inventory/features/widgets/gradient_background_widget.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/extensions/theme_extension.dart';
import '../../../core/routes/route_name.dart';
import '../../widgets/common_no_data_found_for_listing_widget.dart';
import '../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../domain/entities/split_location_entity.dart';
import 'goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';
import 'goods_receipt_split_location_bloc/goods_receipt_split_location_bloc.dart';

class CreateLabelPage extends StatefulWidget {
  const CreateLabelPage({
    super.key,
    required this.goodsReceiptPurchaseOrderLineItemEntity,
  });

  final GoodsReceiptPurchaseOrderLineItemEntity
  goodsReceiptPurchaseOrderLineItemEntity;

  @override
  State<CreateLabelPage> createState() => _CreateLabelPageState();
}

class _CreateLabelPageState extends State<CreateLabelPage> {
  final GlobalKey<CreateLabelSecondCardWidgetState>
  goodsReceiptCreateLabelSaveWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      debugPrint(
        "widget.goodsReceiptPurchaseOrderLineItemEntity inside CreateLabelPage: ${widget.goodsReceiptPurchaseOrderLineItemEntity}",
      );
      context.read<GoodsReceiptCreateLabelBloc>().add(RestInitialData());
      context.read<GoodsReceiptCreateLabelBloc>().add(
        GetItemDetailEvent(
          getGoodsReceiptPurchaseOrderLineItemEntity:
              widget.goodsReceiptPurchaseOrderLineItemEntity,
        ),
      );
      context.read<GoodsReceiptSplitLocationBloc>().add(
        FetchPendingPoSplitLocationDataEvent(
          poHdId: widget.goodsReceiptPurchaseOrderLineItemEntity.poHdId ?? -1,
          poDtId: widget.goodsReceiptPurchaseOrderLineItemEntity.poDtId ?? -1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final extra = GoRouterState.of(context).extra as Map;
    // final GoodsReceiptPurchaseOrderLineItemEntity
    // goodsReceiptPurchaseOrderLineItemEntity =
    //     extra['goodsReceiptPurchaseOrderLineItemEntity'];
    // debugPrint(
    //   "goodsReceiptPurchaseOrderLineItemEntity in create label : $goodsReceiptPurchaseOrderLineItemEntity",
    // );
    return BlocConsumer<
      GoodsReceiptCreateLabelBloc,
      GoodsReceiptCreateLabelState
    >(
      listener: (BuildContext context, GoodsReceiptCreateLabelState state) {
        if (state.isSaveSuccess) {
          context.pop();
        }
      },
      builder: (context, state) {
        if (state.isLoading == true) {
          return GradientBackground(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: AppColor.colorPrimary),
              ),
            ),
          );
        } else {
          return GradientBackground(
            child: Scaffold(
              appBar: CustomAppBar(
                title:
                    state
                        .goodsReceiptPurchaseOrderLineItemEntity
                        ?.productName ??
                    '',
              ),

              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                  child: Column(
                    children: <Widget>[
                      //first card
                      if (state.goodsReceiptPurchaseOrderLineItemEntity !=
                          null) ...[
                        CreateLabelFirstCardWidget(
                          goodsReceiptPurchaseOrderLineItemEntity:
                              state.goodsReceiptPurchaseOrderLineItemEntity!,
                        ),
                      ],
                      //second card
                      SizedBox(height: AppSize.size15),
                      if (state.goodsReceiptPurchaseOrderLineItemEntity !=
                          null) ...[
                        CreateLabelSecondCardWidget(
                          key: goodsReceiptCreateLabelSaveWidgetKey,
                          goodsReceiptPurchaseOrderLineItemEntity:
                              state.goodsReceiptPurchaseOrderLineItemEntity!,
                        ),
                      ],
                      //third card
                      SizedBox(height: AppSize.size15),
                      CreateLabelAttachmentWidget(
                        poId:
                            '${state.goodsReceiptPurchaseOrderLineItemEntity?.poHdId}',
                        dtId:
                            '${state.goodsReceiptPurchaseOrderLineItemEntity?.poDtId}',
                        itemId:
                            '${state.goodsReceiptPurchaseOrderLineItemEntity?.itemId}',
                      ),
                      //fourth card
                      SizedBox(height: AppSize.size15),
                      CreateLabelBottomCardWidget(
                        itemId:
                            '${state.goodsReceiptPurchaseOrderLineItemEntity?.itemId}',
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.scaffoldPadding,
                  right: AppPadding.scaffoldPadding,
                  bottom: AppPadding.scaffoldPadding,
                ),
                child: /*state.isInitialLoad*/
                    true
                        ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: AppFlatButton(
                                backgroundColor: context.customThemeColor(
                                  light: AppColor.colorWhite,
                                  dark: AppColor.colorTransparent,
                                ),
                                textColor: AppColor.colorPrimary,
                                text: context.l.cancel,
                                onPressed: onCancelLabel(context),
                              ),
                            ),
                            SizedBox(width: AppSize.size8),
                            Expanded(
                              child: AppFlatButton(
                                backgroundColor: AppColor.colorPrimary,
                                textColor: AppColor.colorWhite,
                                text: context.l.save,
                                onPressed: onCreateLabelSave(context),
                              ),
                            ),
                          ],
                        )
                        : AppFlatButton(
                          text: context.l.createLabel,
                          onPressed: () {
                            context.push(AppRoute.printRfidPage.path);
                          },
                          backgroundColor: AppColor.colorPrimary,
                          textColor: AppColor.colorWhite,
                        ),
              ),
            ),
          );
        }
      },
    );
  }

  VoidCallback onCreateLabelSave(BuildContext context) {
    return () {
      try {
        if (goodsReceiptCreateLabelSaveWidgetKey.currentState != null) {
          GoodsReceiptPurchaseOrderLineItemEntity?
          goodsReceiptPurchaseOrderLineItemEntity =
              goodsReceiptCreateLabelSaveWidgetKey
                  .currentState
                  ?.goodsReceiptPurchaseOrderLineItemEntity;
          goodsReceiptPurchaseOrderLineItemEntity?.damagedOrWrongSupply =
              goodsReceiptCreateLabelSaveWidgetKey
                      .currentState!
                      .damagedQtyController
                      .text
                      .isEmpty
                  ? 0
                  : double.parse(
                    goodsReceiptCreateLabelSaveWidgetKey
                        .currentState!
                        .damagedQtyController
                        .text
                        .toString(),
                  );
          goodsReceiptPurchaseOrderLineItemEntity?.receivedQty =
              goodsReceiptCreateLabelSaveWidgetKey
                      .currentState!
                      .receivedQtyController
                      .text
                      .isEmpty
                  ? 0
                  : double.parse(
                    goodsReceiptCreateLabelSaveWidgetKey
                        .currentState!
                        .receivedQtyController
                        .text
                        .toString(),
                  );
          goodsReceiptPurchaseOrderLineItemEntity?.newStock =
              goodsReceiptCreateLabelSaveWidgetKey
                      .currentState!
                      .newStockController
                      .text
                      .isEmpty
                  ? 0
                  : double.parse(
                    goodsReceiptCreateLabelSaveWidgetKey
                        .currentState!
                        .newStockController
                        .text
                        .toString(),
                  );
          goodsReceiptPurchaseOrderLineItemEntity?.reconditionedStock =
              goodsReceiptCreateLabelSaveWidgetKey
                      .currentState!
                      .reConditionStockController
                      .text
                      .isEmpty
                  ? 0
                  : double.parse(
                    goodsReceiptCreateLabelSaveWidgetKey
                        .currentState!
                        .reConditionStockController
                        .text
                        .toString(),
                  );
          // goodsReceiptPurchaseOrderLineItemEntity?.qualityId = int.parse(
          //   goodsReceiptCreateLabelSaveWidgetKey.currentState!.qualityId,
          // );
          // goodsReceiptPurchaseOrderLineItemEntity?.expiryDate =
          // goodsReceiptCreateLabelSaveWidgetKey
          //     .currentState!
          //     .expiryDateController
          //     .text
          //     .isEmpty
          //     ? ""
          //     : goodsReceiptCreateLabelSaveWidgetKey
          //     .currentState!
          //     .expiryDateController
          //     .text
          //     .toString();
          // goodsReceiptPurchaseOrderLineItemEntity?.batchNo =
          // goodsReceiptCreateLabelSaveWidgetKey
          //     .currentState!
          //     .batchNameController
          //     .text
          //     .isEmpty
          //     ? ''
          //     : goodsReceiptCreateLabelSaveWidgetKey
          //     .currentState!
          //     .batchNameController
          //     .text
          //     .toString();
          // goodsReceiptPurchaseOrderLineItemEntity?.articleNo =
          // goodsReceiptCreateLabelSaveWidgetKey
          //     .currentState!
          //     .inputSerialNumController
          //     .text
          //     .isEmpty
          //     ? '0'
          //     : goodsReceiptCreateLabelSaveWidgetKey
          //     .currentState!
          //     .inputSerialNumController
          //     .text
          //     .toString();
          // goodsReceiptPurchaseOrderLineItemEntity?.imdgClassId =
          //     goodsReceiptCreateLabelSaveWidgetKey.currentState!.imdgClassId;
          // goodsReceiptPurchaseOrderLineItemEntity?.remarks =
          //     goodsReceiptCreateLabelSaveWidgetKey
          //         .currentState!
          //         .remarksController
          //         .text
          //         .toString();
          // goodsReceiptPurchaseOrderLineItemEntity?.className =
          //     goodsReceiptCreateLabelSaveWidgetKey.currentState!.storageLocation;
          debugPrint(
            'goodsReceiptPurchaseOrderLineItemEntity : $goodsReceiptPurchaseOrderLineItemEntity',
          );
          if (goodsReceiptPurchaseOrderLineItemEntity != null) {
            if (goodsReceiptPurchaseOrderLineItemEntity.receivedQty == 0) {
              showSuccessPopup('Received Quantity should not be zero', context);
              return;
            }
            if (goodsReceiptPurchaseOrderLineItemEntity.receivedQty >
                goodsReceiptPurchaseOrderLineItemEntity.quantity) {
              showSuccessPopup(
                'Received Quantity should be less than Quantity',
                context,
              );
              return;
            }
            if ((goodsReceiptPurchaseOrderLineItemEntity.damagedOrWrongSupply +
                    goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock +
                    goodsReceiptPurchaseOrderLineItemEntity.newStock) !=
                goodsReceiptPurchaseOrderLineItemEntity.receivedQty) {
              showSuccessPopup(
                'Total quantity of Damaged, Reconditioned, and New Stock must be equal to Received Quantity',
                context,
              );
              return;
            }
            List<SplitLocationEntity> splitLocationData = [];
            // if (goodsReceiptCreateLabelSaveWidgetKey
            //         .currentState
            //         ?.splitStorageLocationWidgetKey
            //         .currentState !=
            //     null) {
            //   SplitStorageLocationWidgetState? splitStorageLocationWidgetState =
            //       goodsReceiptCreateLabelSaveWidgetKey
            //           .currentState
            //           ?.splitStorageLocationWidgetKey
            //           .currentState;
            //   splitLocationData =
            //       splitStorageLocationWidgetState
            //           ?.splitStorageLocationEntityList ??
            //       [];
            // }
            debugPrint("splitLocationData : $splitLocationData");
            if (splitLocationData.isNotEmpty) {
              if(splitLocationData.any((element)=> element.locationId == 0)){
                showSuccessPopup(
                  'Choose storage locations',
                  context,
                );
                return;
              }
              var damagedSplitLocationData =
                  splitLocationData
                      .where((element) => element.typeId == 1)
                      .toList();
              debugPrint(
                "damagedSplitLocationData : $damagedSplitLocationData",
              );
              if (goodsReceiptPurchaseOrderLineItemEntity
                          .damagedOrWrongSupply !=
                      0 &&
                  damagedSplitLocationData.isNotEmpty &&
                  goodsReceiptPurchaseOrderLineItemEntity
                          .damagedOrWrongSupply !=
                      damagedSplitLocationData
                          .map((element) => element.quantity)
                          .toList()
                          .reduce((a, b) => a + b)) {
                showSuccessPopup(
                  'Damage Split Location Quantity should be equal to Damaged Quantity',
                  context,
                );
                return;
              }
              var newQuantitySplitLocationData =
                  splitLocationData
                      .where((element) => element.typeId == 2)
                      .toList();
              debugPrint(
                "goodsReceiptPurchaseOrderLineItemEntity.newStock : ${goodsReceiptPurchaseOrderLineItemEntity.newStock}",
              );
              if (goodsReceiptPurchaseOrderLineItemEntity.newStock != 0 &&
                  newQuantitySplitLocationData.isNotEmpty &&
                  goodsReceiptPurchaseOrderLineItemEntity.newStock !=
                      newQuantitySplitLocationData
                          .map((element) => element.quantity)
                          .toList()
                          .reduce((a, b) => a + b)) {
                showSuccessPopup(
                  'New Quantity Split Location Quantity should be equal to New Stock Quantity',
                  context,
                );
                return;
              }

              var reConditionSplitLocationData =
                  splitLocationData
                      .where((element) => element.typeId == 3)
                      .toList();
              if (goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock !=
                      0 &&
                  reConditionSplitLocationData.isNotEmpty &&
                  goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock !=
                      reConditionSplitLocationData
                          .map((element) => element.quantity)
                          .toList()
                          .reduce((a, b) => a + b)) {
                showSuccessPopup(
                  'Reconditioned Stock Quantity Split Location Quantity should be equal to Reconditioned Stock Quantity',
                  context,
                );
                return;
              }

              sl<GoodsReceiptSplitLocationBloc>().add(
                PendingPoSplitLocationUpdateToDbEvent(
                  splitLocationEntityList: splitLocationData,
                ),
              );
            }

            debugPrint("validation success *************");

            sl<GoodsReceiptCreateLabelBloc>().add(
              GoodsReceiptCreateLabelSaveEvent(
                goodsReceiptPurchaseOrderLineItemEntity,
              ),
            );
          }

          // sl<GoodsReceiptCreateLabelBloc>().add(
          //   GoodsReceiptCreateLabelSaveEvent(
          //     goodsReceiptPurchaseOrderLineItemEntity!,
          //   ),
          // );

          // if (goodsReceiptCreateLabelSaveWidgetKey
          //     .currentState
          //     ?.splitStorageLocationWidgetKey
          //     .currentState !=
          //     null) {
          //   SplitStorageLocationWidgetState? splitStorageLocationWidgetState =
          //       goodsReceiptCreateLabelSaveWidgetKey
          //           .currentState
          //           ?.splitStorageLocationWidgetKey
          //           .currentState;
          //   List<SplitLocationEntity>? splitLocationEntityList =
          //       splitStorageLocationWidgetState?.splitStorageLocationEntityList;
          //
          //   if (splitLocationEntityList!.isNotEmpty) {
          //     sl<GoodsReceiptSplitLocationBloc>().add(
          //       UpdateSplitLocationInTableOnLabelDetailEvent(
          //         splitLocationEntityList,
          //       ),
          //     );
          //   }
          // }
        } else {
          debugPrint("inside the else *****************");
        }
      } catch (e) {
        debugPrint("inside the catch of onCreateLabelSave ************");
        debugPrint("$e");
        debugPrint("inside the catch of onCreateLabelSave ************");
      }
    };
  }

  VoidCallback onCancelLabel(BuildContext context) {
    return () {};
  }
}
