// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bagging_tagging_purchase_pending_details_bloc.dart';

class BaggingTaggingPurchasePendingDetailsState extends Equatable {
  const BaggingTaggingPurchasePendingDetailsState({
    required this.isLoading,
    required this.goodsReceiptPurchaseItemDetailEntity,
    required this.goodsReceiptPurchaseItemDetailEntityList,
    required this.goodsReceiptFailure,
    required this.goodsReceiptsTransactionEntity,
    required this.saveLoading,
  });

  factory BaggingTaggingPurchasePendingDetailsState.initial() =>
      BaggingTaggingPurchasePendingDetailsState(
        isLoading: false,
        goodsReceiptPurchaseItemDetailEntityList: [],
        goodsReceiptFailure: none(),
        goodsReceiptPurchaseItemDetailEntity:
            GoodsReceiptPurchaseItemDetailEntity(
              poId: 0,
              poNo: '',
              grnId: 0,
              grnNo: '',
              itemId: 0,
              itemVersionId: 0,
              itemLinkId: 0,
              parentItemId: 0,
              parentItemVersionId: 0,
              parentItemLinkId: 0,
              receivedQty: 0.0,
              convertedStockQty: 0.0,
              newStock: 0.0,
              damagedOrWrongSupply: 0.0,
              reconditionedStock: 0.0,
              expiryDate: '',
              uomId: 0,
              qualityId: 0,
              batchNo: '',
              remarks: '',
              isMd: false,
              isSdoc: false,
              zeroDeclaration: false,
              ihmMaterialQty: 0.0,
              articleNo: '',
              productName: '',
              productDescription: '',
              eccnNo: '',
              hsCode: '',
              countryName: '',
              isAntiPiracy: false,
              isPyroTechnics: false,
              imdgClassId: 0,
              className: '',
              partNo: '',
              categoryName: '',
              itemCategoryId: 0,
              itemSectionId: 0,
              sectionName: '',
              itemSubSectionId: 0,
              subSectionName: '',
              itemUom: '',
              isExportControl: false,
              isIhm: false,
              isCritical: false,
              isImdg: false,
              vessel: '',
              poQuantity: 0,
              isBagTagItem: false,
              drawingPositionNumber: '',
              drawingNumber: '',
              unitPrice: 0,
              equipmentId: 0,
              equipmentName: '',
              grnDtId: -1
            ),
        goodsReceiptsTransactionEntity:
            GoodsReceiptsTransactionEntity.initial(),
        saveLoading: false,
      );

  final bool isLoading;
  final GoodsReceiptsTransactionEntity goodsReceiptsTransactionEntity;
  final GoodsReceiptPurchaseItemDetailEntity
  goodsReceiptPurchaseItemDetailEntity;
  final List<GoodsReceiptPurchaseItemDetailEntity>
  goodsReceiptPurchaseItemDetailEntityList;
  final Option<GoodsReceiptsFailures> goodsReceiptFailure;
  final bool saveLoading;

  @override
  List<Object?> get props => [
    isLoading,
    goodsReceiptPurchaseItemDetailEntity,
    goodsReceiptPurchaseItemDetailEntityList,
    goodsReceiptFailure,
    goodsReceiptsTransactionEntity,
    saveLoading,
  ];

  BaggingTaggingPurchasePendingDetailsState copyWith({
    bool? isLoading,
    GoodsReceiptsTransactionEntity? goodsReceiptsTransactionEntity,
    Option<GoodsReceiptsFailures>? goodsReceiptFailure,
    bool? saveLoading,
    GoodsReceiptPurchaseItemDetailEntity? goodsReceiptPurchaseItemDetailEntity,
    List<GoodsReceiptPurchaseItemDetailEntity>?
    goodsReceiptPurchaseItemDetailEntityList,
  }) {
    return BaggingTaggingPurchasePendingDetailsState(
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptsTransactionEntity:
          goodsReceiptsTransactionEntity ?? this.goodsReceiptsTransactionEntity,
      goodsReceiptFailure: goodsReceiptFailure ?? this.goodsReceiptFailure,
      saveLoading: saveLoading ?? this.saveLoading,
      goodsReceiptPurchaseItemDetailEntity:
          goodsReceiptPurchaseItemDetailEntity ??
          this.goodsReceiptPurchaseItemDetailEntity,
      goodsReceiptPurchaseItemDetailEntityList:
          goodsReceiptPurchaseItemDetailEntityList ??
          this.goodsReceiptPurchaseItemDetailEntityList,
    );
  }
}
