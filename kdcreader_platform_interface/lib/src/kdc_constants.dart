import 'package:flutter/foundation.dart';

import 'package:kdcreader_platform_interface/src/type_conversion.dart';

/// Type(Category) for Unknown device.
const DeviceTypeUnknown = "UNKNOWN";

/// Type(Category) for Bluetooth.
const DeviceTypeBluetooth = "BLUETOOTH";

/// Type(Category) for USB.
const DeviceTypeUsb = "USB";

/// Type(Category) for Software decoder.
const DeviceTypeSoftware = "SOFTWARE"; // software decoder

/// Subtype for Unknown device.
const DeviceSubTypeUnknown = "UNKNOWN";

/// Subtype for Bluetooth Classic.
const DeviceSubTypeClassic = "CLASSIC";

/// Subtype for BLE.
const DeviceSubTypeBle = "SMART";

/// Subtype for USB OTG.
const DeviceSubTypeUsb = "USBDEVICE";

/// Subtype for Software decoder.
const DeviceSubTypeSoftware = "SWDECODER"; // software decoder

/// Indicates the connection state
enum ConnectState {
  /// Initial state or disconnected.
  /// There is no communication with the KDC device.
  None(0),

  /// Bluetooth Classic Listen.
  /// KDCReader is waiting for a KDC device to make a connection
  Listen(1),

  /// Connecting.
  /// KDCReader is initiating a connection to the KDC device
  Connecting(2),

  /// Connection is established and initializing KDCReader is done.
  /// The KDC device are connected and have two way communication established and the KDCReader is ready.
  Connected(3),

  /// Connection is lost.
  /// The connection between the KDCReader and the KDC device has been broken and is no longer working.
  Lost(4),

  /// Connection is failed.
  /// KDCReader and the KDC device failed to establish a connection.
  Failed(5),

  /// KDCReader is initializing.
  /// Connection established physically and KDCReader is preparing to communicate with remote KDC Device.
  ///
  /// <b>Note</b> It is possible to use KDCReader after initialization is done.
  Initializing(7),

  /// Initializing KDCReader is failed.
  /// Connection established successfully but initializing KDCReader is failed.
  ///
  /// <b>Note</b> The connection will be disconnected.
  InitializingFailed(8);

  final value;
  const ConnectState(this.value);
}

/// Device List Type
enum DeviceListType {
  /// Blutooth paired devices
  /// <b>Note</b> It is only supported on Android.
  BONDED_BLUETOOTH_LIST,

  /// Blutooth paired devices
  /// <b>Note</b> It is only supported on Android.
  ATTACHED_USB_LIST,

  /// BLE devices discovered so far.
  SCANNED_BLUETOOTH_LIST,

  /// Accessories connected to the system
  /// <b>Note</b> It is only supported on iOS.
  EXTERNAL_ACCESSORY_LIST,

  /// BLE devices connected to the system
  /// <b>Note</b> It is only supported on iOS.
  CONNECTED_PERIPHERAL_LIST,

  /// BLE devices known to the system.
  /// Retrieve using their identifiers.
  /// <b>Note</b> It is only supported on Android.
  KNOWN_PERIPHERAL_LIST,

  /// Software decoder.
  SOFTWARE_DECODER_LIST,
}

/// Data Type
enum DataType {
  UNKNOWN(0),
  BARCODE(1),
  MSR(2),
  NFC(3),
  GPS(4),
  KEY_EVENT(5),
  UHF_LIST(6),
  POS_MSR(7),
  POS_PINBLOCK(8),
  POS_EMV(9),
  APP_DATA(10);

  final value;
  const DataType(this.value);
}

/// Data Delimiters.
/// It is appended when creating record data in SDK.
enum DataDelimiter {
  NONE,
  TAB,
  SPACE,
  COMMA,
  SEMICOLON,
}

/// Record Delimiters.
/// It is appended when creating record data in SDK.
enum RecordDelimiter {
  NONE,
  LF,
  CR,
  TAB,
  CRnLF,
}

/// Data Process Type
enum DataProcess {
  /// Scanned data is transmitted to the host. The KDC does not store scanned data.
  WEDGE_ONLY,

  /// Scanned data is stored in the KDC and transmitted to the host.
  WEDGE_STROE_ALWAYS,

  /// Scanned data is stored in the KDC but NOT transmitted to the host.
  STROE_ONLY,

  /// Scanned data is stored in the KDC ONLY if transmission to the host is successful.
  STORE_IF_SENT,

  /// Scanned data is stored in the KDC ONLY if transmission to the host is unsuccessful.
  STORE_IF_NOT_SENT,
}

/// Data Format.
enum DataFormat {
  BARCODE_ONLY,
  PACKET_DATA,
}

/// AIM ID statuses
enum AIMIDStatus {
  NONE,
  PREFIX,
  SUFFIX,
}

enum PartialDataAction {
  ERASE,
  SELECT,
}

/// Data Terminator
enum DataTerminator {
  NONE,
  CR,
  LF,
  CRLF,
  TAB,
  RIGHT_ARROW,
  LEFT_ARROW,
  DOWN_ARROW,
  UP_ARROW,
}

/// Sleep Timeout
enum SleepTimeout {
  DISABLED(0),
  SECOND_1(1),
  SECOND_2(2),
  SECOND_3(3),
  SECOND_4(4),
  SECOND_5(5),
  SECOND_10(10),
  SECOND_20(20),
  SECOND_30(30),
  MINUTE_1(60),
  MINUTE_2(120),
  MINUTE_5(300),
  MINUTE_10(600);

  final value;

  const SleepTimeout(this.value);
}

enum Volume {
  NONE,
  LOW,
  HIGH,
}

enum DeviceProfile {
  SPP,
  HID_IOS,
  IPHONE,
  SPP2_0,
  HID_NORMAL,
}

enum BluetoothAutoPowerOnDelay {
  DISABLED,
  SECOND_1,
  SECOND_2,
  SECOND_3,
  SECOND_4,
  SECOND_5,
  SECOND_6,
  SECOND_7,
  SECOND_8,
  SECOND_9,
  SECOND_10,
}

enum BluetoothAutoPowerOffDelay {
  MINUTE_1(1),
  MINUTE_2(2),
  MINUTE_3(3),
  MINUTE_4(4),
  MINUTE_5(5),
  MINUTE_6(6),
  MINUTE_7(7),
  MINUTE_8(8),
  MINUTE_9(9),
  MINUTE_10(10),

  MINUTE_11(11),
  MINUTE_12(12),
  MINUTE_13(13),
  MINUTE_14(14),
  MINUTE_15(15),
  MINUTE_16(16),
  MINUTE_17(17),
  MINUTE_18(18),
  MINUTE_19(19),
  MINUTE_20(20),

  MINUTE_21(21),
  MINUTE_22(22),
  MINUTE_23(23),
  MINUTE_24(24),
  MINUTE_25(25),
  MINUTE_26(26),
  MINUTE_27(27),
  MINUTE_28(28),
  MINUTE_29(29),
  MINUTE_30(30);

  final value;

  const BluetoothAutoPowerOffDelay(this.value);
}

enum RereadDelay {
  CONTINUOUS,
  SHORT,
  MEDIUM,
  LONG,
  EXTRA_LONG,
}

enum MessageTextAttribute {
  NORMAL_TEXT,
  REVERSE_TEXT,
}

enum MessageFontSize {
  FONT8X8,
  FONT10X16,
  FONT16X16,
  FONT16X24,
  FONT16X32,
  FONT24X24,
  FONT24X32,
  FONT32X32,
}

enum NFCDataFormat {
  PACKET,
  DATA_ONLY,
}

