import 'package:equatable/equatable.dart';


abstract class BarcodeFailure extends Equatable {

  const BarcodeFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class CameraPermissionDeniedFailure extends BarcodeFailure {
  const CameraPermissionDeniedFailure() : super('Camera permission denied.');
}

class CameraInitializationFailure extends BarcodeFailure {
  const CameraInitializationFailure([super.message = 'Failed to initialize camera.']);
}

class ScanFailure extends BarcodeFailure {
  const ScanFailure([super.message = 'Barcode scanning failed.']);
}

class UnexpectedBarcodeFailure extends BarcodeFailure {
  const UnexpectedBarcodeFailure([super.message = 'An unexpected error occurred.']);
}
