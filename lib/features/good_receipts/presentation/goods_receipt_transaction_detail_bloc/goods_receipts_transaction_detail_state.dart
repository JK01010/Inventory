part of 'goods_receipts_transaction_detail_bloc.dart';

class GoodsReceiptsTransactionDetailState extends Equatable {
  const GoodsReceiptsTransactionDetailState({
    required this.isLoading,
    required this.goodsReceiptPurchaseItemDetailEntity,
    required this.goodsReceiptPurchaseItemDetailEntityList,
    required this.goodsReceiptFailure,
  });

  factory GoodsReceiptsTransactionDetailState.initial() =>
      GoodsReceiptsTransactionDetailState(
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
      );

  final bool isLoading;
  final GoodsReceiptPurchaseItemDetailEntity
  goodsReceiptPurchaseItemDetailEntity;
  final List<GoodsReceiptPurchaseItemDetailEntity>
  goodsReceiptPurchaseItemDetailEntityList;
  final Option<GoodsReceiptsFailures> goodsReceiptFailure;

  @override
  List<Object?> get props => [
    isLoading,
    goodsReceiptPurchaseItemDetailEntity,
    goodsReceiptPurchaseItemDetailEntityList,
    goodsReceiptFailure,
  ];

  GoodsReceiptsTransactionDetailState copyWith({
    bool? isLoading,
    GoodsReceiptPurchaseItemDetailEntity? goodsReceiptPurchaseItemDetailEntity,
    List<GoodsReceiptPurchaseItemDetailEntity>?
    goodsReceiptPurchaseItemDetailEntityList,
    Option<GoodsReceiptsFailures>? goodsReceiptFailure,
  }) {
    return GoodsReceiptsTransactionDetailState(
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptPurchaseItemDetailEntity:
          goodsReceiptPurchaseItemDetailEntity ??
          this.goodsReceiptPurchaseItemDetailEntity,
      goodsReceiptPurchaseItemDetailEntityList:
          goodsReceiptPurchaseItemDetailEntityList ??
          this.goodsReceiptPurchaseItemDetailEntityList,
      goodsReceiptFailure: goodsReceiptFailure ?? this.goodsReceiptFailure,
    );
  }
}
