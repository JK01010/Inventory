import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:kdcreader_platform_interface/kdcreader_platform_interface.dart';

import 'type_conversion.dart';

class KdcreaderIos extends KdcreaderPlatformInterface
    with EventChannelKdcreaderIos {
  final MethodChannel _channel =
      const MethodChannel('plugins.flutter.koamtac/ios/kdcreader');
  /// Registers this class as the default instance of [KdcreaderPlatformInterface].
  static void registerWith() {
    KdcreaderPlatformInterface.instance = KdcreaderIos();
  }

  @override
  Future<bool?> enableAttachType(bool enable) {
    return _channel.invokeMethod('enableAttachType', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> enableAttachSerialNumber(bool enable) {
    return _channel.invokeMethod('enableAttachType', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> enableAttachTimestamp(bool enable) {
    return _channel.invokeMethod('enableAttachTimestamp', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> setDataDelimiter(DataDelimiter delimiter) {
    final index = delimiter.index;
    return _channel.invokeMethod('setDataDelimiter', <String, dynamic> {
      'delimiter': index,
    });
  }

  @override
  Future<bool?> setRecordDelimiter(RecordDelimiter delimiter) {
    final index = delimiter.index;
    return _channel.invokeMethod('setRecordDelimiter', <String, dynamic> {
      'delimiter': index,
    });
  }

  @override
  Future<List<KDCDevice>?> getAvailableDeviceList(DeviceListType type,
      {dynamic options}) async {
    final listType = toDeviceListTypeString(type);
    if (listType.isEmpty) {
      return <KDCDevice>[];
    }

    final params = <String, dynamic> {
      'type': listType,
    };

    if (options != null) {
      params['options'] = options;
    }

    final devices = await _channel.invokeListMethod<Map<dynamic, dynamic>> (
        'getAvailDeviceListEx', params);

    return devices?.map<KDCDevice>((item) {
      return KDCDevice.fromMap(item.cast<String, dynamic>());
    }).toList();
  }

  @override
  Future<bool?> connect(KDCDevice? device) {
    final deviceMap = device?.toMap();
    return _channel.invokeMethod<bool>('connectEx', <String, dynamic> {
      'device': deviceMap,
    });
  }

  @override
  Future<bool?> disconnect() {
    return _channel.invokeMethod<bool>('disconnect');
  }

  @override
  Future<bool?> isConnected() {
    return _channel.invokeMethod<bool>('isConnected');
  }

  @override
  Future<bool?> startScan() {
    return _channel.invokeMethod<bool>('startScan');
  }

  @override
  Future<bool?> stopScan() {
    return _channel.invokeMethod<bool>('stopScan');
  }

  @override
  Future<bool?> softwareTrigger() {
    return _channel.invokeMethod<bool>('softwareTrigger');
  }

  //
  // Device information APIs
  //
  @override
  Future<KDCDeviceInfo?> getDeviceInfo() async {
    final map =
        await _channel.invokeMapMethod<String, dynamic>('getDeviceInfo');
    return (map != null) ? KDCDeviceInfo.fromMap(map) : null;
  }

  @override
  Future<KDCDevice?> getConnectedDevice() async {
    final map =
        await _channel.invokeMapMethod<String, dynamic>('getConnectedDeviceEx');
    return (map != null) ? KDCDevice.fromMap(map) : null;
  }

  //
  // Data Process APIs
  //
  @override
  Future<String?> getDataPrefix() {
    return _channel.invokeMethod<String>('getDataPrefix');
  }

  @override
  Future<bool?> setDataPrefix(String prefix) {
    return _channel.invokeMethod<bool>('setDataPrefix', <String, dynamic> {
      'prefix': prefix,
    });
  }

  @override
  Future<String?> getDataSuffix() {
    return _channel.invokeMethod<String>('getDataSuffix');
  }

  @override
  Future<bool?> setDataSuffix(String suffix) {
    return _channel.invokeMethod<bool>('setDataSuffix', <String, dynamic> {
      'suffix': suffix,
    });
  }

  @override
  Future<Map<String, bool>?> getSymbology() async {
    final result =
        await _channel.invokeMapMethod<String, dynamic>('getSymbology');
    return result?.cast<String, bool>();
  }

  @override
  Future<bool?> setSymbology(Map<String, bool> symbols) {
    return _channel.invokeMethod<bool>('setSymbology', <String, dynamic> {
      'symbols': symbols,
    });
  }

  @override
  Future<bool?> enableAllSymbology() {
    return _channel.invokeMethod<bool>('enableAllSymbology');
  }

  @override
  Future<bool?> disableAllSymbology() {
    return _channel.invokeMethod<bool>('disableAllSymbology');
  }

  @override
  Future<Map<String, bool>?> getBarcodeOption() async {
    final result =
        await _channel.invokeMapMethod<String, dynamic>('getBarcodeOption');
    return result?.cast<String, bool>();
  }

  @override
  Future<bool?> setBarcodeOption(Map<String, bool> options) {
    return _channel.invokeMethod<bool>('setBarcodeOption', <String, dynamic> {
      'options': options,
    });
  }

  @override
  Future<bool?> enableAllOptions() {
    return _channel.invokeMethod<bool>('enableAllOptions');
  }

  @override
  Future<bool?> disableAllOptions() {
    return _channel.invokeMethod<bool>('disableAllOptions');
  }

  @override
  Future<int?> getMinimumBarcodeLength() {
    return _channel.invokeMethod<int>('getMinimumBarcodeLength');
  }

  @override
  Future<int?> setMinimumBarcodeLength(int length) {
    return _channel
        .invokeMethod<int>('setMinimumBarcodeLength', <String, dynamic> {
      'length': length,
    });
  }

  @override
  Future<int?> getNumberOfStoredBarcode() {
    return _channel.invokeMethod<int>('getNumberOfStoredBarcode');
  }

  @override
  Future<bool?> getStoredDataSingle() {
    return _channel.invokeMethod<bool>('getStoredDataSingle');
  }

  @override
  Future<DataProcess?> getDataProcessMode() async {
    final index = await _channel.invokeMethod<int>('getDataProcessMode');
    return (index is int) ? DataProcess.values[index] : null;
  }

  @override
  Future<bool?> setDataProcessMode(DataProcess mode) {
    final index = mode.index;
    return _channel.invokeMethod<bool>('setDataProcessMode', <String, dynamic> {
      'length': index,
    });
  }

  @override
  Future<DataFormat?> getDataFormat() async {
    final index = await _channel.invokeMethod<int>('getDataFormat');
    return (index is int) ? DataFormat.values[index] : null;
  }

  @override
  Future<bool?> setDataFormat(DataFormat format) {
    final index = format.index;
    return _channel.invokeMethod<bool>('setDataFormat', <String, dynamic> {
      'format': format,
    });
  }

  @override
  Future<int?> getSecurityLevel() {
    return _channel.invokeMethod<int>('getSecurityLevel');
  }

  @override
  Future<bool?> setSecurityLevel(int level) {
    return _channel.invokeMethod<bool>('setSecurityLevel', <String, dynamic> {
      'level': level,
    });
  }

  @override
  Future<bool?> enableAgeVerify(bool enable) {
    return _channel.invokeMethod<bool>('enableAgeVerify', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isAgeVerifyEnabled() {
    return _channel.invokeMethod<bool>('isAgeVerifyEnabled');
  }

  @override
  Future<AIMIDStatus?> getAIMIDSetting() async {
    final index = await _channel.invokeMethod<int>('getAIMIDSetting');
    return (index is int) ? AIMIDStatus.values[index] : null;
  }

  @override
  Future<bool?> setAIMIDSetting(AIMIDStatus aimid) {
    final index = aimid.index;
    return _channel.invokeMethod<bool>('setAIMIDSetting', <String, dynamic> {
      'aimid': index,
    });
  }

  @override
  Future<int?> getPartialDataStartPosition() {
    return _channel.invokeMethod<int>('getPartialDataStartPosition');
  }

  @override
  Future<bool?> setPartialDataStartPosition(int position) {
    return _channel
        .invokeMethod<bool>('setPartialDataStartPosition', <String, dynamic> {
      'position': position,
    });
  }

  @override
  Future<bool?> getPartialDataLength() {
    return _channel.invokeMethod<bool>('getPartialDataLength');
  }

  @override
  Future<bool?> setPartialDataLength(int length) {
    return _channel
        .invokeMethod<bool>('setPartialDataLength', <String, dynamic> {
      'length': length,
    });
  }

  @override
  Future<PartialDataAction?> getPartialDataAction() async {
    final index = await _channel.invokeMethod<int>('getPartialDataAction');
    return (index is int) ? PartialDataAction.values[index] : null;
  }

  @override
  Future<bool?> setPartialDataAction(PartialDataAction action) {
    final index = action.index;
    return _channel
        .invokeMethod<bool>('setPartialDataAction', <String, dynamic> {
      'action': index,
    });
  }

  @override
  Future<bool?> startSynchronization() {
    return _channel.invokeMethod<bool>('startSynchronization');
  }

  @override
  Future<bool?> finishSynchronization() {
    return _channel.invokeMethod<bool>('finishSynchronization');
  }

  @override
  Future<DataTerminator?> getDataTerminator() async {
    final index = await _channel.invokeMethod<int>('getDataTerminator');
    return (index is int) ? DataTerminator.values[index] : null;
  }

  @override
  Future<bool?> setDataTerminator(DataTerminator terminator) {
    final index = terminator.index;
    return _channel.invokeMethod<bool>('setDataTerminator', <String, dynamic> {
      'terminator': index,
    });
  }

  //
  // System Configuration APIs - Lock, Battery Level
  //
  @override
  Future<bool?> enableButtonLock(bool enable) {
    return _channel.invokeMethod<bool>('enableButtonLock', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> enableScanButtonLock(bool enable) {
    return _channel
        .invokeMethod<bool>('enableScanButtonLock', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<int?> getBatteryLevel() {
    return _channel.invokeMethod<int>('getBatteryLevel');
  }

  @override
  Future<int?> getExtendedBatteryLevel() {
    return _channel.invokeMethod<int>('getExtendedBatteryLevel');
  }

  //
  // System Configuration APIs - Time
  //
  @override
  Future<bool?> syncSystemTime() {
    return _channel.invokeMethod<bool>('syncSystemTime');
  }

  @override
  Future<bool?> resetSystemTime() {
    return _channel.invokeMethod<bool>('resetSystemTime');
  }

  @override
  Future<SleepTimeout?> getSleepTimeout() async {
    final v = await _channel.invokeMethod<int>('getSleepTimeout');
    return (v is int) ? toSleepTimeoutEnum(v) : null;
  }

  @override
  Future<bool?> setSleepTimeout(SleepTimeout timeout) {
    final v = toSleepTimeoutValue(timeout);
    return _channel.invokeMethod<bool>('setSleepTimeout', <String, dynamic> {
      'timeout': v!,
    });
  }

  @override
  Future<int?> getScanTimeout() {
    return _channel.invokeMethod<int>('getScanTimeout');
  }

  @override
  Future<bool?> setScanTimeout(int timeout) {
    return _channel.invokeMethod<bool>('setScanTimeout', <String, dynamic> {
      'timeout': timeout,
    });
  }

  //
  // System Configuration APIs - Memory
  //
  @override
  Future<bool?> eraseMemory() {
    return _channel.invokeMethod<bool>('eraseMemory');
  }

  @override
  Future<bool?> eraseLastData() {
    return _channel.invokeMethod<bool>('eraseLastData');
  }

  @override
  Future<int?> getMemoryLeft() {
    return _channel.invokeMethod<int>('getMemoryLeft');
  }

  @override
  Future<bool?> setFactoryDefault() {
    return _channel.invokeMethod<bool>('setFactoryDefault');
  }

  //
  // System Configuration APIs - Beep
  //
  @override
  Future<Volume?> getBeepVolume() async {
    final index = await _channel.invokeMethod<int>('getBeepVolume');
    return (index is int) ? Volume.values[index] : null;
  }

  @override
  Future<bool?> setBeepVolume(Volume volume) {
    final index = volume.index;
    return _channel.invokeMethod<bool>('setBeepVolume', <String, dynamic> {
      'volume': index,
    });
  }

  @override
  Future<bool?> enableHighBeepVolume(bool enable) {
    return _channel
        .invokeMethod<bool>('enableHighBeepVolume', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isHighBeepVolumeEnabled() {
    return _channel.invokeMethod<bool>('isHighBeepVolumeEnabled');
  }

  @override
  Future<bool?> enableBeepSound(bool enable) {
    return _channel.invokeMethod<bool>('enableBeepSound', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isBeepSoundEnabled() {
    return _channel.invokeMethod<bool>('isBeepSoundEnabled');
  }

  @override
  Future<bool?> enablePowerOnBeep(bool enable) {
    return _channel.invokeMethod<bool>('enablePowerOnBeep', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isPowerOnBeepEnabled() {
    return _channel.invokeMethod<bool>('isPowerOnBeepEnabled');
  }

  @override
  Future<bool?> enableBeepOnScan(bool enable) {
    return _channel.invokeMethod<bool>('enableBeepOnScan', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isBeepOnScanEnabled() {
    return _channel.invokeMethod<bool>('isBeepOnScanEnabled');
  }

  @override
  Future<bool?> enableBeepOnConnect(bool enable) {
    return _channel.invokeMethod<bool>('enableBeepOnConnect', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isBeepOnConnectEnabled() {
    return _channel.invokeMethod<bool>('isBeepOnConnectEnabled');
  }

  @override
  Future<bool?> setFailureAlertBeep() {
    return _channel.invokeMethod<bool>('setFailureAlertBeep');
  }

  @override
  Future<bool?> setSuccessAlertBeep() {
    return _channel.invokeMethod<bool>('setSuccessAlertBeep');
  }

  @override
  Future<bool?> setCustomBeepTone(int onTime, int offTime, int repeat) {
    return _channel.invokeMethod<bool>('setCustomBeepTone', <String, dynamic> {
      'onTime': onTime,
      'offTime': offTime,
      'repeat': repeat,
    });
  }

  //
  // System Configuration APIs - MFi
  //
  @override
  Future<bool?> enableMFiMode(bool enable) {
    return _channel.invokeMethod<bool>('enableMFiMode', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isMFiEnabled() {
    return _channel.invokeMethod<bool>('isMFiEnabled');
  }

  @override
  Future<bool?> isMFiAuthChipInstalled() {
    return _channel.invokeMethod<bool>('isMFiAuthChipInstalled');
  }

  //
  // System Configuration APIs - Bluetooth
  //
  @override
  Future<bool?> enableBluetoothAutoConnect(bool enable) {
    return _channel
        .invokeMethod<bool>('enableBluetoothAutoConnect', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isAutoConnectEnabled() {
    return _channel.invokeMethod<bool>('isAutoConnectEnabled');
  }

  @override
  Future<bool?> enableBluetoothAutoPowerOn(bool enable) {
    return _channel
        .invokeMethod<bool>('enableBluetoothAutoPowerOn', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isAutoPowerOnEnabled() {
    return _channel.invokeMethod<bool>('isAutoPowerOnEnabled');
  }

  @override
  Future<bool?> enableBluetoothAutoPowerOff(bool enable) {
    return _channel
        .invokeMethod<bool>('enableBluetoothAutoPowerOff', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isBluetoothAutoPowerOffEnabled() {
    return _channel.invokeMethod<bool>('isBluetoothAutoPowerOffEnabled');
  }

  @override
  Future<bool?> enableBluetoothBeepWarning(bool enable) {
    return _channel
        .invokeMethod<bool>('enableBluetoothBeepWarning', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isBluetoothBeepWarningEnabled() {
    return _channel.invokeMethod<bool>('isBluetoothBeepWarningEnabled');
  }

  @override
  Future<DeviceProfile?> getDeviceProfile() async {
    final index = await _channel.invokeMethod<int>('getDeviceProfile');
    return (index is int) ? DeviceProfile.values[index] : null;
  }

  @override
  Future<bool?> setDeviceProfile(DeviceProfile profile) {
    final index = profile.index;
    return _channel.invokeMethod<bool>('setDeviceProfile', <String, dynamic> {
      'profile': index,
    });
  }

  @override
  Future<BluetoothAutoPowerOffDelay?> getBluetoothAutoPowerOffTimeout() async {
    final v =
        await _channel.invokeMethod<int>('getBluetoothAutoPowerOffTimeout');
    return (v is int) ? toBluetoothAutoPowerOffDelayEnum(v) : null;
  }

  @override
  Future<bool?> setBluetoothAutoPowerOffTimeout(
      BluetoothAutoPowerOffDelay timeout) {
    final v = toBluetoothAutoPowerOffDelayValue(timeout);
    return _channel.invokeMethod<bool>(
        'setBluetoothAutoPowerOffTimeout', <String, dynamic>{
      'timeout': v!,
    });
  }

  @override
  Future<bool?> enableBluetoothPowerOffMessage(bool enable) {
    return _channel
        .invokeMethod<bool>('enableBluetoothPowerOffMessage', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isPowerOffMessageEnabled() {
    return _channel.invokeMethod<bool>('isPowerOffMessageEnabled');
  }

  @override
  Future<String?> getBluetoothMACAddress() {
    return _channel.invokeMethod<String>('getBluetoothMACAddress');
  }

  @override
  Future<BluetoothAutoPowerOnDelay?> getBluetoothAutoPowerOnDelay() async {
    final index =
        await _channel.invokeMethod<int>('getBluetoothAutoPowerOnDelay');
    return (index is int) ? BluetoothAutoPowerOnDelay.values[index] : null;
  }

  @override
  Future<bool?> setBluetoothAutoPowerOnDelay(BluetoothAutoPowerOnDelay delay) {
    final index = delay.index;
    return _channel
        .invokeMethod<bool>('setBluetoothAutoPowerOnDelay', <String, dynamic> {
      'delay': index,
    });
  }

  @override
  Future<String?> getBluetoothFirmwareVersion() {
    return _channel.invokeMethod<String>('getBluetoothFirmwareVersion');
  }

  @override
  Future<bool?> enableBluetoothWakeupNull(bool enable) {
    return _channel
        .invokeMethod<bool>('enableBluetoothWakeupNull', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isWakeupNullsEnabled() {
    return _channel.invokeMethod<bool>('isWakeupNullsEnabled');
  }

  @override
  Future<bool?> enableBluetoothToggle(bool enable) {
    return _channel
        .invokeMethod<bool>('enableBluetoothToggle', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isBluetoothToggleEnabled() {
    return _channel.invokeMethod<bool>('isBluetoothToggleEnabled');
  }

  @override
  Future<bool?> enableBluetoothDisconnectButton(bool enable) {
    return _channel.invokeMethod<bool>(
        'enableBluetoothDisconnectButton', <String, dynamic>{
      'enable': enable,
    });
  }

  @override
  Future<bool?> isBluetoothDisconnectButtonEnabled() {
    return _channel.invokeMethod<bool>('isBluetoothDisconnectButtonEnabled');
  }

  //
  // System Configuration APIs - Etc.
  //
  @override
  Future<bool?> enableDuplicateCheck(bool enable) {
    return _channel
        .invokeMethod<bool>('enableDuplicateCheck', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isDuplicateCheckEnabled() {
    return _channel.invokeMethod<bool>('isDuplicateCheckEnabled');
  }

  @override
  Future<bool?> enableAutoErase(bool enable) {
    return _channel.invokeMethod<bool>('enableAutoErase', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isAutoEraseEnabled() {
    return _channel.invokeMethod<bool>('isAutoEraseEnabled');
  }

  @override
  Future<bool?> enableScanIfConnected(bool enable) {
    return _channel
        .invokeMethod<bool>('enableScanIfConnected', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isScanIfConnectedEnabled() {
    return _channel.invokeMethod<bool>('isScanIfConnectedEnabled');
  }

  @override
  Future<RereadDelay?> getAutoTriggerRereadDelay() async {
    final index = await _channel.invokeMethod<int>('getAutoTriggerRereadDelay');
    return (index is int) ? RereadDelay.values[index] : null;
  }

  @override
  Future<bool?> setAutoTriggerRereadDelay(RereadDelay delay) {
    final index = delay.index;
    return _channel
        .invokeMethod<bool>('setAutoTriggerRereadDelay', <String, dynamic> {
      'delay': index,
    });
  }

  @override
  Future<bool?> enableAutoTrigger(bool enable) {
    return _channel.invokeMethod<bool>('enableAutoTrigger', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isAutoTriggerEnabled() {
    return _channel.invokeMethod<bool>('isAutoTriggerEnabled');
  }

  @override
  Future<String?> getKDCFirmwareVersion() {
    return _channel.invokeMethod<String>('getKDCFirmwareVersion');
  }

  @override
  Future<String?> getKDCFirmwareBuildVersion() {
    return _channel.invokeMethod<String>('getKDCFirmwareBuildVersion');
  }

  @override
  Future<String?> getInterfaceVersion() {
    return _channel.invokeMethod<String>('getInterfaceVersion');
  }

  @override
  Future<String?> getPowerDeliveryVersion() {
    return _channel.invokeMethod<String>('getPowerDeliveryVersion');
  }

  //
  // Vibrate
  //
  @override
  Future<bool?> enableVibrator(bool enable) {
    return _channel.invokeMethod<bool>('enableVibrator', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isVibratorEnabled() {
    return _channel.invokeMethod<bool>('isVibratorEnabled');
  }

  @override
  Future<bool?> setCustomVibration(int onTime, int offTime, int repeat) {
    return _channel.invokeMethod<bool>('setCustomVibration', <String, dynamic> {
      'onTime': onTime,
      'offTime': offTime,
      'repeat': repeat,
    });
  }

  //
  // Display APIs
  //
  @override
  Future<bool?> enableDisplayConnectionStatus(bool enable) {
    return _channel
        .invokeMethod<bool>('enableDisplayConnectionStatus', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isDisplayConnectionStatusEnabled() {
    return _channel.invokeMethod<bool>('isDisplayConnectionStatusEnabled');
  }

  @override
  Future<bool?> enableMenuBarcodeState(bool enable) {
    return _channel
        .invokeMethod<bool>('enableMenuBarcodeState', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isMenuBarcodeStateEnabled() {
    return _channel.invokeMethod<bool>('isMenuBarcodeStateEnabled');
  }

  @override
  Future<bool?> enableDisplayScroll(bool enable) {
    return _channel.invokeMethod<bool>('enableDisplayScroll', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isScrollingEnabled() {
    return _channel.invokeMethod<bool>('isScrollingEnabled');
  }

  @override
  Future<bool?> setDisplayPosition(int row, int column) {
    return _channel.invokeMethod<bool>(
        'setDisplayPosition', <String, dynamic> {'row': row, 'column': column});
  }

  @override
  Future<bool?> clearDisplay() {
    return _channel.invokeMethod<bool>('clearDisplay');
  }

  @override
  Future<bool?> setDisplayMessageFontSize(MessageFontSize size) {
    final index = size.index;
    return _channel
        .invokeMethod<bool>('setDisplayMessageFontSize', <String, dynamic> {
      'size': index,
    });
  }

  @override
  Future<bool?> setDisplayMessageDuration(int duration) {
    return _channel
        .invokeMethod<bool>('setDisplayMessageDuration', <String, dynamic> {
      'duration': duration,
    });
  }

  @override
  Future<bool?> setMessageTextAttribute(MessageTextAttribute attribute) {
    final index = attribute.index;
    return _channel
        .invokeMethod<bool>('setMessageTextAttribute', <String, dynamic>{ 
      'attribute': index,
    });
  }

  @override
  Future<bool?> setDisplayMessage(String message) {
    return _channel.invokeMethod<bool>('setDisplayMessage', <String, dynamic> {
      'message': message,
    });
  }

  @override
  Future<bool?> setDisplayMessageAndGetUserConfirm(String message) {
    return _channel.invokeMethod<bool>(
        'setDisplayMessageAndGetUserConfirm', <String, dynamic> {
      'message': message,
    });
  }

  @override
  Future<bool?> enableAutoMenuExit(bool enable) {
    return _channel.invokeMethod<bool>('enableAutoMenuExit', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isAutoMenuExitEnabled() {
    return _channel.invokeMethod<bool>('isAutoMenuExitEnabled');
  }

  //
  // Keypad APIs
  //
  @override
  Future<bool?> enableEnterKeyFunction(bool enable) {
    return _channel
        .invokeMethod<bool>('enableEnterKeyFunction', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isEnterKeyFunctionEnabled() {
    return _channel.invokeMethod<bool>('isEnterKeyFunctionEnabled');
  }

  @override
  Future<bool?> enableExtendKeypad(bool enable) {
    return _channel.invokeMethod<bool>('enableExtendKeypad', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isExtendKeypadEnabled() {
    return _channel.invokeMethod<bool>('isExtendKeypadEnabled');
  }

  @override
  Future<bool?> enableKeypad(bool enable) {
    return _channel.invokeMethod<bool>('enableKeypad', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isKeypadEnabled() {
    return _channel.invokeMethod<bool>('isKeypadEnabled');
  }

  //
  // HID APIs
  //
  @override
  Future<HIDAutoLockTime?> getHIDAutoLockTime() async {
    final v = await _channel.invokeMethod<int>('getHIDAutoLockTime');
    return (v is int) ? toHIDAutoLockTimeEnum(v) : null;
  }

  @override
  Future<bool?> setHIDAutoLockTime(HIDAutoLockTime timeout) {
    final v = toHIDAutoLockTimeValue(timeout);
    return _channel.invokeMethod<bool>('setHIDAutoLockTime', <String, dynamic> {
      'timeout': v!,
    });
  }

  @override
  Future<HIDKeyboard?> getHIDKeyboard() async {
    final index = await _channel.invokeMethod<int>('getHIDKeyboard');
    return (index is int) ? HIDKeyboard.values[index] : null;
  }

  @override
  Future<bool?> setHIDKeyboard(HIDKeyboard keyboard) {
    final index = keyboard.index;
    return _channel.invokeMethod<bool>('setHIDKeyboard', <String, dynamic> {
      'keyboard': keyboard,
    });
  }

  @override
  Future<HIDInitialDelay?> getHIDInitialDelay() async {
    final v = await _channel.invokeMethod<int>('getHIDInitialDelay');
    return (v is int) ? toHIDInitialDelayEnum(v) : null;
  }

  @override
  Future<bool?> setHIDInitialDelay(HIDInitialDelay delay) {
    final v = toHIDInitialDelayValue(delay);
    return _channel.invokeMethod<bool>('setHIDInitialDelay', <String, dynamic> {
      'delay': v!,
    });
  }

  @override
  Future<HIDInterDelay?> getHIDInterDelay() async {
    final v = await _channel.invokeMethod<int>('getHIDInterDelay');
    return (v is int) ? toHIDInterDelayEnum(v) : null;
  }

  @override
  Future<bool?> setHIDInterDelay(HIDInterDelay delay) {
    final v = toHIDInterDelayValue(delay);
    return _channel.invokeMethod<bool>('setHIDInterDelay', <String, dynamic> {
      'delay': v!,
    });
  }

  @override
  Future<HIDControlCharacter?> getHIDControlCharacter() async {
    final index = await _channel.invokeMethod<int>('getHIDControlCharacter');
    return (index is int) ? HIDControlCharacter.values[index] : null;
  }

  @override
  Future<bool?> setHIDControlCharacter(HIDControlCharacter character) {
    final index = character.index;
    return _channel
        .invokeMethod<bool>('setHIDControlCharacter', <String, dynamic> {
      'character': index,
    });
  }

  //
  // WiFi APIs
  //
  @override
  Future<bool?> isWiFiInstalled() {
    return _channel.invokeMethod<bool>('isWiFiInstalled');
  }

  @override
  Future<bool?> enableWiFiPower(bool enable) {
    return _channel.invokeMethod<bool>('enableWiFiPower', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isWiFiPowerEnabled() {
    return _channel.invokeMethod<bool>('isWiFiPowerEnabled');
  }

  @override
  Future<bool?> enableWiFiAutoConnect(bool enable) {
    return _channel
        .invokeMethod<bool>('enableWiFiAutoConnect', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isWiFiAutoConnectEnabled() {
    return _channel.invokeMethod<bool>('isWiFiAutoConnectEnabled');
  }

  @override
  Future<bool?> setWiFiServerIPAddress(String ip) {
    return _channel
        .invokeMethod<bool>('setWiFiServerIPAddress', <String, dynamic> {
      'ip': ip,
    });
  }

  @override
  Future<String?> getWiFiServerIPAddress() {
    return _channel.invokeMethod<String>('getWiFiServerIPAddress');
  }

  @override
  Future<bool?> setWiFiServerURLAddress(String url) {
    return _channel
        .invokeMethod<bool>('setWiFiServerURLAddress', <String, dynamic> {
      'url': url,
    });
  }

  @override
  Future<String?> getWiFiServerURLAddress() {
    return _channel.invokeMethod<String>('getWiFiServerURLAddress');
  }

  @override
  Future<bool?> setWiFiServerPortNumber(int port) {
    return _channel
        .invokeMethod<bool>('setWiFiServerPortNumber', <String, dynamic> {
      'port': port,
    });
  }

  @override
  Future<int?> getWiFiServerPortNumber() {
    return _channel.invokeMethod<int>('getWiFiServerPortNumber');
  }

  @override
  Future<bool?> setWiFiProtocol(WiFiProtocol protocol) {
    final index = protocol.index;
    return _channel.invokeMethod<bool>('setWiFiProtocol', <String, dynamic> {
      'protocol': index,
    });
  }

  @override
  Future<WiFiProtocol?> getWiFiProtocol() async {
    final index = await _channel.invokeMethod<int>('getWiFiProtocol');
    return (index is int) ? WiFiProtocol.values[index] : null;
  }

  @override
  Future<bool?> enableWiFiSSL(bool enable) {
    return _channel.invokeMethod<bool>('enableWiFiSSL', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isWiFiSSLEnabled() {
    return _channel.invokeMethod<bool>('isWiFiSSLEnabled');
  }

  @override
  Future<bool?> setWiFiServerPage(String page) {
    return _channel.invokeMethod<bool>('setWiFiServerPage', <String, dynamic> {
      'page': page,
    });
  }

  @override
  Future<String?> getWiFiServerPage() {
    return _channel.invokeMethod<String>('getWiFiServerPage');
  }

  @override
  Future<bool?> setWiFiCertification(Uint8List cert) {
    return _channel
        .invokeMethod<bool>('setWiFiCertification', <String, dynamic>{
      'cert': cert,
    });
  }

  @override
  Future<Uint8List?> getWiFiCertification() {
    return _channel.invokeMethod<Uint8List>('getWiFiCertification');
  }

  @override
  Future<bool?> setWiFiApSSID(String ssid) {
    return _channel.invokeMethod<bool>('setWiFiApSSID', <String, dynamic> {
      'ssid': ssid,
    });
  }

  @override
  Future<String?> getWiFiApSSID() {
    return _channel.invokeMethod<String>('getWiFiApSSID');
  }

  @override
  Future<bool?> setWiFiApPasscode(String passcode) {
    return _channel.invokeMethod<bool>('setWiFiApPasscode', <String, dynamic> {
      'passcode': passcode,
    });
  }

  @override
  Future<String?> getWiFiApPasscode() {
    return _channel.invokeMethod<String>('getWiFiApPasscode');
  }

  //
  // NFC APIs
  //
  @override
  Future<bool?> isNFCInstalled() {
    return _channel.invokeMethod<bool>('isNFCInstalled');
  }

  @override
  Future<bool?> enableNFCPower(bool enable) {
    return _channel.invokeMethod<bool>('enableNFCPower', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isNFCPowerEnabled() {
    return _channel.invokeMethod<bool>('isNFCPowerEnabled');
  }

  @override
  Future<bool?> setNFCDataFormat(NFCDataFormat format) {
    final index = format.index;
    return _channel.invokeMethod<bool>('setNFCDataFormat', <String, dynamic> {
      'format': index,
    });
  }

  @override
  Future<NFCDataFormat?> getNFCDataFormat() async {
    final index = await _channel.invokeMethod<int>('getNFCDataFormat');
    return (index is int) ? NFCDataFormat.values[index] : null;
  }

  @override
  Future<bool?> enableNFCUIDOnly(bool enable) {
    return _channel.invokeMethod<bool>('enableNFCUIDOnly', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isNFCUIDOnlyEnabled() {
    return _channel.invokeMethod<bool>('isNFCUIDOnlyEnabled');
  }

  @override
  Future<bool?> enableNFCExtendedFormat(bool enable) {
    return _channel
        .invokeMethod<bool>('enableNFCExtendedFormat', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isNFCExtendedFormatEnabled() {
    return _channel.invokeMethod<bool>('isNFCExtendedFormatEnabled');
  }

  //
  // MSR APIs
  //
  @override
  Future<bool?> enableMSRErrorBeep(bool enable) {
    return _channel.invokeMethod<bool>('enableMSRErrorBeep', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isMSRErrorBeepEnabled() {
    return _channel.invokeMethod<bool>('isMSRErrorBeepEnabled');
  }

  @override
  Future<bool?> enableMSRSentinel(bool enable) {
    return _channel.invokeMethod<bool>('enableMSRSentinel', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isMSRSentinelEnabled() {
    return _channel.invokeMethod<bool>('isMSRSentinelEnabled');
  }

  @override
  Future<MSRCardType?> getMSRCardType() async {
    final index = await _channel.invokeMethod<int>('getMSRCardType');
    return (index is int) ? MSRCardType.values[index] : null;
  }

  @override
  Future<bool?> setMSRCardType(MSRCardType type) {
    final index = type.index;
    return _channel.invokeMethod<bool>('setMSRCardType', <String, dynamic> {
      'type': index,
    });
  }

  @override
  Future<MSRDataType?> getMSRDataType() async {
    final index = await _channel.invokeMethod<int>('getMSRDataType');
    return (index is int) ? MSRDataType.values[index] : null;
  }

  @override
  Future<bool?> setMSRDataType(MSRDataType type) {
    final index = type.index;
    return _channel.invokeMethod<bool>('setMSRDataType', <String, dynamic> {
      'type': index,
    });
  }

  @override
  Future<MSRDataEncryption?> getMSRDataEncryption() async {
    final index = await _channel.invokeMethod<int>('getMSRDataEncryption');
    return (index is int) ? MSRDataEncryption.values[index] : null;
  }

  @override
  Future<bool?> setMSRDataEncryption(MSRDataEncryption encryption) {
    final index = encryption.index;
    return _channel
        .invokeMethod<bool>('setMSRDataEncryption', <String, dynamic> {
      'encryption': index,
    });
  }

  @override
  Future<MSRTrackSeparator?> getMSRTrackSeparator() async {
    final index = await _channel.invokeMethod<int>('getMSRTrackSeparator');
    return (index is int) ? MSRTrackSeparator.values[index] : null;
  }

  @override
  Future<bool?> setMSRTrackSeparator(MSRTrackSeparator separator) {
    final index = separator.index;
    return _channel
        .invokeMethod<bool>('setMSRTrackSeparator', <String, dynamic> {
      'separator': index,
    });
  }

  @override
  Future<int?> getMSRTrackSelection() {
    return _channel.invokeMethod<int>('getMSRTrackSelection');
  }

  @override
  Future<bool?> setMSRTrackSelection(int selection) {
    return _channel
        .invokeMethod<bool>('setMSRTrackSelection', <String, dynamic> {
      'selection': selection,
    });
  }

  @override
  Future<int?> getPartialDataMSRStartPosition() {
    return _channel.invokeMethod<int>('getPartialDataMSRStartPosition');
  }

  @override
  Future<bool?> setPartialDataMSRStartPosition(int position) {
    return _channel
        .invokeMethod<bool>('setPartialDataMSRStartPosition', <String, dynamic> {
      'position': position,
    });
  }

  @override
  Future<int?> getPartialDataMSRLength() {
    return _channel.invokeMethod<int>('getPartialDataMSRLength');
  }

  @override
  Future<bool?> setPartialDataMSRLength(int length) {
    return _channel
        .invokeMethod<bool>('setPartialDataMSRLength', <String, dynamic> {
      'length': length,
    });
  }

  @override
  Future<PartialDataAction?> getPartialDataMSRAction() async {
    final index = await _channel.invokeMethod<int>('getPartialDataMSRAction');
    return (index is int) ? PartialDataAction.values[index] : null;
  }

  @override
  Future<bool?> setPartialDataMSRAction(PartialDataAction action) {
    final index = action.index;
    return _channel
        .invokeMethod<bool>('setPartialDataMSRAction', <String, dynamic> {
      'action': index,
    });
  }

  //
  // MSRIC APIs
  //
  @override
  Future<bool?> isMSRICModuleAttached() {
    return _channel.invokeMethod<bool>('isMSRICModuleAttached');
  }

  @override
  Future<String?> sendMSRICData(String message) {
    return _channel.invokeMethod<String>('sendMSRICData', <String, dynamic> {
      'message': message,
    });
  }

  //
  // UHF APIs
  //
  @override
  Future<bool?> isUHFModuleAttached() {
    return _channel.invokeMethod<bool>('isUHFModuleAttached');
  }

  @override
  Future<bool?> isUHFPowerEnabled() {
    return _channel.invokeMethod<bool>('isUHFPowerEnabled');
  }

  @override
  Future<bool?> enableUHFPower(bool enable) {
    return _channel.invokeMethod<bool>('enableUHFPower', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<UHFPowerLevel?> getUHFPowerLevel() async {
    final index = await _channel.invokeMethod<int>('getUHFPowerLevel');
    return (index is int) ? UHFPowerLevel.values[index] : null;
  }

  @override
  Future<bool?> setUHFPowerLevel(UHFPowerLevel level) {
    final index = level.index;
    return _channel.invokeMethod<bool>('setUHFPowerLevel', <String, dynamic> {
      'level': index,
    });
  }

  @override
  Future<UHFReadMode?> getUHFReadMode() async {
    final index = await _channel.invokeMethod<int>('getUHFReadMode');
    return (index is int) ? UHFReadMode.values[index] : null;
  }

  @override
  Future<bool?> setUHFReadMode(UHFReadMode mode) {
    final index = mode.index;
    return _channel.invokeMethod<bool>('setUHFReadMode', <String, dynamic> {
      'mode': index,
    });
  }

  @override
  Future<UHFReadTagMode?> getUHFReadTagMode() async {
    final index = await _channel.invokeMethod<int>('getUHFReadTagMode');
    return (index is int) ? UHFReadTagMode.values[index] : null;
  }

  @override
  Future<bool?> setUHFReadTagMode(UHFReadTagMode mode) {
    final index = mode.index;
    return _channel.invokeMethod<bool>('setUHFReadTagMode', <String, dynamic> {
      'mode': index,
    });
  }

  @override
  Future<UHFDataType?> getUHFDataType() async {
    final index = await _channel.invokeMethod<int>('getUHFDataType');
    return (index is int) ? UHFDataType.values[index] : null;
  }

  @override
  Future<bool?> setUHFDataType(UHFDataType type) {
    final index = type.index;
    return _channel.invokeMethod<bool>('setUHFDataType', <String, dynamic> {
      'type': index,
    });
  }

  @override
  Future<UHFDataFormat?> getUHFDataFormat() async {
    final index = await _channel.invokeMethod<int>('getUHFDataFormat');
    return (index is int) ? UHFDataFormat.values[index] : null;
  }

  @override
  Future<bool?> setUHFDataFormat(UHFDataFormat format) {
    final index = format.index;
    return _channel.invokeMethod<bool>('setUHFDataFormat', <String, dynamic> {
      'type': index,
    });
  }

  @override
  Future<bool?> isUHFDuplicateCheckEnabled() {
    return _channel.invokeMethod<bool>('isUHFDuplicateCheckEnabled');
  }

  @override
  Future<bool?> enableUHFDuplicateCheck(bool enable) {
    return _channel
        .invokeMethod<bool>('enableUHFDuplicateCheck', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isUHFBurstModeEnabled() {
    return _channel.invokeMethod<bool>('isUHFBurstModeEnabled');
  }

  @override
  Future<bool?> enableUHFBurstMode(bool enable) {
    return _channel.invokeMethod<bool>('enableUHFBurstMode', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> isUHFKeyEventEnabled() {
    return _channel.invokeMethod<bool>('isUHFKeyEventEnabled');
  }

  @override
  Future<bool?> enableUHFKeyEvent(bool enable) {
    return _channel.invokeMethod<bool>('enableUHFKeyEvent', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> cancelUHFReading() {
    return _channel.invokeMethod<bool>('cancelUHFReading');
  }

  @override
  Future<UHFModuleType?> getUHFModuleType() async {
    final index = await _channel.invokeMethod<int>('getUHFModuleType');
    return (index is int) ? UHFModuleType.values[index] : null;
  }

  @override
  Future<int?> getUHFPowerLevelEx() {
    return _channel.invokeMethod<int>('getUHFPowerLevelEx');
  }

  @override
  Future<bool?> setUHFPowerLevelEx(int level) {
    return _channel.invokeMethod<bool>('setUHFPowerLevelEx', <String, dynamic>{
      'level': level,
    });
  }

  @override
  Future<int?> getUHFPowerTimeout() {
    return _channel.invokeMethod<int>('getUHFPowerTimeout');
  }

  @override
  Future<bool?> setUHFPowerTimeout(int timeout) {
    return _channel.invokeMethod<bool>('setUHFPowerTimeout', <String, dynamic> {
      'timeout': timeout,
    });
  }

  @override
  Future<int?> getUHFReadingTimeout() {
    return _channel.invokeMethod<int>('getUHFReadingTimeout');
  }

  @override
  Future<bool?> setUHFReadingTimeout(int timeout) {
    return _channel
        .invokeMethod<bool>('setUHFReadingTimeout', <String, dynamic> {
      'timeout': timeout,
    });
  }

  @override
  Future<UHFRegion?> getUHFRegion() async {
    final index = await _channel.invokeMethod<int>('getUHFRegion');
    return (index is int) ? toUHFRegionEnum(index) : null;
  }

  @override
  Future<List<String>?> getUHFTagList(int timeout) {
    return _channel.invokeListMethod<String>('getUHFTagList', <String, dynamic> {
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> selectUHFTag(String epc) {
    return _channel.invokeMethod<bool>('selectUHFTag', <String, dynamic> {
      'epc': epc,
    });
  }

  @override
  Future<String?> readUHFTagMemory(
      String pwd, UHFMemoryBank bank, int start, int length) {
    final index = bank.index;
    return _channel.invokeMethod<String>('readUHFTagMemory', <String, dynamic> {
      'pwd': pwd,
      'bank': index,
      'start': start,
      'length': length,
    });
  }

  @override
  Future<bool?> writeUHFTagMemory(
      String pwd, UHFMemoryBank bank, int start, int length, String data) {
    final index = bank.index;
    return _channel.invokeMethod<bool>('writeUHFTagMemory', <String, dynamic> {
      'pwd': pwd,
      'bank': index,
      'start': start,
      'length': length,
      'data': data,
    });
  }

  @override
  Future<bool?> setUHFTagLock(String pwd, int mask) {
    return _channel.invokeMethod<bool>('setUHFTagLock', <String, dynamic> {
      'pwd': pwd,
      'mask': mask,
    });
  }

  @override
  Future<bool?> killUHFTag(String pwd) {
    return _channel.invokeMethod<bool>('killUHFTag', <String, dynamic> {
      'pwd': pwd,
    });
  }

  @override
  Future<bool?> setUHFUntraceable(
      int xpc, int epc, int tid, int user, int range, String pwd) {
    return _channel.invokeMethod<bool>('setUHFUntraceable', <String, dynamic> {
      'xpc': xpc,
      'epc': epc,
      'tid': tid,
      'user': user,
      'range': range,
      'pwd': pwd,
    });
  }

  @override
  Future<bool?> setUHFSelectParameter(
      int target,
      int action,
      UHFMemoryBank bank,
      int pointer,
      int length,
      String maskData,
      bool truncated) {
    final index = bank.index;
    return _channel
        .invokeMethod<bool>('setUHFSelectParameter', <String, dynamic> {
      'target': target,
      'action': action,
      'bank': index,
      'pointer': pointer,
      'length': length,
      'maskData': maskData,
      'truncated': truncated,
    });
  }

  @override
  Future<UHFSelectParameter?> getUHFSelectParameter() async {
    final map = await _channel
        .invokeMapMethod<String, dynamic>('getUHFSelectParameter');
    return (map != null) ? UHFSelectParameter.fromMap(map) : null;
  }

  @override
  Future<bool?> setUHFQueryParameter(int dr, int cycle, int tRext, int sel,
      int session, int target, int slotNum) {
    return _channel
        .invokeMethod<bool>('setUHFQueryParameter', <String, dynamic> {
      'dr': dr,
      'cycle': cycle,
      'tRext': tRext,
      'sel': sel,
      'session': session,
      'target': target,
      'slotNum': slotNum,
    });
  }

  @override
  Future<UHFQueryParameter?> getUHFQueryParameter() async {
    final map =
        await _channel.invokeMapMethod<String, dynamic>('getUHFQueryParameter');
    return (map != null) ? UHFQueryParameter.fromMap(map) : null;
  }

  @override
  Future<bool?> authenticateUHFTag(
      int senRep, int incRepLen, int csi, int length, String message) {
    return _channel
        .invokeMethod<bool>('setHIDControlCharacter', <String, dynamic> {
      'senRep': senRep,
      'incRepLen': incRepLen,
      'csi': csi,
      'length': length,
      'message': message,
    });
  }

  //
  // USB Perimission APIs
  //
  @override
  Future<bool?> checkUsbPermission(KDCDevice device) {
    throw UnimplementedError(
        'checkUsbPermission has not been implemented.');
  }

  @override
  Future<bool?> requestUsbPermission(KDCDevice device) {
    throw UnimplementedError(
        'requestUsbPermission has not been implemented.');
  }

  //
  // mPOS(KDC500) APIs
  //

  //
  // KDC500 Barcode/NFC Methods
  //
  @override
  Future<bool?> softwareTriggerPos() {
    return _channel.invokeMethod<bool>('softwareTriggerPos');
  }

  @override
  Future<bool?> enableNFCPos() {
    return _channel.invokeMethod<bool>('enableNFCPos');
  }

  @override
  Future<bool?> disableNFCPos() {
    return _channel.invokeMethod<bool>('disableNFCPos');
  }

  //
  // KDC500 MS/IC Transaction Methods
  //
  @override
  Future<bool?> enableMSRPos() {
    return _channel.invokeMethod<bool>('enableMSRPos');
  }

  @override
  Future<bool?> disableMSRPos() {
    return _channel.invokeMethod<bool>('disableMSRPos');
  }

  @override
  Future<bool?> enableCardReaderPos(int target) {
    return _channel.invokeMethod<bool>('enableCardReaderPos', <String, dynamic> {
      'target': target,
    });
  }

  @override
  Future<bool?> disableCardReaderPos(int target) {
    return _channel
        .invokeMethod<bool>('disableCardReaderPos', <String, dynamic> {
      'target': target,
    });
  }

  @override
  Future<bool?> readCardPos(int target, int timeout) {
    return _channel.invokeMethod<bool>('readCardPos', <String, dynamic> {
      'target': target,
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> cancelReadCardPos(int target) {
    return _channel.invokeMethod<bool>('cancelReadCardPos', <String, dynamic> {
      'target': target,
    });
  }

  @override
  Future<bool?> selectEMVApplicationPos(int aid) {
    return _channel
        .invokeMethod<bool>('selectEMVApplicationPos', <String, dynamic> {
      'aid': aid,
    });
  }

  @override
  Future<bool?> initiateEMVTransactionPos(int pinBlockFormat, int maxDigit,
      int transType, int amount, int otherAmount, int operation) {
    return _channel
        .invokeMethod<bool>('initiateEMVTransactionPos', <String, dynamic> {
      'pinBlockFormat': pinBlockFormat,
      'maxDigit': maxDigit,
      'transType': transType,
      'lenamountgth': amount,
      'otherAmount': otherAmount,
      'operation': operation,
    });
  }

  @override
  Future<bool?> selectApplicationAndInitiateEMVTransactionPos(
      int pinBlockFormat,
      int maxDigit,
      int aid,
      int transType,
      int amount,
      int otherAmount,
      int operation) {
    return _channel.invokeMethod<bool>(
        'selectApplicationAndInitiateEMVTransactionPos', <String, dynamic> {
      'pinBlockFormat': pinBlockFormat,
      'maxDigit': maxDigit,
      'aid': aid,
      'transType': transType,
      'amount': amount,
      'otherAmount': otherAmount,
      'operation': operation,
    });
  }

  @override
  Future<bool?> replyEMVTransactionPos(Uint8List tlvs) {
    return _channel
        .invokeMethod<bool>('replyEMVTransactionPos', <String, dynamic> {
      'tlvs': tlvs,
    });
  }

  @override
  Future<bool?> enterPINPos(
      String pan, int pinBlockFormat, int maxDigit, int timeout) {
    return _channel
        .invokeMethod<bool>('setHIDControlCharacter', <String, dynamic> {
      'pan': pan,
      'pinBlockFormat': pinBlockFormat,
      'maxDigit': maxDigit,
      'lengtimeoutth': timeout,
    });
  }

  @override
  Future<bool?> cancelEnterPINPos() {
    return _channel.invokeMethod<bool>('cancelEnterPINPos');
  }

  //
  // KDC500 Configuration Methods
  //
  @override
  Future<KPOSResult?> getDeviceStatusPos() async {
    final map =
        await _channel.invokeMapMethod<String, dynamic>('getDeviceStatusPos');
    return (map != null) ? KPOSResult.fromMap(map) : null;
  }

  @override
  Future<bool?> setBeepSoundPos(int keyVolume, int beepVolume, bool beepSound,
      bool beepPowerOn, bool beepBarcode, bool beepConnection) {
    return _channel.invokeMethod<bool>('setBeepSoundPos', <String, dynamic> {
      'keyVolume': keyVolume,
      'beepVolume': beepVolume,
      'beepSound': beepSound,
      'beepPowerOn': beepPowerOn,
      'beepBarcode': beepBarcode,
      'beepConnection': beepConnection,
    });
  }

  @override
  Future<KPOSResult?> getBeepSoundPos() async {
    final map =
        await _channel.invokeMapMethod<String, dynamic>('getBeepSoundPos');
    return (map != null) ? KPOSResult.fromMap(map) : null;
  }

  @override
  Future<bool?> setKeypadMenuEntryPos(bool enable) {
    return _channel
        .invokeMethod<bool>('setKeypadMenuEntryPos', <String, dynamic> {
      'enable': enable,
    });
  }

  @override
  Future<bool?> syncDateTimePos() {
    return _channel.invokeMethod<bool>('syncDateTimePos');
  }

  @override
  Future<KPOSResult?> getDateTimePos() async {
    final map =
        await _channel.invokeMapMethod<String, dynamic>('getDateTimePos');
    return (map != null) ? KPOSResult.fromMap(map) : null;
  }

  @override
  Future<bool?> enableBatteryAlarmPos(int interval, int level) {
    return _channel
        .invokeMethod<bool>('enableBatteryAlarmPos', <String, dynamic> {
      'interval': interval,
      'level': level,
    });
  }

  @override
  Future<bool?> disableBatteryAlarmPos() {
    return _channel.invokeMethod<bool>('disableBatteryAlarmPos');
  }

  //
  // KDC500 Other Methods
  //
  @override
  Future<bool?> readDataPos(
      int titleId, int target, int timeout, int maxDigit, bool mask) {
    return _channel.invokeMethod<bool>('readDataPos', <String, dynamic> {
      'titleId': titleId,
      'target': target,
      'timeout': timeout,
      'maxDigit': maxDigit,
      'mask': mask,
    });
  }

  @override
  Future<bool?> cancelReadDataPos() {
    return _channel.invokeMethod<bool>('cancelReadDataPos');
  }

  @override
  Future<bool?> findMyKDCPos(int count) {
    return _channel.invokeMethod<bool>('findMyKDCPos', <String, dynamic> {
      'count': count,
    });
  }

  @override
  Future<bool?> setDisplayMessagePos(
      String? line1, String? line2, String? line3, String? line4, int timeout) {
    return _channel
        .invokeMethod<bool>('setDisplayMessagePos', <String, dynamic> {
      'line1': line1,
      'line2': line2,
      'line3': line3,
      'line4': line4,
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> clearDisplayPos() {
    return _channel.invokeMethod<bool>('clearDisplayPos');
  }

  @override
  Future<bool?> enableKeypadPos(
      int line, int maxDigit, bool clear, bool mask, int timeout) {
    return _channel.invokeMethod<bool>('enableKeypadPos', <String, dynamic> {
      'line': line,
      'maxDigit': maxDigit,
      'clear': clear,
      'mask': mask,
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> enableKeypadEventOnlyPos() {
    return _channel.invokeMethod<bool>('enableKeypadEventOnlyPos');
  }

  @override
  Future<bool?> disableKeypadPos(bool clear) {
    return _channel.invokeMethod<bool>('disableKeypadPos', <String, dynamic> {
      'clear': clear,
    });
  }

  @override
  Future<bool?> readEmvCLCardPos(int pinBlockFormat, int maxDigit,
      int transType, int amount, int otherAmount, int online, int timeout) {
    return _channel.invokeMethod<bool>('readEmvCLCardPos', <String, dynamic> {
      'pinBlockFormat': pinBlockFormat,
      'maxDigit': maxDigit,
      'transType': transType,
      'amount': amount,
      'otherAmount': otherAmount,
      'online': online,
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> stopEmvCLTransactionPos() {
    return _channel.invokeMethod<bool>('stopEmvCLTransactionPos');
  }

  @override
  Future<KPOSResult?> getSupportedLocalesPos() async {
    final map = await _channel
        .invokeMapMethod<String, dynamic>('getSupportedLocalesPos');
    if (map != null) {
      final result = KPOSResult.fromMap(map);

      // change bitmask to List<KPOSLocale>
      final loc = map['locales'] as int?;
      if (loc != null) {
        result.locales = [];

        KPOSLocale.values.forEach((el) {
          var v = toKPOSLocaleValue(el);

          if (v != null && (loc & v) > 0) {
            result.locales?.add(el);
          }
        });
      }
      return result;
    }
    return null;
  }

  @override
  Future<bool?> setDisplayMessageWithLocalePos(String line1, String line2,
      String line3, String line4, KPOSLocale locale, int timeout) {
    final v = toKPOSLocaleValue(locale);
    return _channel
        .invokeMethod<bool>('setDisplayMessageWithLocalePos', <String, dynamic> {
      'line1': line1,
      'line2': line2,
      'line3': line3,
      'line4': line4,
      'locale': v,
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> setDisplayMessageIdAndReadKeypadPos(
      int line1,
      int line2,
      int line3,
      int line4,
      KPOSLocale locale,
      int keypadType,
      bool mask,
      int inputLine,
      KPOSAlign inputAlign,
      int maxDigit,
      int timeout) {
    final v = toKPOSLocaleValue(locale);
    return _channel.invokeMethod<bool>(
        'setDisplayMessageIdAndReadKeypadPos', <String, dynamic> {
      'line1': line1,
      'line2': line2,
      'line3': line3,
      'line4': line4,
      'locale': v,
      'keypadType': keypadType,
      'mask': mask,
      'inputLine': inputLine,
      'inputAlign': KPOSAlign.values[inputAlign.index],
      'maxDigit': maxDigit,
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> setDisplayMessageAndReadKeypadPos(
      String line1,
      String line2,
      String line3,
      String line4,
      KPOSLocale locale,
      int keypadType,
      bool mask,
      int inputLine,
      KPOSAlign inputAlign,
      int maxDigit,
      int timeout) {
    final v = toKPOSLocaleValue(locale);
    return _channel.invokeMethod<bool>(
        'setDisplayMessageAndReadKeypadPos', <String, dynamic> {
      'line1': line1,
      'line2': line2,
      'line3': line3,
      'line4': line4,
      'locale': v,
      'keypadType': keypadType,
      'mask': mask,
      'inputLine': inputLine,
      'inputAlign': KPOSAlign.values[inputAlign.index],
      'maxDigit': maxDigit,
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> setDisplayMessageAndSelectItemPos(
      String line1,
      String line2,
      String line3,
      KPOSLocale locale,
      int firstItemLine,
      List<String> items,
      int timeout) {
    final v = toKPOSLocaleValue(locale);
    return _channel.invokeMethod<bool>(
        'setDisplayMessageAndSelectItemPos', <String, dynamic> {
      'line1': line1,
      'line2': line2,
      'line3': line3,
      'locale': v,
      'firstItemLine': firstItemLine,
      'items': items,
      'timeout': timeout,
    });
  }

  @override
  Future<bool?> clearDisplayAndCancelKeypadPos() {
    return _channel.invokeMethod<bool>('clearDisplayAndCancelKeypadPos');
  }

  //
  // Software Decoder APIs
  //
  @override
  Future<bool?> isSoftwareDecoderActivated() {
    return _channel.invokeMethod<bool>('isSoftwareDecoderActivated');
  }

  @override
  Future<KDCSWDecoderActivationResult?> activateSoftwareDecoder(
      String license) async {
    final map = await _channel.invokeMapMethod<String, dynamic>(
        'activateSoftwareDecoder', <String, dynamic> {
      'license': license,
    });
    return (map != null) ? KDCSWDecoderActivationResult.fromMap(map) : null;
  }

  @override
  Future<bool?> setSoftwareDecoderActivationPeriod(int period) {
    return _channel.invokeMethod<bool>(
        'setSoftwareDecoderActivationPeriod', <String, dynamic> {
      'period': period,
    });
  }

  @override
  Future<KDCSWDecoderSetting?> getSoftwareDecoderSetting() async {
    final map = await _channel
        .invokeMapMethod<String, dynamic>('getSoftwareDecoderSetting');
    return (map != null) ? KDCSWDecoderSetting.fromMap(map) : null;
  }

  @override
  Future<bool?> setSoftwareDecoderSetting(KDCSWDecoderSetting setting) {
    final windowMode = setting.windowMode?.index;
    final ocrActiveTemplate =
        toSWDecoderOCRActiveTemplatValue(setting.ocrActive);
    final activeCamera = setting.activeCamera?.index;

    return _channel
        .invokeMethod<bool>('setSoftwareDecoderSetting', <String, dynamic> {
      'flashOnDecode': setting.flashOnDecode,
      'decode': setting.decode,
      'window': setting.window,
      'windowMode': windowMode,
      'aimer': setting.aimer,
      'aimerColor': setting.aimerColor,
      'overlayText': setting.overlayText,
      'overlayTextColor': setting.overlayTextColor,
      'ocrActive': ocrActiveTemplate,
      'ocrUser': setting.ocrUser,
      'activeCamera': activeCamera,
    });
  }

  @override
  Future<bool?> startComponentScanActivity() {
    return _channel.invokeMethod<bool>('startComponentScanActivity');
  }

  @override
  Future<String?> getSoftwareDecoderDeviceId() {
    return _channel.invokeMethod<String>('getSoftwareDecoderDeviceId');
  }

  @override
  Future<KDCSWDecoderImage?> getSoftwareDecoderLastProcessedImage() async {
    final map = await _channel
        .invokeMapMethod<String, dynamic>('getSoftwareDecoderLastProcessedImage');
    return (map != null) ? KDCSWDecoderImage.fromMap(map) : null;
  }

  @override
  Future<KDCSWDecoderImage?> getSoftwareDecoderLastDecodedImage() async {
    final map = await _channel
        .invokeMapMethod<String, dynamic>('getSoftwareDecoderLastDecodedImage');
    return (map != null) ? KDCSWDecoderImage.fromMap(map) : null;
  }

  @override
  Future<KDCSWDecoderImage?> getSoftwareDecoderLastBarcodeImage(KDCDataBounds bounds) async {
    final topLeft = <String, int> {
      'x': bounds.topLeft.dx.toInt(),
      'y': bounds.topLeft.dy.toInt(),
    };

    final topRight = <String, int> {
      'x': bounds.topRight.dx.toInt(),
      'y': bounds.topRight.dy.toInt(),
    };

    final bottomLeft = <String, int> {
      'x': bounds.bottomLeft.dx.toInt(),
      'y': bounds.bottomLeft.dy.toInt(),
    };

    final bottomRight = <String, int> {
      'x': bounds.bottomRight.dx.toInt(),
      'y': bounds.bottomRight.dy.toInt(),
    };
    
    final map =  await _channel
      .invokeMapMethod<String, dynamic>('getSoftwareDecoderLastBarcodeImage', <String, dynamic> {
      'topLeft': topLeft,
      'topRight': topRight,
      'bottomLeft': bottomLeft,
      'bottomRight': bottomRight,
      'width': bounds.width,
      'height': bounds.height,
    });
    return (map != null) ? KDCSWDecoderImage.fromMap(map) : null;
  }
}

mixin EventChannelKdcreaderIos
    implements EventChannelKdcreaderPlatformInterface {
  final EventChannel _connectionStateEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/connection');

  final EventChannel _barcodeDataEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/barcode');
  final EventChannel _nfcDataEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/nfc');
  final EventChannel _msrDataEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/msr');
  final EventChannel _generalDataEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/general');

  final EventChannel _posDataEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/pos');

  final EventChannel _errorEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/error');

  final EventChannel _deviceScannedEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/device_scanned');

  final EventChannel _infoUpdatedEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/info_updated');

  // Software Decoder when separate notification is used.
  final EventChannel _swBarcodeDataEventChannel =
      EventChannel('plugins.flutter.koamtac/ios/sw_barcode');

  @override
  Stream<ConnectionEvent> getConnectionStateStream() {
    return _connectionStateEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseConnectionState(event));
  }

  ConnectionEvent _parseConnectionState(dynamic event) {
    final map = event as Map<dynamic, dynamic>;
    return ConnectionEvent.fromMap(map.cast<String, dynamic>());
  }

  @override
  Stream<KDCData> getBarcodeDataStream() {
    return _barcodeDataEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) {
          final map = Map<String, dynamic>.from(event as Map<dynamic, dynamic>);
          if (map.containsKey('bounds')) {
            return _parseKdcSwData(event);
          }
          return  _parseKdcData(event);
        });
  }

  @override
  Stream<KDCData> getNfcDataStream() {
    return _nfcDataEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseKdcData(event));
  }

  @override
  Stream<KDCData> getMsrDataStream() {
    return _msrDataEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseKdcData(event));
  }

  @override
  Stream<KDCData> getGeneralDataStream() {
    return _generalDataEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseKdcData(event));
  }

  KDCData _parseKdcData(dynamic event) {
    final map = event as Map<dynamic, dynamic>;
    return KDCData.fromMap(map.cast<String, dynamic>());
  }

  KDCSWData _parseKdcSwData(dynamic event) {
    final map = event as Map<dynamic, dynamic>;
    return KDCSWData.fromMap(map.cast<String, dynamic>());
  }

  @override
  Stream<KPOSData> getPosDataStream() {
    return _posDataEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseKPosData(event));
  }

  KPOSData _parseKPosData(dynamic event) {
    final map = event as Map<dynamic, dynamic>;
    return KPOSData.fromMap(map.cast<String, dynamic>());
  }

  @override
  Stream<ErrorEvent> getErrorStream() {
    return _errorEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseErrorData(event));
  }

  ErrorEvent _parseErrorData(dynamic event) {
    final map = event as Map<dynamic, dynamic>;
    return ErrorEvent.fromMap(map.cast<String, dynamic>());
  }

  @override
  Stream<KDCDevice> getDeviceScannedStream() {
    return _deviceScannedEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseKdcDevice(event));
  }

  KDCDevice _parseKdcDevice(dynamic event) {
    final map = event as Map<dynamic, dynamic>;
    return KDCDevice.fromMap(map.cast<String, dynamic>());
  }

  @override
  Stream<ScanFailEvent> getDeviceScanFailedrStream() {
    throw UnimplementedError(
        'getDeviceScanFailedrStream has not been implemented.');
  }

  @override
  Stream<KDCDevice> getUsbAttachedStream() {
    throw UnimplementedError(
        'getUsbAttachedStream has not been implemented.');
  }

  @override
  Stream<KDCDevice> getUsbDetachedStream() {
    throw UnimplementedError(
        'getUsbDetachedStream has not been implemented.');
  }

  @override
  Stream<InfoEvent> getInfoUpdatedStream() {
    return _infoUpdatedEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseInfoEventData(event));
  }

  InfoEvent _parseInfoEventData(dynamic event) {
    final map = event as Map<dynamic, dynamic>;
    return InfoEvent.fromMap(map.cast<String, dynamic>());
  }

  @override
  Stream<List<KDCData>> getSwBarcodeDataStream() {
    return _swBarcodeDataEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _parseKdcDataList(event));
  }

  List<KDCData> _parseKdcDataList(dynamic event) {
    return event?.map<KDCData>((item) {
      final map = item.cast<String, dynamic>();
      if (map.containsKey('bounds')) {
        return KDCSWData.fromMap(map);
      }
      return KDCData.fromMap(map);
    }).toList();
  }
}