enum NFCTagType {
  NDEF_TYPE1,
  NDEF_TYPE2,
  RFID,
  CALYPSO,
  MIFARE_4K,
  TYPE_A,
  TYPE_B,
  FELICA,
  JEWEL,
  MIFARE_1K,
  MIFARE_UL_C,
  MIFARE_UL,
  MIFARE_DESFIRE,
  ISO15693,
  UNDEFINED,
}

enum HIDAutoLockTime {
  DISABLED(0),
  MINUTE_1(1),
  MINUTE_2(2),
  MINUTE_3(3),
  MINUTE_4(4),
  MINUTE_5(5),
  MINUTE_10(10),
  MINUTE_15(15);

  final value;

  const HIDAutoLockTime(this.value);
}

enum HIDKeyboard {
  ENGLISH,
  GERMAN,
  FRENCH,
  ITALIAN,
  SPANISH,
  JAPANESE,
  DANISH,
}

enum HIDInitialDelay {
  DISABLED(0),
  SECOND_1(1),
  SECOND_2(2),
  SECOND_3(3),
  SECOND_5(5),
  SECOND_10(10);

  final value;

  const HIDInitialDelay(this.value);
}

enum HIDInterDelay {
  DISABLED(0),
  MSECS_10(10),
  MSECS_20(20),
  MSECS_30(30),
  MSECS_50(50),
  MSECS_100(100);

  final value;

  const HIDInterDelay(this.value);
}

enum HIDControlCharacter {
  DISABLE,
  ALT_NUMPAD,
  CNTL_CHAR,
  REPLACE_TO_PIPE,
}

enum WiFiProtocol {
  UDP,
  TCP,
  HTTP_GET,
  HTTP_POST,
}

//const MSRTrack1 = 1;
//const MSRTrack2 = 2;
//const MSRTrack3 = 4;

enum MSRCardType {
  ISO,
  OTHER_1,
  AAMVA,
}

enum MSRDataType {
  PAYLOAD,
  PACKET,
}

enum MSRDataEncryption {
  NONE,
  AES,
}

enum MSRTrack {
  TRACK1,
  TRACK2,
  TRACK3,
}

enum MSRTrackSeparator {
  NONE,
  SPACE,
  COMMA,
  SEMICOLON,
  CR,
  LF,
  CRLF,
  TAB,
}

enum UHFReadMode {
  NFC_RFID,
  BARCODE,
}

enum UHFReadTagMode {
  SINGLE,
  MULTIPLE,
  ACTIVE,
}

enum UHFPowerTime {
  DISABLE,
  TIME_500MS,
  TIME_1000MS,
  TIME_1500MS,
  TIME_2000MS,
  TIME_2500MS,
  TIME_3000MS,
  TIME_3500MS,
  TIME_4000MS,
  TIME_4500MS,
  TIME_5000MS,
}

enum UHFPowerLevel {
  LEVEL0(18),
  LEVEL1(19),
  LEVEL2(20),
  LEVEL3(21),
  LEVEL4(22),
  LEVEL5(23),
  LEVEL6(24),
  LEVEL7(25),
  LEVEL8(26),
  LEVEL9(27),
  LEVEL10(28),
  LEVEL11(29),
  LEVEL12(30);

  final value;

  const UHFPowerLevel(this.value);
}

// UHF Data Format
enum UHFDataFormat {
  BINARY,
  HEX_DECIMAL,
}

/// UHF Data Type
enum UHFDataType {
  /// EPC Only
  EPC,

  /// PC and EPC
  PC_EPC,

  /// RSSI and EPC
  RSSI_EPC,

  /// RSSI, PC and EPC
  RSSI_PC_EPC,

  /// TID Only
  TID,

  /// EPC and TID
  EPC_TID,

  /// PC, EPC and TID
  PC_EPC_TID,
}

/// UHF Memory Bank
enum UHFMemoryBank {
  RFU,
  EPC,
  TID,
  USER,
}

/// UHF Region
enum UHFRegion {
  US(1),
  KR(2),
  JP(3),
  EU(4);

  final value;

  const UHFRegion(this.value);
}

/// UHF Module Type
enum UHFModuleType {
  /// Detached
  MODULE_DETACHED,

  /// Supported power level is [18, 27] dBm
  MODULE_0_5W_TYPE1,

  /// Supported power level is [18, 30] dBm
  MODULE_1_0W_TYPE1,

  /// Supported power level is [18, 30] dBm
  MODULE_1_0W_TYPE2,

  /// Supported power level is [0, 27] dBm
  MODULE_0_5W_TYPE2,

  /// Supported power level is [0, 30] dBm
  MODULE_1_0W_TYPE3,

  /// Supported power level is [0, 30] dBm
  MODULE_1_0W_TYPE4,
}

/// This object represents kdc device and it is wrapper class to provide common object regardless of connection method.
class KDCDevice {
  KDCDevice(this.deviceName,
      {this.type, this.subType, this.kdcName, this.identifier});

  /// Remote device name to distinguish.
  String deviceName;

  /// Connection main type.
  String? type;

  /// Connection sub type.
  String? subType;

  /// KDC name of remote device.
  String? kdcName;

  /// Identifier for BLE peripheral.
  ///
  /// This is only available on iOS devices.
  String? identifier;

  static KDCDevice fromMap(Map<String, dynamic> map) {
    return KDCDevice(
      map['deviceName'] ?? "",
      type: map['type'] as String?,
      subType: map['subType'] as String?,
      kdcName: map['kdcName'] as String?,
      identifier: map['identifier'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceName': deviceName,
      'type': type,
      'subType': subType,
      'kdcName': kdcName,
      'identifier': identifier,
    };
  }
}

/// This object contained connected KDC device information.
///
/// This information is availabe after connection is established.
/// Supported features is listed up based on serial number.
class KDCDeviceInfo {
  KDCDeviceInfo._(this.name,
      {required this.firmware,
      required this.serial,
      required this.isFlash,
      required this.isBluetooth,
      required this.is2D,
      required this.isMSR,
      required this.isNFC,
      required this.isGPS,
      required this.isUHF,
      required this.isWiFi,
      required this.isKeypad,
      required this.isVibrator,
      required this.isDisplay,
      required this.isPassportReader,
      required this.isFingerPrint,
      required this.isMSRIC,
      this.isSocialDistance,
      this.isOCR,
      this.isMRZ,
      this.isSLED,
      required this.isNA,
      required this.isPOS});

  /// KDC device name or series name.
  String name;

  /// KDC firmware version.
  String firmware;

  /// KDC serial number.
  String serial;

  /// Check if flash is supported.
  bool isFlash;

  /// Check if bluetooth is supported.
  bool isBluetooth;

  /// Check if 2D is supported.
  bool is2D;

  /// Check if MSR is supported.
  bool isMSR;

  /// Check if NFC is supported.
  bool isNFC;

  /// Check if GPS is supported.
  bool isGPS;

  ///Check if UHF is supported.
  bool isUHF;

  /// Check if WiFi is supported.
  bool isWiFi;

  /// Check if keypad is supported.
  bool isKeypad;

  /// Check if Vibrator is supported.
  bool isVibrator;

  /// Check if Display is supported.
  bool isDisplay;

  /// Check if Passport Reader is supported.
  bool isPassportReader;

  /// Check if Finger Print is supported.
  bool isFingerPrint;

  /// Check if MSRIC module is supported.
  bool isMSRIC;

  /// Check if Social Distance is supported.
  bool? isSocialDistance;

  /// Check if OCR is supported.
  bool? isOCR;

  /// Check if MRZ is supported.
  bool? isMRZ;

  /// Check if SLED is supported.
  bool? isSLED;

  /// Check if it is New Architecture model.
  bool isNA;

  /// Check if POS is supported.
  bool isPOS;

