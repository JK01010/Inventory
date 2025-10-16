part of 'consumption_rfid_scanning_bloc.dart';

class ConsumptionRfidScanningState extends Equatable {
  const ConsumptionRfidScanningState({
    required this.isScanning,
    required this.continueEnable,
    required this.isLoading,
    required this.isCompleteSelected,
    required this.consumptionFailures,
    required this.viewList,
    required this.mainList,
    required this.reader,
    required this.rfidList,
    required this.rangeValue,
     this.scanController,
  });

  factory ConsumptionRfidScanningState.initial() {
    return ConsumptionRfidScanningState(
      isScanning: false,
      isLoading: false,
      continueEnable: false,
      isCompleteSelected: false,
      consumptionFailures: none(),
      reader: Kdcreader(),
      rangeValue: 18,
      viewList: [],
      rfidList: [],
      mainList: [],
    );
  }

  final bool isScanning;
  final bool continueEnable;
  final bool isLoading;
  final bool isCompleteSelected;
  final Kdcreader reader;
  final double rangeValue;
  final StreamController<String>? scanController;
  final Option<ConsumptionFailures> consumptionFailures;
  final List<ConsumptionRfidListingViewEntity> viewList;
  final List<String> rfidList;
  final List<ConsumptionRfidListingViewEntity> mainList;

  @override
  List<Object?> get props => [
    isScanning,
    continueEnable,
    isLoading,
    isCompleteSelected,
    consumptionFailures,
    viewList,
    mainList,
    reader,
    rfidList,
    rangeValue,
  ];

  @override
  bool get stringify => true;

  ConsumptionRfidScanningState copyWith({
    bool? isScanning,
    bool? continueEnable,
    bool? isLoading,
    bool? isCompleteSelected,
    double? rangeValue,
    Option<ConsumptionFailures>? consumptionFailures,
    List<ConsumptionRfidListingViewEntity>? viewLists,
    List<ConsumptionRfidListingViewEntity>? mainList,
    List<String>? rfidList,
     StreamController<String>? scanController,
    Kdcreader? reader
  }) {
    return ConsumptionRfidScanningState(
      isScanning: isScanning ?? this.isScanning,
      continueEnable: continueEnable ?? this.continueEnable,
      isLoading: isLoading ?? this.isLoading,
      isCompleteSelected: isCompleteSelected ?? this.isCompleteSelected,
      consumptionFailures: consumptionFailures ?? this.consumptionFailures,
      viewList: viewLists ?? this.viewList,
      mainList: mainList ?? this.mainList,
        rfidList: rfidList ?? this.rfidList,
        rangeValue: rangeValue ?? this.rangeValue,
      reader: reader?? this.reader,
        scanController:  scanController ??this.scanController
    );
  }
}
