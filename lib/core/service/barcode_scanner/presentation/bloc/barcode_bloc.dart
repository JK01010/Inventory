import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../domain/entities/barcode_entity.dart';
import '../../domain/use_cases/get_scanned_barcode_stream_use_case.dart';
import '../../domain/use_cases/initialize_barcode_scanner_use_case.dart';
import '../../domain/use_cases/request_camera_permission_use_case.dart';
import '../../domain/use_cases/start_scan_use_case.dart';
import '../../domain/use_cases/stop_scan_use_case.dart';

part 'barcode_event.dart';

part 'barcode_state.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  BarcodeBloc({
    required this.initializeBarcodeScannerUseCase,
    required this.startScanUseCase, // Still required for DI, but logic will change
    required this.stopScanUseCase, // Still required for DI, but logic will change
    required this.getScannedBarcodeStreamUseCase,
    required this.requestCameraPermissionUseCase,
  }) : super(BarcodeState.initial()) {
    on<InitializeScanner>(_onInitializeScanner);
    on<StartScan>(_onStartScan);
    on<StopScan>(_onStopScan);
    on<BarcodeScanned>(_onBarcodeScanned);
    on<RequestCameraPermission>(_onRequestCameraPermission);
    on<ResetScanner>(_onResetScanner);
    on<ToggleFlashLightEvent>((event, emit) async {
      await _onToggleFlashLight(event, emit);
    });
  }

  final InitializeBarcodeScannerUseCase initializeBarcodeScannerUseCase;
  final StartScanUseCase startScanUseCase; // Will be simplified
  final StopScanUseCase stopScanUseCase; // Will be simplified
  final GetScannedBarcodeStreamUseCase getScannedBarcodeStreamUseCase;
  final RequestCameraPermissionUseCase requestCameraPermissionUseCase;

  StreamSubscription? _barcodeSubscription;

  Future<void> _onInitializeScanner(
    InitializeScanner event,
    Emitter<BarcodeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final permissionResult = await requestCameraPermissionUseCase();

    await permissionResult.fold(
      (failure) async => emit(
        state.copyWith(isBarCodeScanFailed: true, message: failure.message),
      ),
      (granted) async {
        if (!granted) {
          emit(
            state.copyWith(
              message: 'Camera permission denied. Please grant it in settings.',
              isPermissionGranted: false,
            ),
          );
          return;
        }

        final initResult = await initializeBarcodeScannerUseCase();
        initResult.fold(
          (failure) => emit(
            state.copyWith(isBarCodeScanFailed: true, message: failure.message),
          ),
          (controller) {
            bool isTorchOn = controller.value.torchState == TorchState.on;
            // Pass the controller to the ready state
            emit(
              state.copyWith(
                isBarCodeScannerReady: true,
                controller: controller,
                isTorchOn: isTorchOn,
              ),
            );
            _barcodeSubscription
                ?.cancel(); // Cancel previous subscription if any
            _barcodeSubscription = getScannedBarcodeStreamUseCase()
                .distinct()
                .listen(
                  (barcode) {
                    debugPrint("barcode : $barcode");
                    add(BarcodeScanned(barcode));
                  },

                  onError:
                      (error) => emit(
                        state.copyWith(
                          isBarCodeScanFailed: true,
                          message: 'Error receiving barcode: $error',
                        ),
                      ),
                  onDone: () => debugPrint('Barcode stream closed.'),
                );
          },
        );
      },
    );
  }

  Future<void> _onStartScan(StartScan event, Emitter<BarcodeState> emit) async {
    if (state.isBarCodeScannerScanning) {
      return;
    }
    try {
      emit(state.copyWith(isBarCodeScannerScanning: true));
    } catch (e) {
      emit(
        state.copyWith(
          isBarCodeScanFailed: true,
          message: 'Failed to start scanning: $e',
        ),
      );
    }
  }

  Future<void> _onStopScan(StopScan event, Emitter<BarcodeState> emit) async {
    try {
      state.controller?.stop();
      emit(
        state.copyWith(
          isBarCodeScannerScanning: false,
          isBarCodeScanSuccess: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isBarCodeScanFailed: true,
          message: 'Failed to stop scanning: $e',
        ),
      );
    }
  }

  void _onBarcodeScanned(BarcodeScanned event, Emitter<BarcodeState> emit) {
    if (state.isBarCodeScanSuccess == false) {
      debugPrint("inside the _onBarcodeScanned ************");
      emit(state.copyWith(isBarCodeScanSuccess: true, barcode: event.barcode));
    }
  }

  Future<void> _onRequestCameraPermission(
    RequestCameraPermission event,
    Emitter<BarcodeState> emit,
  ) async {
    // Check if the bloc is already closed before proceeding
    if (isClosed) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result = await requestCameraPermissionUseCase();

    // Check again after the async operation completes
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) {
        if (!isClosed) {
          // Double check before emitting
          emit(
            state.copyWith(isBarCodeScanFailed: true, message: failure.message),
          );
        }
      },
      (granted) {
        if (isClosed) {
          return; // Double check before emitting/adding
        }

        if (granted) {
          emit(state.copyWith(isPermissionGranted: true));
          // Only add InitializeScanner if the bloc is still open
          if (!isClosed) {
            add(InitializeScanner());
          }
        } else {
          emit(
            state.copyWith(
              isPermissionGranted: false,
              message: 'Camera permission denied.',
            ),
          );
        }
      },
    );
  }

  void _onResetScanner(ResetScanner event, Emitter<BarcodeState> emit) {
    emit(
      state.copyWith(
        isBarCodeScanFailed: false,
        isPermissionGranted: true,
        isBarCodeScanSuccess: false,
        isBarCodeScannerScanning: true,
        barcode: null,
        isBarCodeScannerReady: true,
      ),
    ); // Reset to initial state
  }

  @override
  Future<void> close() {
    _barcodeSubscription?.cancel();
    return super.close();
  }

  Future<void> _onToggleFlashLight(
    ToggleFlashLightEvent event,
    Emitter<BarcodeState> emit,
  ) async {
    if (state.controller != null) {
      await state.controller!.toggleTorch();
      bool isTorchOn = state.controller!.value.torchState == TorchState.off;
      emit(state.copyWith(isTorchOn: isTorchOn));
    }
  }
}