  static KDCDeviceInfo fromMap(Map<String, dynamic> map) {
    return KDCDeviceInfo._(
      map['name'] as String,
      firmware: map['firmware'] as String,
      serial: map['serial'] as String,
      isFlash: map['isFlash'] as bool,
      isBluetooth: map['isBluetooth'] as bool,
      is2D: map['is2D'] as bool,
      isMSR: map['isMSR'] as bool,
      isNFC: map['isNFC'] as bool,
      isGPS: map['isGPS'] as bool,
      isUHF: map['isUHF'] as bool,
      isWiFi: map['isWiFi'] as bool,
      isKeypad: map['isKeypad'] as bool,
      isVibrator: map['isVibrator'] as bool,
      isDisplay: map['isDisplay'] as bool,
      isPassportReader: map['isPassportReader'] as bool,
      isFingerPrint: map['isFingerPrint'] as bool,
      isMSRIC: map['isMSRIC'] as bool,
      isSocialDistance: map['isSocialDistance'] as bool?,
      isOCR: map['isOCR'] as bool?,
      isMRZ: map['isMRZ'] as bool?,
      isSLED: map['isSLED'] as bool?,
      isNA: map['isNA'] as bool,
      isPOS: map['isPOS'] as bool,
    );
  }
}

/// The object contains KDC Data.
///
/// It is passed as a parameter when the each data listener is called.
/// The validity of each data is determined by the data type.
class KDCData {
  KDCData._(
      {required this.type,
      this.data,
      this.dataBytes,
      this.symbol,
      this.barcode,
      this.barcodeBytes,
      this.gps,
      this.msr,
      this.msrBytes,
      this.nfcType,
      this.nfcUid,
      this.nfc,
      this.nfcBytes,
      this.uhfListType,
      this.uhfList,
      this.uhfRssiList,
      this.key,
      this.record});

  /// contructor used only for subclassing.
  KDCData(this.type);

  /// Data type.
  DataType type;

  /// Received data.
  String? data;

  /// Received data as byte array.
  Uint8List? dataBytes;

  /// Barcode symbology
  String? symbol;

  /// Barcode data.
  String? barcode;

  /// Barcode data as byte array.
  Uint8List? barcodeBytes;

  /// GPS data.
  String? gps;

  /// MSR data.
  String? msr;

  /// MSR data as byte array.
  Uint8List? msrBytes;

  /// NFC tag type.
  NFCTagType? nfcType;

  /// NFC UID.
  String? nfcUid;

  /// NFC string.
  String? nfc;

  /// NFC data as byte array.
  Uint8List? nfcBytes;

  /// UHF data list type.
  int? uhfListType;

  /// UHF data list when burst mode is enabled.
  List<String>? uhfList;

  /// UHF RSSI list when burst mode is enabled.
  List<int>? uhfRssiList;

  /// Key Event.
  String? key;

  /// Record data.
  String? record;

  static KDCData fromMap(Map<String, dynamic> map) {
    final dataType = toDataTypeEnum(map['type'] as int?);
    final nfcTagType = toNFCTagTypeEnum(map['nfcType'] as int?);

    return KDCData._(
      type: dataType,
      data: map['data'] as String?,
      dataBytes: map['dataBytes'] as Uint8List?,
      symbol: map['symbol'] as String?,
      barcode: map['barcode'] as String?,
      barcodeBytes: map['barcodeBytes'] as Uint8List?,
      gps: map['gps'] as String?,
      msr: map['msr'] as String?,
      msrBytes: map['msrBytes'] as Uint8List?,
      nfcType: nfcTagType,
      nfcUid: map['nfcUid'] as String?,
      nfc: map['nfc'] as String?,
      nfcBytes: map['nfcBytes'] as Uint8List?,
      uhfListType: map['uhfListType'] as int?,
      uhfList: map['uhfList'] as List<String>?,
      uhfRssiList: map['uhfRssiList'] as List<int>?,
      key: map['key'] as String?,
      record: map['record'] as String?,
    );
  }
}

/// Pre-defined key for selected barcode symbol map.
///
/// The validity of each data is determined by the barcode engine type.
class KDCSymbology {
  KDCSymbology._() {}

  /// Enable or disable UPCE. 1D only.
  static const UPCE = "UPCE";

  /// Enable or disable CODE35. 1D only.
  static const CODE35 = "CODE35";

  /// Enable or disable BooklandEAN. 1D only.
  static const BOOKLANDEAN = "BOOKLANDEAN";

  /// Enable or disable EAN13 with ADDON. 1D only.
  static const EAN13WADDON = "EAN13WADDON";

  /// Enable or disable EAN8 with ADDON. 1D only.
  static const EAN8WADDON = "EAN8WADDON";

  /// Enable or disable UPCA with ADDON. 1D only.
  static const UPCAWADDON = "UPCAWADDON";

  /// Enable or disable UPCE with ADDON. 1D only.
  static const UPCEWADDON = "UPCEWADDON";

  /// Enable or disable GS1 128. 1D only.
  static const GS1128 = "GS1128";

  /// Enable or disable ITF14. 1D only.
  static const ITF14 = "ITF14";

  /// Enable or disable CODABAR.
  static const CODABAR = "CODABAR";

  /// Enable or disable CODE11. 2D only.
  static const CODE11 = "CODE11";

  /// Enable or disable CODE32. 2D only.
  static const CODE32 = "CODE32";

  /// Enable or disable CODE39.
  static const CODE39 = "CODE39";

  /// Enable or disable CODE93.
  static const CODE93 = "CODE93";

  /// Enable or disable CODE128.
  static const CODE128 = "CODE128";

  /// Enable or disable EAN8.
  static const EAN8 = "EAN8";

  /// Enable or disable EAN13.
  static const EAN13 = "EAN13";

  /// Enable or disable GS1 COMPOSITE. 2D only.
  static const GS1_COMPOSIT = "GS1_COMPOSIT";

  /// Enabled or disabled I2OF5.
  static const I2OF5 = "I2OF5";

  /// Enable or disable MATRIX 2OF5. 2D only.
  static const MATRIX2OF5 = "MATRIX2OF5";

  /// Enable or disable MSI. 2D only.
  static const MSI = "MSI";

  /// Enable or disable PLESSEY CODE. 2D only.
  static const PLESSEY_CODE = "PLESSEY_CODE";

  /// Enable or disable POSI CODE. 2D only.
  static const POSICODE = "POSICODE";

  /// Enable or disable GS1 OMNI.
  static const GS1_OMNI = "GS1_OMNI";

  /// Enable or disable GS1 LIMITED.
  static const GS1_LIMITED = "GS1_LIMITED";

  /// Enable or disable GS1 EXPANDED.
  static const GS1_EXPANDED = "GS1_EXPANDED";

  /// Enable or disable S2OF5 INDUSTRIAL. 2D only.
  static const S2OF5IND = "S2OF5IND";

  /// Enable or disable S2OF5 IATA. 2D only.
  static const S2OF5IATA = "S2OF5IATA";

  /// Enable or disable TLC39. 2D only.
  static const TLC39 = "TLC39";

  /// Enable or disable TELEPEN. 2D only.
  static const TELEPEN = "TELEPEN";

  /// Enable or disable TRIOPTIC. 2D only.
  static const TRIOPTIC = "TRIOPTIC";

  /// Enabled or disabled UPCA.
  static const UPCA = "UPCA";

  /// Enable or disable UPCE0. 2D only.
  static const UPCE0 = "UPCE0";

  /// Enable or disable UPCE1. 2D only.
  static const UPCE1 = "UPCE1";

  /// Enable or disable AZTEC CODE. 2D only.
  static const AZTEC_CODE = "AZTEC_CODE";

  /// Enable or disable AZTEC RUNES. 2D only.
  static const AZTEC_RUNES = "AZTEC_RUNES";

