part of 'goods_receipt_create_label_bloc.dart';

class GoodsReceiptCreateLabelState extends Equatable {
  GoodsReceiptCreateLabelState({
    required this.goodsReceiptPurchaseOrderLineItemEntity,
    required this.isLoading,
    required this.goodsReceiptsLabelDetailFailure,
    required this.isInitialLoad,
    required this.goodsReceiptLabelEntity,
    required this.storageLocationEntityList,
    required this.fetchImdgClassList,
    required this.isAutoSerialNumber,
    required this.autoSerialNumberList,
    required this.itemRobDetailsList,
    required this.isSaveSuccess,
  });

  factory GoodsReceiptCreateLabelState.initial() =>
      GoodsReceiptCreateLabelState(
        goodsReceiptLabelEntity: GoodsReceiptLabelEntity(
          dtId: -1,
          hdId: -1,
          itemId: -1,
          qty: 0,
          packetSize: "",
          unitPrice: "",
          imdgClassId: 0,
          remarksFromVendor: "",
          flag: "",
          expiryDate: "",
          tags: "",
          isPartial: "",
          isSync: 'N',
        ),
        isLoading: false,
        goodsReceiptsLabelDetailFailure: none(),
        isInitialLoad: true,
        goodsReceiptPurchaseOrderLineItemEntity: null,

        storageLocationEntityList: [],
        fetchImdgClassList: [],
        isAutoSerialNumber: false,
        autoSerialNumberList: [],
        itemRobDetailsList: [],
        isSaveSuccess: false,
      );

  final GoodsReceiptPurchaseOrderLineItemEntity?
  goodsReceiptPurchaseOrderLineItemEntity;
  final bool? isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsLabelDetailFailure;
  bool isInitialLoad = true;
  final GoodsReceiptLabelEntity? goodsReceiptLabelEntity;
  final List<StorageLocationEntity> storageLocationEntityList;
  final List<ImdgClassEntity> fetchImdgClassList;
  bool? isAutoSerialNumber = false;
  final List<String> autoSerialNumberList;
  final List<ItemRobDetailsEntity>? itemRobDetailsList;
  final bool isSaveSuccess;

  @override
  List<Object?> get props => [
    goodsReceiptPurchaseOrderLineItemEntity,
    isLoading,
    isInitialLoad,
    goodsReceiptLabelEntity,
    goodsReceiptsLabelDetailFailure,
    storageLocationEntityList,
    fetchImdgClassList,
    isAutoSerialNumber,
    autoSerialNumberList,
    itemRobDetailsList,
    isSaveSuccess,
  ];

  GoodsReceiptCreateLabelState copyWith({
    GoodsReceiptPurchaseOrderLineItemEntity?
    goodsReceiptPurchaseOrderLineItemEntity,
    bool? isLoading,
    Option<GoodsReceiptsFailures>? getGoodsReceiptsLabelDetailFailure,
    bool? isInitialLoad,
    List<StorageLocationEntity>? storageLocationEntityList,
    List<ImdgClassEntity>? fetchImdgClassList,
    bool? isAutoSerialNumber,
    List<String>? autoSerialNumberList,
    List<ItemRobDetailsEntity>? itemRobDetailsList,
    bool? isSaveSuccess,
  }) {
    return GoodsReceiptCreateLabelState(
      goodsReceiptPurchaseOrderLineItemEntity:
          goodsReceiptPurchaseOrderLineItemEntity ??
          this.goodsReceiptPurchaseOrderLineItemEntity,
      isInitialLoad: isInitialLoad ?? this.isInitialLoad,
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptLabelEntity: this.goodsReceiptLabelEntity,
      storageLocationEntityList:
          storageLocationEntityList ?? this.storageLocationEntityList,
      fetchImdgClassList: fetchImdgClassList ?? this.fetchImdgClassList,
      goodsReceiptsLabelDetailFailure: goodsReceiptsLabelDetailFailure,
      isAutoSerialNumber: isAutoSerialNumber ?? this.isAutoSerialNumber,
      autoSerialNumberList: autoSerialNumberList ?? this.autoSerialNumberList,
      itemRobDetailsList: itemRobDetailsList ?? this.itemRobDetailsList,
      isSaveSuccess: isSaveSuccess ?? this.isSaveSuccess,
    );
  }
}
