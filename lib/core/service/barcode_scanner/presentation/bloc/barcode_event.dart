part of 'barcode_bloc.dart';

/// Abstract base class for all barcode events.
abstract class BarcodeEvent extends Equatable {
  const BarcodeEvent();

  @override
  List<Object> get props => [];
}

/// Event to initialize the barcode scanner.
class InitializeScanner extends BarcodeEvent {}

/// Event to start the barcode scanning process.
class StartScan extends BarcodeEvent {}

/// Event to stop the barcode scanning process.
class StopScan extends BarcodeEvent {}

/// Event dispatched when a barcode is successfully scanned.
class BarcodeScanned extends BarcodeEvent {
  const BarcodeScanned(this.barcode);

  final BarcodeEntity barcode;

  @override
  List<Object> get props => [barcode];
}

/// Event to request camera permissions.
class RequestCameraPermission extends BarcodeEvent {}

/// Event to reset the scanner to its initial state.
class ResetScanner extends BarcodeEvent {}

class ToggleFlashLightEvent extends BarcodeEvent {}
