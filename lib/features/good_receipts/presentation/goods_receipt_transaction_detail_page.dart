import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/extensions/text_theme_extension.dart';
import '../../../core/routes/route_name.dart';
import '../../widgets/app_decorated_box_shadow_widget.dart';
import '../../widgets/app_title_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_background_widget.dart';
import 'goods_receipt_transaction_detail_bloc/goods_receipts_transaction_detail_bloc.dart';
import 'widgets/goods_receipt_value_widget.dart';
import '../purchase_order/presentation/widgets/item_detail_row_widget.dart';
import 'widgets/shimmer_widget/goods_recipts_transaction_details_shimmer.dart';

class GoodsReceiptTransactionDetailPage extends StatelessWidget {
  const GoodsReceiptTransactionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map;
    final int selectedItemPosition = extra['selectedItemPosition'];
    final String selectedTransactionPoCode = extra['transactionPoCode'];
    return BlocBuilder<
      GoodsReceiptsTransactionDetailBloc,
      GoodsReceiptsTransactionDetailState
    >(
      builder: (context, state) {
        return GradientBackground(
          child: Scaffold(
            appBar: CustomAppBar(title: selectedTransactionPoCode),
            body: Padding(
              padding: EdgeInsets.all(AppPadding.scaffoldPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.scaffoldPadding,
                    ),
                    child: Text(
                      "${state.goodsReceiptPurchaseItemDetailEntityList.length} Item(s)",
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: AppSize.size20),
                  state.isLoading
                      ? Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GoodsReceiptsTransactionDetailsShimmer();
                          },
                          itemCount: 3,
                          separatorBuilder:
                              (context, index) =>
                                  SizedBox(height: AppSize.size10),
                        ),
                      )
                      : Expanded(
                        child: ListView.separated(
                          itemCount:
                              state
                                  .goodsReceiptPurchaseItemDetailEntityList
                                  .length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // context
                                //     .read<GoodsReceiptsTransactionDetailBloc>()
                                //     .add(
                                //       GetGoodsReceiptsTransactionByIdEvent(
                                //         state
                                //             .goodsReceiptPurchaseItemDetailEntityList[index]
                                //             .poId,
                                //       ),
                                //     );
                                // debugPrint(
                                //   "aaaaaaaaa : ${state.goodsReceiptPurchaseItemDetailEntityList[index]}",
                                // );

                                // TODO Commented for the GRPOLineItem model change
                                // context.read<GoodsReceiptSplitLocationBloc>().add(
                                //   FetchSplitStorageLocationByPurchaseItemDetailEntity(
                                //     state
                                //         .goodsReceiptPurchaseItemDetailEntityList[index],
                                //   ),
                                // );
                                context.push(
                                  AppRoute
                                      .goodsReceiptTransactionItemDetailPage
                                      .path,
                                  extra: {
                                    'selectedItemPosition': index,
                                    "grnDtId":
                                        state
                                            .goodsReceiptPurchaseItemDetailEntityList[index]
                                            .grnDtId,
                                  },
                                );
                              },
                              child: GoodsReceiptTransactionCardWidget(index),
                            );
                          },
                          separatorBuilder:
                              (context, index) =>
                                  SizedBox(height: AppSize.size10),
                        ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GoodsReceiptTransactionCardWidget extends StatelessWidget {
  const GoodsReceiptTransactionCardWidget(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return BlocBuilder<
      GoodsReceiptsTransactionDetailBloc,
      GoodsReceiptsTransactionDetailState
    >(
      builder: (context, state) {
        return AppDecoratedBoxShadowWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ReceiptCardHeadingWidget(
                      text:
                          state
                              .goodsReceiptPurchaseItemDetailEntityList[index]
                              .productName!,
                    ),
                    SizedBox(height: AppSize.size10),

                    // GRN no and category row
                    // TODO Commented for the GRPOLineItem model change
                    // ItemDetailRowWidget(
                    //   titleFirst: context.l.equipmentName,
                    //   valueFirst:
                    //       state
                    //           .goodsReceiptPurchaseItemDetailEntityList[index]
                    //           .equipmentName ??
                    //       '',
                    //   titleSecond: context.l.drawingNo,
                    //   valueSecond:
                    //       state
                    //           .goodsReceiptPurchaseItemDetailEntityList[index]
                    //           .productDescription ??
                    //       '',
                    // ),
                    SizedBox(height: AppSize.size10),

                    ItemDetailRowWidget(
                      titleFirst: context.l.partNo,
                      valueFirst:
                          state
                              .goodsReceiptPurchaseItemDetailEntityList[index]
                              .partNo,
                      titleSecond: context.l.robSmall,
                      valueSecond:
                          '${state.goodsReceiptPurchaseItemDetailEntityList[index].receivedQty}',
                    ),

                    SizedBox(height: AppSize.size10),
                    // Title section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleWidget(text: context.l.articleNo),
                        GoodsReceiptValueWidget(
                          text:
                              state
                                  .goodsReceiptPurchaseItemDetailEntityList[index]
                                  .articleNo,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.size10),
                    // Title section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleWidget(text: context.l.storageLocation),
                        GoodsReceiptValueWidget(
                          text:
                              state
                                  .goodsReceiptPurchaseItemDetailEntityList[index]
                                  .className,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ReceiptCardHeadingWidget extends StatelessWidget {
  const ReceiptCardHeadingWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
