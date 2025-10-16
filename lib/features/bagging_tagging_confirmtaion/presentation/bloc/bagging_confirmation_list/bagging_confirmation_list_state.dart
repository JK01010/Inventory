part of 'bagging_confirmation_list_bloc.dart';

class BaggingConfirmationListState extends Equatable {
  const BaggingConfirmationListState({
    required this.isLoading,
    required this.baggingAndTaggingFailures,
    required this.baggingConfirmationListEntity,
    required this.storageLocation,
    required this.isCompleteSelected,
    required this.reader,
    required this.rangeValue,
    this.scanController,
    required this.isScanning,
    required this.rfidList,
    required this.isContinueEnable,
    required this.locList,
    required this.selectedGrnId,
    required this.isConfirmationListLoading,
    required this.confirmationListByItemIds,
    required this.confirmationListByGRNId,
    required this.rfidItemIds,
  });

  factory BaggingConfirmationListState.initial() =>
      BaggingConfirmationListState(
        baggingConfirmationListEntity: [],
        isLoading: false,
        baggingAndTaggingFailures: none(),
        storageLocation: '',
        isCompleteSelected: false,
        reader: Kdcreader(),
        rangeValue: 0,
        scanController: StreamController<String>.broadcast(),
        isScanning: false,
        rfidList: [],
        isContinueEnable: false,
        locList: [],
        selectedGrnId: 0,
        isConfirmationListLoading: false,
        confirmationListByItemIds: [],
        confirmationListByGRNId: [],
        rfidItemIds: [],
      );

  final List<BaggingConfirmationListEntity> baggingConfirmationListEntity;
  final bool isLoading;
  final Option<BaggingAndTaggingFailures> baggingAndTaggingFailures;
  final String storageLocation;
  final bool isCompleteSelected;

  final Kdcreader reader;
  final int rangeValue;
  final StreamController<String>? scanController;
  final bool isScanning;
  final List<String> rfidList;
  final bool isContinueEnable;

  final List<LocationModelForConfirmation> locList;
  final int selectedGrnId;
  final bool isConfirmationListLoading;
  final List<Map<String, dynamic>> confirmationListByItemIds;
  final List<Map<String, dynamic>> confirmationListByGRNId;

  final List<int> rfidItemIds;

  @override
  List<Object?> get props => [
        baggingConfirmationListEntity,
        isLoading,
        baggingAndTaggingFailures,
        storageLocation,
        isCompleteSelected,
        reader,
        rangeValue,
        scanController,
        isScanning,
        rfidList,
        locList,
        selectedGrnId,
        isConfirmationListLoading,
        confirmationListByItemIds,
        confirmationListByGRNId,
        rfidItemIds,
      ];

  BaggingConfirmationListState copyWith({
    List<BaggingConfirmationListEntity>? baggingConfirmationListEntity,
    bool? isLoading,
    Option<BaggingAndTaggingFailures>? baggingAndTaggingFailures,
    String? storageLocation,
    bool? isCompleteSelected,
    Kdcreader? reader,
    int? rangeValue,
    StreamController<String>? scanController,
    bool? isScanning,
    bool? isContinueEnable,
    List<String>? rfidList,
    List<LocationModelForConfirmation>? locList,
    int? selectedGrnId,
    bool? isConfirmationListLoading,
    List<Map<String, dynamic>>? confirmationListByItemIds,
    List<Map<String, dynamic>>? confirmationListByGRNId,
    List<int>? rfidItemIds,
  }) {
    return BaggingConfirmationListState(
      baggingConfirmationListEntity:
          baggingConfirmationListEntity ?? this.baggingConfirmationListEntity,
      isLoading: isLoading ?? this.isLoading,
      baggingAndTaggingFailures:
          baggingAndTaggingFailures ?? this.baggingAndTaggingFailures,
      storageLocation: storageLocation ?? this.storageLocation,
      isCompleteSelected: isCompleteSelected ?? this.isCompleteSelected,
      reader: reader ?? this.reader,
      rangeValue: rangeValue ?? this.rangeValue,
      scanController: scanController ?? this.scanController,
      isScanning: isScanning ?? this.isScanning,
      rfidList: rfidList ?? this.rfidList,
      isContinueEnable: isContinueEnable ?? this.isContinueEnable,
      locList: locList ?? this.locList,
      selectedGrnId: selectedGrnId ?? this.selectedGrnId,
      isConfirmationListLoading:
          isConfirmationListLoading ?? this.isConfirmationListLoading,
      confirmationListByItemIds:
          confirmationListByItemIds ?? this.confirmationListByItemIds,
      confirmationListByGRNId:
          confirmationListByGRNId ?? this.confirmationListByGRNId,
      rfidItemIds: rfidItemIds ?? this.rfidItemIds,
    );
  }
}
