// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:typed_data';
import 'package:kdcreader_platform_interface/kdcreader_platform_interface.dart';

/// Main Class of KDCReader SDK
class Kdcreader {
  /// Get stream to receive connection event.
  ///
  Stream<ConnectionEvent> getConnectionStateStream() {
    return KdcreaderPlatformInterface.instance.getConnectionStateStream();
  }

  /// Get stream to receive barcode data.
  ///
  Stream<KDCData> getBarcodeDataStream() {
    return KdcreaderPlatformInterface.instance.getBarcodeDataStream();
  }

  /// Get stream to receive nfc data.
  ///
  Stream<KDCData> getNfcDataStream() {
    return KdcreaderPlatformInterface.instance.getNfcDataStream();
  }

  /// Get stream to receive msr data.
  ///
  Stream<KDCData> getMsrDataStream() {
    return KdcreaderPlatformInterface.instance.getMsrDataStream();
  }

  /// Get stream to receive general data.
  ///
  Stream<KDCData> getGeneralDataStream() {
    return KdcreaderPlatformInterface.instance.getGeneralDataStream();
  }

  /// Get stream to receive pos data.
  ///
  Stream<KPOSData> getPosDataStream() {
    return KdcreaderPlatformInterface.instance.getPosDataStream();
  }

  /// Get stream to receive error from native SDK.
  ///
  Stream<ErrorEvent> getErrorStream() {
    return KdcreaderPlatformInterface.instance.getErrorStream();
  }

  /// Get stream to receive BLE scanned peripheral device.
  ///
  Stream<KDCDevice> getDeviceScannedStream() {
    return KdcreaderPlatformInterface.instance.getDeviceScannedStream();
  }

  /// Get stream to receive BLE scan fail event.
  ///
  /// <b>Note</b> This is only supported on Android devices.
  Stream<ScanFailEvent> getDeviceScanFailedrStream() {
    return KdcreaderPlatformInterface.instance.getDeviceScanFailedrStream();
  }

  /// Get stream to receive usb device attached event.
  ///
  /// <b>Note</b> This is only supported on Android devices.
  Stream<KDCDevice> getUsbAttachedStream() {
    return KdcreaderPlatformInterface.instance.getUsbAttachedStream();
  }

  /// Get stream to receive usb device detached event.
  ///
  /// <b>Note</b> This is only supported on Android devices.
  Stream<KDCDevice> getUsbDetachedStream() {
    return KdcreaderPlatformInterface.instance.getUsbDetachedStream();
  }

  /// Get stream to receive CBManagerState(Core Bluetooth Manager state) updated event.
  ///
  /// <b>Note</b> This is only supported on iOS devices.
  Stream<InfoEvent> getInfoUpdatedStream() {
    return KdcreaderPlatformInterface.instance.getInfoUpdatedStream();
  }

  /// Get stream to receive barcode data list decoded by software decoder engine.
  ///
  /// <b>Note</b> This is only supported when separate notification for KDC8 is used.
  Stream<List<KDCData>> getSwBarcodeDataStream() {
    return KdcreaderPlatformInterface.instance.getSwBarcodeDataStream();
  }

  //
  // Common APIs (Connection, KDCReader Configuration, SoftwareTrigger)
  //

