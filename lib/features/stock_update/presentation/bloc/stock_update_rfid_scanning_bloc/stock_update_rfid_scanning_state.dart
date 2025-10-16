part of 'stock_update_rfid_scanning_bloc.dart';

class StockUpdateRfidScanningState extends Equatable {
  const StockUpdateRfidScanningState({
    required this.isScanning,
    required this.continueEnable,
    required this.isLoading,
    required this.isCompleteSelected,
    required this.viewList,
    required this.mainList,
    required this.stockUpdateFailures,
    required this.reader,
    required this.rangeValue,
    required this.rfidList,
    this.scanController,
  });

  factory StockUpdateRfidScanningState.initial() {
    return StockUpdateRfidScanningState(
      isScanning: false,
      continueEnable: false,
      isLoading: false,
      isCompleteSelected: false,
      viewList: [],
      mainList: [],
      stockUpdateFailures: none(),
      reader: Kdcreader(),
      rangeValue: 0,
      rfidList: [],
      scanController: StreamController<String>.broadcast(),
    );
  }

  final bool isScanning;
  final bool continueEnable;
  final bool isLoading;

  final bool isCompleteSelected;
  final List<StockUpdateRfidListingViewEntity> viewList;
  final List<StockUpdateRfidListingViewEntity> mainList;
  final Option<StockUpdateFailures> stockUpdateFailures;

  final Kdcreader reader;
  final double rangeValue;
  final List<String> rfidList;
  final StreamController<String>? scanController;


  @override
  List<Object?> get props => [
    isScanning,
    continueEnable,
    isLoading,
    isCompleteSelected,
    viewList,
    mainList,
    stockUpdateFailures,
    reader,
    rangeValue,
    rfidList,
    scanController,
  ];

  @override
  bool get stringify => true;

  StockUpdateRfidScanningState copyWith({
    bool? isScanning,
    bool? continueEnable,
    bool? isLoading,
    bool? isCompleteSelected,
    List<StockUpdateRfidListingViewEntity>? viewList,
    List<StockUpdateRfidListingViewEntity>? mainList,
    Option<StockUpdateFailures>? stockUpdateFailures,
    Kdcreader? reader,
    double? rangeValue,
    List<String>? rfidList,
    StreamController<String>? scanController,
  }) {
    return StockUpdateRfidScanningState(
      isScanning: isScanning ?? this.isScanning,
      continueEnable: continueEnable ?? this.continueEnable,
      isLoading: isLoading ?? this.isLoading,
      isCompleteSelected: isCompleteSelected ?? this.isCompleteSelected,
      viewList: viewList ?? this.viewList,
      mainList: mainList ?? this.mainList,
      stockUpdateFailures: stockUpdateFailures ?? this.stockUpdateFailures,
      reader: reader ?? this.reader,
      rangeValue: rangeValue ?? this.rangeValue,
      rfidList: rfidList ?? this.rfidList,
      scanController: scanController ?? this.scanController,
    );
  }
}
