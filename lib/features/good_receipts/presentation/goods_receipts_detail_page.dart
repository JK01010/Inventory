import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_encrypted_storage_keys.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routes/route_name.dart';
import '../../../core/service/other_service/app_secure_storage_service.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../stock_update/presentation/bloc/stock_location_bloc/stock_location_bloc.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_background_widget.dart';
import '../../widgets/sync_button_widget.dart';
import '../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../domain/entities/purchase_order_hd_entity.dart';
import 'goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';
import 'goods_receipt_detail_label_bloc/goods_receipt_label_bloc.dart';
import 'goods_receipt_label_attachment_bloc/goods_receipt_label_attachment_item_bloc.dart';
import 'goods_receipt_split_location_bloc/goods_receipt_split_location_bloc.dart';
import 'goods_receipt_transaction_bloc/goods_receipts_transaction_bloc.dart';
import 'goods_receipts_po_bloc/goods_receipts_po_bloc.dart';
import 'widgets/create_label_row_widget.dart';
import 'widgets/good_receipt_details_card_widget.dart';
import 'widgets/goods_receipt_card_details_item_widget.dart';
import 'widgets/goods_receipts_bottom_bar_widget.dart';
import 'widgets/shimmer_widget/goods_receipts_pending_details_shimmer.dart';

List<GlobalKey<GoodsReceiptCardDetailsItemWidgetState>>
goodsReceiptCardDetailsItemWidgetKeys = [];

GlobalKey<CreateLabelRowWidgetState> createLabelWidgetKey = GlobalKey();

class GoodsReceiptsDetailPage extends StatelessWidget {
  GoodsReceiptsDetailPage({super.key});

  final GlobalKey<GoodReceiptsDetailCardWidgetState>
  goodsReceiptDetailsCardWidgetKey = GlobalKey();

