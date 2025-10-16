part of 'barcode_bloc.dart';

class BarcodeState extends Equatable {
  const BarcodeState({
    required this.isLoading,
    required this.isPermissionGranted,
    required this.isBarCodeScannerReady,
    required this.isBarCodeScannerScanning,
    required this.isBarCodeScanSuccess,
    required this.isBarCodeScanFailed,
    this.barcode,
    required this.message,
    this.controller,
    required this.isTorchOn
  });

  factory BarcodeState.initial() {
    return const BarcodeState(
      isLoading: false,
      isPermissionGranted: false,
      isBarCodeScannerReady: false,
      isBarCodeScannerScanning: true,
      isBarCodeScanFailed: false,
      isBarCodeScanSuccess: false,
      message: '',
      isTorchOn: false,
    );
  }

  final bool isLoading;
  final bool isPermissionGranted;
  final bool isBarCodeScannerReady;
  final bool isBarCodeScannerScanning;
  final bool isBarCodeScanSuccess;
  final bool isBarCodeScanFailed;
  final BarcodeEntity? barcode;
  final String message;
  final MobileScannerController? controller;
  final bool isTorchOn;

  @override
  List<Object?> get props => [
    isLoading,
    isPermissionGranted,
    isBarCodeScannerReady,
    isBarCodeScannerScanning,
    isBarCodeScanSuccess,
    isBarCodeScanFailed,
    barcode,
    message,
    controller,
    isTorchOn
  ];

  BarcodeState copyWith({
    bool? isLoading,
    bool? isPermissionGranted,
    bool? isBarCodeScannerReady,
    bool? isBarCodeScannerScanning,
    bool? isBarCodeScanSuccess,
    bool? isBarCodeScanFailed,
    BarcodeEntity? barcode,
    String? message,
    MobileScannerController? controller,
    bool? isTorchOn,
    bool keepNull = false,
  }) {
    return BarcodeState(
      isLoading: isLoading ?? this.isLoading,
      isPermissionGranted: isPermissionGranted ?? this.isPermissionGranted,
      isBarCodeScannerReady:
          isBarCodeScannerReady ?? this.isBarCodeScannerReady,
      isBarCodeScannerScanning:
          isBarCodeScannerScanning ?? this.isBarCodeScannerScanning,
      isBarCodeScanSuccess: isBarCodeScanSuccess ?? this.isBarCodeScanSuccess,
      isBarCodeScanFailed: isBarCodeScanFailed ?? this.isBarCodeScanFailed,
      barcode: keepNull == true ? barcode : barcode ?? this.barcode,
      message: message ?? this.message,
      controller: controller ?? this.controller,
      isTorchOn: isTorchOn ?? this.isTorchOn,
    );
  }
}

// class BarcodeInitial extends BarcodeState {}
//
// class BarcodeLoading extends BarcodeState {}
//
// class BarcodePermissionGranted extends BarcodeState {}
//
// class BarcodePermissionDenied extends BarcodeState {
//   const BarcodePermissionDenied(this.message);
//   final String message;
//
//   @override
//   List<Object> get props => [message];
// }
//
// class BarcodeReady extends BarcodeState { // Controller is now part of the state
//   const BarcodeReady({this.controller});
//   final MobileScannerController? controller;
//
//   @override
//   List<Object?> get props => [controller];
// }
//
// class BarcodeScanning extends BarcodeState { // Controller is now part of the state
//   const BarcodeScanning({this.controller});
//   final MobileScannerController? controller;
//
//   @override
//   List<Object?> get props => [controller];
// }
//
// class BarcodeScannedSuccess extends BarcodeState { // Controller is now part of the state
//
//   const BarcodeScannedSuccess(this.barcode, {this.controller});
//   final BarcodeEntity barcode;
//   final MobileScannerController? controller;
//
//   @override
//   List<Object?> get props => [barcode, controller];
// }
//
// class BarcodeError extends BarcodeState {
//
//   const BarcodeError(this.message);
//   final String message;
//
//   @override
//   List<Object> get props => [message];
// }
//
