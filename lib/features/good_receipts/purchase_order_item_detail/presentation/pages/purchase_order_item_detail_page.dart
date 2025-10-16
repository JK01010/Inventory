import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../widgets/app_flat_button.dart';
import '../../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../../presentation/quality_bloc/quality_bloc.dart';
import '../../../presentation/widgets/create_label_second_card_widget.dart';
import '../pages_params/purchase_order_item_detail_page_params.dart';
import '../purchase_order_detail_bloc/purchase_order_item_detail_bloc.dart';
import '../purchase_order_detail_bloc/purchase_order_item_detail_bloc_event.dart';
import '../purchase_order_detail_bloc/purchase_order_item_detail_bloc_state.dart';
import '../widgets/purchase_order_item_detail_attachment_widget.dart';
import '../widgets/purchase_order_item_detail_bottom_card.dart';
import '../widgets/purchase_order_item_detail_header_card_widget.dart';
import '../widgets/purchase_order_item_detail_quantity_widget.dart';

class PurchaseOrderItemDetailPage extends StatefulWidget {
  const PurchaseOrderItemDetailPage({
    super.key,
    required this.purchaseOrderItemDetailPageParams,
  });

  final PurchaseOrderItemDetailPageParams purchaseOrderItemDetailPageParams;

  @override
  State<PurchaseOrderItemDetailPage> createState() =>
      _PurchaseOrderItemDetailPageState();
}