  ValueNotifier<List<bool>> headerValueNotifiers = ValueNotifier([
    false,
    false,
    false,
  ]);

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map;
    final int selectedPOIndex = extra['selectedPOIndex'];
    return BlocConsumer<GoodsReceiptsPoBloc, GoodsReceiptsPoState>(
      listener: (BuildContext context, GoodsReceiptsPoState state) {
        if (state.isFinalizeDone) {
          context.read<GoodsReceiptsPoBloc>().add(
            GoodsReceiptsPoGetAllPoLineItemsDataEvent(),
          );
          // context.read<GoodsReceiptsTransactionBloc>().add(
          //   FetchAllTransactionFromDb(),
          // );
          context.pop();
        }
      },
      listenWhen:
          (previous, current) =>
              previous.isFinalizeDone != current.isFinalizeDone,
      builder: (context, poState) {
        final poEntity = poState.goodsReceiptsHdEntityList[selectedPOIndex];
        return GradientBackground(
          child: Scaffold(
            appBar: CustomAppBar(
              title: poEntity.poNo!,
              actions: [SyncButtonWidget()],
            ),
            body: BlocBuilder<GoodsReceiptLabelBloc, GoodsReceiptLabelState>(
              builder: (context, labelState) {
                // Correctly get the list of all item IDs from the GoodsReceiptLabelBloc state
                final List<int> itemIds =
                    labelState.goodsReceiptPurchaseOrderLineItemEntityList
                        .map((item) => item.itemId)
                        .toList();

                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          AppPadding.scaffoldPadding,
                        ),
                        child: Column(
                          children: <Widget>[
                            GoodReceiptsDetailCardWidget(
                              poState
                                  .goodsReceiptsHdEntityList[selectedPOIndex],
                              selectedPOIndex,
                              headerValueNotifiers,
                              key: goodsReceiptDetailsCardWidgetKey,
                            ),
                            SizedBox(height: AppSize.size10),
                            // Pass the list of itemIds here
                            CreateLabelRowWidget(
                              poEntity,
                              key: createLabelWidgetKey,
                              itemIds: itemIds,
                            ),
                            SizedBox(height: AppSize.size10),
                            ItemListBuilderWidget(),
                            SizedBox(height: AppSize.size10),
                          ],
                        ),
                      ),
                    ),
                    if (poState.isSaveLoading) ...[
                      const Center(child: CircularProgressIndicator()),
                    ] else ...[
                      SizedBox.shrink(),
                    ],
                  ],
                );
              },
            ),
            bottomNavigationBar: GoodsReceiptsBottomBarWidget(
              onDraftSave: () {
                processUiData("DFD", context);
              },
              onFinalizeSave: onFinalizeSave(poState, context),
            ),
          ),
        );
      },
    );
  }

  VoidCallback onFinalizeSave(
    GoodsReceiptsPoState state,
    BuildContext context,
  ) {
    return () {
      processUiData("FNL", context);
      if (goodsReceiptCardDetailsItemWidgetKeys.isNotEmpty &&
          goodsReceiptCardDetailsItemWidgetKeys[0].currentState != null) {
        Logger().i('Called update Stock Location event ');
        sl<StockLocationBloc>().add(
          UpdateStockLocationByItemIdEvent(
            goodsReceiptCardDetailsItemWidgetKeys[0]
                .currentState!
                .goodsReceiptPurchaseOrderLineItemEntityList[0]
                .itemId,
          ),
        );
      }
      if (createLabelWidgetKey.currentState != null) {
        Logger().i('Implement Finalize save');
        Logger().i(
          '${createLabelWidgetKey.currentState?.purchaseOrderHDEntity.selectedLabelType}',
        );
        Logger().i(
          '${createLabelWidgetKey.currentState?.purchaseOrderHDEntity.printingPosition}',
        );
        Logger().i(
          '${createLabelWidgetKey.currentState?.purchaseOrderHDEntity.numberOfLabels}',
        );
      }
    };
  }

  void processUiData(String statusType, BuildContext context) {
    if (goodsReceiptDetailsCardWidgetKey.currentState != null) {
      PurchaseOrderHDEntity? purchaseOrderHDEntity =
          goodsReceiptDetailsCardWidgetKey.currentState?.purchaseOrderHDEntity
            ?..portId =
                goodsReceiptDetailsCardWidgetKey.currentState!.receivedPortId
            ..deliveryTo =
                goodsReceiptDetailsCardWidgetKey
                    .currentState!
                    .deliveryReferenceController
                    .text
                    .toString()
            ..weight = goodsReceiptDetailsCardWidgetKey.currentState!.weight
            ..actualVolume =
                goodsReceiptDetailsCardWidgetKey.currentState!.actualVolume
            ..noOfPackets =
                goodsReceiptDetailsCardWidgetKey.currentState!.noOfPackets
            ..poRemarks =
                goodsReceiptDetailsCardWidgetKey
                    .currentState!
                    .remarksController
                    .text
                    .toString()
            ..isFull = headerValueNotifiers.value[1]
            ..isBaggingCompleted = headerValueNotifiers.value[2];

      if (goodsReceiptDetailsCardWidgetKey
          .currentState!
          .poReceivedDateController
          .text
          .toString()
          .isNotEmpty) {
        DateTime selectedDate = AppDateUtils.getDateTimeFromString(
          goodsReceiptDetailsCardWidgetKey
              .currentState!
              .poReceivedDateController
              .text
              .toString(),
          'dd-MMM-yyyy',
        );
        String formattedReceivedDate = AppDateUtils.getStringFromDateWithFormat(
          selectedDate,
          'yyyy-MM-ddThh:mm:ss',
        );

        purchaseOrderHDEntity?.deliveryDate = formattedReceivedDate;
      }

      // Logger().i(
      //   ' purchaseOrderHDEntity ${goodsReceiptDetailsCardWidgetKey.currentState?.purchaseOrderHDEntity}',
      // );
      context.read<GoodsReceiptsPoBloc>().add(
        UpdateGoodsReceiptDetailForDraftEvent(purchaseOrderHDEntity!),
      );
      context.read<GoodsReceiptsPoBloc>().add(
        SaveOrDraftGoodsReceiptEvent(
          purchaseOrderHDEntity: purchaseOrderHDEntity,
          statusType: statusType,
        ),
      );
    }
    if (goodsReceiptCardDetailsItemWidgetKeys[0].currentState != null) {
      List<GoodsReceiptPurchaseOrderLineItemEntity>
      goodsReceiptPurchaseOrderLineItemEntityList = [];
      for (
        var index = 0;
        index <
            goodsReceiptCardDetailsItemWidgetKeys[0]
                .currentState!
                .goodsReceiptPurchaseOrderLineItemEntityList
                .length;
        index++
      ) {
        GoodsReceiptPurchaseOrderLineItemEntity?
        goodsReceiptPurchaseOrderLineItemEntity =
            goodsReceiptCardDetailsItemWidgetKeys[index]
                  .currentState
                  ?.goodsReceiptPurchaseOrderLineItemEntityList[index]
              ?..receivedQty =
                  goodsReceiptCardDetailsItemWidgetKeys[index]
                      .currentState!
                      .receivedQuantity
              ..damagedOrWrongSupply =
                  goodsReceiptCardDetailsItemWidgetKeys[index]
                      .currentState!
                      .damagedQuantity;
        goodsReceiptPurchaseOrderLineItemEntityList.add(
          goodsReceiptPurchaseOrderLineItemEntity!,
        );
      }
      for (var itemDetail in goodsReceiptPurchaseOrderLineItemEntityList) {
        Logger().i(
          ' goodsReceiptDetailLabelEntityList detail : ${itemDetail.receivedQty}  -  ${itemDetail.damagedOrWrongSupply}',
        );
      }
      sl<GoodsReceiptLabelBloc>().add(
        UpdateGoodsReceiptDetailLabelListForDraftEvent(
          goodsReceiptPurchaseOrderLineItemEntityList,
        ),
      );
    }
  }
}

