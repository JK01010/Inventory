part of 'storage_location_bloc.dart';

class StorageLocationState extends Equatable {
  const StorageLocationState({
    required this.storageLocationEntityList,
    required this.storageLocationEntity,
    required this.isLoading,
    required this.goodsReceiptsFailure,
    required this.breadCrumbEntityList,
    required this.storageLocationViewListEntity
  });

  factory StorageLocationState.initial() => StorageLocationState(
    isLoading: false,
    storageLocationEntity: StorageLocationEntity(
      id: 0,
      parentId: 0,
      code: '',
      locName: '',
      description: '',
      vesselLocationID: 0,
      isActive: false,
      referenceTypeID: 0,
      referenceID: 0,
      referenceSubID: 0,
      parentLocName: '',
    ),
    storageLocationEntityList: [],
    goodsReceiptsFailure: none(),
    breadCrumbEntityList: [
      StorageLocationEntity(
        id: 0,
        parentId: 0,
        code: '',
        locName: '',
        description: '',
        vesselLocationID: 0,
        isActive: false,
        referenceTypeID: 0,
        referenceID: 0,
        referenceSubID: 0,
        parentLocName: '',
      ),

    ],
    storageLocationViewListEntity:[],
  );

  final List<StorageLocationEntity> storageLocationEntityList;
  final StorageLocationEntity storageLocationEntity;
  final bool isLoading;
  final Option<GoodsReceiptsFailures> goodsReceiptsFailure;
  final List<StorageLocationEntity> breadCrumbEntityList;
  final List<StorageLocationEntity> storageLocationViewListEntity;

  @override
  List<Object?> get props => [
    isLoading,
    storageLocationEntity,
    storageLocationEntityList,
    goodsReceiptsFailure,
    breadCrumbEntityList,
    storageLocationViewListEntity,
  ];

  StorageLocationState copyWith({
    bool? isLoading,
    StorageLocationEntity? storageLocationEntity,
    List<StorageLocationEntity>? storageLocationEntityList,
    Option<GoodsReceiptsFailures>? goodsReceiptsFailure,
    List<String>? breadCrumbItems,
    List<StorageLocationEntity>? breadCrumbEntityList,
    List<StorageLocationEntity>? storageLocationViewListEntity,
  }) {
    return StorageLocationState(
      storageLocationEntityList:
          storageLocationEntityList ?? this.storageLocationEntityList,
      storageLocationEntity:
          storageLocationEntity ?? this.storageLocationEntity,
      isLoading: isLoading ?? this.isLoading,
      goodsReceiptsFailure: goodsReceiptsFailure ?? this.goodsReceiptsFailure,
      breadCrumbEntityList: breadCrumbEntityList ?? this.breadCrumbEntityList,
      storageLocationViewListEntity: storageLocationViewListEntity ?? this.storageLocationViewListEntity,
    );
  }
}
