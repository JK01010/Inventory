part of 'item_master_bloc.dart';

class ItemMasterState extends Equatable {

  const ItemMasterState({
    required this.itemMasterList,
    required this.isLoading,
    required this.itemMasterFailures,
    required this.isFilterEnable,
    required this.searchList,
    required this.offSet,
    required this.hasMore,
    required this.reader,
    required this.rangeValue,
    this.scanController,
    required this.isScanning,
    required this.rfidList,
    required this.commonRfid,
    required this.selectedItemId,
    required this.isRfidDeviceConnected,
  });

  factory ItemMasterState.initial() =>
      ItemMasterState(
          itemMasterList: const [],
          isLoading: false,
          itemMasterFailures: none(),
          isFilterEnable:false,
          searchList: const [],
          offSet:0,
          hasMore:true,
          reader: Kdcreader(),
          rangeValue: 18,
          scanController: StreamController<String>.broadcast(),
          isScanning: false,
          rfidList: const [],
          commonRfid: const [],
          selectedItemId:0,
          isRfidDeviceConnected: false,
      );

  final List<ItemMasterEntity> itemMasterList;
  final List<ItemMasterEntity> searchList;

  final bool isLoading;
  final bool isFilterEnable;
  final Option<ItemMasterFailures> itemMasterFailures;
  final int offSet;
  final bool hasMore;

  final Kdcreader reader;
  final double rangeValue;
  final StreamController<String>? scanController;
  final bool isScanning;
  final List<RfidModel> rfidList;

  final List<String> commonRfid;
  final int selectedItemId;

  final bool isRfidDeviceConnected;


  @override
  List<Object?> get props => [
    itemMasterList,
    isLoading,
    itemMasterFailures,
    isFilterEnable,
    offSet,
    searchList,
    hasMore,
    reader,
    rangeValue,
    scanController,
    isScanning,
    rfidList,
    commonRfid,
    selectedItemId,
    isRfidDeviceConnected,
  ];

  ItemMasterState copyWith({
    List<ItemMasterEntity>? itemMasterList,
    List<ItemMasterEntity>? searchList,
    bool? isLoading,
    bool? isFilterEnable,
    Option<ItemMasterFailures>? itemMasterFailures,
    int? offSet,
    bool? hasMore,
    Kdcreader? reader,
    double? rangeValue,
    StreamController<String>? scanController,
    bool? isScanning,
    List<RfidModel>? rfidList,
    List<String>? commonRfid,
    int? selectedItemId,
    bool? isRfidDeviceConnected,
  }) {
    return ItemMasterState(
        searchList: searchList ?? this.searchList,
        itemMasterList: itemMasterList ?? this.itemMasterList,
        isLoading: isLoading ?? this.isLoading,
        itemMasterFailures: itemMasterFailures ?? this.itemMasterFailures,
        isFilterEnable: isFilterEnable ?? this.isFilterEnable,
        offSet: offSet ?? this.offSet,
        hasMore: hasMore ?? this.hasMore,
        reader: reader ?? this.reader,
        rangeValue:  rangeValue ?? this.rangeValue,
        scanController: scanController ?? this.scanController,
        isScanning: isScanning ?? this.isScanning,
        rfidList: rfidList ?? this.rfidList,
         commonRfid: commonRfid ?? this.commonRfid,
        selectedItemId:selectedItemId??this.selectedItemId,
      isRfidDeviceConnected: isRfidDeviceConnected ?? this.isRfidDeviceConnected,
    );
  }
}

