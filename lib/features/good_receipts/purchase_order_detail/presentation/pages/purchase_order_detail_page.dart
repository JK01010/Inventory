import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/utils/app_date_utils.dart';
import '../../../../stock_update/presentation/bloc/stock_location_bloc/stock_location_bloc.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../../../widgets/sync_button_widget.dart';
import '../../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../../domain/entities/purchase_order_hd_entity.dart';
import '../../../presentation/goods_receipt_detail_label_bloc/goods_receipt_label_bloc.dart';
import '../../../presentation/goods_receipt_transaction_bloc/goods_receipts_transaction_bloc.dart';
import '../../../presentation/goods_receipts_po_bloc/goods_receipts_po_bloc.dart';
import '../../../presentation/widgets/create_label_row_widget.dart';
import '../../../presentation/widgets/good_receipt_details_card_widget.dart';
import '../../../presentation/widgets/goods_receipt_card_details_item_widget.dart';
import '../../../presentation/widgets/goods_receipts_bottom_bar_widget.dart';
import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc_event.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc_state.dart';
import '../widgets/purchase_order_detail_card_widget.dart';
import '../widgets/purchase_order_detail_create_label_widget.dart';
import '../widgets/purchase_order_details_items_list_widget.dart';

List<GlobalKey<GoodsReceiptCardDetailsItemWidgetState>>
goodsReceiptCardDetailsItemWidgetKeys = [];

GlobalKey<CreateLabelRowWidgetState> createLabelWidgetKey = GlobalKey();

class PurchaseOrderDetailPage extends StatefulWidget {
  const PurchaseOrderDetailPage({super.key, required this.purchaseOrderEntity});

  final PurchaseOrderEntity purchaseOrderEntity;

  @override
  State<PurchaseOrderDetailPage> createState() =>
      _PurchaseOrderDetailPageState();
}

class _PurchaseOrderDetailPageState extends State<PurchaseOrderDetailPage> {
  final GlobalKey<GoodReceiptsDetailCardWidgetState>
  goodsReceiptDetailsCardWidgetKey = GlobalKey();

  ValueNotifier<List<bool>> headerValueNotifiers = ValueNotifier([
    false,
    false,
    false,
  ]);

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      context.read<PurchaseOrderDetailBloc>().add(
        GetPurchaseOrderItemsEvent(
          purchaseOrderData: widget.purchaseOrderEntity,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchaseOrderDetailBloc, PurchaseOrderDetailBlocState>(
      listener: (BuildContext context, PurchaseOrderDetailBlocState state) {
        if (state.isFinalizeDone) {
          // context.read<GoodsReceiptsPoBloc>().add(
          //   GoodsReceiptsPoGetAllDataEvent(),
          // );
          // context.read<GoodsReceiptsPoBloc>().add(
          //   GoodsReceiptsPoGetAllPoLineItemsDataEvent(),
          // );
          // context.read<GoodsReceiptsTransactionBloc>().add(
          //   FetchAllTransactionFromDb(),
          // );
          // context.pop();
        }
      },
      listenWhen:
          (previous, current) =>
              previous.isFinalizeDone != current.isFinalizeDone,
      builder: (context, state) {
        return GradientBackground(
          child: Scaffold(
            appBar: CustomAppBar(
              title: widget.purchaseOrderEntity.poCode,
              actions: [SyncButtonWidget()],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                    child: Column(
                      children: <Widget>[
                        PurchaseOrderDetailCardWidget(),
                        SizedBox(height: AppSize.size10),
                        // // Pass the list of itemIds here
                        PurchaseOrderDetailCreateLabelWidget(),
                        SizedBox(height: AppSize.size10),
                        PurchaseOrderDetailsItemsListWidget(),
                        // SizedBox(height: AppSize.size10),
                      ],
                    ),
                  ),
                ),
                if (state.isSaveLoading) ...[
                  const Center(child: CircularProgressIndicator()),
                ] else ...[
                  SizedBox.shrink(),
                ],
              ],
            ),
            bottomNavigationBar: GoodsReceiptsBottomBarWidget(
              onDraftSave: () {
                processUiData("DFD", context);
              },
              onFinalizeSave: () {},
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
        String _formattedReceivedDate =
            AppDateUtils.getStringFromDateWithFormat(
              selectedDate,
              'yyyy-MM-ddThh:mm:ss',
            );

        purchaseOrderHDEntity?.deliveryDate = _formattedReceivedDate;
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