  /// Decide whether to attach the type when creating a data record.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableAttachType(bool enable) {
    return KdcreaderPlatformInterface.instance.enableAttachType(enable);
  }

  /// Decide whether to attach the serial number when creating a data record.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableAttachSerialNumber(bool enable) {
    return KdcreaderPlatformInterface.instance.enableAttachSerialNumber(enable);
  }

  /// Decide whether to attach the timestamp when creating a data record.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableAttachTimestamp(bool enable) {
    return KdcreaderPlatformInterface.instance.enableAttachTimestamp(enable);
  }

  /// Select data delimiter when creating a data record.
  ///
  /// [delimiter] Data delimiter to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDataDelimiter(DataDelimiter delimiter) {
    return KdcreaderPlatformInterface.instance.setDataDelimiter(delimiter);
  }

  /// Select record delimiter when creating a data record.
  ///
  /// [delimiter] Record delimiter to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setRecordDelimiter(RecordDelimiter delimiter) {
    return KdcreaderPlatformInterface.instance.setRecordDelimiter(delimiter);
  }

  /// Get available KDC device list.
  ///
  /// [type] Device list type to be obtained.<br>
  /// [options] To retrieve known peripheral.
  /// <b>Note</b> It is only supported on iOS in case of KNOWN_PERIPHERAL_LIST.
  ///
  /// Return available device list if succeeded.
  Future<List<KDCDevice>?> getAvailableDeviceList(DeviceListType type,
      {dynamic options}) {
    return KdcreaderPlatformInterface.instance
        .getAvailableDeviceList(type, options: options);
  }

  /// Connect to the target KDC device.
  ///
  /// If the specific device is not provided, KDCReader will attempt to connect to all available devices.
  ///
  /// [device] The KDC device to be connected.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> connect(KDCDevice? device) {
    return KdcreaderPlatformInterface.instance.connect(device);
  }

  /// Disconnect current connection.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> disconnect() {
    return KdcreaderPlatformInterface.instance.disconnect();
  }

  /// Check if connection is established.
  ///
  /// Return 'true' if connected, otherwise false.
  Future<bool?> isConnected() {
    return KdcreaderPlatformInterface.instance.isConnected();
  }

  /// Start Bluetooth LE scan.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> startScan() {
    return KdcreaderPlatformInterface.instance.startScan();
  }

  /// Stop Bluetooth LE scan.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> stopScan() {
    return KdcreaderPlatformInterface.instance.stopScan();
  }

  /// Scan Barcode or Read UHF tag.
  ///
  /// This behavior is depended on configuration of the KDC device.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> softwareTrigger() {
    return KdcreaderPlatformInterface.instance.softwareTrigger();
  }

  //
  // Device information APIs
  //

  /// Get the KDC device information.
  ///
  /// Return KDC device information when successful.
  Future<KDCDeviceInfo?> getDeviceInfo() async {
    return KdcreaderPlatformInterface.instance.getDeviceInfo();
  }

  /// Get the current KDC device connected to the KDCReader.
  ///
  /// Return KDC device instance when successful.
  Future<KDCDevice?> getConnectedDevice() async {
    return KdcreaderPlatformInterface.instance.getConnectedDevice();
  }

  //
  // Data Process APIs
  //

  /// Get prefix string.
  ///
  /// Return prefix string up to 11 when successful.
  Future<String?> getDataPrefix() {
    return KdcreaderPlatformInterface.instance.getDataPrefix();
  }

  /// Set prefix string.
  ///
  /// [prefix] Data prefix string up to 11.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDataPrefix(String prefix) {
    return KdcreaderPlatformInterface.instance.setDataPrefix(prefix);
  }

  /// Get suffix string.
  ///
  /// Return suffix string up to 11 when successful
  Future<String?> getDataSuffix() {
    return KdcreaderPlatformInterface.instance.getDataSuffix();
  }

  /// Set suffix string.
  ///
  /// [suffix] Data suffix string up to 11.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDataSuffix(String suffix) {
    return KdcreaderPlatformInterface.instance.setDataSuffix(suffix);
  }

  /// Get current symbology options saved in the KDC.
  ///
  /// Please refer to [KDCSymbology] for the key of each symbol.
  ///
  /// Return KDC barcode symbology map when successful.
  Future<Map<String, bool>?> getSymbology() {
    return KdcreaderPlatformInterface.instance.getSymbology();
  }

  /// Enable or disable symbology options.
  ///
  /// [symbols] Symbology selection map.<br>
  /// Please refer to [KDCSymbology] for the key of each symbol.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setSymbology(Map<String, bool> symbols) {
    return KdcreaderPlatformInterface.instance.setSymbology(symbols);
  }

  /// Enable all symbologies.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableAllSymbology() {
    return KdcreaderPlatformInterface.instance.enableAllSymbology();
  }

  /// Disable all symbologies.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> disableAllSymbology() {
    return KdcreaderPlatformInterface.instance.disableAllSymbology();
  }

  /// Get current barcode options saved in the KDC.
  ///
  /// Please refer to [KDCBarcodeOption] for the key of each option.
  ///
  /// Return KDC barcode option when successful.
  Future<Map<String, bool>?> getBarcodeOption() {
    return KdcreaderPlatformInterface.instance.getBarcodeOption();
  }

  /// Enable or disable barcode options.
  ///
  /// [options] Barcode option to be enabled or disabled.<br>
  /// Please refer to [KDCBarcodeOption] for the key of each option.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setBarcodeOption(Map<String, bool> options) {
    return KdcreaderPlatformInterface.instance.setBarcodeOption(options);
  }

  /// Enable all barcode options.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableAllOptions() {
    return KdcreaderPlatformInterface.instance.enableAllOptions();
  }

  /// Disable all barcode options.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> disableAllOptions() {
    return KdcreaderPlatformInterface.instance.disableAllOptions();
  }

  /// Get the minimum length of barcode.
  ///
  /// Return minimum length when successful.
  Future<int?> getMinimumBarcodeLength() {
    return KdcreaderPlatformInterface.instance.getMinimumBarcodeLength();
  }

  /// Set the minimum length of barcode.
  ///
  /// [length] The minimum length of barcode to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<int?> setMinimumBarcodeLength(int length) {
    return KdcreaderPlatformInterface.instance.setMinimumBarcodeLength(length);
  }

  /// Get number of stored barcodes in the KDC internal flash memory.
  ///
  /// Return the number of stored barcodes when successful.
  Future<int?> getNumberOfStoredBarcode() {
    return KdcreaderPlatformInterface.instance.getNumberOfStoredBarcode();
  }

  /// Get the all sotred barcodes in the KDC internal flash memory.
  ///
  /// The all stored barcode is passed to the application via listener one by one.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> getStoredDataSingle() {
    return KdcreaderPlatformInterface.instance.getStoredDataSingle();
  }

  /// Get current setting of data process mode of KDC device.
  ///
  /// Return Data process mode when successful.
  Future<DataProcess?> getDataProcessMode() async {
    return KdcreaderPlatformInterface.instance.getDataProcessMode();
  }

  /// Set data process mode of the KDC device.
  ///
  /// [mode] Data process mode to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDataProcessMode(DataProcess mode) {
    return KdcreaderPlatformInterface.instance.setDataProcessMode(mode);
  }

  /// Get current setting of data format of KDC device.
  ///
  /// Return current data format when successful.
  Future<DataFormat?> getDataFormat() async {
    return KdcreaderPlatformInterface.instance.getDataFormat();
  }

  /// Set data format the KDC device.
  ///
  /// [format] Data format mode to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDataFormat(DataFormat format) {
    return KdcreaderPlatformInterface.instance.setDataFormat(format);
  }

  /// Get current security level.
  ///
  /// Returns security level [1, 4] when successful.
  ///
  /// <b>Note</b> This command is only applicable to Laser(1D) models.
  Future<int?> getSecurityLevel() {
    return KdcreaderPlatformInterface.instance.getSecurityLevel();
  }

  /// Set KDC security level.
  ///
  /// [level] Security level [1, 4] to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to Laser(1D) models.
  Future<bool?> setSecurityLevel(int level) {
    return KdcreaderPlatformInterface.instance.setSecurityLevel(level);
  }

  /// Enable age verification
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to Camera(2D) models.
  Future<bool?> enableAgeVerify(bool enable) {
    return KdcreaderPlatformInterface.instance.enableAgeVerify(enable);
  }

  /// Check if age verification is enabled.
  ///
  /// Return enable state when successful. (true if enabled, otherwise false)
  ///
  /// <b>Note</br> This command is only applicable to Camera(2D) models.
  Future<bool?> isAgeVerifyEnabled() {
    return KdcreaderPlatformInterface.instance.isAgeVerifyEnabled();
  }

  /// Get AIM ID setting type.
  ///
  /// Return AIM ID setting type when successful.
  Future<AIMIDStatus?> getAIMIDSetting() {
    return KdcreaderPlatformInterface.instance.getAIMIDSetting();
  }

  /// Set AIM ID setting type.
  ///
  /// [aimid] AIMIDStatus type to be set
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setAIMIDSetting(AIMIDStatus aimid) {
    return KdcreaderPlatformInterface.instance.setAIMIDSetting(aimid);
  }

  /// Get partial data start position.
  ///
  /// Return the partial data start position when successful.
  Future<int?> getPartialDataStartPosition() {
    return KdcreaderPlatformInterface.instance.getPartialDataStartPosition();
  }

  /// Set partial data start position.
  ///
  /// [position] Partial data start position to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setPartialDataStartPosition(int position) {
    return KdcreaderPlatformInterface.instance
        .setPartialDataStartPosition(position);
  }

  /// Get length of partial data.
  ///
  /// Return the partial data length when successful.
  Future<bool?> getPartialDataLength() {
    return KdcreaderPlatformInterface.instance.getPartialDataLength();
  }

  /// Set length of partial data
  ///
  /// [length] Partial data length to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setPartialDataLength(int length) {
    return KdcreaderPlatformInterface.instance.setPartialDataLength(length);
  }

  /// Get current partial data action.
  ///
  /// Return the partial data action when successful.
  Future<PartialDataAction?> getPartialDataAction() async {
    return KdcreaderPlatformInterface.instance.getPartialDataAction();
  }

  /// Set partial data action.
  ///
  /// [action] Partial data action type to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setPartialDataAction(PartialDataAction action) {
    return KdcreaderPlatformInterface.instance.setPartialDataAction(action);
  }

  /// Acknowledges start of the Synchronization process.
  ///
  /// The KDC enters synchronization mode, locks buttons and accepts only commands from the host.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> startSynchronization() {
    return KdcreaderPlatformInterface.instance.startSynchronization();
  }

  /// Acknowledges finish of the Synchronization process.
  ///
  /// The KDC resumes normal mode upon receiving the finish synchronization command.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> finishSynchronization() {
    return KdcreaderPlatformInterface.instance.finishSynchronization();
  }

  /// Get termination character setting after barcode data.
  ///
  /// It is only supported when data fromat is barcode only.
  ///
  /// Return data terminator type when successful.
  ///
  /// <b>Note</b> The values 5,6,7,8 (RIGHT_ARROW, LEFT_ARROW, DOWN_ARROW, UP_ARROW)
  /// are only supported when Bluetooth profile is HID mode.
  Future<DataTerminator?> getDataTerminator() {
    return KdcreaderPlatformInterface.instance.getDataTerminator();
  }

  /// Set termination character after barcode data.
  ///
  /// It is only supported when data fromat is barcode only.
  ///
  /// [terminator] Data terminator type
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> The values 5,6,7,8 (RIGHT_ARROW, LEFT_ARROW, DOWN_ARROW, UP_ARROW)
  /// are only supported when Bluetooth profile is HID mode.
  Future<bool?> setDataTerminator(DataTerminator terminator) {
    return KdcreaderPlatformInterface.instance.setDataTerminator(terminator);
  }

  //
  // System Configuration APIs - Lock, Battery Level
  //

  /// Enable button lock.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true'  if command is done succesfully, otherwise failed.
  Future<bool?> enableButtonLock(bool enable) {
    return KdcreaderPlatformInterface.instance.enableButtonLock(enable);
  }

  /// Enable scan button lock.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true'  if command is done succesfully, otherwise failed.
  Future<bool?> enableScanButtonLock(bool enable) {
    return KdcreaderPlatformInterface.instance.enableScanButtonLock(enable);
  }

  /// Read the current battery capacity of the KDC.
  ///
  /// Return the capacity level of the battery when successful. [0, 100]
  Future<int?> getBatteryLevel() {
    return KdcreaderPlatformInterface.instance.getBatteryLevel();
  }

  /// Read the current extended battery capacity of the KDC.
  ///
  /// Return the capacity of the extended battery when successful. [0, 100]
  Future<int?> getExtendedBatteryLevel() {
    return KdcreaderPlatformInterface.instance.getExtendedBatteryLevel();
  }

  //
  // System Configuration APIs - Time
  //

  /// Synchronize KDC system time to the device.
  ///
  /// Return 'true'  if command is done succesfully, otherwise failed.
  Future<bool?> syncSystemTime() {
    return KdcreaderPlatformInterface.instance.syncSystemTime();
  }

  /// Reset KDC system time.
  ///
  /// Return 'true'  if command is done succesfully, otherwise failed.
  Future<bool?> resetSystemTime() {
    return KdcreaderPlatformInterface.instance.resetSystemTime();
  }

  /// Get current KDC device sleep timeout duration.
  ///
  /// Return device sleep timeout value when successful.
  Future<SleepTimeout?> getSleepTimeout() {
    return KdcreaderPlatformInterface.instance.getSleepTimeout();
  }

  /// Set KDC device sleep timeout duration.
  ///
  /// [timeout] Sleep timeout duration to be set.
  ///
  /// Return 'true'  if command is done succesfully, otherwise failed.
  Future<bool?> setSleepTimeout(SleepTimeout timeout) {
    return KdcreaderPlatformInterface.instance.setSleepTimeout(timeout);
  }

  /// Get current barcode read operation timeout.
  ///
  /// Return device scan timeout value when successful.
  Future<int?> getScanTimeout() {
    return KdcreaderPlatformInterface.instance.getScanTimeout();
  }

  /// Set the timeout for barcode read operation.
  ///
  /// [timeout] Barcode read timeout to be set. [100, 10000]
  ///
  /// Return 'true'  if command is done succesfully, otherwise failed.
  Future<bool?> setScanTimeout(int timeout) {
    return KdcreaderPlatformInterface.instance.setScanTimeout(timeout);
  }

  //
  // System Configuration APIs - Memory
  //

  /// Erase the flash (barcode and application) memory completely.
  ///
  /// All stored data will be lost.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> eraseMemory() {
    return KdcreaderPlatformInterface.instance.eraseMemory();
  }

  /// Erase the last stored data.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> eraseLastData() {
    return KdcreaderPlatformInterface.instance.eraseLastData();
  }

  /// Get the current available KDC memory(KB).
  ///
  /// Return The size of KDC available memory(KB) when successful.
  Future<int?> getMemoryLeft() {
    return KdcreaderPlatformInterface.instance.getMemoryLeft();
  }

  /// Set KDC internal options and flag to the factory default.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setFactoryDefault() {
    return KdcreaderPlatformInterface.instance.setFactoryDefault();
  }

  //
  // System Configuration APIs - Beep
  //

  /// Get current volume setting of KDC device.
  ///
  /// Return current volume when successful.
  Future<Volume?> getBeepVolume() {
    return KdcreaderPlatformInterface.instance.getBeepVolume();
  }

  /// Set beep volume setting of KDC device.
  ///
  /// [volume] Volume type to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setBeepVolume(Volume volume) {
    return KdcreaderPlatformInterface.instance.setBeepVolume(volume);
  }

  /// Set KDC beep volume to high or low.
  ///
  /// [enable] True if high, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableHighBeepVolume(bool enable) {
    return KdcreaderPlatformInterface.instance.enableHighBeepVolume(enable);
  }

  /// Check if KDC beep volume is high or low regardless of beep sound state.
  ///
  /// Return enable state when successful. (true if enabled, otherwise false)
  Future<bool?> isHighBeepVolumeEnabled() {
    return KdcreaderPlatformInterface.instance.isHighBeepVolumeEnabled();
  }

  /// Set KDC beep sound to enable or disable.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableBeepSound(bool enable) {
    return KdcreaderPlatformInterface.instance.enableBeepSound(enable);
  }

  /// Check if beep sound is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isBeepSoundEnabled() {
    return KdcreaderPlatformInterface.instance.isBeepSoundEnabled();
  }

  /// Set power on beep to enable or disable
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enablePowerOnBeep(bool enable) {
    return KdcreaderPlatformInterface.instance.enablePowerOnBeep(enable);
  }

  /// Check if power on beep is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isPowerOnBeepEnabled() {
    return KdcreaderPlatformInterface.instance.isPowerOnBeepEnabled();
  }

  /// Set beep on scan to enable or disable
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableBeepOnScan(bool enable) {
    return KdcreaderPlatformInterface.instance.enableBeepOnScan(enable);
  }

  /// Check if beep on scan is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isBeepOnScanEnabled() {
    return KdcreaderPlatformInterface.instance.isBeepOnScanEnabled();
  }

  /// Set beep on connect to enable or disable
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableBeepOnConnect(bool enable) {
    return KdcreaderPlatformInterface.instance.enableBeepOnConnect(enable);
  }

  /// Check if beep on connect is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isBeepOnConnectEnabled() {
    return KdcreaderPlatformInterface.instance.isBeepOnConnectEnabled();
  }

  /// Enable failure alert beep
  ///
  /// Retunrs 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setFailureAlertBeep() {
    return KdcreaderPlatformInterface.instance.setFailureAlertBeep();
  }

  /// Enable success alert beep
  ///
  /// Retunrs 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setSuccessAlertBeep() {
    return KdcreaderPlatformInterface.instance.setSuccessAlertBeep();
  }

  /// Set custom beep.
  ///
  /// [onTime] To set KDC device custom beep on time to.<br>
  /// [offTime] To set KDC device custom beep off time to.<br>
  /// [repeat] Set KDC device custom beep to repeat this many times.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setCustomBeepTone(int onTime,
      {required int offTime, required int repeat}) {
    return KdcreaderPlatformInterface.instance
        .setCustomBeepTone(onTime, offTime, repeat);
  }

  //
  // System Configuration APIs - MFi
  //

  /// Enable MFi mode.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableMFiMode(bool enable) {
    return KdcreaderPlatformInterface.instance.enableMFiMode(enable);
  }

  /// Check if MFi mode is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isMFiEnabled() {
    return KdcreaderPlatformInterface.instance.isMFiEnabled();
  }

  /// Check if MFi auth chip(i-chip) is installed.
  ///
  /// Return install status when successful. (true if installed, otherwise disabled)
  Future<bool?> isMFiAuthChipInstalled() {
    return KdcreaderPlatformInterface.instance.isMFiAuthChipInstalled();
  }

  //
  // System Configuration APIs - Bluetooth
  //

  /// Enable bluetooth auto connect feature.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableBluetoothAutoConnect(bool enable) {
    return KdcreaderPlatformInterface.instance
        .enableBluetoothAutoConnect(enable);
  }

  /// Check if bluetooth auto connect is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isAutoConnectEnabled() {
    return KdcreaderPlatformInterface.instance.isAutoConnectEnabled();
  }

  /// Enable or disable KDC to turn on Bluetooth module power when scan button is pressed.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This feature enables the KDC to automatically power on Bluetooth when the SCAN button is pressed.
  Future<bool?> enableBluetoothAutoPowerOn(bool enable) {
    return KdcreaderPlatformInterface.instance
        .enableBluetoothAutoPowerOn(enable);
  }

  /// Check if bluetooth auto power on is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isAutoPowerOnEnabled() {
    return KdcreaderPlatformInterface.instance.isAutoPowerOnEnabled();
  }

  /// Enable or Disable to turn Bluetooth module power off when the KDC is disconnected.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableBluetoothAutoPowerOff(bool enable) {
    return KdcreaderPlatformInterface.instance
        .enableBluetoothAutoPowerOff(enable);
  }

  /// Check if bluetooth auto power off is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isBluetoothAutoPowerOffEnabled() {
    return KdcreaderPlatformInterface.instance.isBluetoothAutoPowerOffEnabled();
  }

  /// Enable or disable KDC to Bluetooth beep warning.
  ///
  /// KDC beeps on every 15 minutes when Bluetooth power is on and Bluetooth is disconnected,
  /// but Auto power off option is disabled. The KDC beeps 5 times with short intervals.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This feature enables the KDC to beep to warn user that the Bluetooth power is off when timeout is passed.
  Future<bool?> enableBluetoothBeepWarning(bool enable) {
    return KdcreaderPlatformInterface.instance
        .enableBluetoothBeepWarning(enable);
  }

  /// Check if bluetooth beep warning is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isBluetoothBeepWarningEnabled() {
    return KdcreaderPlatformInterface.instance.isBluetoothBeepWarningEnabled();
  }

  /// Get current Bluetooth profile of the connected KDC device.
  ///
  /// Return current Bluetooth profile when successful.
  Future<DeviceProfile?> getDeviceProfile() {
    return KdcreaderPlatformInterface.instance.getDeviceProfile();
  }

  /// Set Bluetooth profile of the connected KDC device.
  ///
  /// [profile] Device profile to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDeviceProfile(DeviceProfile profile) {
    return KdcreaderPlatformInterface.instance.setDeviceProfile(profile);
  }

  /// Get current Bluetooth auto power off timeout duration.
  ///
  /// Return Bluetooth auto power off delay when successful.
  Future<BluetoothAutoPowerOffDelay?> getBluetoothAutoPowerOffTimeout() {
    return KdcreaderPlatformInterface.instance
        .getBluetoothAutoPowerOffTimeout();
  }

  /// Set current Bluetooth auto power off timeout value from 1 to 30 minutes.
  ///
  /// [timeout] Timeout value of Bluetooth auto power off.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> It will be set to 5 minutes if value is 0; set to 30 minutes if value is greater than 30.
  Future<bool?> setBluetoothAutoPowerOffTimeout(
      BluetoothAutoPowerOffDelay timeout) {
    return KdcreaderPlatformInterface.instance
        .setBluetoothAutoPowerOffTimeout(timeout);
  }

  /// Enable or disable KDC to turn Bluetooth module power off.
  ///
  /// Bluetooth module powers off when the KDC is disconnected
  /// from the Bluetooth host for a period of time defined in command.<br>
  /// The default power off time is 5 minutes.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This feature enables the KDC to send a Bluetooth power off message "BTOFF" to the host when KDC is disconnected from host.
  Future<bool?> enableBluetoothPowerOffMessage(bool enable) {
    return KdcreaderPlatformInterface.instance
        .enableBluetoothPowerOffMessage(enable);
  }

  /// Check if bluetooth power off message is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isPowerOffMessageEnabled() {
    return KdcreaderPlatformInterface.instance.isPowerOffMessageEnabled();
  }

  /// Get the Bluetooth Mac Address from KDC.
  ///
  /// Return Bluetooth mac address of the device when successful.
  Future<String?> getBluetoothMACAddress() {
    return KdcreaderPlatformInterface.instance.getBluetoothMACAddress();
  }

  /// Get current Bluetooth auto power on delay time.
  ///
  /// Return auto power on delay time in seconds when successful.
  Future<BluetoothAutoPowerOnDelay?> getBluetoothAutoPowerOnDelay() {
    return KdcreaderPlatformInterface.instance.getBluetoothAutoPowerOnDelay();
  }

  /// Set Bluetooth Auto Power On Delay.
  ///
  /// [delay] Delay time in seconds.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setBluetoothAutoPowerOnDelay(BluetoothAutoPowerOnDelay delay) {
    return KdcreaderPlatformInterface.instance
        .setBluetoothAutoPowerOnDelay(delay);
  }

  /// Get current Bluetooth firmware version setting of KDC device.
  ///
  /// Return current Bluetooth firmware version when successful.
  Future<String?> getBluetoothFirmwareVersion() {
    return KdcreaderPlatformInterface.instance.getBluetoothFirmwareVersion();
  }

  /// Enable bluetooth null wakeup
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableBluetoothWakeupNull(bool enable) {
    return KdcreaderPlatformInterface.instance
        .enableBluetoothWakeupNull(enable);
  }

  /// Check if bluetooth null wakeup is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isWakeupNullsEnabled() {
    return KdcreaderPlatformInterface.instance.isWakeupNullsEnabled();
  }

  /// Enable bluetooth toggle
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableBluetoothToggle(bool enable) {
    return KdcreaderPlatformInterface.instance.enableBluetoothToggle(enable);
  }

  /// Check if bluetooth toggle is enabled.
  ///
  /// Return Enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isBluetoothToggleEnabled() {
    return KdcreaderPlatformInterface.instance.isBluetoothToggleEnabled();
  }

  /// Enable bluetooth disconnect button
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableBluetoothDisconnectButton(bool enable) {
    return KdcreaderPlatformInterface.instance
        .enableBluetoothDisconnectButton(enable);
  }

  /// Check if bluetooth disconnect button is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise disabled)
  Future<bool?> isBluetoothDisconnectButtonEnabled() {
    return KdcreaderPlatformInterface.instance
        .isBluetoothDisconnectButtonEnabled();
  }

  //
  // System Configuration APIs - Etc.
  //

  /// Enable duplicate check setting in normal mode.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableDuplicateCheck(bool enable) {
    return KdcreaderPlatformInterface.instance.enableDuplicateCheck(enable);
  }

  /// Check if DuplicateCheck feature is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isDuplicateCheckEnabled() {
    return KdcreaderPlatformInterface.instance.isDuplicateCheckEnabled();
  }

  /// Enable auto erase feature to erase stored barcode data after sync.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableAutoErase(bool enable) {
    return KdcreaderPlatformInterface.instance.enableAutoErase(enable);
  }

  /// Check if AutoErase feature is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isAutoEraseEnabled() {
    return KdcreaderPlatformInterface.instance.isAutoEraseEnabled();
  }

  /// Enable ScanIfConnected feature.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableScanIfConnected(bool enable) {
    return KdcreaderPlatformInterface.instance.enableScanIfConnected(enable);
  }

  /// Check if ScanIfConnected feature is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isScanIfConnectedEnabled() {
    return KdcreaderPlatformInterface.instance.isScanIfConnectedEnabled();
  }

  /// Get current auto trigger reread delay among continuous, short, medium, long and extra long.
  ///
  /// Return re-read delay value when successful.
  Future<RereadDelay?> getAutoTriggerRereadDelay() {
    return KdcreaderPlatformInterface.instance.getAutoTriggerRereadDelay();
  }

  /// Set auto trigger reread delay among continuous, short, medium, long and extra.
  ///
  /// [delay] RereadDelay type.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setAutoTriggerRereadDelay(RereadDelay delay) {
    return KdcreaderPlatformInterface.instance.setAutoTriggerRereadDelay(delay);
  }

  /// Enable Auto Trigger mode. Starts scanning from motion trigger.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableAutoTrigger(bool enable) {
    return KdcreaderPlatformInterface.instance.enableAutoTrigger(enable);
  }

  /// Check if Auto Trigger feature is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isAutoTriggerEnabled() {
    return KdcreaderPlatformInterface.instance.isAutoTriggerEnabled();
  }

  /// Get KDC Firmware version from connected KDC.
  ///
  /// Return KDC firmware version string when successful.
  Future<String?> getKDCFirmwareVersion() {
    return KdcreaderPlatformInterface.instance.getKDCFirmwareVersion();
  }

  /// Get KDC Firmware build version from connected KDC.
  ///
  /// Return KDC firmware build version string when successful.
  Future<String?> getKDCFirmwareBuildVersion() {
    return KdcreaderPlatformInterface.instance.getKDCFirmwareBuildVersion();
  }

  /// Get Interface Firmware version from connected KDC.
  ///
  /// Return interface firmware version string when successful.
  ///
  /// <b>Note</b> This API is only applicable to SKX SLED series.
  Future<String?> getInterfaceVersion() {
    return KdcreaderPlatformInterface.instance.getInterfaceVersion();
  }

  /// Get Power Delivery Firmware version from connected KDC.
  ///
  /// Return power delivery firmware version string when successful.
  ///
  /// <b>Note</b> This API is only applicable to SKX SLED series.
  Future<String?> getPowerDeliveryVersion() {
    return KdcreaderPlatformInterface.instance.getPowerDeliveryVersion();
  }

  //
  // Vibrate
  //

  /// Enable vibrator.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableVibrator(bool enable) {
    return KdcreaderPlatformInterface.instance.enableVibrator(enable);
  }

  /// Check if vibrator is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isVibratorEnabled() {
    return KdcreaderPlatformInterface.instance.isVibratorEnabled();
  }

  /// Set custom vibration.
  ///
  /// [onTime] To set KDC device custom vibration on time to. (duration)<br>
  /// [offTime] To set KDC device custom vibration off time to. (interval)<br>
  /// [repeat] Set KDC device custom vibration to repeat this many times.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setCustomVibration(int onTime,
      {required int offTime, required int repeat}) {
    return KdcreaderPlatformInterface.instance
        .setCustomVibration(onTime, offTime, repeat);
  }

  //
  // Display APIs
  //

  /// Enable Display Connection Status.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableDisplayConnectionStatus(bool enable) {
    return KdcreaderPlatformInterface.instance
        .enableDisplayConnectionStatus(enable);
  }

  /// Check if Display Connection Status is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isDisplayConnectionStatusEnabled() {
    return KdcreaderPlatformInterface.instance
        .isDisplayConnectionStatusEnabled();
  }

  /// Enable HHP Menu Barcode State.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> HHP Menu Barcode is Honeywell special barcodes. It is only supported on KDC300, 350C and 500C.
  Future<bool?> enableMenuBarcodeState(bool enable) {
    return KdcreaderPlatformInterface.instance.enableMenuBarcodeState(enable);
  }

  /// Check if HHP Menu Barcode State is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  ///
  /// <b>Note</b> HHP Menu Barcode is Honeywell special barcodes. It is only supported on KDC300, 350C and 500C.
  Future<bool?> isMenuBarcodeStateEnabled() {
    return KdcreaderPlatformInterface.instance.isMenuBarcodeStateEnabled();
  }

  /// Enable display scrolling.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableDisplayScroll(bool enable) {
    return KdcreaderPlatformInterface.instance.enableDisplayScroll(enable);
  }

  /// Check if display scrolling is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isScrollingEnabled() {
    return KdcreaderPlatformInterface.instance.isScrollingEnabled();
  }

  /// Set display position.
  ///
  /// [row] Row value to be set.<br>
  /// [column] Column value to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDisplayPosition(int row, {required int column}) {
    return KdcreaderPlatformInterface.instance.setDisplayPosition(row, column);
  }

  /// Clear KDC screen.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> clearDisplay() {
    return KdcreaderPlatformInterface.instance.clearDisplay();
  }

  /// Set KDC screen message font size.
  ///
  /// [size] Font size type. [0, 7]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDisplayMessageFontSize(MessageFontSize size) {
    return KdcreaderPlatformInterface.instance.setDisplayMessageFontSize(size);
  }

  /// Set Display Message Duration.
  ///
  /// [duration] Message display duration. [1, 60]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> Default display duration is system sleep time. KDC maintains the display duration until device is reset.
  Future<bool?> setDisplayMessageDuration(int duration) {
    return KdcreaderPlatformInterface.instance
        .setDisplayMessageDuration(duration);
  }

  /// Set message text attribute.
  ///
  /// [attribute] message text attribute type.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setMessageTextAttribute(MessageTextAttribute attribute) {
    return KdcreaderPlatformInterface.instance
        .setMessageTextAttribute(attribute);
  }

  /// Set Display Message using the platform's default charset.
  ///
  /// [message] The message to be displayed. This message should end with CR("\r").
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setDisplayMessage(String message) {
    return KdcreaderPlatformInterface.instance.setDisplayMessage(message);
  }

  /// Set Display Message and Get User Confirmation using the platform's default charset.
  ///
  /// [message] The message to be displayed. This message should end with CR("\r").
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This is only supported on Android devices.
  Future<bool?> setDisplayMessageAndGetUserConfirm(String message) {
    return KdcreaderPlatformInterface.instance
        .setDisplayMessageAndGetUserConfirm(message);
  }

  /// Enable the KDC to exit menu mode.
  ///
  /// The KDC400 automatically exits from menu mode if it remains idle in menu mode for 5 minutes.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableAutoMenuExit(bool enable) {
    return KdcreaderPlatformInterface.instance.enableAutoMenuExit(enable);
  }

  /// Check if Auto menu exit is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isAutoMenuExitEnabled() {
    return KdcreaderPlatformInterface.instance.isAutoMenuExitEnabled();
  }

  //
  // Keypad APIs
  //

  /// Enable Enter Key Functions.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableEnterKeyFunction(bool enable) {
    return KdcreaderPlatformInterface.instance.enableEnterKeyFunction(enable);
  }

  /// Check if Enter Function Key is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isEnterKeyFunctionEnabled() {
    return KdcreaderPlatformInterface.instance.isEnterKeyFunctionEnabled();
  }

  /// Enable extended keypad.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableExtendKeypad(bool enable) {
    return KdcreaderPlatformInterface.instance.enableExtendKeypad(enable);
  }

  /// Check if extended keypad is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isExtendKeypadEnabled() {
    return KdcreaderPlatformInterface.instance.isExtendKeypadEnabled();
  }

  /// Enable KDC350 Keypad.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableKeypad(bool enable) {
    return KdcreaderPlatformInterface.instance.enableKeypad(enable);
  }

  /// Check if KDC350 Keypad is enabled.
  ///
  /// Return enable status when successful. (true if enabled, otherwise false)
  Future<bool?> isKeypadEnabled() {
    return KdcreaderPlatformInterface.instance.isKeypadEnabled();
  }

  //
  // HID APIs
  //

  /// Get current HID auto lock timeout duration.
  ///
  /// Return HID auto lock timeout value when successful.
  Future<HIDAutoLockTime?> getHIDAutoLockTime() {
    return KdcreaderPlatformInterface.instance.getHIDAutoLockTime();
  }

  /// Set HID auto lock timeout duration.
  ///
  /// [timeout] timeout value. (0-5, 10, 15) minutes
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setHIDAutoLockTime(HIDAutoLockTime timeout) {
    return KdcreaderPlatformInterface.instance.setHIDAutoLockTime(timeout);
  }

  /// Get current HID keyboard layout.
  ///
  /// Return HID keyboard layout value when successful.
  Future<HIDKeyboard?> getHIDKeyboard() {
    return KdcreaderPlatformInterface.instance.getHIDKeyboard();
  }

  /// Set HID keyboard layout.
  ///
  /// [keyboard] HID keyboard layout to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setHIDKeyboard(HIDKeyboard keyboard) {
    return KdcreaderPlatformInterface.instance.setHIDKeyboard(keyboard);
  }

  /// Get HID initial transmit delay.
  ///
  /// Return HID initial delay value when successful.
  Future<HIDInitialDelay?> getHIDInitialDelay() {
    return KdcreaderPlatformInterface.instance.getHIDInitialDelay();
  }

  /// Set HID initial transmit delay.
  ///
  /// [delay] HID initial transmit delay to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setHIDInitialDelay(HIDInitialDelay delay) {
    return KdcreaderPlatformInterface.instance.setHIDInitialDelay(delay);
  }

  /// Get HID inter delay between characters.
  ///
  /// Return HID inter delay value when successful.
  Future<HIDInterDelay?> getHIDInterDelay() {
    return KdcreaderPlatformInterface.instance.getHIDInterDelay();
  }

  /// Set HID inter delay between characters.
  ///
  /// [delay] HID inter delay to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setHIDInterDelay(HIDInterDelay delay) {
    return KdcreaderPlatformInterface.instance.setHIDInterDelay(delay);
  }

  /// Get HID control character transmit method.
  ///
  /// Return current HID control character mode when successful.
  Future<HIDControlCharacter?> getHIDControlCharacter() {
    return KdcreaderPlatformInterface.instance.getHIDControlCharacter();
  }

  /// Set HID control character transmit method.
  ///
  /// [character] HID control character mode to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setHIDControlCharacter(HIDControlCharacter character) {
    return KdcreaderPlatformInterface.instance
        .setHIDControlCharacter(character);
  }

  //
  // WiFi APIs
  //

  /// Check if WiFi module installed in the device.
  ///
  /// Return installed state when successful. (true if installed, otherwise false)
  Future<bool?> isWiFiInstalled() {
    return KdcreaderPlatformInterface.instance.isWiFiInstalled();
  }

  /// Enable WiFi module power.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableWiFiPower(bool enable) {
    return KdcreaderPlatformInterface.instance.enableWiFiPower(enable);
  }

  /// Check if WiFi module power enabled.
  ///
  /// Return enabled state when successful. (true if enabled, otherwise false)
  Future<bool?> isWiFiPowerEnabled() {
    return KdcreaderPlatformInterface.instance.isWiFiPowerEnabled();
  }

  /// Enable Auto Connect feature of WiFi module.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableWiFiAutoConnect(bool enable) {
    return KdcreaderPlatformInterface.instance.enableWiFiAutoConnect(enable);
  }

  /// Check if WiFi module auto connect feature enabled.
  ///
  /// Return enabled state when successful. (true if enabled, otherwise false)
  Future<bool?> isWiFiAutoConnectEnabled() {
    return KdcreaderPlatformInterface.instance.isWiFiAutoConnectEnabled();
  }

  /// Set the IP address of WiFi server.
  ///
  /// [ip] A string representing IP Address.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setWiFiServerIPAddress(String ip) {
    return KdcreaderPlatformInterface.instance.setWiFiServerIPAddress(ip);
  }

  /// Get IP address of WiFi server.
  ///
  /// Return A string representing IP address when successful
  Future<String?> getWiFiServerIPAddress() {
    return KdcreaderPlatformInterface.instance.getWiFiServerIPAddress();
  }

  /// Set the URL address of WiFi server.
  ///
  /// [url] A string representing URL Address.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setWiFiServerURLAddress(String url) {
    return KdcreaderPlatformInterface.instance.setWiFiServerURLAddress(url);
  }

  /// Get the URL address of WiFi server.
  ///
  /// Return a string representing URL address when successful.
  Future<String?> getWiFiServerURLAddress() {
    return KdcreaderPlatformInterface.instance.getWiFiServerURLAddress();
  }

  /// Set the port number of WiFi server.
  ///
  /// [port] an integer representing port number.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setWiFiServerPortNumber(int port) {
    return KdcreaderPlatformInterface.instance.setWiFiServerPortNumber(port);
  }

  /// Get the port number of WiFi server.
  ///
  /// Return an integer representing port number when successful.
  Future<int?> getWiFiServerPortNumber() {
    return KdcreaderPlatformInterface.instance.getWiFiServerPortNumber();
  }

  /// Set the WiFi protocol used.
  ///
  /// [protocol] WiFi protocol (UDP/TCP/HTTP) to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setWiFiProtocol(WiFiProtocol protocol) {
    return KdcreaderPlatformInterface.instance.setWiFiProtocol(protocol);
  }

  /// Get WiFi protocol used.
  ///
  /// Return current WiFi protocol when successful.
  Future<WiFiProtocol?> getWiFiProtocol() {
    return KdcreaderPlatformInterface.instance.getWiFiProtocol();
  }

  /// Enable SSL security feature of WiFi.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableWiFiSSL(bool enable) {
    return KdcreaderPlatformInterface.instance.enableWiFiSSL(enable);
  }

  /// Check if WiFi SSL security feature enabled.
  ///
  /// Return enabled state when successful. (true if enabled, otherwise false)
  Future<bool?> isWiFiSSLEnabled() {
    return KdcreaderPlatformInterface.instance.isWiFiSSLEnabled();
  }

  /// Set the WiFi server page.
  ///
  /// [page] A string to be set the server page.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setWiFiServerPage(String page) {
    return KdcreaderPlatformInterface.instance.setWiFiServerPage(page);
  }

  /// Get WiFi server page.
  ///
  /// Return current server page when successful.
  Future<String?> getWiFiServerPage() {
    return KdcreaderPlatformInterface.instance.getWiFiServerPage();
  }

  /// Set WiFi certification.
  ///
  /// [cert] A byte array contains the certification data to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setWiFiCertification(Uint8List cert) {
    return KdcreaderPlatformInterface.instance.setWiFiCertification(cert);
  }

  /// Get WiFi certification data.
  ///
  /// Return a byte array contains the current certification data when successful.
  Future<Uint8List?> getWiFiCertification() {
    return KdcreaderPlatformInterface.instance.getWiFiCertification();
  }

  /// Set the AP SSID.
  ///
  /// [ssid] A string representing AP SSID.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setWiFiApSSID(String ssid) {
    return KdcreaderPlatformInterface.instance.setWiFiApSSID(ssid);
  }

  /// Get SSID of AP.
  ///
  /// Return current AP SSID when successful.
  Future<String?> getWiFiApSSID() {
    return KdcreaderPlatformInterface.instance.getWiFiApSSID();
  }

  /// Set the AP Passcode.
  ///
  /// [passcode] AP passcode to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setWiFiApPasscode(String passcode) {
    return KdcreaderPlatformInterface.instance.setWiFiApPasscode(passcode);
  }

  /// Get the passcode of AP.
  ///
  /// Return a string representing current AP passcode when successful.
  Future<String?> getWiFiApPasscode() {
    return KdcreaderPlatformInterface.instance.getWiFiApPasscode();
  }

  //
  // NFC APIs
  //

  /// Check if NFC module installed in the device used.
  ///
  /// Return installed state when successful. (true if installed, otherwise false)
  Future<bool?> isNFCInstalled() {
    return KdcreaderPlatformInterface.instance.isNFCInstalled();
  }

  /// Enable or Disable current status of NFC power.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableNFCPower(bool enable) {
    return KdcreaderPlatformInterface.instance.enableNFCPower(enable);
  }

  /// Check if NFC power is enabled.
  ///
  /// Return enable state when successful. (true if enabled, otherwise false)
  Future<bool?> isNFCPowerEnabled() {
    return KdcreaderPlatformInterface.instance.isNFCPowerEnabled();
  }

  /// Set current status of NFC data format.
  ///
  /// [format] NFC data format to be set
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setNFCDataFormat(NFCDataFormat format) {
    return KdcreaderPlatformInterface.instance.setNFCDataFormat(format);
  }

  /// Get current status of NFC data format.
  ///
  /// Return NFC data format when successful.
  Future<NFCDataFormat?> getNFCDataFormat() {
    return KdcreaderPlatformInterface.instance.getNFCDataFormat();
  }

  /// Enable NFC UID Only.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableNFCUIDOnly(bool enable) {
    return KdcreaderPlatformInterface.instance.enableNFCUIDOnly(enable);
  }

  /// Check if NFC UID Only is enabled.
  ///
  /// Return enabled state when successful. (true if enabled, otherwise false)
  Future<bool?> isNFCUIDOnlyEnabled() {
    return KdcreaderPlatformInterface.instance.isNFCUIDOnlyEnabled();
  }

  /// Enable NFC Extended Format to follow Barcode transmission format.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableNFCExtendedFormat(bool enable) {
    return KdcreaderPlatformInterface.instance.enableNFCExtendedFormat(enable);
  }

  /// Check if NFC extended foramt enabled.
  ///
  /// Return enabled state when successful. (true if enabled, otherwise false)
  Future<bool?> isNFCExtendedFormatEnabled() {
    return KdcreaderPlatformInterface.instance.isNFCExtendedFormatEnabled();
  }

  //
  // MSR APIs
  //

  /// Enable or disable KDC MSR Error Beep.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<bool?> enableMSRErrorBeep(bool enable) {
    return KdcreaderPlatformInterface.instance.enableMSRErrorBeep(enable);
  }

  /// Check if MSR Error beep is enabled.
  ///
  /// Return enabled state when successful. (true if enabled, otherwise false)
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<bool?> isMSRErrorBeepEnabled() {
    return KdcreaderPlatformInterface.instance.isMSRErrorBeepEnabled();
  }

  /// Enable to attach MSR Start/End Sentinel.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableMSRSentinel(bool enable) {
    return KdcreaderPlatformInterface.instance.enableMSRSentinel(enable);
  }

  /// Check if attaching MSR Start/End Sentinel is enabled.
  ///
  /// Return enabled state when successful. (true if enabled, otherwise false)
  Future<bool?> isMSRSentinelEnabled() {
    return KdcreaderPlatformInterface.instance.isMSRSentinelEnabled();
  }

  /// Get MSR Card type.
  ///
  /// Return MSR card type when successful.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<MSRCardType?> getMSRCardType() {
    return KdcreaderPlatformInterface.instance.getMSRCardType();
  }

  /// Set MSR card type.
  ///
  /// [type] MSR card type to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setMSRCardType(MSRCardType type) {
    return KdcreaderPlatformInterface.instance.setMSRCardType(type);
  }

  /// Get MSR Data Type.
  ///
  /// Return MSR data type when successful.
  Future<MSRDataType?> getMSRDataType() {
    return KdcreaderPlatformInterface.instance.getMSRDataType();
  }

  /// Set MSR Data Type.
  ///
  /// [type] MSR data type to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setMSRDataType(MSRDataType type) {
    return KdcreaderPlatformInterface.instance.setMSRDataType(type);
  }

  /// Get MSR Data Encrypt Mode.
  ///
  /// Return MSR encrypt mode when successful.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<MSRDataEncryption?> getMSRDataEncryption() {
    return KdcreaderPlatformInterface.instance.getMSRDataEncryption();
  }

  /// Set MSR Data Encrypt Mode.
  ///
  /// [encryption] MSR data encrypt mode.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<bool?> setMSRDataEncryption(MSRDataEncryption encryption) {
    return KdcreaderPlatformInterface.instance.setMSRDataEncryption(encryption);
  }

  /// Get current MSR track separator type.
  ///
  /// Return MSR track separator type when successful.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<MSRTrackSeparator?> getMSRTrackSeparator() {
    return KdcreaderPlatformInterface.instance.getMSRTrackSeparator();
  }

  /// Set MSR track separator type.
  ///
  /// [separator] MSR track separator type to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<bool?> setMSRTrackSeparator(MSRTrackSeparator separator) {
    return KdcreaderPlatformInterface.instance.setMSRTrackSeparator(separator);
  }

  /// Get current MSR Track Selection.
  ///
  /// Bit ORing (0x01 - track1 selected, 0x02 - track2 selected, 0x04 - track3 selected)
  ///
  /// Return MSR track selection when successful.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<int?> getMSRTrackSelection() {
    return KdcreaderPlatformInterface.instance.getMSRTrackSelection();
  }

  /// Set MSR Track Selection.
  ///
  /// Bit ORing (0x01 - track1 selected, 0x02 - track2 selected, 0x04 - track3 selected)
  ///
  /// [selection] Bit mask for MSR Track selection
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<bool?> setMSRTrackSelection(int selection) {
    return KdcreaderPlatformInterface.instance.setMSRTrackSelection(selection);
  }

  /// Get Start Position of MSR Partial Data.
  ///
  /// Return start position of MSR Partial Data when successful. [0, 255]
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<int?> getPartialDataMSRStartPosition() {
    return KdcreaderPlatformInterface.instance.getPartialDataMSRStartPosition();
  }

  /// Set Start Position of MSR Partial Data.
  ///
  /// [position] Start Position of MSR Partial Data. [0, 255] "0" means no partial data option is enabled.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<bool?> setPartialDataMSRStartPosition(int position) {
    return KdcreaderPlatformInterface.instance
        .setPartialDataMSRStartPosition(position);
  }

  /// Get length of MSR Partial Data.
  ///
  /// Return partial data length of MSR Data when successful. [0, 255]
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<int?> getPartialDataMSRLength() {
    return KdcreaderPlatformInterface.instance.getPartialDataMSRLength();
  }

  /// Set Length of MSR Partial Data.
  ///
  /// [length] Partial data length of MSR Data. [0, 255] "0" means no partial data option is enabled.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<bool?> setPartialDataMSRLength(int length) {
    return KdcreaderPlatformInterface.instance.setPartialDataMSRLength(length);
  }

  /// Get MSR Partial Data Action Flag.
  ///
  /// Return MSR Partial Data Action Flag when successful.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<PartialDataAction?> getPartialDataMSRAction() {
    return KdcreaderPlatformInterface.instance.getPartialDataMSRAction();
  }

  /// Set MSR Partial Data Action Flag.
  ///
  /// [action] MSR Partial Data Action Flag.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This command is only applicable to models that support the MSR or MSRIC feature.
  Future<bool?> setPartialDataMSRAction(PartialDataAction action) {
    return KdcreaderPlatformInterface.instance.setPartialDataMSRAction(action);
  }

  //
  // MSRIC APIs
  //

  /// Check if MSRIC module is attached.
  ///
  /// Return MSRIC module attached state when successful. (true if attached, otherwise false)
  Future<bool?> isMSRICModuleAttached() {
    return KdcreaderPlatformInterface.instance.isMSRICModuleAttached();
  }

  /// Send IC APDU message.
  ///
  /// [message] APDU message as hex string (0, 514], maximum 257 bytes.
  ///
  /// Return Response data as hex string when successful.
  ///
  /// <b>Note</b> This command is only applicable when an IC card is inserted in models that support MSRIC feature.
  Future<String?> sendMSRICData(String message) {
    return KdcreaderPlatformInterface.instance.sendMSRICData(message);
  }

  //
  // UHF APIs
  //

  /// Check if UHF module is attached.
  ///
  /// Return UHF module attached state when successful. (true if attached, otherwise false)
  Future<bool?> isUHFModuleAttached() {
    return KdcreaderPlatformInterface.instance.isUHFModuleAttached();
  }

  /// Determine whether UHF module power enabled or not.
  ///
  /// Return enable state when successful. (true if enabled, otherwise false)
  Future<bool?> isUHFPowerEnabled() {
    return KdcreaderPlatformInterface.instance.isUHFPowerEnabled();
  }

  /// Enable UHF module power.
  ///
  /// [enable] true if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableUHFPower(bool enable) {
    return KdcreaderPlatformInterface.instance.enableUHFPower(enable);
  }

  /// Get UHF power level except the KDC which supports low power level.
  ///
  /// Return current power level when successful.
  ///
  /// <b>Note</br> 0.5W maximum power level is LEVEL9(27dBm), 1.0w is LEVEL12(30dBm)
  Future<UHFPowerLevel?> getUHFPowerLevel() {
    return KdcreaderPlatformInterface.instance.getUHFPowerLevel();
  }

  /// Set UHF power level except the KDC which supports low power level.
  ///
  /// [level] UHF power level to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</br> 0.5W maximum power level is LEVEL9(27dBm), 1.0w is LEVEL12(30dBm)

  Future<bool?> setUHFPowerLevel(UHFPowerLevel level) {
    return KdcreaderPlatformInterface.instance.setUHFPowerLevel(level);
  }

  /// Get UHF read mode.
  ///
  /// Return current UHF read mode when successful.
  Future<UHFReadMode?> getUHFReadMode() {
    return KdcreaderPlatformInterface.instance.getUHFReadMode();
  }

  /// Set UHF read mode.
  ///
  /// [mode] UHF read mode to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setUHFReadMode(UHFReadMode mode) {
    return KdcreaderPlatformInterface.instance.setUHFReadMode(mode);
  }

  /// Get UHF read tag mode.
  ///
  /// Return current UHF read tag mode when successful.
  Future<UHFReadTagMode?> getUHFReadTagMode() {
    return KdcreaderPlatformInterface.instance.getUHFReadTagMode();
  }

  /// Set UHF read tag mode.
  ///
  /// [mode] UHF read tag mode to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setUHFReadTagMode(UHFReadTagMode mode) {
    return KdcreaderPlatformInterface.instance.setUHFReadTagMode(mode);
  }

  /// Get UHF data type.
  ///
  /// Return current UHF data type when successful.
  Future<UHFDataType?> getUHFDataType() {
    return KdcreaderPlatformInterface.instance.getUHFDataType();
  }

  /// Set UHF data type.
  ///
  /// [type] UHF data type to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setUHFDataType(UHFDataType type) {
    return KdcreaderPlatformInterface.instance.setUHFDataType(type);
  }

  /// Get UHF data format.
  ///
  /// Return current UHF data format when successful.
  Future<UHFDataFormat?> getUHFDataFormat() {
    return KdcreaderPlatformInterface.instance.getUHFDataFormat();
  }

  /// Set UHF data format.
  ///
  /// [format] UHF data format to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setUHFDataFormat(UHFDataFormat format) {
    return KdcreaderPlatformInterface.instance.setUHFDataFormat(format);
  }

  /// Check if UHF Duplicate Check enabled.
  ///
  /// Return enable state when successful. (true if enabled, otherwise false)
  Future<bool?> isUHFDuplicateCheckEnabled() {
    return KdcreaderPlatformInterface.instance.isUHFDuplicateCheckEnabled();
  }

  /// Enable UHF Duplicate Check.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> enableUHFDuplicateCheck(bool enable) {
    return KdcreaderPlatformInterface.instance.enableUHFDuplicateCheck(enable);
  }

  /// Check if UHF Burst Mode feature is enabled.
  ///
  /// Return enable state when successful. (true if enabled, otherwise false)
  Future<bool?> isUHFBurstModeEnabled() {
    return KdcreaderPlatformInterface.instance.isUHFBurstModeEnabled();
  }

  /// Enable UHF Burst Mode.
  ///
  /// If enabled, received several tags at once[data type - UHF_LIST] and
  /// UHF_START, UHF_STOP key event feature is enabled regardless of enable status.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> This value Return to the default after rebooting the KDC device.
  Future<bool?> enableUHFBurstMode(bool enable) {
    return KdcreaderPlatformInterface.instance.enableUHFBurstMode(enable);
  }

  /// Check if UHF Key Event feature is enabled.
  ///
  /// Return enable state when successful. (true if enabled, otherwise false)
  Future<bool?> isUHFKeyEventEnabled() {
    return KdcreaderPlatformInterface.instance.isUHFKeyEventEnabled();
  }

  /// Enable UHF Key Event.
  ///
  /// If enabled, UHF_START and UHF_STOP key event will be sent before UHF read start and stop.
  ///
  /// [enable] True if enable, otherwise false.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <b>Note</b> The range of supported values is depended on attached UHF module.
  Future<bool?> enableUHFKeyEvent(bool enable) {
    return KdcreaderPlatformInterface.instance.enableUHFKeyEvent(enable);
  }

  /// Request to stop UHF reading process.
  ///
  /// If UHF key event is enabled and stops successfully, UHF_STOP event will be received.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> cancelUHFReading() {
    return KdcreaderPlatformInterface.instance.cancelUHFReading();
  }

  /// Get UHF Module Type
  ///
  /// Return current attached UHF module type when successful.
  Future<UHFModuleType?> getUHFModuleType() {
    return KdcreaderPlatformInterface.instance.getUHFModuleType();
  }

  /// Get UHF power level for the KDC which supports low power level feature.
  ///
  /// Return current power level as integer when successful.
  Future<int?> getUHFPowerLevelEx() {
    return KdcreaderPlatformInterface.instance.getUHFPowerLevelEx();
  }

  /// Set UHF power level for the KDC which supports low power level feature.
  ///
  /// [level] UHF power level to be set as integer.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  ///
  /// <pre><b>Note</b> The range of supported values is depended on attached UHF module.
  /// 0.5W - [18, 27] dBm
  /// 1.0W - [18, 30] dBm
  /// 0.5W Low Power supported - [0, 27] dBm
  /// 1.0W Low Power supported - [0, 30] dBm </pre>

  Future<bool?> setUHFPowerLevelEx(int level) {
    return KdcreaderPlatformInterface.instance.setUHFPowerLevelEx(level);
  }

  /// Get UHF Power Timeout.
  ///
  /// Return current power timeout value in minutes when successful.
  Future<int?> getUHFPowerTimeout() {
    return KdcreaderPlatformInterface.instance.getUHFPowerTimeout();
  }

  /// Set UHF Power Timeout.
  ///
  /// [timeout] UHF timeout to be set in minutes. [0, 255].
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setUHFPowerTimeout(int timeout) {
    return KdcreaderPlatformInterface.instance.setUHFPowerTimeout(timeout);
  }

  /// Get current UHF auto reading timeout.
  ///
  /// Return reading timeout value in milliseconds when successful.
  Future<int?> getUHFReadingTimeout() {
    return KdcreaderPlatformInterface.instance.getUHFReadingTimeout();
  }

  /// Set the timeout for UHF auto reading timeout.(ms)
  ///
  /// [timeout] UHF timeout to be set in milliseconds. [0 , 65535].
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> setUHFReadingTimeout(int timeout) {
    return KdcreaderPlatformInterface.instance.setUHFReadingTimeout(timeout);
  }

  ///  Get UHF region.
  ///
  /// Return current UHF region when successful.
  Future<UHFRegion?> getUHFRegion() {
    return KdcreaderPlatformInterface.instance.getUHFRegion();
  }

  /// Get UHF Tag List.
  ///
  /// [timeout] Timeout value in milliseconds. [0, 25500].
  ///
  /// Return EPC tag data list to be found when successful.
  Future<List<String>?> getUHFTagList(int timeout) {
    return KdcreaderPlatformInterface.instance.getUHFTagList(timeout);
  }

  /// Select UHF Tag.
  ///
  /// [epc] EPC tag data to be selected as word unit.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> selectUHFTag(String epc) {
    return KdcreaderPlatformInterface.instance.selectUHFTag(epc);
  }

  /// Read UHF Tag Memory in word(2bytes) units.
  ///
  /// [pwd] Access password as hexadecimal string<br>
  /// [bank] Memory bank to read<br>
  /// [start] Start address in word<br>
  /// [length] Length of data in word
  ///
  /// Return tag data as hex string when successful.
  Future<String?> readUHFTagMemory(String pwd,
      {required UHFMemoryBank bank, required int start, required int length}) {
    return KdcreaderPlatformInterface.instance
        .readUHFTagMemory(pwd, bank, start, length);
  }

  /// Write UHF Tag Memory in word(2bytes) units.
  ///
  /// [pwd] Access password as hexadecimal string<br>
  /// [bank] Memory bank to read<br>
  /// [start] Start address in word<br>
  /// [length] Length of data in word<br>
  /// [data] Data to be written (hex string)
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> writeUHFTagMemory(String pwd,
      {required UHFMemoryBank bank,
      required int start,
      required int length,
      required String data}) {
    return KdcreaderPlatformInterface.instance
        .writeUHFTagMemory(pwd, bank, start, length, data);
  }

  /// Set UHF Tag Lock.
  ///
  /// [pwd] Access password as hex string.<br>
  /// [mask] Bitmask for lock mask and action to be set. Refer to [UHFConst]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> setUHFTagLock(String pwd, {required int mask}) {
    return KdcreaderPlatformInterface.instance.setUHFTagLock(pwd, mask);
  }

  /// Kill UHF Tag.
  ///
  /// [pwd] Kill password as hex string.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> killUHFTag(String pwd) {
    return KdcreaderPlatformInterface.instance.killUHFTag(pwd);
  }

  /// Set UHF Tag Untraceable.
  ///
  /// [xpc] XPC_W1 control. 0:deassert 1:assert U flag(Untraceable indicator)<br>
  /// [epc] EPC control. 0-4 bit(5 LSBs): new EPC length[0,31], 5bit: show(0)/hide(1), 6-7bit: reserved.<br>
  /// [tid] TID control. hide none(0), hide some(1), hide all(2)<br>
  /// [user] User control. view(0), hide(1)<br>
  /// [range] Range control. normal(0), toggle temporarily(1), reduced(2)<br>
  /// [pwd] Access password as hexadecimal string
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> setUHFUntraceable(int xpc,
      {required int epc,
      required int tid,
      required int user,
      required int range,
      required String pwd}) {
    return KdcreaderPlatformInterface.instance
        .setUHFUntraceable(xpc, epc, tid, user, range, pwd);
  }

  /// Set 18000-6C air interface protocol command 'Select' parameters.
  ///
  /// Parameters are 1 byte binary or 2 bytes hex string which is depended on data format of status.
  ///
  /// [target] Select target : S0(0), S1(1), S2(2), S3(3), SL(4)
  /// [action] Select action [0,7] Refer to ISO18000-6C
  /// [bank] Memory bank : RFU(0), EPC(1), TID(2), User(3)
  /// [pointer] A starting bit address for the Mask comparison
  /// [length] Mask bits length of binary data [0,255]
  /// [maskData] Mask value as hex string (Max 64bytes hex string - 32bytes as binary data)
  /// [truncated] Enable (1) and Disable (0)
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> setUHFSelectParameter(int target,
      {required int action,
      required UHFMemoryBank bank,
      required int pointer,
      required int length,
      required String maskData,
      required bool truncated}) {
    return KdcreaderPlatformInterface.instance.setUHFSelectParameter(
        target, action, bank, pointer, length, maskData, truncated);
  }

  /// Get 18000-6C air interface protocol command 'Select' parameters.
  ///
  /// Return UHF select parameter when successful.
  Future<UHFSelectParameter?> getUHFSelectParameter() {
    return KdcreaderPlatformInterface.instance.getUHFSelectParameter();
  }

  /// Set 18000-6C air interface protocol command 'Query' parameters.
  ///
  /// Parameters are 1 byte binary or 2 bytes hex string which is depended on data format of status.
  ///
  /// [dr] TRcal divide ratio, sets the T=&gt;R link frequency. DR = 8(0) DR = 64 / 3(1)<br>
  /// [cycle] Cycles per symbol, sets the T=&gt;R data rate and modulation format. M1(0), M2(1), M4(2), M8(3)<br>
  /// [tRext] Whether a tag prepends the T=&gt;R preamble with a pilot tone. No pilot tone(0), Use pilot tone(1)<br>
  /// [sel] Which Tags respond to the Query. ALL(0,1), ~SL(2), SL(3)<br>
  /// [session] A session for the inventory round. S0(0), S1(1), S2(2), S3(3)<br>
  /// [target] Whether Tags whose inventoried flag is A or B participate in the inventory round. A(0), B(1)<br>
  /// [slotNum] The number of slots in the round. Q-parameter [0, 15]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> setUHFQueryParameter(int dr,
      {required int cycle,
      required int tRext,
      required int sel,
      required int session,
      required int target,
      required int slotNum}) {
    return KdcreaderPlatformInterface.instance
        .setUHFQueryParameter(dr, cycle, tRext, sel, session, target, slotNum);
  }

  /// Get 18000-6C air interface protocol command 'Query' parameters.
  ///
  /// Return UHF query parameter when successful.
  Future<UHFQueryParameter?> getUHFQueryParameter() {
    return KdcreaderPlatformInterface.instance.getUHFQueryParameter();
  }

  /// Authenticate UHF Tag.
  ///
  /// [senRep] Whether a tag backscatters its response or stores the response in its ResponseBuffer. Store(0), Send(1)<br>
  /// [incRepLen] Wheter a tag omits or includes length in its reply. Omit length(0), Incldue length(1)<br>
  /// [csi] The cryptographic suite that tag and interrogator use for the authentication. AES(0)<br>
  /// [length] The message length in bits<br>
  /// [message] The message includes parameters for the authentication (hex string)
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  Future<bool?> authenticateUHFTag(int senRep,
      {required int incRepLen,
      required int csi,
      required int length,
      required String message}) {
    return KdcreaderPlatformInterface.instance
        .authenticateUHFTag(senRep, incRepLen, csi, length, message);
  }

  //
  // USB Perimission APIs
  //

  /// Check if USB access is allowed.
  ///
  /// [device] The KDC device to be checked.
  ///
  /// Return true if the application has USB access permission, otherwise false.
  ///
  /// <b>Note</b> This is only supported on Android devices.
  Future<bool?> checkUsbPermission(KDCDevice device) {
    return KdcreaderPlatformInterface.instance.checkUsbPermission(device);
  }

  /// Request USB access permission.
  ///
  /// [device] The KDC device to be requested.
  ///
  /// Return true if USB access is granted, otherwise false.
  ///
  /// <b>Note</b> This is only supported on Android devices.
  Future<bool?> requestUsbPermission(KDCDevice device) {
    return KdcreaderPlatformInterface.instance.requestUsbPermission(device);
  }

  //
  // mPOS(KDC500) APIs
  //

  // KDC500 Barcode/NFC Methods

  /// Make the device scan barcode.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> softwareTriggerPos() {
    return KdcreaderPlatformInterface.instance.softwareTriggerPos();
  }

  /// Enable KDC to read NFC card(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> enableNFCPos() {
    return KdcreaderPlatformInterface.instance.enableNFCPos();
  }

  /// Disable KDC from reading NFC card(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> disableNFCPos() {
    return KdcreaderPlatformInterface.instance.disableNFCPos();
  }

  // KDC500 MS/IC Transaction Methods

  /// Enable KDC to read MS card(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> enableMSRPos() {
    return KdcreaderPlatformInterface.instance.enableMSRPos();
  }

  /// Disable KDC from reading MS card(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> disableMSRPos() {
    return KdcreaderPlatformInterface.instance.disableMSRPos();
  }

  /// Enable KDC to read target card(s).
  ///
  /// After KDC accepts this method, KPOSDataReceived listener is called for informing the result.
  ///
  /// [target] The type of card(s).
  /// Bit ORing can be used for selecting multiple targets.
  /// [KPOSConst.CARD_TYPE_MAGNETIC] and/or [KPOSConst.CARD_TYPE_EMV_CONTACT]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> enableCardReaderPos(int target) {
    return KdcreaderPlatformInterface.instance.enableCardReaderPos(target);
  }

  /// Disable KDC from reading target card(s).
  ///
  /// [target] The type of card(s).
  /// Bit ORing can be used for selecting multiple targets.
  /// [KPOSConst.CARD_TYPE_MAGNETIC] and/or [[KPOSConst.CARD_TYPE_EMV_CONTACT]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> disableCardReaderPos(int target) {
    return KdcreaderPlatformInterface.instance.disableCardReaderPos(target);
  }

  /// Make KDC accept target card(s).
  ///
  /// After KDC accepts this method, KPOSDataReceived listener is called for informing the result.
  ///
  /// [target] The type of card(s).
  /// Bit ORing can be used for selecting multiple targets.
  /// [KPOSConst.CARD_TYPE_MAGNETIC], [KPOSConst.CARD_TYPE_EMV_CONTACT], [KPOSConst.CARD_TYPE_EMV_CONTACTLESS]<br>
  /// [timeout] timeout in second(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> readCardPos(int target, {required int timeout}) {
    return KdcreaderPlatformInterface.instance.readCardPos(target, timeout);
  }

  /// Make KDC stop accepting target card(s).
  ///
  /// [target] The type of card(s).
  /// Bit ORing can be used for selecting multiple targets.
  /// [KPOSConst.MAGNETIC_STRIPE], [KPOSConst.EMV_CONTACT], [KPOSConst.EMV_CONTACTLESS].
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> cancelReadCardPos(int target) {
    return KdcreaderPlatformInterface.instance.cancelReadCardPos(target);
  }

  /// Select Application.
  ///
  /// [aid] Application ID
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> selectEMVApplicationPos(int aid) {
    return KdcreaderPlatformInterface.instance.selectEMVApplicationPos(aid);
  }

  /// Initiate EMV transaction.
  ///
  /// [pinBlockFormat] PIN block format. Format 0(0), Format1(1), Format3(3).
  ///  PINBLOCK_XX in [KPOSConst]<br>
  /// [maxDigit] Maximum number of PIN digits to accept. 4 &lt;= maxDigit &lt;= 12<br>
  /// [transType] Transcaction type. MV_TRANS_XX in [KPOSConst]<br>
  /// [amount] Amount<br>
  /// [otherAmount] Ohter amount<br>
  /// [operation] Additional operation. EMV_ADDITIONAL_XX in [KPOSConst]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> initiateEMVTransactionPos(int pinBlockFormat,
      {required int maxDigit,
      required int transType,
      required int amount,
      required int otherAmount,
      required int operation}) {
    return KdcreaderPlatformInterface.instance.initiateEMVTransactionPos(
        pinBlockFormat, maxDigit, transType, amount, otherAmount, operation);
  }

  /// Select Application and Initiate EMV transaction
  ///
  /// [pinBlockFormat] PIN block format. Format 0(0), Format1(1), Format3(3).
  ///  PINBLOCK_XX in [KPOSConst]<br>
  /// [maxDigit] Maximum number of PIN digits to accept. 4 &lt;= maxDigit &lt;= 12<br>
  /// [aid] Application id<br>
  /// [transType] Transaction type. MV_TRANS_XX in [KPOSConst]<br>
  /// [amount] Amount<br>
  /// [otherAmount] Ohter amount<br>
  /// [operation] Additional operation. EMV_ADDITIONAL_XX in [KPOSConst]<br>
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> selectApplicationAndInitiateEMVTransactionPos(
      int pinBlockFormat,
      {required int maxDigit,
      required int aid,
      required int transType,
      required int amount,
      required int otherAmount,
      required int operation}) {
    return KdcreaderPlatformInterface.instance
        .selectApplicationAndInitiateEMVTransactionPos(pinBlockFormat, maxDigit,
            aid, transType, amount, otherAmount, operation);
  }

  /// Send the reply for the EMV transaction request.
  ///
  /// [tlvs] EMV Tag list data(TLV - byte array) received from Payment processor
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> replyEMVTransactionPos(Uint8List tlvs) {
    return KdcreaderPlatformInterface.instance.replyEMVTransactionPos(tlvs);
  }

  /// Makes KDC500 accept PIN Entry.
  ///
  /// After KDC accepts this method, KPOSDataReceived listener is called for informing the result.
  ///
  /// [pan] Primary account number in the card data<br>
  /// [pinBlockFormat] PIN block format. Format 0(0), Format1(1), Format3(3).
  ///  PINBLOCK_XX in [KPOSConst]<br>
  /// [maxDigit] Maximum number of PIN digits to accept. 4 &lt;= maxDigit &lt;= 12<br>
  /// [timeout] Timeout in second(s)
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> enterPINPos(String pan,
      {required int pinBlockFormat,
      required int maxDigit,
      required int timeout}) {
    return KdcreaderPlatformInterface.instance
        .enterPINPos(pan, pinBlockFormat, maxDigit, timeout);
  }

  /// Make KDC stop accepting PIN Entry
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> cancelEnterPINPos() {
    return KdcreaderPlatformInterface.instance.cancelEnterPINPos();
  }

  // KDC500 Configuration Methods

  /// Get the KDC device status.
  ///
  /// Return the current device status.
  /// The validity of the member variables is depended on the called API.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<KPOSResult?> getDeviceStatusPos() {
    return KdcreaderPlatformInterface.instance.getDeviceStatusPos();
  }

  /// Set Beep sound configuration
  ///
  /// [keyVolume] Volume for the key pressed event.
  ///  [KPOSConst.KEYTONE_NONE], [KPOSConst.KEYTONE_LOW],
  ///  [KPOSConst.KEYTONE_MEDIUM], [KPOSConst.KEYTONE_HIGH]<br>
  /// [beepVolume] Volume for PowerOn, Barcode, Connection event.
  ///  [KPOSConst.BEEP_VOLUME_LOW], [KPOSConst.BEEP_VOLUME_HIGH]<br>
  /// [beepSound] Overall flag for the beep sound.
  /// If this value is true, the beep is enabled or disabled according to the value below.
  /// Otherwise, there is no beep sound no matter the value of them.<br>
  /// [beepPowerOn] Enable or disable a beep sound for the device power on event<br>
  /// [beepBarcode] Enable or disable a beep sound for barcode scan even<br>
  /// [beepConnection] Enable or disable a beep sound for the Bluetooth or USB connection event
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> setBeepSoundPos(int keyVolume,
      {required int beepVolume,
      required bool beepSound,
      required bool beepPowerOn,
      required bool beepBarcode,
      required bool beepConnection}) {
    return KdcreaderPlatformInterface.instance.setBeepSoundPos(keyVolume,
        beepVolume, beepSound, beepPowerOn, beepBarcode, beepConnection);
  }

  /// Get Beep sound configuration.
  ///
  /// Return The current beep sound configuration.
  /// The validity of the member variables is depended on the called API.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<KPOSResult?> getBeepSoundPos() {
    return KdcreaderPlatformInterface.instance.getBeepSoundPos();
  }

  /// Make the device enter to the FN/Menu mode using keypad input or not.
  ///
  /// [enable] True for enable keypad FN/Menu key, false for disable keypad FN/Menu key.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> setKeypadMenuEntryPos(bool enable) {
    return KdcreaderPlatformInterface.instance.setKeypadMenuEntryPos(enable);
  }

  /// Set date and time of KDC500 to the same as the host device.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> syncDateTimePos() {
    return KdcreaderPlatformInterface.instance.syncDateTimePos();
  }

  /// Get date and time.
  ///
  /// Return the current date and time. The validity of the member variables is depended on the called API.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<KPOSResult?> getDateTimePos() {
    return KdcreaderPlatformInterface.instance.getDateTimePos();
  }

  /// Enable KDC to make BATTERY LOW event when its battery gauge reaches to the specified value.
  ///
  /// [interval] Interval in second(s). [1, 3600]<br>
  /// [level] Battery level [1, 100]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> enableBatteryAlarmPos(int interval, {required int level}) {
    return KdcreaderPlatformInterface.instance
        .enableBatteryAlarmPos(interval, level);
  }

  /// Disable KDC from making BATTERY LOW event.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> disableBatteryAlarmPos() {
    return KdcreaderPlatformInterface.instance.disableBatteryAlarmPos();
  }

  // KDC500 Other Methods

  /// Enable KDC to read data from target modules - MSR/Barcode/NFC/Keypad.
  ///
  /// [titleId] Pre-defined title string id TITLE_XX in [KPOSConst].<br>
  /// [target] The type of input modules. Bit ORing can be used for selecting mulitple targets.
  ///  [KPOSConst.READ_DATA_MSR], [KPOSConst.READ_DATA_NFC],
  ///  [KPOSConst.READ_DATA_NUMERIC_KEYPAD], [KPOSConst.READ_DATA_ALPHANUMERIC_KEYPAD].<br>
  /// [timeout] Timeout in second(s).<br>
  /// [maxDigit] Maximum digits for Keypad input. 1 &lt;= maxDigit &lt;= 26.<br>
  /// [mask] Enable or disable masking for the typed data via Keypad.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> readDataPos(int titleId,
      {required int target,
      required int timeout,
      required int maxDigit,
      required bool mask}) {
    return KdcreaderPlatformInterface.instance
        .readDataPos(titleId, target, timeout, maxDigit, mask);
  }

  /// Cancel the readDataPos command.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> cancelReadDataPos() {
    return KdcreaderPlatformInterface.instance.cancelReadDataPos();
  }

  /// Make the device generate the beep sound and blink LED for the specified count.
  ///
  /// [count] Count for the beep and blink. [1, 5]
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> findMyKDCPos(int count) {
    return KdcreaderPlatformInterface.instance.findMyKDCPos(count);
  }

  /// Set Display Message.
  ///
  /// [line1] Message to be displayed in the first line of the screen.
  /// [line2] Message to be displayed in the second line of the screen.
  /// [line3] Message to be displayed in the third line of the screen.
  /// [line4] Message to be displayed in the forth line of the screen.
  /// [timeout] Timeout in second(s). 0 for no timeout.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> setDisplayMessagePos(String? line1,
      {String? line2, String? line3, String? line4, required int timeout}) {
    return KdcreaderPlatformInterface.instance
        .setDisplayMessagePos(line1, line2, line3, line4, timeout);
  }

  /// Clear KDC Display.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> clearDisplayPos() {
    return KdcreaderPlatformInterface.instance.clearDisplayPos();
  }

  /// Enable KDC to accept the keypad input and display the key value on the display.
  ///
  /// [line] Screen line number where the pressed key values are displayed 1 &lt;= line &lt;=4.<br>
  /// [maxDigit] Maximum digits for keypad input. 1 &lt;= maxDigit &lt;= 13.<br>
  /// [clear] If this flag is true, KDC automatically clears the screen when ENTER or CANCEL key is pressed.<br>
  /// [mask] Enable or disable masking for the typed data via Keypad.<br>
  /// [timeout] Timeout in second(s). 0 for no timeout
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> enableKeypadPos(int line,
      {required int maxDigit,
      required bool clear,
      required bool mask,
      required int timeout}) {
    return KdcreaderPlatformInterface.instance
        .enableKeypadPos(line, maxDigit, clear, mask, timeout);
  }

  /// Enable KDC to raise the key pressed event.
  ///
  /// The pressed key value is not displayed on the screen.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> enableKeypadEventOnlyPos() {
    return KdcreaderPlatformInterface.instance.enableKeypadEventOnlyPos();
  }

  /// Disable KDC from accepting Keypad input.
  ///
  /// [clear] If this flag is true, KDC clears the current screen.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> disableKeypadPos(bool clear) {
    return KdcreaderPlatformInterface.instance.disableKeypadPos(clear);
  }

  /// Read an EMV Contactless card.
  ///
  /// [pinBlockFormat] PIN block format. Format 0(0), Format1(1), Format3(3).
  ///  PINBLOCK_XX in [KPOSConst]<br>
  /// [maxDigit] Maximum number of PIN digits to accept. 4 &lt;= maxDigit &lt;= 12.<br>
  /// [transType] Transaction type<br>
  /// [amount] Amount<br>
  /// [otherAmount] Other amount<br>
  /// [online] [KPOSConst.EMV_CL_ONLINE_PIN_DISABLED], [KPOSConst.EVM_CL_ONLINE_PIN_ENABLED]
  ///  or [KPOSConst.EMV_CL_ONLINE_PIN_NOTUSED]<br>
  /// [timeout] Timeout in second(s). 0 for no timeout.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> readEmvCLCardPos(int pinBlockFormat,
      {required int maxDigit,
      required int transType,
      required int amount,
      required int otherAmount,
      required int online,
      required int timeout}) {
    return KdcreaderPlatformInterface.instance.readEmvCLCardPos(pinBlockFormat,
        maxDigit, transType, amount, otherAmount, online, timeout);
  }

  /// Stop EMV Contactless transaction.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> stopEmvCLTransactionPos() {
    return KdcreaderPlatformInterface.instance.stopEmvCLTransactionPos();
  }

  /// Get supported locales by connected KDC device
  ///
  /// Return The supported locales. [KPOSLocale] The validity of the member variables is depended on the called API.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<KPOSResult?> getSupportedLocalesPos() {
    return KdcreaderPlatformInterface.instance.getSupportedLocalesPos();
  }

  /// Display message in the specified locale and alignment.
  ///
  /// [line1] Message to be displayed in the first line of the screen.<br>
  /// [line2] Message to be displayed in the second line of the screen.<br>
  /// [line3] Message to be displayed in the third line of the screen.<br>
  /// [line4] Message to be displayed in the fourth line of the screen.<br>
  /// [locale] Message locale.<br>
  /// [timeout] Timeout in second(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> setDisplayMessageWithLocalePos(String line1,
      {required String line2,
      required String line3,
      required String line4,
      required KPOSLocale locale,
      required int timeout}) {
    return KdcreaderPlatformInterface.instance.setDisplayMessageWithLocalePos(
        line1, line2, line3, line4, locale, timeout);
  }

  /// Display pre-defined message in the specified locale and Read keypad input.
  ///
  /// [line1] Pre-defined message ID to be displayed in the first line of the screen. KT_MSG_XX in [KPOSConst]<br>
  /// [line2] Pre-defined message ID to be displayed in the second line of the screen.<br>
  /// [line3] Pre-defined message ID to be displayed in the third line of the screen.<br>
  /// [line4] Pre-defined message ID to be displayed in the fourth line of the screen.<br>
  /// [locale] Message locale.<br>
  /// [keypadType] Keypad type numeric(0), alpha-numeric(1).
  ///  [KPOSConst.KEYPAD_TYPE_NUMERIC] , [KPOSConst.KEYPAD_TYPE_ALPHA_NUMERIC].<br>
  /// [mask] Enable displaying '*' instead of pressed key.<br>
  /// [inputLine] The line of entered key value. [1, 4].<br>
  /// [inputAlign] Alignment with entered kye value..<br>
  /// [maxDigit] Maximum digit [1, 13].<br>
  /// [timeout] Timeout in second(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> setDisplayMessageIdAndReadKeypadPos(int line1,
      {required int line2,
      required int line3,
      required int line4,
      required KPOSLocale locale,
      required int keypadType,
      required bool mask,
      required int inputLine,
      required KPOSAlign inputAlign,
      required int maxDigit,
      required int timeout}) {
    return KdcreaderPlatformInterface.instance
        .setDisplayMessageIdAndReadKeypadPos(line1, line2, line3, line4, locale,
            keypadType, mask, inputLine, inputAlign, maxDigit, timeout);
  }

  /// Display message in the specified locale and Read keypad input.
  ///
  /// <p><small><b>Note: only supported in non PCI mode </b></small>
  ///
  /// [line1] Message to be displayed in the first line of the screen.<br>
  /// [line2] Message to be displayed in the second line of the screen.<br>
  /// [line3] Message to be displayed in the third line of the screen.<br>
  /// [line4] Message to be displayed in the fourth line of the screen.<br>
  /// [locale] Message locale.<br>
  /// [keypadType] Keypad type numeric(0), alpha-numeric(1).
  ///  [KPOSConst.KEYPAD_TYPE_NUMERIC] , [KPOSConst.KEYPAD_TYPE_ALPHA_NUMERIC].<br>
  /// [mask] Enable displaying '*' instead of pressed key.<br>
  /// [inputLine] The line of entered key value. [1, 4].<br>
  /// [inputAlign] Alignment with entered kye value.<br>
  /// [maxDigit] Maximum digit [1, 13].<br>
  /// [timeout] Timeout in second(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> setDisplayMessageAndReadKeypadPos(String line1,
      {required String line2,
      required String line3,
      required String line4,
      required KPOSLocale locale,
      required int keypadType,
      required bool mask,
      required int inputLine,
      required KPOSAlign inputAlign,
      required int maxDigit,
      required int timeout}) {
    return KdcreaderPlatformInterface.instance
        .setDisplayMessageAndReadKeypadPos(line1, line2, line3, line4, locale,
            keypadType, mask, inputLine, inputAlign, maxDigit, timeout);
  }

  /// Display message in the specified locale and alignment and enable item selection.
  ///
  /// [line1] Message to be displayed in the first line of the screen.<br>
  /// [line2] Message to be displayed in the second line of the screen.<br>
  /// [line3] Message to be displayed in the third line of the screen.<br>
  /// [locale] Message locale.<br>
  /// [firstItemLine] The line of the first item [1, 4].<br>
  /// [items] Item array. The size of item array should be [1, 8].<br>
  /// [timeout] Timeout in second(s).
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> setDisplayMessageAndSelectItemPos(String line1,
      {required String line2,
      required String line3,
      required KPOSLocale locale,
      required int firstItemLine,
      required List<String> items,
      required int timeout}) {
    return KdcreaderPlatformInterface.instance
        .setDisplayMessageAndSelectItemPos(
            line1, line2, line3, locale, firstItemLine, items, timeout);
  }

  /// Clear Display and Cancel Keypad input
  ///
  /// Return 'true' if command is done succesfully, otherwise failed. opCode is from native SDK.
  ///
  /// <b>Note</b> This command is only applicable to KDC500 series.
  Future<bool?> clearDisplayAndCancelKeypadPos() {
    return KdcreaderPlatformInterface.instance.clearDisplayAndCancelKeypadPos();
  }

  //
  // Software Decoder APIs
  //

  /// Check if software decoder is activated.
  ///
  /// Return 'true' if activated, otherwise false.
  Future<bool?> isSoftwareDecoderActivated() {
    return KdcreaderPlatformInterface.instance.isSoftwareDecoderActivated();
  }

  /// Activate software decoder.
  ///
  /// [license] License key.
  ///
  /// Return the result of software decoder activation [KDCSWDecoderActivationResult].
  Future<KDCSWDecoderActivationResult?> activateSoftwareDecoder(
      String license) {
    return KdcreaderPlatformInterface.instance.activateSoftwareDecoder(license);
  }

  /// Set the period to check the validity of activation code for software decoder.
  ///
  /// [period] Period as day unit.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setSoftwareDecoderActivationPeriod(int period) {
    return KdcreaderPlatformInterface.instance
        .setSoftwareDecoderActivationPeriod(period);
  }

  /// Get current Software decoder setting.
  ///
  /// Return current software decoder setting [KDCSWDecoderSetting].
  Future<KDCSWDecoderSetting?> getSoftwareDecoderSetting() {
    return KdcreaderPlatformInterface.instance.getSoftwareDecoderSetting();
  }

  /// Set Software decoder setting
  ///
  /// [setting] Specific software decoder setting to be set.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> setSoftwareDecoderSetting(KDCSWDecoderSetting setting) {
    return KdcreaderPlatformInterface.instance
        .setSoftwareDecoderSetting(setting);
  }

  /// Scan with new Activity that has Component Custom View.
  ///
  /// Return 'true' if command is done succesfully, otherwise failed.
  Future<bool?> startComponentScanActivity() {
    return KdcreaderPlatformInterface.instance.startComponentScanActivity();
  }

  /// Get Software decoder device id used to activate software decoder with Koamtac activation code.
  ///
  /// Return device id string when successful.
  Future<String?> getSoftwareDecoderDeviceId() {
    return KdcreaderPlatformInterface.instance.getSoftwareDecoderDeviceId();
  }

  /// Get Software decoder last image the was sent to the software decoder engine
  ///
  /// Return the last image that was sent, if successful, otherwise null.
  /// 
  /// <b>Note</b> The returned image is a PNG.
  Future<KDCSWDecoderImage?> getSoftwareDecoderLastProcessedImage() {
    return KdcreaderPlatformInterface.instance.getSoftwareDecoderLastDecodedImage();
  }

  /// Get Software decoder last image that was decoded by the software decoder engine.
  ///
  /// Return the last image that was decoded, if successful, otherwise null.
  /// 
  /// <b>Note</b> The returned image is a PNG.
  Future<KDCSWDecoderImage?> getSoftwareDecoderLastDecodedImage() {
    return KdcreaderPlatformInterface.instance.getSoftwareDecoderLastDecodedImage();
  }

  /// Get Software Decoder cropped image of the last decoded barcode.
  ///
  /// Return the cropped image, if successful, otherwise null.
  /// 
  /// <b>Note</b> The returned image is a PNG.
  Future<KDCSWDecoderImage?> getSoftwareDecoderLastBarcodeImage(KDCDataBounds bounds) {
    return KdcreaderPlatformInterface.instance.getSoftwareDecoderLastBarcodeImage(bounds);
  }
}
