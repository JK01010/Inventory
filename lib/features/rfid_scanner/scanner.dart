import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:kdcreader/kdcreader.dart';
final Map<Kdcreader, bool> _scanActive = {};

Future<Either<bool, Kdcreader>> initReader() async {
  Kdcreader reader = Kdcreader();
  //
  // // Subscribe to connection events
  // reader.getConnectionStateStream().listen(
  //       (event) {
  //     log("Connection event: ${event}");
  //   },
  //   onError: (err) => log("Error: $err"),
  //   onDone: () => log("Stream closed"),
  // );

  // Discover USB devices
  final devices = await reader.getAvailableDeviceList(DeviceListType.ATTACHED_USB_LIST);

  if (devices != null && devices.isNotEmpty) {
    log("Found devices: $devices");
    final hasPermission = await _checkUsbPermission(devices.first,reader);
    if (!hasPermission) {
      final isGranted = await _requestUsbPermission(devices.first,reader);
      await Future.delayed(Duration(seconds: 2));
      if (!isGranted) {
        return Left(false);
      }else{
        final device = devices.first;
        try {
          final result = await reader.connect(device);
          if(result==true){
            return Right(reader);
          }
          else{
            return Left(false);
          }

        } catch (e) {
          log("Error while connecting: $e");
          return Left(false);
        }
      }
    }else{
      final device = devices.first;
      try {
        final result = await reader.connect(device);
        if(result==true){
          return Right(reader);
        }
        else{
          return Left(false);
        }
      } catch (e) {
        log("Error while connecting: $e");
        return Left(false);
      }
    }
  } else {
    log("⚠️ No USB devices found");
    return Left(false);
  }
}

Stream<String> startScan(
    Kdcreader reader, {
      Duration interval = const Duration(seconds: 1),
      int timeout = 1000,
      int? powerLevel,
    }) async* {
  final isConnected = await reader.isConnected();
  if (isConnected ?? false) {
    await reader.enableUHFPower(true);
    await reader.setUHFReadMode(UHFReadMode.NFC_RFID);
    await reader.setUHFReadTagMode(UHFReadTagMode.MULTIPLE);
    await reader.setUHFPowerLevelEx(powerLevel ?? 18);

    _scanActive[reader] = true; // mark active

    while (_scanActive[reader] == true) {
      try {
        final tags = await reader.getUHFTagList(timeout);
        if (tags != null && tags.isNotEmpty) {
          for (final epc in tags) {
            log("UHF Tag EPC: $epc");
            yield epc;
          }
        }
      } catch (e) {
        log("Cannot find: $e");
      }

      await Future.delayed(interval);
    }
  }
}

Future<void> stopScan({required Kdcreader reader}) async {
  try {
    _scanActive[reader] = false; // break the loop in startScan
    await reader.setUHFPowerLevelEx(0);
    await reader.enableUHFPower(false);
    await reader.cancelUHFReading();
    log("Scan stopped for reader");
  } catch (e) {
    log('Scanner stop failed: ${e.toString()}');
  }
}

Future<bool> _checkUsbPermission(KDCDevice device,Kdcreader reader) async {
  return await reader.checkUsbPermission(device) ?? false;
}

Future<bool> _requestUsbPermission(KDCDevice device,Kdcreader reader) async {
  return await reader.requestUsbPermission(device) ?? false;
}

 Future<void>getPermission()async{
  Kdcreader reader = Kdcreader();
  final devices = await reader.getAvailableDeviceList(DeviceListType.ATTACHED_USB_LIST);
  if (devices != null && devices.isNotEmpty) {
    log("Found devices: $devices");
    final hasPermission = await _checkUsbPermission(devices.first,reader);
    if (!hasPermission) {
      final isGranted = await _requestUsbPermission(devices.first,reader);
      if (!isGranted) {
      }
    }
  }
}