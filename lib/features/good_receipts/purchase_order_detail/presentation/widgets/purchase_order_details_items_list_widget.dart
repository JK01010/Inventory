import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../presentation/widgets/shimmer_widget/goods_receipts_pending_details_shimmer.dart';
import '../../../purchase_order_item_detail/presentation/pages_params/purchase_order_item_detail_page_params.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc_state.dart';
import 'purchase_order_detail_item_widget.dart';

class PurchaseOrderDetailsItemsListWidget extends StatelessWidget {
  const PurchaseOrderDetailsItemsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseOrderDetailBloc, PurchaseOrderDetailBlocState>(
      builder: (context, state) {
        return Stack(
          children: [
            state.isLoading
                ? ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemBuilder:
                      (context, index) => GoodsReceiptsPendingDetailsShimmer(),

                  itemCount: 5,

                  separatorBuilder: (_, _) => SizedBox(height: AppSize.size10),
                )
                : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.purchaseOrderItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          AppRoute.purchaseOrderItemDetailPage.path,
                          extra: PurchaseOrderItemDetailPageParams(
                            purchaseOrderEntity: state.purchaseOrderData,
                            itemEntity: state.purchaseOrderItems[index],
                          ),
                        );
                        // final int itemId =
                        //     state.purchaseOrderItems[index].itemId;

                        // context.push(
                        //   AppRoute.createLabelPage.path,
                        //
                        //   extra: {
                        //     'goodsReceiptPurchaseOrderLineItemEntity':
                        //     state
                        //         .goodsReceiptPurchaseOrderLineItemEntityList[index],
                        //   },
                        // );

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
                        // context.read<GoodsReceiptCreateLabelBloc>().add(
                        //   FetchAllStorageLocationsEvent(),
                        // );
                        // context.read<GoodsReceiptCreateLabelBloc>().add(
                        //   FetchAllImdgClassEvent(),
                        // );
                        // context.read<GoodsReceiptSplitLocationBloc>().add(
                        //   FetchSplitStorageLocationByPurchaseItemDetailEntity(
                        //     state
                        //         .goodsReceiptPurchaseOrderLineItemEntityList[index],
                        //   ),
                        // );
                      },
                      child: Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          extentRatio: 0.2,
                          children: [
                            SlidableAction(
                              backgroundColor: AppColor.redColor,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: '',
                              onPressed: (BuildContext context) {
                                //ToDo
                              },
                            ),
                          ],
                        ),
                        child: PurchaseOrderDetailItemWidget(
                          itemEntity: state.purchaseOrderItems[index],
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