// ... existing imports

class ItemListBuilderWidget extends StatelessWidget {
  const ItemListBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsReceiptLabelBloc, GoodsReceiptLabelState>(
      builder: (context, state) {
        if (state.goodsReceiptPurchaseOrderLineItemEntityList.isNotEmpty &&
            state.isInitialLoad) {
          goodsReceiptCardDetailsItemWidgetKeys = List.generate(
            state.goodsReceiptPurchaseOrderLineItemEntityList.length,
            (_) => GlobalKey(),
          );
        }

        return Stack(
          children: [
            state.isLoading
                ? ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemBuilder:
                      (context, index) => GoodsReceiptsPendingDetailsShimmer(),

                  itemCount: 5,

                  separatorBuilder: (_, __) => SizedBox(height: AppSize.size10),
                )
                : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      state.goodsReceiptPurchaseOrderLineItemEntityList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        final int itemId =
                            state
                                .goodsReceiptPurchaseOrderLineItemEntityList[index]
                                .itemId;
                        debugPrint(
                          "varr aaa ==== ${state.goodsReceiptPurchaseOrderLineItemEntityList[index]}",
                        );
                        context.push(
                          AppRoute.createLabelPage.path,

                          extra: {
                            'goodsReceiptPurchaseOrderLineItemEntity':
                                state
                                    .goodsReceiptPurchaseOrderLineItemEntityList[index],
                          },
                        );

                        // REMOVE THIS LINE:
                        // createLabelWidgetKey.currentState?.updateItemId(itemId);
                        //
                        // context.read<GoodsReceiptCreateLabelBloc>().add(
                        //   GoodsReceiptGetLabelDetailById(
                        //     state
                        //         .goodsReceiptPurchaseOrderLineItemEntityList[index]
                        //         .grnId,
                        //     state
                        //             .goodsReceiptPurchaseOrderLineItemEntityList[index]
                        //             .poHdId ??
                        //         -1,
                        //     state
                        //         .goodsReceiptPurchaseOrderLineItemEntityList[index]
                        //         .itemId,
                        //   ),
                        // );
                        // context.read<GoodsReceiptLabelAttachmentItemBloc>().add(
                        //   GetGoodsReceiptLabelAttachmentItemEvent(
                        //     state
                        //         .goodsReceiptPurchaseOrderLineItemEntityList[index],
                        //   ),
                        // );
                        context.read<GoodsReceiptCreateLabelBloc>().add(
                          FetchAllStorageLocationsEvent(),
                        );
                        context.read<GoodsReceiptCreateLabelBloc>().add(
                          FetchAllImdgClassEvent(),
                        );
                        context.read<GoodsReceiptSplitLocationBloc>().add(
                          FetchSplitStorageLocationByPurchaseItemDetailEntity(
                            state
                                .goodsReceiptPurchaseOrderLineItemEntityList[index],
                          ),
                        );
                      },
                      child: Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const BehindMotion(),
                          // A pane can dismiss the Slidable.
                          // dismissible: DismissiblePane(onDismissed: () {}),
                          extentRatio: 0.2,
                          // All actions are defined in the children parameter.
                          children: [
                            // A Slidable Action can have an icon and/or a label.
                            SlidableAction(
                              backgroundColor: AppColor.redColor,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: '',
                              onPressed: (BuildContext context) {
                                context.read<GoodsReceiptLabelBloc>().add(
                                  DeleteGoodsReceiptsLabelItemByIdEvent(
                                    state
                                        .goodsReceiptPurchaseOrderLineItemEntityList[index],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        child: GoodsReceiptCardDetailsItemWidget(
                          key: goodsReceiptCardDetailsItemWidgetKeys[index],
                          selectedIndex: index,
                        ),
                      ),
                    );
                  },
                  separatorBuilder:
                      (context, index) => SizedBox(height: AppSize.size10),
                ),
          ],
        );
      },
    );
  }
}