class _PurchaseOrderItemDetailPageState
    extends State<PurchaseOrderItemDetailPage> {
  final GlobalKey<CreateLabelSecondCardWidgetState>
  goodsReceiptCreateLabelSaveWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      context.read<PurchaseOrderItemDetailBloc>().add(
        SetInitialDataEvent(
          itemEntity: widget.purchaseOrderItemDetailPageParams.itemEntity,
          purchaseOrderEntity:
              widget.purchaseOrderItemDetailPageParams.purchaseOrderEntity,
        ),
      );
      context.read<QualityBloc>().add(FetchAllQualityListEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      PurchaseOrderItemDetailBloc,
      PurchaseOrderItemDetailBlocState
    >(
      listener: (BuildContext context, PurchaseOrderItemDetailBlocState state) {
        if (state.isSaveSuccess) {
          context.pop();
        }
        if (state.validationError == true &&
            state.validationMessage.isNotEmpty) {
          showSuccessPopup(state.validationMessage, context);
        }
      },
      listenWhen: (previous, current) {
        return (previous.isSaveSuccess != current.isSaveSuccess ||
            previous.validationError != current.validationError ||
            previous.validationMessage != current.validationMessage ||
            previous.isGeneratingSerialNumber !=
                current.isGeneratingSerialNumber);
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
              appBar: CustomAppBar(title: state.itemEntity.productName),

              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                      child: Column(
                        children: <Widget>[
                          //first card
                          PurchaseOrderItemDetailHeaderCardWidget(
                            itemEntity: state.itemEntity,
                          ),
                          SizedBox(height: AppSize.size15),
                          //second card
                          PurchaseOrderItemDetailQuantityWidget(),
                          SizedBox(height: AppSize.size15),
                          //third card
                          PurchaseOrderItemDetailAttachmentWidget(),
                          SizedBox(height: AppSize.size15),
                          //fourth card
                          PurchaseOrderItemDetailBottomCard(),
                        ],
                      ),
                    ),
                  ),
                  if (state.isGeneratingSerialNumber) ...[
                    Positioned.fill(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: AppColor.colorBackground.withValues(alpha: 0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoActivityIndicator(),
                            Text("Generating Serial Numbers"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.scaffoldPadding,
                  right: AppPadding.scaffoldPadding,
                  bottom: AppPadding.scaffoldPadding,
                ),
                child: Row(
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
                        onPressed: () {
                          context.read<PurchaseOrderItemDetailBloc>().add(
                            SavePurchaseOrderItemDetailEvent(),
                          );
                        },
                      ),
                    ),
                  ],
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
        // if (goodsReceiptCreateLabelSaveWidgetKey.currentState != null) {
        //   GoodsReceiptPurchaseOrderLineItemEntity?
        //   goodsReceiptPurchaseOrderLineItemEntity =
        //       goodsReceiptCreateLabelSaveWidgetKey
        //           .currentState
        //           ?.goodsReceiptPurchaseOrderLineItemEntity;
        //   goodsReceiptPurchaseOrderLineItemEntity?.damagedOrWrongSupply =
        //       goodsReceiptCreateLabelSaveWidgetKey
        //               .currentState!
        //               .damagedQtyController
        //               .text
        //               .isEmpty
        //           ? 0
        //           : double.parse(
        //             goodsReceiptCreateLabelSaveWidgetKey
        //                 .currentState!
        //                 .damagedQtyController
        //                 .text
        //                 .toString(),
        //           );
        //   goodsReceiptPurchaseOrderLineItemEntity?.receivedQty =
        //       goodsReceiptCreateLabelSaveWidgetKey
        //               .currentState!
        //               .receivedQtyController
        //               .text
        //               .isEmpty
        //           ? 0
        //           : double.parse(
        //             goodsReceiptCreateLabelSaveWidgetKey
        //                 .currentState!
        //                 .receivedQtyController
        //                 .text
        //                 .toString(),
        //           );
        //   goodsReceiptPurchaseOrderLineItemEntity?.newStock =
        //       goodsReceiptCreateLabelSaveWidgetKey
        //               .currentState!
        //               .newStockController
        //               .text
        //               .isEmpty
        //           ? 0
        //           : double.parse(
        //             goodsReceiptCreateLabelSaveWidgetKey
        //                 .currentState!
        //                 .newStockController
        //                 .text
        //                 .toString(),
        //           );
        //   goodsReceiptPurchaseOrderLineItemEntity?.reconditionedStock =
        //       goodsReceiptCreateLabelSaveWidgetKey
        //               .currentState!
        //               .reConditionStockController
        //               .text
        //               .isEmpty
        //           ? 0
        //           : double.parse(
        //             goodsReceiptCreateLabelSaveWidgetKey
        //                 .currentState!
        //                 .reConditionStockController
        //                 .text
        //                 .toString(),
        //           );
        //   // goodsReceiptPurchaseOrderLineItemEntity?.qualityId = int.parse(
        //   //   goodsReceiptCreateLabelSaveWidgetKey.currentState!.qualityId,
        //   // );
        //   // goodsReceiptPurchaseOrderLineItemEntity?.expiryDate =
        //   // goodsReceiptCreateLabelSaveWidgetKey
        //   //     .currentState!
        //   //     .expiryDateController
        //   //     .text
        //   //     .isEmpty
        //   //     ? ""
        //   //     : goodsReceiptCreateLabelSaveWidgetKey
        //   //     .currentState!
        //   //     .expiryDateController
        //   //     .text
        //   //     .toString();
        //   // goodsReceiptPurchaseOrderLineItemEntity?.batchNo =
        //   // goodsReceiptCreateLabelSaveWidgetKey
        //   //     .currentState!
        //   //     .batchNameController
        //   //     .text
        //   //     .isEmpty
        //   //     ? ''
        //   //     : goodsReceiptCreateLabelSaveWidgetKey
        //   //     .currentState!
        //   //     .batchNameController
        //   //     .text
        //   //     .toString();
        //   // goodsReceiptPurchaseOrderLineItemEntity?.articleNo =
        //   // goodsReceiptCreateLabelSaveWidgetKey
        //   //     .currentState!
        //   //     .inputSerialNumController
        //   //     .text
        //   //     .isEmpty
        //   //     ? '0'
        //   //     : goodsReceiptCreateLabelSaveWidgetKey
        //   //     .currentState!
        //   //     .inputSerialNumController
        //   //     .text
        //   //     .toString();
        //   // goodsReceiptPurchaseOrderLineItemEntity?.imdgClassId =
        //   //     goodsReceiptCreateLabelSaveWidgetKey.currentState!.imdgClassId;
        //   // goodsReceiptPurchaseOrderLineItemEntity?.remarks =
        //   //     goodsReceiptCreateLabelSaveWidgetKey
        //   //         .currentState!
        //   //         .remarksController
        //   //         .text
        //   //         .toString();
        //   // goodsReceiptPurchaseOrderLineItemEntity?.className =
        //   //     goodsReceiptCreateLabelSaveWidgetKey.currentState!.storageLocation;
        //   debugPrint(
        //     'goodsReceiptPurchaseOrderLineItemEntity : $goodsReceiptPurchaseOrderLineItemEntity',
        //   );
        //   if (goodsReceiptPurchaseOrderLineItemEntity != null) {
        //     if (goodsReceiptPurchaseOrderLineItemEntity.receivedQty == 0) {
        //       showSuccessPopup('Received Quantity should not be zero', context);
        //       return;
        //     }
        //     if (goodsReceiptPurchaseOrderLineItemEntity.receivedQty >
        //         goodsReceiptPurchaseOrderLineItemEntity.quantity) {
        //       showSuccessPopup(
        //         'Received Quantity should be less than Quantity',
        //         context,
        //       );
        //       return;
        //     }
        //     if ((goodsReceiptPurchaseOrderLineItemEntity.damagedOrWrongSupply +
        //             goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock +
        //             goodsReceiptPurchaseOrderLineItemEntity.newStock) !=
        //         goodsReceiptPurchaseOrderLineItemEntity.receivedQty) {
        //       showSuccessPopup(
        //         'Total quantity of Damaged, Reconditioned, and New Stock must be equal to Received Quantity',
        //         context,
        //       );
        //       return;
        //     }
        //     List<SplitLocationEntity> splitLocationData = [];
        //     if (goodsReceiptCreateLabelSaveWidgetKey
        //             .currentState
        //             ?.splitStorageLocationWidgetKey
        //             .currentState !=
        //         null) {
        //       SplitStorageLocationWidgetState? splitStorageLocationWidgetState =
        //           goodsReceiptCreateLabelSaveWidgetKey
        //               .currentState
        //               ?.splitStorageLocationWidgetKey
        //               .currentState;
        //       splitLocationData =
        //           splitStorageLocationWidgetState
        //               ?.splitStorageLocationEntityList ??
        //           [];
        //     }
        //     debugPrint("splitLocationData : $splitLocationData");
        //     if (splitLocationData.isNotEmpty) {
        //       if (splitLocationData.any((element) => element.locationId == 0)) {
        //         showSuccessPopup('Choose storage locations', context);
        //         return;
        //       }
        //       var damagedSplitLocationData =
        //           splitLocationData
        //               .where((element) => element.typeId == 1)
        //               .toList();
        //       debugPrint(
        //         "damagedSplitLocationData : $damagedSplitLocationData",
        //       );
        //       if (goodsReceiptPurchaseOrderLineItemEntity
        //                   .damagedOrWrongSupply !=
        //               0 &&
        //           damagedSplitLocationData.isNotEmpty &&
        //           goodsReceiptPurchaseOrderLineItemEntity
        //                   .damagedOrWrongSupply !=
        //               damagedSplitLocationData
        //                   .map((element) => element.quantity)
        //                   .toList()
        //                   .reduce((a, b) => a + b)) {
        //         showSuccessPopup(
        //           'Damage Split Location Quantity should be equal to Damaged Quantity',
        //           context,
        //         );
        //         return;
        //       }
        //       var newQuantitySplitLocationData =
        //           splitLocationData
        //               .where((element) => element.typeId == 2)
        //               .toList();
        //       debugPrint(
        //         "goodsReceiptPurchaseOrderLineItemEntity.newStock : ${goodsReceiptPurchaseOrderLineItemEntity.newStock}",
        //       );
        //       if (goodsReceiptPurchaseOrderLineItemEntity.newStock != 0 &&
        //           newQuantitySplitLocationData.isNotEmpty &&
        //           goodsReceiptPurchaseOrderLineItemEntity.newStock !=
        //               newQuantitySplitLocationData
        //                   .map((element) => element.quantity)
        //                   .toList()
        //                   .reduce((a, b) => a + b)) {
        //         showSuccessPopup(
        //           'New Quantity Split Location Quantity should be equal to New Stock Quantity',
        //           context,
        //         );
        //         return;
        //       }
        //
        //       var reConditionSplitLocationData =
        //           splitLocationData
        //               .where((element) => element.typeId == 3)
        //               .toList();
        //       if (goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock !=
        //               0 &&
        //           reConditionSplitLocationData.isNotEmpty &&
        //           goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock !=
        //               reConditionSplitLocationData
        //                   .map((element) => element.quantity)
        //                   .toList()
        //                   .reduce((a, b) => a + b)) {
        //         showSuccessPopup(
        //           'Reconditioned Stock Quantity Split Location Quantity should be equal to Reconditioned Stock Quantity',
        //           context,
        //         );
        //         return;
        //       }
        //
        //       sl<GoodsReceiptSplitLocationBloc>().add(
        //         PendingPoSplitLocationUpdateToDbEvent(
        //           splitLocationEntityList: splitLocationData,
        //         ),
        //       );
        //     }
        //
        //     debugPrint("validation success *************");
        //
        //     sl<GoodsReceiptCreateLabelBloc>().add(
        //       GoodsReceiptCreateLabelSaveEvent(
        //         goodsReceiptPurchaseOrderLineItemEntity,
        //       ),
        //     );
        //   }
        //
        //   // sl<GoodsReceiptCreateLabelBloc>().add(
        //   //   GoodsReceiptCreateLabelSaveEvent(
        //   //     goodsReceiptPurchaseOrderLineItemEntity!,
        //   //   ),
        //   // );
        //
        //   // if (goodsReceiptCreateLabelSaveWidgetKey
        //   //     .currentState
        //   //     ?.splitStorageLocationWidgetKey
        //   //     .currentState !=
        //   //     null) {
        //   //   SplitStorageLocationWidgetState? splitStorageLocationWidgetState =
        //   //       goodsReceiptCreateLabelSaveWidgetKey
        //   //           .currentState
        //   //           ?.splitStorageLocationWidgetKey
        //   //           .currentState;
        //   //   List<SplitLocationEntity>? splitLocationEntityList =
        //   //       splitStorageLocationWidgetState?.splitStorageLocationEntityList;
        //   //
        //   //   if (splitLocationEntityList!.isNotEmpty) {
        //   //     sl<GoodsReceiptSplitLocationBloc>().add(
        //   //       UpdateSplitLocationInTableOnLabelDetailEvent(
        //   //         splitLocationEntityList,
        //   //       ),
        //   //     );
        //   //   }
        //   // }
        // } else {
        //   debugPrint("inside the else *****************");
        // }
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
