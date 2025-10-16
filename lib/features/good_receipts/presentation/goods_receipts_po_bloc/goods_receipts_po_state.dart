part of 'goods_receipts_po_bloc.dart';

class GoodsReceiptsPoState extends Equatable {
  const GoodsReceiptsPoState({
    required this.goodsReceiptsHdEntityList,
    required this.goodsReceiptPoLineItemList,
    required this.purchaseOrderHDEntity,
    required this.isLoading,
    required this.goodsReceiptsFailures,
    required this.purchaseOrderFilterEntity,
    required this.portEntityList,
    required this.isSaveLoading,
    required this.isFinalizeDone,
  });

  factory GoodsReceiptsPoState.initial() => GoodsReceiptsPoState(
    goodsReceiptsHdEntityList: [],
    goodsReceiptPoLineItemList: [],
    isLoading: false,
    goodsReceiptsFailures: none(),
    purchaseOrderHDEntity: PurchaseOrderHDEntity(
      poCode: '',
      poHdId: 0,
      title: '',
      vendorDeliveryDate: '',
      remarksToVendor: '',
      requisitionCategoryId: 0,
      reqCategoryCode: '',
      requisitionCategory: '',
      deliveryPort: '',
      portCode: '',
      vendorReference: '',

      grnId: 0,
      receiptNo: '',
      receiptDate: '',
      poNo: '',
      poId: -1,
      inSights: '',
      reqCategoryId: -1,
      category: '',
      priorityId: -1,
      priority: '',
      vendorId: -1,
      vendorName: '',
      deliveryDate: '',
      deliveryToId: -1,
      deliveryTo: '',
      poTitle: '',
      totalNoOfProducts: -1,
      plannedNoOfProducts: -1,
      entityId: -1,
      entity: '',
      remarksForVendor: '',
      poCost: 0.0,
      weight: 0.0,
      actualVolume: 0.0,
      currencyName: '',
      noOfPackets: 0,
      presentProperties: '',
      deliveryToLocationId: -1,
      deliveryToLocation: '',
      totalAmountReportingCurrency: 0.0,
      poRemarks: '',
      isBaggingCompleted: false,
      modifiedOn: '',
      portId: -1,
      isFull: false,
      isLocked: false,
    ),
    purchaseOrderFilterEntity: PurchaseOrderFilterEntity(),
    portEntityList: [],
    isSaveLoading: false,
    isFinalizeDone: false,
  );

  final List<PurchaseOrderHDEntity> goodsReceiptsHdEntityList;
  final List<GoodsReceiptPurchaseOrderLineItemEntity>
  goodsReceiptPoLineItemList;
  final PurchaseOrderHDEntity purchaseOrderHDEntity;
  final bool isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailures;
  final PurchaseOrderFilterEntity purchaseOrderFilterEntity;
  final List<PortEntity> portEntityList;
  final bool isSaveLoading;
  final bool isFinalizeDone;

  GoodsReceiptsPoState copyWith({
    List<PurchaseOrderHDEntity>? goodsReceiptsHdEntityList,
    List<GoodsReceiptPurchaseOrderLineItemEntity>? goodsReceiptPoLineItemList,
    PurchaseOrderHDEntity? purchaseOrderHDEntity,
    bool? isLoading,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailures,
    PurchaseOrderFilterEntity? purchaseOrderFilterEntity,
    List<PortEntity>? portEntityList,
    bool? isSaveLoading,
    bool? isFinalizeDone,
  }) {
    return GoodsReceiptsPoState(
      goodsReceiptsHdEntityList:
          goodsReceiptsHdEntityList ?? this.goodsReceiptsHdEntityList,
      goodsReceiptPoLineItemList:
          goodsReceiptPoLineItemList ?? this.goodsReceiptPoLineItemList,
      purchaseOrderHDEntity:
          purchaseOrderHDEntity ?? this.purchaseOrderHDEntity,
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptsFailures:
          goodsReceiptsFailures ?? this.goodsReceiptsFailures,
      purchaseOrderFilterEntity:
          purchaseOrderFilterEntity ?? this.purchaseOrderFilterEntity,
      portEntityList: portEntityList ?? this.portEntityList,
      isSaveLoading: isSaveLoading ?? this.isSaveLoading,
      isFinalizeDone: isFinalizeDone ?? this.isFinalizeDone,
    );
  }

  @override
  List<Object?> get props => [
    goodsReceiptsHdEntityList,
    goodsReceiptPoLineItemList,
    purchaseOrderHDEntity,
    isLoading,
    goodsReceiptsFailures,
    purchaseOrderFilterEntity,
    portEntityList,
    isSaveLoading,
    isFinalizeDone,
  ];
}