  /// Enable or disable CODABLOCK F. 2D only.
  static const CODABLOCK_F = "CODABLOCK_F";

  /// Enable or disable CODE 16K. 2D only.
  static const CODE16K = "CODE16K";

  /// Enable or disable CODE49. 2D only.
  static const CODE49 = "CODE49";

  /// Enable or disable DATA MATRIX. 2D only.
  static const DATA_MATRIX = "DATA_MATRIX";

  /// Enable or disable MAXI CODE. 2D only.
  static const MAXICODE = "MAXICODE";

  /// Enable or disable MICROPDF417. 2D only.
  static const MICROPDF417 = "MICROPDF417";

  /// Enable or disable PDF417. 2D only.
  static const PDF417 = "PDF417";

  /// Enable or disable QR CODE. 2D only.
  static const QR_CODE = "QR_CODE";

  /// Enable or disable HANXIN. 2D only.
  static const HANXIN = "HANXIN";

  /// Enable or disable POSTNET. 2D only.
  static const POSTNET = "POSTNET";

  /// Enable or disable PLANET CODE. 2D only.
  static const PLANET_CODE = "PLANET_CODE";

  /// Enable or disable BRITISH POST. 2D only.
  static const BRITISH_POST = "BRITISH_POST";

  /// Enable or disable CANADIAN POST. 2D only.
  static const CANADIAN_POST = "CANADIAN_POST";

  /// Enable or disable KIX POST. 2D only.
  static const KIX_POST = "KIX_POST";

  /// Enable or disable AUSTRALIAN POST. 2D only.
  static const AUSTRALIAN_POST = "AUSTRALIAN_POST";

  /// Enable or disable JAPANESE POST. 2D only.
  static const JAPANESE_POST = "JAPANESE_POST";

  /// Enable or disable CHINA POST. 2D only.
  static const CHINA_POST = "CHINA_POST";

  /// Enable or disable  OREAN POST. 2D only.
  static const KOREA_POST = "KOREA_POST";

  /// Enable OCR OFF. OCR(Optical Character Recognition) supported model only.
  static const OCR_OFF = "OCR_OFF";

  /// Enable OCR A. OCR supported model only .
  static const OCR_A = "OCR_A";

  /// Enable OCR B. OCR supported model only.
  static const OCR_B = "OCR_B";

  /// Enable OCR US CURRENCY. OCR supported model only .
  static const OCR_US_CURRENCY = "OCR_US_CURRENCY";

  /// Enable OCR MICR E13B. OCR supported model only.
  static const OCR_MICR_E13B = "OCR_MICR_E13B";

  /// Enable OCR SEMI FONT. OCR supported model only.
  static const OCR_SEMI_FONT = "OCR_SEMI_FONT";

  /// Enable or disable MRZ. MRZ supported model only.
  static const MRZ = "MRZ";
}

/// Pre-defined key for selected barcode option map.
///
/// The validity of each data is determined by the barcode engine type.
class KDCBarcodeOption {
  KDCBarcodeOption._() {}

  /// Enable or disable CODABAR_NO_START_STOP_CHARS. 1D only.
  static const CODABAR_NO_START_STOP_CHARS = "CODABAR_NO_START_STOP_CHARS";

  /// Enable or disable REVERSE_DIRECTION. 1D only.
  static const REVERSE_DIRECTION = "REVERSE_DIRECTION";

  /// Enable or disable UPCE_AS_UPCA.
  static const UPCE_AS_UPCA = "UPCE_AS_UPCA";

  /// Enable or disable EAN8_AS_EAN13.
  static const EAN8_AS_EAN13 = "EAN8_AS_EAN13";

  /// Enable or disable UPCE_AS_EAN13.
  static const UPCE_AS_EAN13 = "UPCE_AS_EAN13";

  /// Enable or disable RETURN_CHECK_DIGIT. 1D only.
  static const RETURN_CHECK_DIGIT = "RETURN_CHECK_DIGIT";

  /// Enable or disable VERIFY_CHECK_DIGIT. 1D only.
  static const VERIFY_CHECK_DIGIT = "VERIFY_CHECK_DIGIT";

  /// Enable or disable WIDE_SCAN_ANGLE. 1D only.
  static const WIDE_SCAN_ANGLE = "WIDE_SCAN_ANGLE";

  /// Enable or disable HIGH_FILTER_MODE. 1D only.
  static const HIGH_FILTER_MODE = "HIGH_FILTER_MODE";

  /// Enable or disable UPCA_AS_EAN13.
  static const UPCA_AS_EAN13 = "UPCA_AS_EAN13";

  /// Enable or disable I2OF5_VERIFY_CHECK_DIGIT. 1D only.
  static const I2OF5_VERIFY_CHECK_DIGIT = "I2OF5_VERIFY_CHECK_DIGIT";

  /// Enable or disable CODE39_VERIFY_CHECK_DIGIT. 1D only.
  static const CODE39_VERIFY_CHECK_DIGIT = "CODE39_VERIFY_CHECK_DIGIT";

  /// Enable or disable I2OF5_RETURN_CHECK_DIGIT. 1D only.
  static const I2OF5_RETURN_CHECK_DIGIT = "I2OF5_RETURN_CHECK_DIGIT";

  /// Enable or disable CODE39_RETURN_CHECK_DIGIT. 1D only.
  static const CODE39_RETURN_CHECK_DIGIT = "CODE39_RETURN_CHECK_DIGIT";

  /// Enable or disable UPCE_RETURN_CHECK_DIGITRZ. 1D only.
  static const UPCE_RETURN_CHECK_DIGITRZ = "UPCE_RETURN_CHECK_DIGITRZ";

  /// Enable or disable UPCA_RETURN_CHECK_DIGIT. 1D only.
  static const UPCA_RETURN_CHECK_DIGIT = "UPCA_RETURN_CHECK_DIGIT";

  /// Enable or disable EAN8_RETURN_CHECK_DIGIT. 1D only.
  static const EAN8_RETURN_CHECK_DIGIT = "EAN8_RETURN_CHECK_DIGIT";

  /// Enable or disable EAN13_RETURN_CHECK_DIGIT. 1D only.
  static const EAN13_RETURN_CHECK_DIGIT = "EAN13_RETURN_CHECK_DIGIT";

  /// Enable or disable CODABAR_TRANSMIT_START_STOP. 2D model only.
  static const CODABAR_TRANSMIT_START_STOP = "CODABAR_TRANSMIT_START_STOP";

  /// Enable or disable CODABAR_CHECK_DIGIT_VERIFY_NO_TRANSMIT. 2D model only.
  static const CODABAR_CHECK_DIGIT_VERIFY_NO_TRANSMIT =
      "CODABAR_CHECK_DIGIT_VERIFY_NO_TRANSMIT";

  /// Enable or disable CODABAR_CHECK_DIGIT_VERIFY_TRANSMIT. 2D model only.
  static const CODABAR_CHECK_DIGIT_VERIFY_TRANSMIT =
      "CODABAR_CHECK_DIGIT_VERIFY_TRANSMIT";

  /// Enable or disable CODABAR_CONCATENATION_ON. 2D model only.
  static const CODABAR_CONCATENATION_ON = "CODABAR_CONCATENATION_ON";

  /// Enable or disable CODABAR_CONCATENATION_REQUIRE. 2D model only.
  static const CODABAR_CONCATENATION_REQUIRE = "CODABAR_CONCATENATION_REQUIRE";

  /// Enable or disable CODE39_TRANSMIT_START_STOP. 2D model only.
  static const CODE39_TRANSMIT_START_STOP = "CODE39_TRANSMIT_START_STOP";

