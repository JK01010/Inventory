import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:kdcreader_platform_interface/src/kdc_constants.dart';
import 'package:kdcreader_platform_interface/src/kpos_constants.dart';
import 'package:kdcreader_platform_interface/src/ksw_constants.dart'; // software decoder

import 'package:kdcreader_platform_interface/src/default/kdcreader_default.dart';

abstract class KdcreaderPlatformInterface extends PlatformInterface
    implements EventChannelKdcreaderPlatformInterface {
  /// Constructs a KdcreaderPlatform.
  KdcreaderPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static KdcreaderPlatformInterface _instance = KdcreaderDefault();

  /// The default instance of [KdcreaderPlatformInterface] to use.
  ///
  /// Defaults to [KdcreaderDefault].
  static KdcreaderPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KdcreaderPlatformInterface] when
  /// they register themselves.
  static set instance(KdcreaderPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> enableAttachType(bool enable) {
    throw UnimplementedError('enableAttachType has not been implemented.');
  }

  Future<bool?> enableAttachSerialNumber(bool enable) {
    throw UnimplementedError(
        'enableAttachSerialNumber has not been implemented.');
  }

  Future<bool?> enableAttachTimestamp(bool enable) {
    throw UnimplementedError('enableAttachTimestamp has not been implemented.');
  }

  Future<bool?> setDataDelimiter(DataDelimiter delimiter) {
    throw UnimplementedError('setDataDelimiter has not been implemented.');
  }

  Future<bool?> setRecordDelimiter(RecordDelimiter delimiter) {
    throw UnimplementedError('setRecordDelimiter has not been implemented.');
  }

  Future<List<KDCDevice>?> getAvailableDeviceList(DeviceListType type,
      {dynamic options}) {
    throw UnimplementedError(
        'getAvailableDeviceList has not been implemented.');
  }

  Future<bool?> connect(KDCDevice? device) {
    throw UnimplementedError('connect has not been implemented.');
  }

  Future<bool?> disconnect() {
    throw UnimplementedError('disconnect has not been implemented.');
  }

  Future<bool?> isConnected() {
    throw UnimplementedError('isConnected has not been implemented.');
  }

  Future<bool?> startScan() {
    throw UnimplementedError('startScan has not been implemented.');
  }

  Future<bool?> stopScan() {
    throw UnimplementedError('stopScan has not been implemented.');
  }

  Future<bool?> softwareTrigger() {
    throw UnimplementedError('softwareTrigger has not been implemented.');
  }

  /*
   * Device information APIs
   */
  Future<KDCDeviceInfo?> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo has not been implemented.');
  }

  Future<KDCDevice?> getConnectedDevice() {
    throw UnimplementedError('getConnectedDevice has not been implemented.');
  }

  /*
   * Data Process APIs
   */
  Future<String?> getDataPrefix() {
    throw UnimplementedError('getDataPrefix has not been implemented.');
  }

  Future<bool?> setDataPrefix(String prefix) {
    throw UnimplementedError('setDataPrefix has not been implemented.');
  }

  Future<String?> getDataSuffix() {
    throw UnimplementedError('getDataSuffix has not been implemented.');
  }

  Future<bool?> setDataSuffix(String suffix) {
    throw UnimplementedError('setDataSuffix has not been implemented.');
  }

  Future<Map<String, bool>?> getSymbology() {
    throw UnimplementedError('getSymbology has not been implemented.');
  }

  Future<bool?> setSymbology(Map<String, bool> symbols) {
    throw UnimplementedError('setSymbology has not been implemented.');
  }

  Future<bool?> enableAllSymbology() {
    throw UnimplementedError('enableAllSymbology has not been implemented.');
  }

  Future<bool?> disableAllSymbology() {
    throw UnimplementedError('disableAllSymbology has not been implemented.');
  }

  Future<Map<String, bool>?> getBarcodeOption() {
    throw UnimplementedError('getBarcodeOption has not been implemented.');
  }

  Future<bool?> setBarcodeOption(Map<String, bool> options) {
    throw UnimplementedError('setBarcodeOption has not been implemented.');
  }

  Future<bool?> enableAllOptions() {
    throw UnimplementedError('enableAllOptions has not been implemented.');
  }

  Future<bool?> disableAllOptions() {
    throw UnimplementedError('disableAllOptions has not been implemented.');
  }

  Future<int?> getMinimumBarcodeLength() {
    throw UnimplementedError(
        'getMinimumBarcodeLength has not been implemented.');
  }

  Future<int?> setMinimumBarcodeLength(int length) {
    throw UnimplementedError(
        'setMinimumBarcodeLength has not been implemented.');
  }

  Future<int?> getNumberOfStoredBarcode() {
    throw UnimplementedError(
        'getNumberOfStoredBarcode has not been implemented.');
  }

  Future<bool?> getStoredDataSingle() {
    throw UnimplementedError('getStoredDataSingle has not been implemented.');
  }

  Future<DataProcess?> getDataProcessMode() async {
    throw UnimplementedError('getDataProcessMode has not been implemented.');
  }

  Future<bool?> setDataProcessMode(DataProcess mode) {
    throw UnimplementedError('setDataProcessMode has not been implemented.');
  }

  Future<DataFormat?> getDataFormat() async {
    throw UnimplementedError('getDataFormat has not been implemented.');
  }

  Future<bool?> setDataFormat(DataFormat format) {
    throw UnimplementedError('setDataFormat has not been implemented.');
  }

  Future<int?> getSecurityLevel() {
    throw UnimplementedError('getSecurityLevel has not been implemented.');
  }

  Future<bool?> setSecurityLevel(int level) {
    throw UnimplementedError('setSecurityLevel has not been implemented.');
  }

  Future<bool?> enableAgeVerify(bool enable) {
    throw UnimplementedError('enableAgeVerify has not been implemented.');
  }

  Future<bool?> isAgeVerifyEnabled() {
    throw UnimplementedError('isAgeVerifyEnabled has not been implemented.');
  }

  Future<AIMIDStatus?> getAIMIDSetting() async {
    throw UnimplementedError('getAIMIDSetting has not been implemented.');
  }

  Future<bool?> setAIMIDSetting(AIMIDStatus aimid) {
    throw UnimplementedError('setAIMIDSetting has not been implemented.');
  }

  Future<int?> getPartialDataStartPosition() {
    throw UnimplementedError(
        'getPartialDataStartPosition has not been implemented.');
  }

  Future<bool?> setPartialDataStartPosition(int position) {
    throw UnimplementedError(
        'setPartialDataStartPosition has not been implemented.');
  }

  Future<bool?> getPartialDataLength() {
    throw UnimplementedError('getPartialDataLength has not been implemented.');
  }

  Future<bool?> setPartialDataLength(int length) {
    throw UnimplementedError('setPartialDataLength has not been implemented.');
  }

  Future<PartialDataAction?> getPartialDataAction() async {
    throw UnimplementedError('getPartialDataAction has not been implemented.');
  }

  Future<bool?> setPartialDataAction(PartialDataAction action) {
    throw UnimplementedError('setPartialDataAction has not been implemented.');
  }

  Future<bool?> startSynchronization() {
    throw UnimplementedError('startSynchronization has not been implemented.');
  }

  Future<bool?> finishSynchronization() {
    throw UnimplementedError('finishSynchronization has not been implemented.');
  }

  Future<DataTerminator?> getDataTerminator() async {
    throw UnimplementedError('getDataTerminator has not been implemented.');
  }

  Future<bool?> setDataTerminator(DataTerminator terminator) {
    throw UnimplementedError('setDataTerminator has not been implemented.');
  }

  /*
   * System Configuration APIs - Lock, Battery Level
   */
  Future<bool?> enableButtonLock(bool enable) {
    throw UnimplementedError('enableButtonLock has not been implemented.');
  }

  Future<bool?> enableScanButtonLock(bool enable) {
    throw UnimplementedError('enableScanButtonLock has not been implemented.');
  }

  Future<int?> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel has not been implemented.');
  }

  Future<int?> getExtendedBatteryLevel() {
    throw UnimplementedError(
        'getExtendedBatteryLevel has not been implemented.');
  }

  /*
   * System Configuration APIs - Time
   */
  Future<bool?> syncSystemTime() {
    throw UnimplementedError('syncSystemTime has not been implemented.');
  }

  Future<bool?> resetSystemTime() {
    throw UnimplementedError('resetSystemTime has not been implemented.');
  }

  Future<SleepTimeout?> getSleepTimeout() {
    throw UnimplementedError('getSleepTimeout has not been implemented.');
  }

  Future<bool?> setSleepTimeout(SleepTimeout timeout) {
    throw UnimplementedError('setSleepTimeout has not been implemented.');
  }

  Future<int?> getScanTimeout() {
    throw UnimplementedError('getScanTimeout has not been implemented.');
  }

  Future<bool?> setScanTimeout(int timeout) {
    throw UnimplementedError('setScanTimeout has not been implemented.');
  }

  /*
   * System Configuration APIs - Memory
   */
  Future<bool?> eraseMemory() {
    throw UnimplementedError('eraseMemory has not been implemented.');
  }

  Future<bool?> eraseLastData() {
    throw UnimplementedError('eraseLastData has not been implemented.');
  }

  Future<int?> getMemoryLeft() {
    throw UnimplementedError('getMemoryLeft has not been implemented.');
  }

  Future<bool?> setFactoryDefault() {
    throw UnimplementedError('setFactoryDefault has not been implemented.');
  }

  /*
   * System Configuration APIs - Beep
   */
  Future<Volume?> getBeepVolume() {
    throw UnimplementedError('getBeepVolume has not been implemented.');
  }

  Future<bool?> setBeepVolume(Volume volume) {
    throw UnimplementedError('setBeepVolume has not been implemented.');
  }

  Future<bool?> enableHighBeepVolume(bool enable) {
    throw UnimplementedError('enableHighBeepVolume has not been implemented.');
  }

  Future<bool?> isHighBeepVolumeEnabled() {
    throw UnimplementedError(
        'isHighBeepVolumeEnabled has not been implemented.');
  }

  Future<bool?> enableBeepSound(bool enable) {
    throw UnimplementedError('enableBeepSound has not been implemented.');
  }

  Future<bool?> isBeepSoundEnabled() {
    throw UnimplementedError('isBeepSoundEnabled has not been implemented.');
  }

  Future<bool?> enablePowerOnBeep(bool enable) {
    throw UnimplementedError('enablePowerOnBeep has not been implemented.');
  }

  Future<bool?> isPowerOnBeepEnabled() {
    throw UnimplementedError('isPowerOnBeepEnabled has not been implemented.');
  }

  Future<bool?> enableBeepOnScan(bool enable) {
    throw UnimplementedError('enableBeepOnScan has not been implemented.');
  }

  Future<bool?> isBeepOnScanEnabled() {
    throw UnimplementedError('isBeepOnScanEnabled has not been implemented.');
  }

  Future<bool?> enableBeepOnConnect(bool enable) {
    throw UnimplementedError('enableBeepOnConnect has not been implemented.');
  }

  Future<bool?> isBeepOnConnectEnabled() {
    throw UnimplementedError(
        'isBeepOnConnectEnabled has not been implemented.');
  }

  Future<bool?> setFailureAlertBeep() {
    throw UnimplementedError('setFailureAlertBeep has not been implemented.');
  }

  Future<bool?> setSuccessAlertBeep() {
    throw UnimplementedError('setSuccessAlertBeep has not been implemented.');
  }

  Future<bool?> setCustomBeepTone(int onTime, int offTime, int repeat) {
    throw UnimplementedError('setCustomBeepTone has not been implemented.');
  }

  /*
   * System Configuration APIs - MFi
   */
  Future<bool?> enableMFiMode(bool enable) {
    throw UnimplementedError('enableMFiMode has not been implemented.');
  }

  Future<bool?> isMFiEnabled() {
    throw UnimplementedError('isMFiEnabled has not been implemented.');
  }

  Future<bool?> isMFiAuthChipInstalled() {
    throw UnimplementedError(
        'isMFiAuthChipInstalled has not been implemented.');
  }

  /*
   * System Configuration APIs - Bluetooth
   */
  Future<bool?> enableBluetoothAutoConnect(bool enable) {
    throw UnimplementedError(
        'enableBluetoothAutoConnect has not been implemented.');
  }

  Future<bool?> isAutoConnectEnabled() {
    throw UnimplementedError('isAutoConnectEnabled has not been implemented.');
  }

  Future<bool?> enableBluetoothAutoPowerOn(bool enable) {
    throw UnimplementedError(
        'enableBluetoothAutoPowerOn has not been implemented.');
  }

  Future<bool?> isAutoPowerOnEnabled() {
    throw UnimplementedError('isAutoPowerOnEnabled has not been implemented.');
  }

  Future<bool?> enableBluetoothAutoPowerOff(bool enable) {
    throw UnimplementedError(
        'enableBluetoothAutoPowerOff has not been implemented.');
  }

  Future<bool?> isBluetoothAutoPowerOffEnabled() {
    throw UnimplementedError(
        'isBluetoothAutoPowerOffEnabled has not been implemented.');
  }

  Future<bool?> enableBluetoothBeepWarning(bool enable) {
    throw UnimplementedError(
        'enableBluetoothBeepWarning has not been implemented.');
  }

  Future<bool?> isBluetoothBeepWarningEnabled() {
    throw UnimplementedError(
        'isBluetoothBeepWarningEnabled has not been implemented.');
  }

  Future<DeviceProfile?> getDeviceProfile() {
    throw UnimplementedError('getDeviceProfile has not been implemented.');
  }

  Future<bool?> setDeviceProfile(DeviceProfile profile) {
    throw UnimplementedError('setDeviceProfile has not been implemented.');
  }

  Future<BluetoothAutoPowerOffDelay?> getBluetoothAutoPowerOffTimeout() {
    throw UnimplementedError(
        'getBluetoothAutoPowerOffTimeout has not been implemented.');
  }

  Future<bool?> setBluetoothAutoPowerOffTimeout(
      BluetoothAutoPowerOffDelay timeout) {
    throw UnimplementedError(
        'setBluetoothAutoPowerOffTimeout has not been implemented.');
  }

  Future<bool?> enableBluetoothPowerOffMessage(bool enable) {
    throw UnimplementedError(
        'enableBluetoothPowerOffMessage has not been implemented.');
  }

  Future<bool?> isPowerOffMessageEnabled() {
    throw UnimplementedError(
        'isPowerOffMessageEnabled has not been implemented.');
  }

  Future<String?> getBluetoothMACAddress() {
    throw UnimplementedError(
        'getBluetoothMACAddress has not been implemented.');
  }

  Future<BluetoothAutoPowerOnDelay?> getBluetoothAutoPowerOnDelay() {
    throw UnimplementedError(
        'getBluetoothAutoPowerOnDelay has not been implemented.');
  }

  Future<bool?> setBluetoothAutoPowerOnDelay(BluetoothAutoPowerOnDelay delay) {
    throw UnimplementedError(
        'setBluetoothAutoPowerOnDelay has not been implemented.');
  }

  Future<String?> getBluetoothFirmwareVersion() {
    throw UnimplementedError(
        'getBluetoothFirmwareVersion has not been implemented.');
  }

  Future<bool?> enableBluetoothWakeupNull(bool enable) {
    throw UnimplementedError(
        'enableBluetoothWakeupNull has not been implemented.');
  }

  Future<bool?> isWakeupNullsEnabled() {
    throw UnimplementedError('isWakeupNullsEnabled has not been implemented.');
  }

  Future<bool?> enableBluetoothToggle(bool enable) {
    throw UnimplementedError('enableBluetoothToggle has not been implemented.');
  }

  Future<bool?> isBluetoothToggleEnabled() {
    throw UnimplementedError(
        'isBluetoothToggleEnabled has not been implemented.');
  }

  Future<bool?> enableBluetoothDisconnectButton(bool enable) {
    throw UnimplementedError(
        'enableBluetoothDisconnectButton has not been implemented.');
  }

  Future<bool?> isBluetoothDisconnectButtonEnabled() {
    throw UnimplementedError(
        'isBluetoothDisconnectButtonEnabled has not been implemented.');
  }

  /*
   * System Configuration APIs - Etc.
   */
  Future<bool?> enableDuplicateCheck(bool enable) {
    throw UnimplementedError('enableDuplicateCheck has not been implemented.');
  }

  Future<bool?> isDuplicateCheckEnabled() {
    throw UnimplementedError(
        'isDuplicateCheckEnabled has not been implemented.');
  }

  Future<bool?> enableAutoErase(bool enable) {
    throw UnimplementedError('enableAutoErase has not been implemented.');
  }

  Future<bool?> isAutoEraseEnabled() {
    throw UnimplementedError('isAutoEraseEnabled has not been implemented.');
  }

  Future<bool?> enableScanIfConnected(bool enable) {
    throw UnimplementedError('enableScanIfConnected has not been implemented.');
  }

  Future<bool?> isScanIfConnectedEnabled() {
    throw UnimplementedError(
        'isScanIfConnectedEnabled has not been implemented.');
  }

  Future<RereadDelay?> getAutoTriggerRereadDelay() {
    throw UnimplementedError(
        'getAutoTriggerRereadDelay has not been implemented.');
  }

  Future<bool?> setAutoTriggerRereadDelay(RereadDelay delay) {
    throw UnimplementedError(
        'setAutoTriggerRereadDelay has not been implemented.');
  }

  Future<bool?> enableAutoTrigger(bool enable) {
    throw UnimplementedError('enableAutoTrigger has not been implemented.');
  }

  Future<bool?> isAutoTriggerEnabled() {
    throw UnimplementedError('isAutoTriggerEnabled has not been implemented.');
  }

  Future<String?> getKDCFirmwareVersion() {
    throw UnimplementedError('getKDCFirmwareVersion has not been implemented.');
  }

  Future<String?> getKDCFirmwareBuildVersion() {
    throw UnimplementedError(
        'getKDCFirmwareBuildVersion has not been implemented.');
  }

  Future<String?> getInterfaceVersion() {
    throw UnimplementedError('getInterfaceVersion has not been implemented.');
  }

  Future<String?> getPowerDeliveryVersion() {
    throw UnimplementedError(
        'getPowerDeliveryVersion has not been implemented.');
  }

  /*
   * Vibrate
   */
  Future<bool?> enableVibrator(bool enable) {
    throw UnimplementedError('enableVibrator has not been implemented.');
  }

  Future<bool?> isVibratorEnabled() {
    throw UnimplementedError('isVibratorEnabled has not been implemented.');
  }

  Future<bool?> setCustomVibration(int onTime, int offTime, int repeat) {
    throw UnimplementedError('setCustomVibration has not been implemented.');
  }

  /*
   * Display APIs
   */
  Future<bool?> enableDisplayConnectionStatus(bool enable) {
    throw UnimplementedError(
        'enableDisplayConnectionStatus has not been implemented.');
  }

  Future<bool?> isDisplayConnectionStatusEnabled() {
    throw UnimplementedError(
        'isDisplayConnectionStatusEnabled has not been implemented.');
  }

  Future<bool?> enableMenuBarcodeState(bool enable) {
    throw UnimplementedError(
        'enableMenuBarcodeState has not been implemented.');
  }

  Future<bool?> isMenuBarcodeStateEnabled() {
    throw UnimplementedError(
        'isMenuBarcodeStateEnabled has not been implemented.');
  }

  Future<bool?> enableDisplayScroll(bool enable) {
    throw UnimplementedError('enableDisplayScroll has not been implemented.');
  }

  Future<bool?> isScrollingEnabled() {
    throw UnimplementedError('isScrollingEnabled has not been implemented.');
  }

  Future<bool?> setDisplayPosition(int row, int column) {
    throw UnimplementedError('setDisplayPosition has not been implemented.');
  }

  Future<bool?> clearDisplay() {
    throw UnimplementedError('clearDisplay has not been implemented.');
  }

  Future<bool?> setDisplayMessageFontSize(MessageFontSize size) {
    throw UnimplementedError(
        'setDisplayMessageFontSize has not been implemented.');
  }

  Future<bool?> setDisplayMessageDuration(int duration) {
    throw UnimplementedError(
        'setDisplayMessageDuration has not been implemented.');
  }

  Future<bool?> setMessageTextAttribute(MessageTextAttribute attribute) {
    throw UnimplementedError(
        'setMessageTextAttribute has not been implemented.');
  }

  Future<bool?> setDisplayMessage(String message) {
    throw UnimplementedError('setDisplayMessage has not been implemented.');
  }

  Future<bool?> setDisplayMessageAndGetUserConfirm(String message) {
    throw UnimplementedError(
        'setDisplayMessageAndGetUserConfirm has not been implemented.');
  }

  Future<bool?> enableAutoMenuExit(bool enable) {
    throw UnimplementedError('enableAutoMenuExit has not been implemented.');
  }

  Future<bool?> isAutoMenuExitEnabled() {
    throw UnimplementedError('isAutoMenuExitEnabled has not been implemented.');
  }

  /*
   * Keypad APIs
   */
  Future<bool?> enableEnterKeyFunction(bool enable) {
    throw UnimplementedError(
        'enableEnterKeyFunction has not been implemented.');
  }

  Future<bool?> isEnterKeyFunctionEnabled() {
    throw UnimplementedError(
        'isEnterKeyFunctionEnabled has not been implemented.');
  }

  Future<bool?> enableExtendKeypad(bool enable) {
    throw UnimplementedError('enableExtendKeypad has not been implemented.');
  }

  Future<bool?> isExtendKeypadEnabled() {
    throw UnimplementedError('isExtendKeypadEnabled has not been implemented.');
  }

  Future<bool?> enableKeypad(bool enable) {
    throw UnimplementedError('enableKeypad has not been implemented.');
  }

  Future<bool?> isKeypadEnabled() {
    throw UnimplementedError('isKeypadEnabled has not been implemented.');
  }

  /*
   * HID APIs
   */
  Future<HIDAutoLockTime?> getHIDAutoLockTime() {
    throw UnimplementedError('getHIDAutoLockTime has not been implemented.');
  }

  Future<bool?> setHIDAutoLockTime(HIDAutoLockTime timeout) {
    throw UnimplementedError('setHIDAutoLockTime has not been implemented.');
  }

  Future<HIDKeyboard?> getHIDKeyboard() {
    throw UnimplementedError('getHIDKeyboard has not been implemented.');
  }

  Future<bool?> setHIDKeyboard(HIDKeyboard keyboard) {
    throw UnimplementedError('setHIDKeyboard has not been implemented.');
  }

  Future<HIDInitialDelay?> getHIDInitialDelay() {
    throw UnimplementedError('getHIDInitialDelay has not been implemented.');
  }

  Future<bool?> setHIDInitialDelay(HIDInitialDelay delay) {
    throw UnimplementedError('setHIDInitialDelay has not been implemented.');
  }

  Future<HIDInterDelay?> getHIDInterDelay() {
    throw UnimplementedError('getHIDInterDelay has not been implemented.');
  }

  Future<bool?> setHIDInterDelay(HIDInterDelay delay) {
    throw UnimplementedError('setHIDInterDelay has not been implemented.');
  }

  Future<HIDControlCharacter?> getHIDControlCharacter() {
    throw UnimplementedError(
        'getHIDControlCharacter has not been implemented.');
  }

  Future<bool?> setHIDControlCharacter(HIDControlCharacter character) {
    throw UnimplementedError(
        'setHIDControlCharacter has not been implemented.');
  }

  /*
   * WiFi APIs
   */
  Future<bool?> isWiFiInstalled() {
    throw UnimplementedError('isWiFiInstalled has not been implemented.');
  }

  Future<bool?> enableWiFiPower(bool enable) {
    throw UnimplementedError('enableWiFiPower has not been implemented.');
  }

  Future<bool?> isWiFiPowerEnabled() {
    throw UnimplementedError('isWiFiPowerEnabled has not been implemented.');
  }

  Future<bool?> enableWiFiAutoConnect(bool enable) {
    throw UnimplementedError('enableWiFiAutoConnect has not been implemented.');
  }

  Future<bool?> isWiFiAutoConnectEnabled() {
    throw UnimplementedError(
        'isWiFiAutoConnectEnabled has not been implemented.');
  }

  Future<bool?> setWiFiServerIPAddress(String ip) {
    throw UnimplementedError(
        'setWiFiServerIPAddress has not been implemented.');
  }

  Future<String?> getWiFiServerIPAddress() {
    throw UnimplementedError(
        'getWiFiServerIPAddress has not been implemented.');
  }

  Future<bool?> setWiFiServerURLAddress(String url) {
    throw UnimplementedError(
        'setWiFiServerURLAddress has not been implemented.');
  }

  Future<String?> getWiFiServerURLAddress() {
    throw UnimplementedError(
        'getWiFiServerURLAddress has not been implemented.');
  }

  Future<bool?> setWiFiServerPortNumber(int port) {
    throw UnimplementedError(
        'setWiFiServerPortNumber has not been implemented.');
  }

  Future<int?> getWiFiServerPortNumber() {
    throw UnimplementedError(
        'getWiFiServerPortNumber has not been implemented.');
  }

  Future<bool?> setWiFiProtocol(WiFiProtocol protocol) {
    throw UnimplementedError('setWiFiProtocol has not been implemented.');
  }

  Future<WiFiProtocol?> getWiFiProtocol() {
    throw UnimplementedError('getWiFiProtocol has not been implemented.');
  }

  Future<bool?> enableWiFiSSL(bool enable) {
    throw UnimplementedError('enableWiFiSSL has not been implemented.');
  }

  Future<bool?> isWiFiSSLEnabled() {
    throw UnimplementedError('isWiFiSSLEnabled has not been implemented.');
  }

  Future<bool?> setWiFiServerPage(String page) {
    throw UnimplementedError('setWiFiServerPage has not been implemented.');
  }

  Future<String?> getWiFiServerPage() {
    throw UnimplementedError('getWiFiServerPage has not been implemented.');
  }

  Future<bool?> setWiFiCertification(Uint8List cert) {
    throw UnimplementedError('setWiFiCertification has not been implemented.');
  }

  Future<Uint8List?> getWiFiCertification() {
    throw UnimplementedError('getWiFiCertification has not been implemented.');
  }

  Future<bool?> setWiFiApSSID(String ssid) {
    throw UnimplementedError('setWiFiApSSID has not been implemented.');
  }

  Future<String?> getWiFiApSSID() {
    throw UnimplementedError('getWiFiApSSID has not been implemented.');
  }

  Future<bool?> setWiFiApPasscode(String passcode) {
    throw UnimplementedError('setWiFiApPasscode has not been implemented.');
  }

  Future<String?> getWiFiApPasscode() {
    throw UnimplementedError('getWiFiApPasscode has not been implemented.');
  }

  /*
   * NFC APIs
   */
  Future<bool?> isNFCInstalled() {
    throw UnimplementedError('isNFCInstalled has not been implemented.');
  }

  Future<bool?> enableNFCPower(bool enable) {
    throw UnimplementedError('enableNFCPower has not been implemented.');
  }

  Future<bool?> isNFCPowerEnabled() {
    throw UnimplementedError('isNFCPowerEnabled has not been implemented.');
  }

  Future<bool?> setNFCDataFormat(NFCDataFormat format) {
    throw UnimplementedError('setNFCDataFormat has not been implemented.');
  }

  Future<NFCDataFormat?> getNFCDataFormat() {
    throw UnimplementedError('getNFCDataFormat has not been implemented.');
  }

  Future<bool?> enableNFCUIDOnly(bool enable) {
    throw UnimplementedError('enableNFCUIDOnly has not been implemented.');
  }

  Future<bool?> isNFCUIDOnlyEnabled() {
    throw UnimplementedError('isNFCUIDOnlyEnabled has not been implemented.');
  }

  Future<bool?> enableNFCExtendedFormat(bool enable) {
    throw UnimplementedError(
        'enableNFCExtendedFormat has not been implemented.');
  }

  Future<bool?> isNFCExtendedFormatEnabled() {
    throw UnimplementedError(
        'isNFCExtendedFormatEnabled has not been implemented.');
  }

  /*
   * MSR APIs
   */
  Future<bool?> enableMSRErrorBeep(bool enable) {
    throw UnimplementedError('enableMSRErrorBeep has not been implemented.');
  }

  Future<bool?> isMSRErrorBeepEnabled() {
    throw UnimplementedError('isMSRErrorBeepEnabled has not been implemented.');
  }

  Future<bool?> enableMSRSentinel(bool enable) {
    throw UnimplementedError('enableMSRSentinel has not been implemented.');
  }

  Future<bool?> isMSRSentinelEnabled() {
    throw UnimplementedError('isMSRSentinelEnabled has not been implemented.');
  }

  Future<MSRCardType?> getMSRCardType() {
    throw UnimplementedError('getMSRCardType has not been implemented.');
  }

  Future<bool?> setMSRCardType(MSRCardType type) {
    throw UnimplementedError('setMSRCardType has not been implemented.');
  }

  Future<MSRDataType?> getMSRDataType() {
    throw UnimplementedError('getMSRDataType has not been implemented.');
  }

  Future<bool?> setMSRDataType(MSRDataType type) {
    throw UnimplementedError('setMSRDataType has not been implemented.');
  }

  Future<MSRDataEncryption?> getMSRDataEncryption() {
    throw UnimplementedError('getMSRDataEncryption has not been implemented.');
  }

  Future<bool?> setMSRDataEncryption(MSRDataEncryption encryption) {
    throw UnimplementedError('setMSRDataEncryption has not been implemented.');
  }

  Future<MSRTrackSeparator?> getMSRTrackSeparator() {
    throw UnimplementedError('getMSRTrackSeparator has not been implemented.');
  }

  Future<bool?> setMSRTrackSeparator(MSRTrackSeparator separator) {
    throw UnimplementedError('setMSRTrackSeparator has not been implemented.');
  }

  Future<int?> getMSRTrackSelection() {
    throw UnimplementedError('getMSRTrackSelection has not been implemented.');
  }

  Future<bool?> setMSRTrackSelection(int selection) {
    throw UnimplementedError('setMSRTrackSelection has not been implemented.');
  }

  Future<int?> getPartialDataMSRStartPosition() {
    throw UnimplementedError(
        'getPartialDataMSRStartPosition has not been implemented.');
  }

  Future<bool?> setPartialDataMSRStartPosition(int position) {
    throw UnimplementedError(
        'setPartialDataMSRStartPosition has not been implemented.');
  }

  Future<int?> getPartialDataMSRLength() {
    throw UnimplementedError(
        'getPartialDataMSRLength has not been implemented.');
  }

  Future<bool?> setPartialDataMSRLength(int length) {
    throw UnimplementedError(
        'setPartialDataMSRLength has not been implemented.');
  }

  Future<PartialDataAction?> getPartialDataMSRAction() {
    throw UnimplementedError(
        'getPartialDataMSRAction has not been implemented.');
  }

  Future<bool?> setPartialDataMSRAction(PartialDataAction action) {
    throw UnimplementedError(
        'setPartialDataMSRAction has not been implemented.');
  }

  /*
   * MSRIC APIs
   */
  Future<bool?> isMSRICModuleAttached() {
    throw UnimplementedError('isMSRICModuleAttached has not been implemented.');
  }

  Future<String?> sendMSRICData(String message) {
    throw UnimplementedError('sendMSRICData has not been implemented.');
  }

  /*
   * UHF APIs
   */
  Future<bool?> isUHFModuleAttached() {
    throw UnimplementedError('isUHFModuleAttached has not been implemented.');
  }

  Future<bool?> isUHFPowerEnabled() {
    throw UnimplementedError('isUHFPowerEnabled has not been implemented.');
  }

  Future<bool?> enableUHFPower(bool enable) {
    throw UnimplementedError('enableUHFPower has not been implemented.');
  }

  Future<UHFPowerLevel?> getUHFPowerLevel() {
    throw UnimplementedError('getUHFPowerLevel has not been implemented.');
  }

  Future<bool?> setUHFPowerLevel(UHFPowerLevel level) {
    throw UnimplementedError('setUHFPowerLevel has not been implemented.');
  }

  Future<UHFReadMode?> getUHFReadMode() {
    throw UnimplementedError('getUHFReadMode has not been implemented.');
  }

  Future<bool?> setUHFReadMode(UHFReadMode mode) {
    throw UnimplementedError('setUHFReadMode has not been implemented.');
  }

  Future<UHFReadTagMode?> getUHFReadTagMode() {
    throw UnimplementedError('getUHFReadTagMode has not been implemented.');
  }

  Future<bool?> setUHFReadTagMode(UHFReadTagMode mode) {
    throw UnimplementedError('setUHFReadTagMode has not been implemented.');
  }

  Future<UHFDataType?> getUHFDataType() {
    throw UnimplementedError('getUHFDataType has not been implemented.');
  }

  Future<bool?> setUHFDataType(UHFDataType type) {
    throw UnimplementedError('setUHFDataType has not been implemented.');
  }

  Future<UHFDataFormat?> getUHFDataFormat() {
    throw UnimplementedError('getUHFDataFormat has not been implemented.');
  }

  Future<bool?> setUHFDataFormat(UHFDataFormat format) {
    throw UnimplementedError('setUHFDataFormat has not been implemented.');
  }

  Future<bool?> isUHFDuplicateCheckEnabled() {
    throw UnimplementedError(
        'isUHFDuplicateCheckEnabled has not been implemented.');
  }

  Future<bool?> enableUHFDuplicateCheck(bool enable) {
    throw UnimplementedError(
        'enableUHFDuplicateCheck has not been implemented.');
  }

  Future<bool?> isUHFBurstModeEnabled() {
    throw UnimplementedError('isUHFBurstModeEnabled has not been implemented.');
  }

  Future<bool?> enableUHFBurstMode(bool enable) {
    throw UnimplementedError('enableUHFBurstMode has not been implemented.');
  }

  Future<bool?> isUHFKeyEventEnabled() {
    throw UnimplementedError('isUHFKeyEventEnabled has not been implemented.');
  }

  Future<bool?> enableUHFKeyEvent(bool enable) {
    throw UnimplementedError('enableUHFKeyEvent has not been implemented.');
  }

  Future<bool?> cancelUHFReading() {
    throw UnimplementedError('cancelUHFReading has not been implemented.');
  }

  Future<UHFModuleType?> getUHFModuleType() {
    throw UnimplementedError('getUHFModuleType has not been implemented.');
  }

  Future<int?> getUHFPowerLevelEx() {
    throw UnimplementedError('getUHFPowerLevelEx has not been implemented.');
  }

  Future<bool?> setUHFPowerLevelEx(int level) {
    throw UnimplementedError('setUHFPowerLevelEx has not been implemented.');
  }

  Future<int?> getUHFPowerTimeout() {
    throw UnimplementedError('getUHFPowerTimeout has not been implemented.');
  }

  Future<bool?> setUHFPowerTimeout(int timeout) {
    throw UnimplementedError('setUHFPowerTimeout has not been implemented.');
  }

  Future<int?> getUHFReadingTimeout() {
    throw UnimplementedError('getUHFReadingTimeout has not been implemented.');
  }

  Future<bool?> setUHFReadingTimeout(int timeout) {
    throw UnimplementedError('setUHFReadingTimeout has not been implemented.');
  }

  Future<UHFRegion?> getUHFRegion() {
    throw UnimplementedError('getUHFRegion has not been implemented.');
  }

  Future<List<String>?> getUHFTagList(int timeout) {
    throw UnimplementedError('getUHFTagList has not been implemented.');
  }

  Future<bool?> selectUHFTag(String epc) {
    throw UnimplementedError('selectUHFTag has not been implemented.');
  }

  Future<String?> readUHFTagMemory(
      String pwd, UHFMemoryBank bank, int start, int length) {
    throw UnimplementedError('readUHFTagMemory has not been implemented.');
  }

  Future<bool?> writeUHFTagMemory(
      String pwd, UHFMemoryBank bank, int start, int length, String data) {
    throw UnimplementedError('writeUHFTagMemory has not been implemented.');
  }

  Future<bool?> setUHFTagLock(String pwd, int mask) {
    throw UnimplementedError('setUHFTagLock has not been implemented.');
  }

  Future<bool?> killUHFTag(String pwd) {
    throw UnimplementedError('killUHFTag has not been implemented.');
  }

  Future<bool?> setUHFUntraceable(
      int xpc, int epc, int tid, int user, int range, String pwd) {
    throw UnimplementedError('setUHFUntraceable has not been implemented.');
  }

  Future<bool?> setUHFSelectParameter(
      int target,
      int action,
      UHFMemoryBank bank,
      int pointer,
      int length,
      String maskData,
      bool truncated) {
    throw UnimplementedError('setUHFSelectParameter has not been implemented.');
  }

  Future<UHFSelectParameter?> getUHFSelectParameter() {
    throw UnimplementedError('getUHFSelectParameter has not been implemented.');
  }

  Future<bool?> setUHFQueryParameter(int dr, int cycle, int tRext, int sel,
      int session, int target, int slotNum) {
    throw UnimplementedError('setUHFQueryParameter has not been implemented.');
  }

  Future<UHFQueryParameter?> getUHFQueryParameter() {
    throw UnimplementedError('getUHFQueryParameter has not been implemented.');
  }

  Future<bool?> authenticateUHFTag(
      int senRep, int incRepLen, int csi, int length, String message) {
    throw UnimplementedError('authenticateUHFTag has not been implemented.');
  }

  /*
   * USB Perimission APIs
   */
  Future<bool?> checkUsbPermission(KDCDevice device) {
    throw UnimplementedError('checkUsbPermission has not been implemented.');
  }

  Future<bool?> requestUsbPermission(KDCDevice device) {
    throw UnimplementedError('requestUsbPermission has not been implemented.');
  }

  /*
   * mPOS(KDC500) APIs
   */
  /* KDC500 Barcode/NFC Methods */
  Future<bool?> softwareTriggerPos() {
    throw UnimplementedError('softwareTriggerPos has not been implemented.');
  }

  Future<bool?> enableNFCPos() {
    throw UnimplementedError('enableNFCPos has not been implemented.');
  }

  Future<bool?> disableNFCPos() {
    throw UnimplementedError('disableNFCPos has not been implemented.');
  }

  /* KDC500 MS/IC Transaction Methods */
  Future<bool?> enableMSRPos() {
    throw UnimplementedError('enableMSRPos has not been implemented.');
  }

  Future<bool?> disableMSRPos() {
    throw UnimplementedError('disableMSRPos has not been implemented.');
  }

  Future<bool?> enableCardReaderPos(int target) {
    throw UnimplementedError('enableCardReaderPos has not been implemented.');
  }

  Future<bool?> disableCardReaderPos(int target) {
    throw UnimplementedError('disableCardReaderPos has not been implemented.');
  }

  Future<bool?> readCardPos(int target, int timeout) {
    throw UnimplementedError('readCardPos has not been implemented.');
  }

  Future<bool?> cancelReadCardPos(int target) {
    throw UnimplementedError('cancelReadCardPos has not been implemented.');
  }

  Future<bool?> selectEMVApplicationPos(int aid) {
    throw UnimplementedError(
        'selectEMVApplicationPos has not been implemented.');
  }

  Future<bool?> initiateEMVTransactionPos(int pinBlockFormat, int timeout,
      int transType, int maxDigit, int otherAmount, int operation) {
    throw UnimplementedError(
        'initiateEMVTransactionPos has not been implemented.');
  }

  Future<bool?> selectApplicationAndInitiateEMVTransactionPos(
      int pinBlockFormat,
      int maxDigit,
      int aid,
      int transType,
      int amount,
      int otherAmount,
      int operation) {
    throw UnimplementedError(
        'selectApplicationAndInitiateEMVTransactionPos has not been implemented.');
  }

  Future<bool?> replyEMVTransactionPos(Uint8List tlvs) {
    throw UnimplementedError(
        'replyEMVTransactionPos has not been implemented.');
  }

  Future<bool?> enterPINPos(
      String pan, int pinBlockFormat, int maxDigit, int timeout) {
    throw UnimplementedError('enterPINPos has not been implemented.');
  }

  Future<bool?> cancelEnterPINPos() {
    throw UnimplementedError('cancelEnterPINPos has not been implemented.');
  }

  /* KDC500 Configuration Methods */
  Future<KPOSResult?> getDeviceStatusPos() {
    throw UnimplementedError('getDeviceStatusPos has not been implemented.');
  }

  Future<bool?> setBeepSoundPos(int keyVolume, int beepVolume, bool beepSound,
      bool beepPowerOn, bool beepBarcode, bool beepConnection) {
    throw UnimplementedError('setBeepSoundPos has not been implemented.');
  }

  Future<KPOSResult?> getBeepSoundPos() {
    throw UnimplementedError('getBeepSoundPos has not been implemented.');
  }

  Future<bool?> setKeypadMenuEntryPos(bool enable) {
    throw UnimplementedError('setKeypadMenuEntryPos has not been implemented.');
  }

  Future<bool?> syncDateTimePos() {
    throw UnimplementedError('syncDateTimePos has not been implemented.');
  }

  Future<KPOSResult?> getDateTimePos() {
    throw UnimplementedError('getDateTimePos has not been implemented.');
  }

  Future<bool?> enableBatteryAlarmPos(int interval, int level) {
    throw UnimplementedError('enableBatteryAlarmPos has not been implemented.');
  }

  Future<bool?> disableBatteryAlarmPos() {
    throw UnimplementedError(
        'disableBatteryAlarmPos has not been implemented.');
  }

  /* KDC500 Other Methods */
  Future<bool?> readDataPos(
      int titleId, int target, int timeout, int maxDigit, bool mask) {
    throw UnimplementedError('readDataPos has not been implemented.');
  }

  Future<bool?> cancelReadDataPos() {
    throw UnimplementedError('cancelReadDataPos has not been implemented.');
  }

  Future<bool?> findMyKDCPos(int count) {
    throw UnimplementedError('findMyKDCPos has not been implemented.');
  }

  Future<bool?> setDisplayMessagePos(
      String? line1, String? line2, String? line3, String? line4, int timeout) {
    throw UnimplementedError('setDisplayMessagePos has not been implemented.');
  }

  Future<bool?> clearDisplayPos() {
    throw UnimplementedError('clearDisplayPos has not been implemented.');
  }

  Future<bool?> enableKeypadPos(
      int line, int maxDigit, bool clear, bool mask, int timeout) {
    throw UnimplementedError('enableKeypadPos has not been implemented.');
  }

  Future<bool?> enableKeypadEventOnlyPos() {
    throw UnimplementedError(
        'enableKeypadEventOnlyPos has not been implemented.');
  }

  Future<bool?> disableKeypadPos(bool clear) {
    throw UnimplementedError('disableKeypadPos has not been implemented.');
  }

  Future<bool?> readEmvCLCardPos(int pinBlockFormat, int maxDigit,
      int transType, int amount, int otherAmount, int online, int timeout) {
    throw UnimplementedError('readEmvCLCardPos has not been implemented.');
  }

  Future<bool?> stopEmvCLTransactionPos() {
    throw UnimplementedError(
        'stopEmvCLTransactionPos has not been implemented.');
  }

  Future<KPOSResult?> getSupportedLocalesPos() {
    throw UnimplementedError(
        'getSupportedLocalesPos has not been implemented.');
  }

  Future<bool?> setDisplayMessageWithLocalePos(String line1, String line2,
      String line3, String line4, KPOSLocale locale, int timeout) {
    throw UnimplementedError(
        'setDisplayMessageWithLocalePos has not been implemented.');
  }

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
    throw UnimplementedError(
        'setDisplayMessageIdAndReadKeypadPos has not been implemented.');
  }

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
    throw UnimplementedError(
        'setDisplayMessageAndReadKeypadPos has not been implemented.');
  }

  Future<bool?> setDisplayMessageAndSelectItemPos(
      String line1,
      String line2,
      String line3,
      KPOSLocale locale,
      int firstItemLine,
      List<String> items,
      int timeout) {
    throw UnimplementedError(
        'setDisplayMessageAndSelectItemPos has not been implemented.');
  }

  Future<bool?> clearDisplayAndCancelKeypadPos() {
    throw UnimplementedError(
        'clearDisplayAndCancelKeypadPos has not been implemented.');
  }

  /*
   * Software Decoder APIs
   */
  Future<bool?> isSoftwareDecoderActivated() {
    throw UnimplementedError(
        'isSoftwareDecoderActivated has not been implemented.');
  }

  Future<KDCSWDecoderActivationResult?> activateSoftwareDecoder(
      String license) {
    throw UnimplementedError(
        'activateSoftwareDecoder has not been implemented.');
  }

  Future<bool?> setSoftwareDecoderActivationPeriod(int period) {
    throw UnimplementedError(
        'setSoftwareDecoderActivationPeriod has not been implemented.');
  }

  Future<KDCSWDecoderSetting?> getSoftwareDecoderSetting() {
    throw UnimplementedError(
        'getSoftwareDecoderSetting has not been implemented.');
  }

  Future<bool?> setSoftwareDecoderSetting(KDCSWDecoderSetting setting) {
    throw UnimplementedError(
        'setSoftwareDecoderSetting has not been implemented.');
  }

  Future<bool?> startComponentScanActivity() {
    throw UnimplementedError(
        'startComponentScanActivity has not been implemented.');
  }

  Future<String?> getSoftwareDecoderDeviceId() {
    throw UnimplementedError(
        'getSoftwareDecoderDeviceId has not been implemented.');
  }

  Future<KDCSWDecoderImage?> getSoftwareDecoderLastProcessedImage() {
    throw UnimplementedError(
        'getSoftwareDecoderLastProcessedImage has not been implemented.');
  }

  Future<KDCSWDecoderImage?> getSoftwareDecoderLastDecodedImage() {
    throw UnimplementedError(
        'getSoftwareDecoderLastDecodedImage has not been implemented.');
  }

  Future<KDCSWDecoderImage?> getSoftwareDecoderLastBarcodeImage(KDCDataBounds bounds) {
    throw UnimplementedError(
        'getSoftwareDecoderLastBarcodeImage has not been implemented.');
  }
}

abstract class EventChannelKdcreaderPlatformInterface {
  Stream<ConnectionEvent> getConnectionStateStream();

  Stream<KDCData> getBarcodeDataStream();
  Stream<KDCData> getNfcDataStream();
  Stream<KDCData> getMsrDataStream();
  Stream<KDCData> getGeneralDataStream();

  Stream<KPOSData> getPosDataStream();

  Stream<ErrorEvent> getErrorStream();

  Stream<KDCDevice> getDeviceScannedStream();
  Stream<ScanFailEvent> getDeviceScanFailedrStream();

  Stream<KDCDevice> getUsbAttachedStream();
  Stream<KDCDevice> getUsbDetachedStream();

  Stream<InfoEvent> getInfoUpdatedStream();

  Stream<List<KDCData>> getSwBarcodeDataStream();  
}
