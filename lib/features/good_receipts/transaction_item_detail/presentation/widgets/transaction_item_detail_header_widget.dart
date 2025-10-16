import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_item_detail_row_widget.dart';
import '../bloc/transaction_item_detail_bloc.dart';
import '../bloc/transaction_item_detail_bloc_state.dart';

final ValueNotifier<bool> isExpand = ValueNotifier<bool>(false);

class TransactionItemDetailHeaderWidget extends StatelessWidget {
  const TransactionItemDetailHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      child: ValueListenableBuilder(
        valueListenable: isExpand,
        builder: (context, value, child) {
          return Stack(
            children: [
              BlocBuilder<
                TransactionItemDetailBloc,
                TransactionItemDetailBlocState
              >(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: AppSize.size10),
                        //1
                        AppItemDetailRowWidget(
                          titleFirst: context.l.articleNo,
                          valueFirst: state.itemEntity.articleNumber,
                          titleSecond: context.l.partNo,
                          valueSecond: state.itemEntity.partNumber,
                        ),
                        //2
                        SizedBox(height: AppSize.size10),
                        AppItemDetailRowWidget(
                          titleFirst: context.l.productName,
                          valueFirst: state.itemEntity.productName,
                          titleSecond: context.l.plateOrDrawing,
                          valueSecond: state.itemEntity.productDescription,
                        ),

                        //3
                        SizedBox(height: AppSize.size10),
                        AppItemDetailRowWidget(
                          titleFirst: context.l.uom,
                          valueFirst: state.itemEntity.uom,
                          titleSecond: context.l.packSize,
                          valueSecond: state.itemEntity.packSize.toString(),
                        ),
                        if (value)
                          Column(
                            children: [
                              //4
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.poQty,
                                valueFirst: '${state.itemEntity.poQuantity}',
                                titleSecond: context.l.unitPrize,
                                valueSecond: '${state.itemEntity.unitPrice}',
                              ),

                              //5
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.totalAcceptedQty,
                                valueFirst:
                                    '${state.itemEntity.totalAcceptedQuantity}',
                                titleSecond: context.l.returnQty,
                                valueSecond:
                                    '${state.itemEntity.returnQuantity}',
                              ),
                              //6
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.imdgClass,
                                valueFirst: state.itemEntity.imdgClass,
                                titleSecond: context.l.remarksFromVendor,
                                valueSecond: state.itemEntity.remarksFromVendor,
                              ),

                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.equipment,
                                valueFirst: state.itemEntity.equipment,
                                titleSecond: context.l.itemCategory,
                                valueSecond: state.itemEntity.itemCategory,
                              ),

                              //8
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.itemSection,
                                valueFirst: state.itemEntity.itemSection,
                                titleSecond: context.l.itemSubSection,
                                valueSecond: state.itemEntity.itemSubSection,
                              ),
                              //9
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.receivedQty,
                                valueFirst:
                                    '${state.itemEntity.receivedQuantity}',
                                titleSecond: context.l.damageWrong,
                                valueSecond:
                                    '${state.itemEntity.damagedQuantity}',
                              ),
                              //10
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.newStock,
                                valueFirst:
                                    '${state.itemEntity.newStockQuantity}',
                                titleSecond: context.l.reconditionStock,
                                valueSecond:
                                    '${state.itemEntity.reconditionedStock}',
                              ),
                              //11
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.quality,
                                valueFirst: state.itemEntity.quality,
                                titleSecond: context.l.expiryDate,
                                valueSecond: state.itemEntity.expiryDate,
                              ),
                              //12
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.batchNo,
                                valueFirst: state.itemEntity.batchNumber,
                                titleSecond: context.l.serialNo,
                                valueSecond: '${state.itemEntity.serialNumber}',
                              ),
                              //13
                              SizedBox(height: AppSize.size10),
                              AppItemDetailRowWidget(
                                titleFirst: context.l.remarks,
                                valueFirst: state.itemEntity.remarks,
                                titleSecond: context.l.defaultStorageLocation,
                                valueSecond:
                                    state.itemEntity.defaultStorageLocation,
                              ),
                              SizedBox(height: AppSize.size10),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(context.l.attachment),
                                      SizedBox(height: AppSize.size6),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            AppBorderRadius.borderRadius10,
                                          ),
                                          border: Border.all(
                                            color: AppColor.colorPrimary,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            AppPadding.padding8,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              // context
                                              //     .read<
                                              //       GoodsReceiptLabelIhmAttachmentBloc
                                              //     >()
                                              //     .add(
                                              //       GetGoodsReceiptLabelIhmAttachmentEvent(
                                              //         itemId:
                                              //             '${state.goodsReceiptPurchaseItemDetailEntity.itemId}',
                                              //       ),
                                              //     );
                                              // showModalBottomSheet(
                                              //   isDismissible: false,
                                              //   context: context,
                                              //   backgroundColor:
                                              //       Colors.transparent,
                                              //   builder: (context) {
                                              //     return DecoratedBox(
                                              //       decoration: BoxDecoration(
                                              //         color:
                                              //             context.isDarkMode
                                              //                 ? AppColor
                                              //                     .colorBGBlack
                                              //                 : AppColor
                                              //                     .colorWhite,
                                              //         borderRadius:
                                              //             BorderRadius.vertical(
                                              //               top: Radius.circular(
                                              //                 AppBorderRadius
                                              //                     .borderRadius20,
                                              //               ),
                                              //             ),
                                              //       ),
                                              //       child:
                                              //           AttachmentsPopupWidget(),
                                              //     );
                                              //   },
                                              // );
                                            },
                                            child: RotatedBox(
                                              quarterTurns: 3,
                                              child: Icon(
                                                Icons.attachment_outlined,
                                                color: AppColor.colorPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    isExpand.value = !isExpand.value;
                  },
                  icon:
                      isExpand.value
                          ? Icon(Icons.keyboard_arrow_up)
                          : Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