  /// Enable or disable CODE39_CHECK_DIGIT_VERIFY_NO_TRANSMIT. 2D model only.
  static const CODE39_CHECK_DIGIT_VERIFY_NO_TRANSMIT =
      "CODE39_CHECK_DIGIT_VERIFY_NO_TRANSMIT";

  /// Enable or disable CODE39_CHECK_DIGIT_VERIFY_TRANSMIT. 2D model only.
  static const CODE39_CHECK_DIGIT_VERIFY_TRANSMIT =
      "CODE39_CHECK_DIGIT_VERIFY_TRANSMIT";

  /// Enable or disable CODE39_APPEND_ON. 2D model only.
  static const CODE39_APPEND_ON = "CODE39_APPEND_ON";

  /// Enable or disable CODE39_FULL_ASCII_ON. 2D model only.
  static const CODE39_FULL_ASCII_ON = "CODE39_FULL_ASCII_ON";

  /// Enable or disable I2OF5_CHECK_DIGIT_VERIFY_NO_TRANSMIT. 2D model only.
  static const I2OF5_CHECK_DIGIT_VERIFY_NO_TRANSMIT =
      "I2OF5_CHECK_DIGIT_VERIFY_NO_TRANSMIT";

  /// Enable or disable I2OF5_CHECK_DIGIT_VERIFY_TRANSMIT. 2D model only.
  static const I2OF5_CHECK_DIGIT_VERIFY_TRANSMIT =
      "I2OF5_CHECK_DIGIT_VERIFY_TRANSMIT";

  /// Enable or disable CODE11_CHECK_DIGIT. 2D model only.
  static const CODE11_CHECK_DIGIT = "CODE11_CHECK_DIGIT";

  /// Enable or disable CODE128_ISBT_CONCATENATION_ON. 2D model only.
  static const CODE128_ISBT_CONCATENATION_ON = "CODE128_ISBT_CONCATENATION_ON";

  /// Enable or disable TELEPEN_AIM_OUTPUT_AIM. 2D model only.
  static const TELEPEN_AIM_OUTPUT_AIM = "TELEPEN_AIM_OUTPUT_AIM";

  /// Enable or disable POSI_CODE_AB_LIMITED_A_ON. 2D model only.
  static const POSI_CODE_AB_LIMITED_A_ON = "POSI_CODE_AB_LIMITED_A_ON";

  /// Enable or disable POSI_CODE_AB_LIMITED_B_ON. 2D model only.
  static const POSI_CODE_AB_LIMITED_B_ON = "POSI_CODE_AB_LIMITED_B_ON";

  /// Enable or disable UPCA_CHECK_DIGIT_VERIFY. 2D model only.
  static const UPCA_CHECK_DIGIT_VERIFY = "UPCA_CHECK_DIGIT_VERIFY";

  /// Enable or disable UPCA_NUMBER_SYSTEM_ON. 2D model only.
  static const UPCA_NUMBER_SYSTEM_ON = "UPCA_NUMBER_SYSTEM_ON";

  /// Enable or disable UPCA_2DIGIT_ADDENDA_ON. 2D model only.
  static const UPCA_2DIGIT_ADDENDA_ON = "UPCA_2DIGIT_ADDENDA_ON";

  /// Enable or disable UPCA_5DIGIT_ADDENDA_ON. 2D model only.
  static const UPCA_5DIGIT_ADDENDA_ON = "UPCA_5DIGIT_ADDENDA_ON";

  /// Enable or disable UPCA_ADDENDA_REQUIRED. 2D model only.
  static const UPCA_ADDENDA_REQUIRED = "UPCA_ADDENDA_REQUIRED";

  /// Enable or disable UPCA_ADDENDA_SEPARATOR_ON. 2D model only.
  static const UPCA_ADDENDA_SEPARATOR_ON = "UPCA_ADDENDA_SEPARATOR_ON";

  /// Enable or disable UPCA_EXTENDED_COUPON_CODE_ON. 2D model only.
  static const UPCA_EXTENDED_COUPON_CODE_ON = "UPCA_EXTENDED_COUPON_CODE_ON";

  /// Enable or disable UPCE_EXPAND_ON. 2D model only.
  static const UPCE_EXPAND_ON = "UPCE_EXPAND_ON";

  /// Enable or disable UPCE_ADDENDA_REQUIRED. 2D model only.
  static const UPCE_ADDENDA_REQUIRED = "UPCE_ADDENDA_REQUIRED";

  /// Enable or disable UPCE_ADDENDA_SEPARATOR_ON. 2D model only.
  static const UPCE_ADDENDA_SEPARATOR_ON = "UPCE_ADDENDA_SEPARATOR_ON";

  /// Enable or disable UPCE_CHECK_DIGIT_ON. 2D model only.
  static const UPCE_CHECK_DIGIT_ON = "UPCE_CHECK_DIGIT_ON";

  /// Enable or disable UPCE_NUMBER_SYSTEM_ON. 2D model only.
  static const UPCE_NUMBER_SYSTEM_ON = "UPCE_NUMBER_SYSTEM_ON";

  /// Enable or disable UPCE_2DIGIT_ADDENDA_ON. 2D model only.
  static const UPCE_2DIGIT_ADDENDA_ON = "UPCE_2DIGIT_ADDENDA_ON";

  /// Enable or disable UPCE_5DIGIT_ADDENDA_ON. 2D model only.
  static const UPCE_5DIGIT_ADDENDA_ON = "UPCE_5DIGIT_ADDENDA_ON";

  /// Enable or disable EAN13_CHECK_DIGIT_VERIFY. 2D model only.
  static const EAN13_CHECK_DIGIT_VERIFY = "EAN13_CHECK_DIGIT_VERIFY";

  /// Enable or disable EAN13_2DIGIT_ADDENDA_ON. 2D model only.
  static const EAN13_2DIGIT_ADDENDA_ON = "EAN13_2DIGIT_ADDENDA_ON";

  /// Enable or disable EAN13_5DIGIT_ADDENDA_ON. 2D model only.
  static const EAN13_5DIGIT_ADDENDA_ON = "EAN13_5DIGIT_ADDENDA_ON";

  /// Enable or disable EAN13_ADDENDA_REQUIRED. 2D model only.
  static const EAN13_ADDENDA_REQUIRED = "EAN13_ADDENDA_REQUIRED";

  /// Enable or disable EAN13_ADDENDA_SEPARATOR_ON. 2D model only.
  static const EAN13_ADDENDA_SEPARATOR_ON = "EAN13_ADDENDA_SEPARATOR_ON";

  /// Enable or disable EAN13_ISBN_TRANSLATOR_ON. 2D model only.
  static const EAN13_ISBN_TRANSLATOR_ON = "EAN13_ISBN_TRANSLATOR_ON";

  /// Enable or disable POSTNET_CHECK_DIGIT_TRANSMIT. 2D model only.
  static const POSTNET_CHECK_DIGIT_TRANSMIT = "POSTNET_CHECK_DIGIT_TRANSMIT";

  /// Enable or disable PLANETCODE_CHECK_DIGIT_TRANSMIT. 2D model only.
  static const PLANETCODE_CHECK_DIGIT_TRANSMIT =
      "PLANETCODE_CHECK_DIGIT_TRANSMIT";

  /// Enable or disable EAN8_VERIFY_CHECK_DIGIT. 2D model only.
  static const EAN8_VERIFY_CHECK_DIGIT = "EAN8_VERIFY_CHECK_DIGIT";

  /// Enable or disable EAN8_2DIGIT_ADDENDA_ON. 2D model only.
  static const EAN8_2DIGIT_ADDENDA_ON = "EAN8_2DIGIT_ADDENDA_ON";

  /// Enable or disable EAN8_5DIGIT_ADDENDA_ON. 2D model only.
  static const EAN8_5DIGIT_ADDENDA_ON = "EAN8_5DIGIT_ADDENDA_ON";

  /// Enable or disable EAN8_ADDENDA_REQUIRED. 2D model only.
  static const EAN8_ADDENDA_REQUIRED = "EAN8_ADDENDA_REQUIRED";

  /// Enable or disable EAN8_ADDENDA_SEPARATOR_ON. 2D model only.
  static const EAN8_ADDENDA_SEPARATOR_ON = "EAN8_ADDENDA_SEPARATOR_ON";

  /// Enable or disable MSI_VERIFY_CHECK_CHARACTER_TRANSMIT. 2D model only.
  static const MSI_VERIFY_CHECK_CHARACTER_TRANSMIT =
      "MSI_VERIFY_CHECK_CHARACTER_TRANSMIT";

  /// Enable or disable MSI_VERSION_ON. 2D model only.
  static const MSI_VERSION_ON = "MSI_VERSION_ON";

  /// Enable or disable MSI_128_EMULATION. 2D model only.
  static const MSI_128_EMULATION = "MSI_128_EMULATION";

  /// Enable or disable MSI_RSS_EMULATION. 2D model only.
  static const MSI_RSS_EMULATION = "MSI_RSS_EMULATION";
}

/// Connection state event.
///
/// It is passed as a parameter when the connection changed listener is called.
class ConnectionEvent {
  ConnectionEvent._(this.state, {this.device});

  /// Connection state enum.
  ConnectState state;

  /// The current device if available.
  KDCDevice? device;

  static ConnectionEvent fromMap(Map<String, dynamic> map) {
    final connState = toConnectStateEnum(map['state'] as int?);
    final deviceMap = map['device'] as Map<dynamic, dynamic>?;

    KDCDevice? device = null;

    if (deviceMap != null) {
      device = KDCDevice.fromMap(deviceMap!.cast<String, dynamic>());
    }

    return ConnectionEvent._(connState, device: device);
  }
}

/// Native SDK error event.
///
/// It is passed as a parameter when the error listener is called.
class ErrorEvent {
  ErrorEvent._({
    this.device,
    required this.errorCode,
    this.nsError,
  });

  /// KDC device.
  ///
  /// This is only available on Android devices.
  KDCDevice? device;

  /// Result code from native SDK.
  ///
  /// RCODE_XX which are defined in KDCConstants of native SDK [RCode].
  int errorCode;

  /// NSError object(Native platforrm error code) with domain and code.
  ///
  /// This is only available on iOS devices.
  Map<String, dynamic>? nsError;

  static ErrorEvent fromMap(Map<String, dynamic> map) {
    final deviceMap = map['device'] as Map<dynamic, dynamic>?;

    KDCDevice? device = null;

    if (deviceMap != null) {
      device = KDCDevice.fromMap(deviceMap!.cast<String, dynamic>());
    }

    return ErrorEvent._(
      device: device,
      errorCode: map['errorCode'] as int,
      nsError: map['nsError'] as Map<String, dynamic>?,
    );
  }
}

/// The object that has peripheral scanning fail information.
///
/// It is passed as a parameter when the scan failed listener is called.
/// <b>Note</b> This is only supported on Android devices.
class ScanFailEvent {
  ScanFailEvent._({
    required this.code,
    required this.message,
    this.opCode,
  });

  /// Flutter Plugin Result code [ResultCode].
  String code;

  /// Result description message.
  String message;

  /// Native platform error code [RCode].
  int? opCode;

  static ScanFailEvent fromMap(Map<String, dynamic> map) {
    return ScanFailEvent._(
      code: map['code'] as String,
      message: map['message'] as String,
      opCode: map['opCode'] as int?,
    );
  }
}

/// The object that has Core Bluetooth Manager Information.
///
/// It is passed as a parameter when the CBManagerState is changed.
/// <b>Note</b> This is only supported on iOS devices.
class InfoEvent {
  InfoEvent._({
    this.cbManagerState,
  });

  /// Core Bluetooth Manager State.
  ///
  /// Please refer to iOS developer document.
  int? cbManagerState;

  static InfoEvent fromMap(Map<String, dynamic> map) {
    return InfoEvent._(
      cbManagerState: map['cbManagerState'] as int?,
    );
  }
}

/// Flutter Plugin Result code
class ResultCode {
  ResultCode._();

  static const String SUCCESS = "0";
  static const String FAILED = "1";
  static const String NULL = "2";
  static const String NOT_CONNECTED = "3";
  static const String USB_PERMISSION_DENIED = "4";
  static const String INVALID_PARAMETER = "5";
  static const String UNSUPPORTED = "6";
}

/// Native SDK Result code
class RCode {
  RCode._();

  /// Success
  static const int NONE = 0x0000;

  /// Success
  static const int SUCCESS = NONE;

  /// Common Error or Fail
  static const int UNKNOWN_FAILED = 0xF000; // 61440

  /// Unavailable Error
  static const int UNAVAILABLE = UNKNOWN_FAILED + 0x200; // 61952

  /// Operation Failed
  static const int OPERATION_FAILED = UNAVAILABLE + 1;

  /// Initialization Failed
  static const int INITIALIZATION_FAILED = UNAVAILABLE + 2;

  //
  // BLE Result code
  //

  /// BLE Operation Failed
  static const int GATT_FAILURE = UNKNOWN_FAILED + 0x300; // 62208

  /// BLE Authentication Error
  static const int GATT_INSUFFICIENT_AUTHENTICATION = GATT_FAILURE + 1;

  static const int GATT_REQUEST_NOT_SUPPORTED = GATT_FAILURE + 2;

  /// BLE Encryption Error
  static const int GATT_INSUFFICIENT_ENCRYPTION = GATT_FAILURE + 3;

  static const int GATT_INVALID_OFFSET = GATT_FAILURE + 4;
  static const int GATT_INVALID_ATTRIBUTE_LENGTH = GATT_FAILURE + 5;
  static const int GATT_CONNECTION_CONGESTED = GATT_FAILURE + 6;
  static const int GATT_DISCOVER_SERVICE = GATT_FAILURE + 7;
  static const int GATT_DISCOVER_CHARACTERISTIC = GATT_FAILURE + 8;
  static const int GATT_READ_VALUE = GATT_FAILURE + 9;
  static const int GATT_READ_NOT_PERMITTED = GATT_FAILURE + 10;
  static const int GATT_WRITE_VALUE = GATT_FAILURE + 11;
  static const int GATT_WRITE_NOT_PERMITTED = GATT_FAILURE + 12;
  static const int GATT_WRITE_CCCD_FAIL = GATT_FAILURE + 13;
  static const int GATT_CONNECT_FAILED = GATT_FAILURE + 14;
  static const int GATT_DISCONNECT_FAILED = GATT_FAILURE + 15;
  static const int GATT_CAHRACTERISTIC_NOTIFICATION_FAILED = GATT_FAILURE + 16;

  //
  // USB Result code
  //

  /// No USB Permission
  static const int USB_NO_PERMISSION = UNKNOWN_FAILED + 0x400; // 62464

  //
  // Firmware Download Result code
  //

  /// Download Firmware error
  static const int DOWNLOAD_ERROR = UNKNOWN_FAILED + 0x600; // 62976

  static const int DOWNLOAD_INVALID_STATE = DOWNLOAD_ERROR + 1;
  static const int DOWNLOAD_INVALID_PARAMETER = DOWNLOAD_ERROR + 2;
  static const int DOWNLOAD_NO_RESPONSE = DOWNLOAD_ERROR + 3;
  static const int DOWNLOAD_INVALID_RESPONSE = DOWNLOAD_ERROR + 4;
  static const int DOWNLOAD_ERROR_RESEND = DOWNLOAD_ERROR + 5;
  static const int DOWNLOAD_ERROR_CRC = DOWNLOAD_ERROR + 6;
  static const int DOWNLOAD_INVALID_PACKET_SIZE = DOWNLOAD_ERROR + 7;
  static const int DOWNLOAD_FLASH_WRITE_FAILED = DOWNLOAD_ERROR + 8;
  static const int DOWNLOAD_INVALID_TARGET = DOWNLOAD_ERROR + 9;
  static const int DOWNLOAD_WAIT_DOWNLOAD_DATA = DOWNLOAD_ERROR + 10;
  static const int DOWNLOAD_NOT_SUPPORTED = DOWNLOAD_ERROR + 11;

  //
  // Software Decoder (KDC8)
  //

  /// Software Decoder unknown fail
  static const int SW_FAILED_UNKNOWN = UNKNOWN_FAILED + 0x500; // 62720

  // From Honeywell Activation Server
  /// Software Decoder License Manager not created
  static const int SW_NOT_CREATED = SW_FAILED_UNKNOWN + 1;

  /// Software Decoder insufficient memory
  static const int SW_INSUFFICIENT_MEMORY = SW_FAILED_UNKNOWN + 2;

  /// Software Decoder already created
  static const int SW_ALREADY_CREATED = SW_FAILED_UNKNOWN + 3;

  /// Software Decoder can not write to specified path
  static const int SW_FOLDER_PATH_ERROR = SW_FAILED_UNKNOWN + 4;

  /// Software Decoder device id error
  static const int SW_DEVICE_ID_ERROR = SW_FAILED_UNKNOWN + 5;

  /// Software Decoder device type error
  static const int SW_DEVICE_TYPE_ERROR = SW_FAILED_UNKNOWN + 6;

  /// Software Decoder License Manager customer id error
  static const int SW_CUSTOMER_ID_ERROR = SW_FAILED_UNKNOWN + 7;

  /// Software Decoder deactivation is not allowed
  static const int SW_DEACTIVATION_NOT_ALLOWED = SW_FAILED_UNKNOWN + 8;

  /// Software Decoder reach the server fail.
  ///
  /// No valid activation id attached to the entitlement Id.
  static const int SW_CURL_FAIL = SW_FAILED_UNKNOWN + 9;

  /// Software Decoder flexera base error code.
  ///
  /// Communication with server was successful, but activation has failed for an unknown reason.
  static const int SW_FLEXERA_FAIL = SW_FAILED_UNKNOWN + 10;

  /// Software Decoder invalid license key
  static const int SW_INVALID_KEY = SW_FAILED_UNKNOWN + 11;

  /// Software Decoder clock wind back detected.
  ///
  /// System time has been altered.
  static const int SW_CLOCK_WINDBACK_DETECTED = SW_FAILED_UNKNOWN + 12;

  /// Software Decoder license not available
  static const int SW_NO_LICENSE_AVAILABLE = SW_FAILED_UNKNOWN + 13;

  /// Software Decoder flexera com error.
  ///
  /// Communication with server was successful, but it is not responding.
  static const int SW_FLEXERA_COM = SW_FAILED_UNKNOWN + 14;

  /// Software Decoder flexera no response.
  ///
  /// No response from server, please check the access to internet.
  static const int SW_FLEXERA_NO_RESPONSE = SW_FAILED_UNKNOWN + 15;

  /// Software Decoder Curl returned an error while contacting the server
  static const int SW_CURL_ERROR = SW_FAILED_UNKNOWN + 16;

  // added in SwiftDecoderM_Android_SDK(5.6.9)
  /// Software Decoder NO Network failed.
  static const int SW_CURL_HOST_NOT_FOUND = SW_FAILED_UNKNOWN + 17;

  /// Software Decoder features expired.
  static const int SW_ALL_FEATURES_EXPIRED = SW_FAILED_UNKNOWN + 18;

  /// Software Decoder validity check failed. License perpetual.
  static const int SW_PERPETUAL_LICENSE = SW_FAILED_UNKNOWN + 19;

  /// Software Decoder validity check failed. License inactive.
  static const int SW_LICENSE_INACTIVE = SW_FAILED_UNKNOWN + 20;

  /// Software Decoder Entitlement or Activation ID is blank
  static const int SW_BLANK_ID = SW_FAILED_UNKNOWN + 21;

  // From SDK
  /// Software Decoder deactivation failed.
  static const int SW_NOT_ACTIVATED = SW_FAILED_UNKNOWN + 50;

  /// Software Decoder encryption error
  static const int SW_ENCRYPTION_ERROR = SW_FAILED_UNKNOWN + 51;

  /// Software Decoder engine not loaded
  static const int SW_NOT_LOADED = SW_FAILED_UNKNOWN + 52;

  /// Invalid response from Koamtac server or network problem
  static const int SW_INVALID_RESPONSE = SW_FAILED_UNKNOWN + 53;

  /// Software Decoder engine unknown failed
  static const int SW_DECODER_FAILED_UNKNOWN = SW_FAILED_UNKNOWN + 54;

  // From Koamtac License Server
  /// Software Decoder activation code expired
  static const int SW_EXPIRED_ACTIVATION_CODE = SW_FAILED_UNKNOWN + 101;

  /// Software Decoder invalid activation code
  static const int SW_INVALID_ACTIVATION_CODE = SW_FAILED_UNKNOWN + 102;

  /// Software Decoder authorized installation exceeded
  static const int SW_EXCEEDED_INSTALL_COUNT = SW_FAILED_UNKNOWN + 103;

  /// Software Decoder outstanding balance
  static const int SW_PAYMENT_ACTIVATION_ERROR = SW_FAILED_UNKNOWN + 104;

  /// Software Decoder insufficient license
  static const int SW_INSUFFICIENT_LICENSE = SW_FAILED_UNKNOWN + 105;

  /// Software Decoder disabled device
  static const int SW_DISABLED_DEVICE = SW_FAILED_UNKNOWN + 106;

  /// Software Decoder invalid request
  static const int SW_INVALID_REQUEST_DATA = SW_FAILED_UNKNOWN + 107;
}

/// Native SDK UHF Result code
class UHFCode {
  UHFCode._();

  static const int UHF_SUCCESS = 0x00;

  static const int UHF_COMMON_ERROR = 0x100;

  //
  // EPC G2v2
  //
  static const int UHF_NOT_SUPPORTED = 0x01;
  static const int UHF_INSUFFICIENT_PRVILEGES = 0x02;
  static const int UHF_MEMORY_OVERRUN = 0x03;
  static const int UHF_MEMORY_LOCKED = 0x04;
  static const int UHF_CRYPTO_SUITE_ERROR = 0x05;
  static const int UHF_COMMAND_NOT_ENCAPSULATED = 0x06;
  static const int UHF_RESPONSE_BUFFER_OVERFLOW = 0x07;
  static const int UHF_SECURITY_TIMEOUT = 0x08;
  static const int UHF_INSUFFICIENT_POWER = 0x0B;
  static const int UHF_NON_SPECIFIC_ERROR = 0x0F;

  //
  // Vendor Specific
  //
  static const int UHF_SENSOR_SCHEDULING_CONFIG = 0x11; // 17
  static const int UHF_TAG_BUSY = 0x12;
  static const int UHF_MEASUREMENT_TYPE_NOT_SUPPORTED = 0x13;

  //
  // Protocol
  //
  static const int UHF_NO_TAG_DETECTED = 0x80; // 128
  static const int UHF_HANDLE_ACQUISITION_FAILED = 0x81;
  static const int UHF_ACCESS_PASSWORD_FAILED = 0x82;

  //
  // Modem
  //
  static const int UHF_CRC_ERROR = 0x90; // 144
  static const int UHF_RX_TIMEOUT = 0x91;

  //
  // Registry
  //
  static const int UHF_REGISTRY_UPDATE_FAILED = 0xA0; // 160
  static const int UHF_REGISTRY_ERASE_FAILED = 0xA1;
  static const int UHF_REGISTRY_WRITE_FAILED = 0xA2;
  static const int UHF_REGISTRY_NOT_EXIST = 0xA3;

  //
  // Peripheral
  //
  static const int UHF_UART_FAILED = 0xB0; // 176
  static const int UHF_SPI_FAILED = 0xB1;
  static const int UHF_I2C_FAILED = 0xB2;
  static const int UHF_GPIO_FAILED = 0xB3;

  //
  // Custom
  //
  static const int UHF_NOT_SUPPORTED_COMMAND = 0xE0; // 224
  static const int UHF_UNDEFINED_COMMAND = 0xE1;
  static const int UHF_INVALID_PARAMETER = 0xE2;
  static const int UHF_TOO_HIGH_PARAMETER = 0xE3;
  static const int UHF_TOO_LOW_PARAMETER = 0xE4;
  static const int UHF_AUTO_READ_OPERATION_FAILED = 0xE5;
  static const int UHF_NOT_AUTO_READ_MODE = 0xE6; // 230
  static const int UHF_GET_LAST_RESPONSE_FAILED = 0xE7;
  static const int UHF_CONTROL_TEST_FAILED = 0xE8;
  static const int UHF_RESET_READER_FAILED = 0xE9;
  static const int UHF_RFID_BLOCK_CONTROL_FAILED = 0xEA;
  static const int UHF_AUTO_READ_IN_OPERATION = 0xEB;

  static const int UHF_UNDEFINED_OTHER_ERROR = 0xF0; // 240
  static const int UHF_VERIFY_WRITE_OPERATION_FAILED = 0xF1;
  static const int UHF_ABNORMAL_ANTENNA = 0xFC;
  static const int UHF_NOT_TAG_SELECTED = 0xFE;

  static const int UHF_NONE_ERROR = 0xFF; // 255
}

/// UHF Constants.
/// Constant value for UHF operation.
class UHFConst {
  UHFConst._();

  static const int UHF_KILL_PWD_MASK = 0x01 << 19;
  static const int UHF_KILL_PWD_LOCK = 0x01 << 9;
  static const int UHF_KILL_PWD_PERM_MASK = 0x01 << 18;
  static const int UHF_KILL_PWD_PERM_LOCK = 0x01 << 8;

  static const int UHF_ACCESS_PWD_MASK = 0x01 << 17;
  static const int UHF_ACCESS_PWD_LOCK = 0x01 << 7;
  static const int UHF_ACCESS_PWD_PERM_MASK = 0x01 << 16;
  static const int UHF_ACCESS_PWD_PERM_LOCK = 0x01 << 6;

  static const int UHF_EPC_MEMORY_MASK = 0x01 << 15;
  static const int UHF_EPC_MEMORY_LOCK = 0x01 << 5;
  static const int UHF_EPC_MEMORY_PERM_MASK = 0x01 << 14;
  static const int UHF_EPC_MEMORY_PERM_LOCK = 0x01 << 4;

  static const int UHF_TID_MEMORY_MASK = 0x01 << 13;
  static const int UHF_TID_MEMORY_LOCK = 0x01 << 3;
  static const int UHF_TID_MEMORY_PERM_MASK = 0x01 << 12;
  static const int UHF_TID_MEMORY_PERM_LOCK = 0x01 << 2;

  static const int UHF_USER_MEMORY_MASK = 0x01 << 11;
  static const int UHF_USER_MEMORY_LOCK = 0x01 << 1;
  static const int UHF_USER_MEMORY_PERM_MASK = 0x01 << 10;
  static const int UHF_USER_MEMORY_PERM_LOCK = 0x01;

  static const int UHF_SESSION_S0 = 0x00;
  static const int UHF_SESSION_S1 = 0x01;
  static const int UHF_SESSION_S2 = 0x02;
  static const int UHF_SESSION_S3 = 0x03;

  static const int UHF_SELECTED_FLAG = 0x04;

  static const int UHF_TRUNCATE_DISABLE = 0x00;
  static const int UHF_TRUNCATE_ENABLE = 0x01;

  static const int UHF_DR_08 = 0x00;
  static const int UHF_DR_64 = 0x01;

  static const int UHF_CYCLE_M1 = 0x00;
  static const int UHF_CYCLE_M2 = 0x01;
  static const int UHF_CYCLE_M4 = 0x02;
  static const int UHF_CYCLE_M8 = 0x03;

  static const int UHF_TREXT_NO_PILOT = 0x00;
  static const int UHF_TREXT_USE_PILOT = 0x01;

  static const int UHF_SEL_ALL = 0x00;
  static const int UHF_SEL_ALL_EX = 0x01;
  static const int UHF_SEL_NOT_SL = 0x02;
  static const int UHF_SEL_SL = 0x03;

  static const int UHF_INVENTORY_A = 0x00;
  static const int UHF_INVENTORY_B = 0x01;
}

/// UHF Select parameter
class UHFSelectParameter {
  UHFSelectParameter._(this.target,
      {required this.action,
      required this.pointer,
      required this.length,
      required this.truncated,
      this.bank,
      this.maskData});

  /// Select target : S0(0), S1(1), S2(2), S3(3), SL(4).
  int target;

  /// select action (0 ~ 7) Refer to ISO18000-6C.
  int action;

  /// A starting bit address for the Mask comparison.
  int pointer;

  /// Mask bits length of binary data (0~255).
  int length;

  /// Enable (1) and Disable (0).
  bool truncated;

  /// Memory bank : RFU(0), EPC(1), TID(2), User(3).
  UHFMemoryBank? bank;

  /// Mask value as hex string (Max 64bytes hex string - 32bytes as binary data).
  String? maskData;

  static UHFSelectParameter fromMap(Map<String, dynamic> map) {
    final index = map['bank'] as int?;

    return UHFSelectParameter._(map['target'] as int,
        action: map['action'] as int,
        pointer: map['pointer'] as int,
        length: map['length'] as int,
        truncated: map['truncated'] as bool,
        bank: (index is int) ? UHFMemoryBank.values[index] : null,
        maskData: map['maskData'] as String?);
  }
}

/// UHF Query Parameter
class UHFQueryParameter {
  UHFQueryParameter._(this.dr,
      {required this.cycle,
      required this.tRext,
      required this.sel,
      required this.session,
      required this.target,
      required this.slotNum});

  /// TRcal divide ratio, sets the T=&gt;R link frequency. DR = 8(0) DR = 64 / 3(1).
  int dr;

  /// Cycles per symbol, sets the T=&gt;R data rate and modulation format. M1(0), M2(1), M4(2), M8(3).
  int cycle;

  /// Whether a tag prepends the T=&gt;R preamble with a pilot tone. No pilot tone(0), Use pilot tone(1).
  int tRext;

  /// Which Tags respond to the Query. ALL(0,1), ~SL(2), SL(3).
  int sel;

  /// A session for the inventory round. S0(0), S1(1), S2(2), S3(3).
  int session;

  /// Whether Tags whose inventoried flag is A or B participate in the inventory round. A(0), B(1).
  int target;

  /// The number of slots in the round. Q-parameter [0, 15].
  int slotNum;

  static UHFQueryParameter fromMap(Map<String, dynamic> map) {
    return UHFQueryParameter._(map['dr'] as int,
        cycle: map['cycle'] as int,
        tRext: map['tRext'] as int,
        sel: map['sel'] as int,
        session: map['session'] as int,
        target: map['target'] as int,
        slotNum: map['slotNum'] as int);
  }
}
