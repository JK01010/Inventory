import 'package:flutter/foundation.dart';

/// KPOS Event values.
class KPOSEvent {
  KPOSEvent._();

  static const int TIMEOUT = 0x0101;
  static const int TIMEOUT_CARD_READ = 0x0201;
  static const int TIMEOUT_PIN_ENTRY = 0x0301;

  static const int CANCELLED = 0x0102;
  static const int CANCELLED_CARD_READ = 0x0202;
  static const int CANCELLED_PIN_ENTRY = 0x0302;
  static const int CARD_SWIPED = 0x0103;
  static const int EMV_CARD_INSERTED = 0x0104;
  static const int EMV_CARD_TAPPED = 0x0105;
  static const int CARD_READ_FAILED = 0x0106;
  static const int PINBLOCK_GENERATED = 0x0107;
  static const int PINBLOCK_GENERATION_FAILED = 0x0108;
  static const int SIGNATURE_CAPTURED = 0x0109;
  static const int SIGNATURE_CAPTURE_FAILED = 0x010A;
  static const int BARCODE_SCANNED = 0x010B;
  static const int NFC_CARD_TAPPED = 0x010C;
  static const int ITEM_SELECTED = 0x010D;
  static const int VALUE_ENTERED = 0x010E;
  static const int CONFIRMED = 0x010F;

  static const int TIP_ENTERED = 0x0110;

  static const int BARCODE_SCAN_FAILED = 0x0113;
  static const int EMV_TRANSACTION_REQUESTED = 0x0114;
  static const int EMV_TRANSACTION_FAILED = 0x0115;
  static const int CARD_SWIPED_ENCRYPTED = 0x0116;
  static const int EMV_TRANSACTION_REVERSED = 0x0119;
  static const int EMV_TRANSACTION_CONFIRMED = 0x011A;
  static const int EMV_PAYPASS_MSG_SIGNAL = 0x011B;
  static const int EMV_PAYPASS_OUT_SIGNAL = 0x011C;
  static const int EMV_PAYWAVE_CLEARING_RECORDS = 0x011D;
  static const int EMV_CT_DATA_READ = 0x011E;
  static const int EMV_CARD_REMOVED = 0x011F;

  static const int IC_CARD_SWIPED = 0x0122;
  static const int EMV_FALLBACK_TRIGGERED = 0x0123;
  static const int KEY_PRESSED = 0x0125;
  static const int BATTERY_LOW = 0x0126;

  static const int CARD_SWIPED_PINBLOCK_GENERATED_SSG = 0x0124; // SSG

  static const int IC_CASH_READ_COMPLETED = 0x0127; // KOREA
  static const int IC_CASH_MULTI_ACCOUNT_READ = 0x0128; // KOREA

  static const int SSG_PAY_READ = 0x0129; // SSG
}

/// Native SDK KPOS Result code.
class KPOSRCode {
  KPOSRCode._();

  static const int SUCCESS = 0x0000;

  static const int NO_RESPONSE = 0x0001;
  static const int NO_CONNECTED_DEVICE = 0x0002;
  static const int DEVICE_BUSY = 0x0003;
  static const int INVALID_RESPONSE = 0x0004;
  static const int DEACTIVATED = 0x0005;

  static const int ERROR = 0x0100;
  static const int CRC_ERROR = 0x0101;
  static const int INTERNAL_ERROR = 0x0102;
  static const int NOT_SUPPORT = 0x0103;
  static const int INSUFFICIENT_MEMORY = 0x0104;

  static const int INVALID_STATE = 0x0201;
  static const int INVALID_PARAMETER = 0x0202;
  static const int DEVICE_ERROR = 0x0203;
  static const int KEY_NOT_FOUND = 0x0204;
  static const int PINPAD_SKIMMER_DETECTED = 0x0205;
  static const int ENCRYPTION_FAILED = 0x0206;
  static const int COMPROMISED = 0x0207;

  static const int NOT_VERIFIED = 0x0208; // SSG
  static const int NO_ENCRYPT_SEED = 0x0209; // SSG

  static const int RSA_INITIALIZE_FAILED = 0x020A;
  static const int RSA_LOAD_FAILED = 0x020B;
  static const int RSA_ENCRYPTION_FAILED = 0x020C;
  static const int AES_INITIALIZE_FAILED = 0x020D;
  static const int DUKPT_LOAD_FAILED = 0x020E;
  static const int DIGEST_INITIALIZE_FAILED = 0x020F;
  static const int DIGEST_PROCESS_FAILED = 0x0210;
  static const int DIGEST_VALUE_MISMATCHED = 0x0211;
  static const int KEY_ALLOCATION_FAILED = 0x0212;
  static const int NOT_SUPPORTED_LOCALE = 0x0213;

  static const int EMV_DECLINED = 0x0300;
  static const int EMV_READ_CARD_FAILED = 0x0301;
  static const int EMV_BUILD_CANDIDATE_FAILED = 0x0302;
  static const int EMV_TRY_NEXT_APPLICATION = 0x0303;
  static const int EMV_CARD_ERROR = 0x0304;
  static const int EMV_CARD_BLOCKED = 0x0305;
  static const int EMV_TRANSACTION_NOT_ACCEPTED = 0x0306;
  static const int EMV_PAN_MISMATCHED = 0x0307;
  static const int EMV_EXPIRY_DATE_MISMATCHED = 0x0308;
  static const int EMV_TRANSACTION_NOT_VALID = 0x0309;
  static const int EMV_CHECKSUM_ERROR = 0x030A;
  static const int EMV_TRANSACTION_REVERSAL = 0x030B;
  static const int EMV_PROTOCOL_ERROR = 0x030C;
  static const int EMV_SELECT_APP_FAILED = 0x030D;
  static const int EMV_POWER_ON_FAILED = 0x030E;
  static const int EMV_ABORT_TRANSACTION = 0x030F;
  static const int EMV_PROCESSING_ERROR = 0x0310;

  static const int EMV_CL_TRY_AGAIN = 0x0401;
  static const int EMV_CL_TRY_ANOTHER_INTERFACE = 0x0402;
  static const int EMV_CL_TRY_ANOTHER_CARD = 0x0403;

  static const int KICC_VAN_CODE_MISMATCHED = 0x0501;
  static const int KICC_SEQ_NUM_FAILED = 0x0502;
  static const int KICC_DATA_LENGTH_FAILED = 0x0503;
  static const int KICC_INVALID_PARAMETER = 0x0504;
  static const int KICC_KEY_SLOT_FULL = 0x0505;
  static const int KICC_RSA_KEY_NOT_FOUND = 0x0506;
}

/// KPOS Constants.
/// Constant value for KPOS operation.
class KPOSConst {
  KPOSConst._();

  // Card Types
  static const int CARD_TYPE_MAGNETIC = 1;
  static const int CARD_TYPE_EMV_CONTACT = 2;
  static const int CARD_TYPE_EMV_CONTACTLESS = 4;

  // Card Data encryption type
  static const int CARD_DATA_ENCRYPTION_NONE = 0;
  static const int CARD_DATA_ENCRYPTION_TDES = 1;
  static const int CARD_DATA_ENCRYPTION_AES128 = 2;
  static const int CARD_DATA_ENCRYPTION_AES196 = 3;
  static const int CARD_DATA_ENCRYPTION_AES256 = 4;

  // Read Data Target
  static const int READ_DATA_TARGET_MSR = 1;
  static const int READ_DATA_TARGET_BARCODE = 2;
  static const int READ_DATA_TARGET_NFC = 4;
  static const int READ_DATA_TARGET_NUMERIC_KEYPAD = 8;
  static const int READ_DATA_TARGET_ALPHANUMERIC_KEYPAD = 16;

  // EMV Transaction Type
  static const int EMV_TRANS_PURCHASE = 0x00;
  static const int EMV_TRANS_PURCHASE_WITH_CASHBACK = 0x09;
  static const int EMV_TRANS_REFUND = 0x14;

  // EMV Additional Operation
  static const int EMV_ADDITIONAL_OP_NONE = 0x00;
  static const int EMV_ADDITIONAL_OP_BYPASSPIN = 0x01;
  static const int EMV_ADDITIONAL_OP_FORCED_ONLINE = 0x02;
  static const int EMV_ADDITIONAL_OP_FORCED_SUCCESSPIN = 0x04;

  // EMV Fallback Type
  static const int EMV_FALLBACK_IC_MALFUNCTION = 0x01;
  static const int EMV_FALLBACK_POWER_ON_FAIL = 0x02;
  static const int EMV_FALLBACK_BUILD_CANDIDATE_FAIL = 0x03;
  static const int EMV_FALLBACK_CHIP_DATA_READ_FAIL = 0x04;
  static const int EMV_FALLBACK_TRACK2_DATA_MISSING = 0x05;

  // EMV CL Online PIN Support
  static const int EMV_CL_ONLINE_PIN_DISABLED = 0x00;
  static const int EMV_CL_ONLINE_PIN_ENABLED = 0X01;
  static const int EMV_CL_ONLINE_PIN_NOTUSED = 0X02;

  // EMV CL Track Data Activity
  static const int EMV_CL_TRACK_DATA_ACTIVITY_TRACK1 = 1;
  static const int EMV_CL_TRACK_DATA_ACTIVITY_TRACK2 = 2;

  // POS Entry Mode
  static const int POS_ENTRY_MODE_MS = 0x90; // MS
  static const int POS_ENTRY_MODE_FALLABACK_MS = 0x80; // Fallback MS

  // Predefined Title ID
  static const int TITLE_NONE = 0;
  static const int TITLE_EMPLYOEE_CARD = 48;
  static const int TITLE_CASH_RECEIPT_CARD = 49;
  static const int TITLE_MEMBERSHIP_CARD = 50;
  static const int TITLE_DISCOUNT_CARD = 51;
  static const int TITLE_ENTER_PIN = 52;
  static const int TITLE_ENTER_CARD_PHONE = 53;
  static const int TITLE_ENTER_PHONE = 54;
  static const int TITLE_ENTER_7DIGIT_ID = 55;

  // Key Tone
  static const int KEYTONE_NONE = 0;
  static const int KEYTONE_LOW = 1;
  static const int KEYTONE_MEDUIM = 2;
  static const int KEYTONE_HIGH = 3;

  // Beep Volume
  static const int BEEP_VOLUME_LOW = 1;
  static const int BEEP_VOLUME_HIGH = 3;

  // Card Enabled Status Flag bit
  static const int CARD_ENABLED_MSR = 1;
  static const int CARD_ENABLED_NFC = 2;

  // Encryption Digest Type
  static const int DIGEST_SHA256 = 1;

  // PIN Block Format
  static const int PINBLOCK_FORMAT0 = 0;
  static const int PINBLOCK_FORMAT1 = 1;
  static const int PINBLOCK_FORMAT2 = 2;
  static const int PINBLOCK_FORMAT3 = 3;
  static const int PINBLOCK_FORMAT_KICC = 4;

  // Encryption Spec
  static const int ENCRYPTION_SPEC_NONE = 0; // NO Encryption
  static const int ENCRYPTION_SPEC_1 = 1; // KOAMTAC STANDARD
  static const int ENCRYPTION_SPEC_2 = 2; // SSG

  // Keypad Key Value
  static const int KEYPAD_ENTER_KEY = 0x0D;
  static const int KEYPAD_CLEAR_KEY = 0x08;
  static const int KEYPAD_CANCEL_KEY = 0x18;

  // RKL Target
  static const int RKL_TARGET_CARD_ENCRYPTION = 1;
  static const int RKL_TARGET_PIN_ENCRYPTION = 2;

  // Keypad Type
  static const int KEYPAD_TYPE_NUMERIC = 0x00;
  static const int KEYPAD_TYPE_ALPHA_NUMERIC = 0x01;

  // Pre-defined Message String
  static const int KT_MSG_NONE = 0;
  static const int KT_MSG_ENTER = 1;
  static const int KT_MSG_PLEASE_ENTER = 2;
  static const int KT_MSG_COUPON_NO = 3;
  static const int KT_MSG_EMAIL = 4;
  static const int KT_MSG_GIFT_CARD_NO = 5;
  static const int KT_MSG_MEMBERSHIP_NO = 6;
  static const int KT_MSG_PREPAID_CARD_NO = 7;
  static const int KT_MSG_TIP_AMOUNT = 8;
  static const int KT_MSG_TIP_RATE = 9;
  static const int KT_MSG_ZIP = 10;
  static const int KT_MSG_ENTER_CARD_NO = 11;
  static const int KT_MSG_ENTER_PHONE_NO = 12;
  static const int KT_MSG_CARD_NO = 13;
  static const int KT_MSG_PHONE_NO = 14;
}

/// KPOS Locales.
enum KPOSLocale {
  ENGLISH(0x1),
  FRENCH(0x1 << 1),
  GERMAN(0x1 << 2),
  ITALIAN(0x1 << 3),
  SPANISH(0x1 << 4),
  KOREAN(0x1 << 5),
  JAPANESE(0x1 << 6);

  final value;

  const KPOSLocale(this.value);
}

/// KPOS Align.
enum KPOSAlign {
  LEFT,
  CENTER,
  RIGHT,
}

/// The object contains KPOS Data.
///
/// It is passed as a parameter when the PosDataListener is called.
/// The validity of each data is determined by the data type.
class KPOSData {
  KPOSData._(
    this.commandCode, {
    required this.eventCode,
    required this.barcode,
    required this.barcodeBytes,
    required this.nfc,
    required this.nfcBytes,
    required this.nfcUid,
    required this.track1,
    required this.track2,
    required this.track3,
    required this.posEntryMode,
    required this.encryptionSpec,
    required this.encryptiontype,
    required this.encryptedDataSize,
    this.maskedTrack1,
    this.maskedTrack2,
    this.maskedTrack3,
    required this.unencryptedTrack1Length,
    required this.unencryptedTrack2Length,
    required this.unencryptedTrack3Length,
    required this.unencryptedPANLength,
    required this.encyrptedTrack1Bytes,
    required this.encyrptedTrack2Bytes,
    required this.encyrptedTrack3Bytes,
    required this.encyrptedPANBytes,
    required this.digestType,
    required this.digestTrack1Bytes,
    required this.digestTrack2Bytes,
    required this.digestTrack3Bytes,
    required this.digestPANBytes,
    required this.cardDataKSN,
    required this.deviceSerialNumber,
    required this.isAutoAppSelection,
    required this.numberOfAIDs,
    required this.emvApplicationList,
    required this.emvTagList,
    required this.emvResultCode,
    required this.emvFallbackType,
    required this.errorCode,
    required this.pinBlockBytes,
    required this.pinBlockKSN,
    required this.valueEntered,
    required this.pressedKey,
    required this.batteryStatus,
    required this.selectedItemIndex,
  });

  /// Command code defined in KPOSConstants of native SDK.
  int commandCode;

  /// Event code from native SDK [KPOSEvent].
  int eventCode;

  /// Barcode data.
  String barcode;

  /// Received barcode data as byte array.
  Uint8List barcodeBytes;

  /// NFC data.
  String nfc;

  /// Received nfc data as byte array.
  Uint8List nfcBytes;

  /// NFC UID.
  String nfcUid;

  /// The string representation of track1 data received from the KDC500 series.
  String track1;

  /// The string representation of track2 data received from the KDC500 series.
  String track2;

  /// The string representation of track3 data received from the KDC500 series.
  String track3;

  /// POS entry mode defined in [KPOSConst].
  /// (0x90: normal MS read, 0x80 : fallback MS read).
  int posEntryMode;

  /// The card data encryption type.
  ///
  /// [KPOSConst.ENCRYPTION_SPEC_NONE], [KPOSConst.ENCRYPTION_SPEC_1] or
  /// [KPOSConst.ENCRYPTION_SPEC_2] defined in KPOSConstants of native SDK.
  int encryptionSpec;

  /// The card data encryption type.
  ///
  /// [KPOSConst.CARD_DATA_ENCRYPTION_NONE], [KPOSConst.CARD_DATA_ENCRYPTION_TDES], [KPOSConst.CARD_DATA_ENCRYPTION_AES128],
  /// [KPOSConst.CARD_DATA_ENCRYPTION_AES196] or [KPOSConst.CARD_DATA_ENCRYPTION_AES256]
  /// defined in KPOSConstants of native SDK.
  int encryptiontype;

  /// The total size of encrypted data.
  int encryptedDataSize;

  /// The string representation of masked track1 data received from the KDC500 series.
  /// 
  /// This is only available on Android devices.
  String? maskedTrack1;

  /// The string representation of masked track2 data received from the KDC500 series.
  /// 
  /// This is only available on Android devices.
  String? maskedTrack2;

  /// The string representation of masked track3 data received from the KDC500 series.
  /// 
  /// This is only available on Android devices.
  String? maskedTrack3;

  /// The length of unencrypted track1 data.
  /// This length is used for the decryption of the encrypted track1 data.
  int unencryptedTrack1Length;

  /// The length of unencrypted track2 data.
  /// This length is used for the decryption of the encrypted track2 data.
  int unencryptedTrack2Length;

  /// The length of unencrypted track3 data.
  /// This length is used for the decryption of the encrypted track3 data.
  int unencryptedTrack3Length;

  /// The length of unencrypted PAN data.
  /// This length is used for the decryption of the encrypted PAN data.
  int unencryptedPANLength;

  /// The byte array representation of encrypted track1 data received from the KDC500 series.
  Uint8List encyrptedTrack1Bytes;

  /// The byte array representation of encrypted track2 data received from the KDC500 series.
  Uint8List encyrptedTrack2Bytes;

  /// The byte array representation of encrypted track3 data received from the KDC500 series.
  Uint8List encyrptedTrack3Bytes;

  /// The byte array representation of encrypted PAN data received from the KDC500 series.
  Uint8List encyrptedPANBytes;

  /// The type of digest for the card data encryption.
  ///
  /// [KPOSConst.DIGEST_SHA256] defined in KPOSConstants of native SDK.
  int digestType;

  /// The byte array representation of the digest for the encrypted track1 data.
  Uint8List digestTrack1Bytes;

  /// The byte array representation of the digest for the encrypted track2 data.
  Uint8List digestTrack2Bytes;

  /// The byte array representation of the digest for the encrypted track3 data.
  Uint8List digestTrack3Bytes;

  /// The byte array representation of the digest for the encrypted PAN data.
  Uint8List digestPANBytes;

  /// The string representation of KSN for Encrypted Card Data received from the KDC500 series.
  String cardDataKSN;

  /// The device serial number.
  String deviceSerialNumber;

  /// Check if the automatic application selection is enabled.
  bool isAutoAppSelection;

  /// The number of EMV Applications supported by the KDC500 and inserted IC Card.
  int numberOfAIDs;

  /// The EMV Application list.
  List<KPOSEMVApplication> emvApplicationList;

  /// The device serial number.
  KPOSEMVTagList emvTagList;

  /// The EMV result code.
  int emvResultCode;

  /// The EMV Fallback type for EMV fallback trigger event.
  int emvFallbackType;

  /// The error code for MS Card read failed event.
  int errorCode;

  /// The byte array representation of PIN Block data received from the KDC500 series.
  Uint8List pinBlockBytes;

  /// The string representation of KSN for PIN Block received from the KDC500 series.
  String pinBlockKSN;

  /// The string representation of data, which is entered via keypad, received from the KDC500 series.
  String valueEntered;

  /// The representation of the key pressed.
  int pressedKey;

  /// The battery status for Battery Low event. [1, 100].
  int batteryStatus;

  /// Selected item index. 0: not selected 1 ~ N: selected item index.
  int selectedItemIndex;

  static KPOSData fromMap(Map<String, dynamic> map) {
    return KPOSData._(
      map['commandCode'] as int,
      eventCode: map['eventCode'] as int,
      barcode: map['barcode'] as String,
      barcodeBytes: map['barcodeBytes'] as Uint8List,
      nfc: map['nfc'] as String,
      nfcBytes: map['nfcBytes'] as Uint8List,
      nfcUid: map['nfcUid'] as String,
      track1: map['track1'] as String,
      track2: map['track2'] as String,
      track3: map['track3'] as String,
      posEntryMode: map['posEntryMode'] as int,
      encryptionSpec: map['encryptionSpec'] as int,
      encryptiontype: map['encryptiontype'] as int,
      encryptedDataSize: map['encryptedDataSize'] as int,
      maskedTrack1: map['maskedTrack1'] as String?,
      maskedTrack2: map['maskedTrack2'] as String?,
      maskedTrack3: map['maskedTrack3'] as String?,
      unencryptedTrack1Length: map['unencryptedTrack1Length'] as int,
      unencryptedTrack2Length: map['unencryptedTrack2Length'] as int,
      unencryptedTrack3Length: map['unencryptedTrack3Length'] as int,
      unencryptedPANLength: map['unencryptedPANLength'] as int,
      encyrptedTrack1Bytes: map['encyrptedTrack1Bytes'] as Uint8List,
      encyrptedTrack2Bytes: map['encyrptedTrack2Bytes'] as Uint8List,
      encyrptedTrack3Bytes: map['encyrptedTrack3Bytes'] as Uint8List,
      encyrptedPANBytes: map['encyrptedPANBytes'] as Uint8List,
      digestType: map['digestType'] as int,
      digestTrack1Bytes: map['digestTrack1Bytes'] as Uint8List,
      digestTrack2Bytes: map['digestTrack2Bytes'] as Uint8List,
      digestTrack3Bytes: map['digestTrack3Bytes'] as Uint8List,
      digestPANBytes: map['digestPANBytes'] as Uint8List,
      cardDataKSN: map['cardDataKSN'] as String,
      deviceSerialNumber: map['deviceSerialNumber'] as String,
      isAutoAppSelection: map['isAutoAppSelection'] as bool,
      numberOfAIDs: map['numberOfAIDs'] as int,
      emvApplicationList: map['emvApplicationList'] as List<KPOSEMVApplication>,
      emvTagList: map['emvTagList'] as KPOSEMVTagList,
      emvResultCode: map['emvResultCode'] as int,
      emvFallbackType: map['emvFallbackType'] as int,
      errorCode: map['errorCode'] as int,
      pinBlockBytes: map['pinBlockBytes'] as Uint8List,
      pinBlockKSN: map['pinBlockKSN'] as String,
      valueEntered: map['valueEntered'] as String,
      pressedKey: map['pressedKey'] as int,
      batteryStatus: map['batteryStatus'] as int,
      selectedItemIndex: map['selectedItemIndex'] as int,
    );
  }
}

/// The object contains the EMV application information.
class KPOSEMVApplication {
  KPOSEMVApplication._(this.index,
      {required this.priority, required this.name});

  /// Index.
  int index;

  /// Priority.
  int priority;

  /// App name.
  String name;

  static KPOSEMVApplication fromMap(Map<String, dynamic> map) {
    return KPOSEMVApplication._(
      map['index'] as int,
      priority: map['priority'] as int,
      name: map['name'] as String,
    );
  }
}

/// The object contains the EMV TLVs from EMV card.
class KPOSEMVTagList {
  KPOSEMVTagList._(this.tlvs, {this.cardBrand});

  /// Received TLVs as byte array.
  Uint8List tlvs;

  /// IC Card brand.
  String? cardBrand;

  static KPOSEMVTagList fromMap(Map<String, dynamic> map) {
    return KPOSEMVTagList._(
      map['tlvs'] as Uint8List,
      cardBrand: map['cardBrand'] as String?,
    );
  }
}

class KPOSResult {
  KPOSResult._(this.opCode,
      {this.serialNumber,
      this.loaderVersion,
      this.applicationVersion,
      this.bluetoothVersion,
      this.bluetoothName,
      this.barcodeType,
      this.batteryStatus,
      this.numOfEMVBatchData,
      this.keyToneVolume,
      this.beepVolume,
      this.beepSoundFlag,
      this.beepPowerOn,
      this.beepBarcodeScan,
      this.beepConnection,
      this.msrEnabled,
      this.nfcEnabled,
      this.keypadMenuEntryEnabled,
      this.date,
      this.locales});

  /// POS operation result code from native SDK.
  ///
  /// RCODE_XX which are defined in KPOSConstants of native SDK [KPOSRCode].
  int opCode;

  /// Serial number.
  String? serialNumber;

  /// Loader version.
  String? loaderVersion;

  /// Firmware version.
  String? firmwareVersion;

  /// KDC application version.
  String? applicationVersion;

  /// Bluetooth version.
  String? bluetoothVersion;

  /// Bluetooth name.
  String? bluetoothName;

  /// Not installed(0), 1D barcode(1), 2D barcode(2).
  int? barcodeType;

  /// Battery status [1,100].
  int? batteryStatus;

  /// The number of EMV batch data.
  int? numOfEMVBatchData;

  /// Key tone volume.
  int? keyToneVolume;

  /// Beep volume.
  int? beepVolume;

  /// Beep sound flag.
  bool? beepSoundFlag;

  /// Beep when power on.
  bool? beepPowerOn;

  /// Beep when barcode scan.
  bool? beepBarcodeScan;

  /// Beep when connection.
  bool? beepConnection;

  /// Check if MSR is enabled.
  bool? msrEnabled;

  /// Check if NFC is enabled.
  bool? nfcEnabled;

  /// Check if Keypad Menu Entry is enabled.
  bool? keypadMenuEntryEnabled;

  /// Date string.
  String? date;

  /// Supported locales [KPOSLocale].
  List<KPOSLocale>? locales;

  static KPOSResult fromMap(Map<String, dynamic> map) {
    final result = KPOSResult._(
      map['opCode'] as int,
      serialNumber: map['serialNumber'] as String?,
      loaderVersion: map['loaderVersion'] as String?,
      applicationVersion: map['applicationVersion'] as String?,
      bluetoothVersion: map['bluetoothVersion'] as String?,
      bluetoothName: map['bluetoothName'] as String?,
      barcodeType: map['barcodeType'] as int?,
      batteryStatus: map['batteryStatus'] as int?,
      numOfEMVBatchData: map['numOfEMVBatchData'] as int?,
      keyToneVolume: map['keyToneVolume'] as int?,
      beepVolume: map['beepVolume'] as int?,
      beepSoundFlag: map['beepSoundFlag'] as bool?,
      beepPowerOn: map['beepPowerOn'] as bool?,
      beepBarcodeScan: map['beepBarcodeScan'] as bool?,
      beepConnection: map['beepConnection'] as bool?,
      msrEnabled: map['msrEnabled'] as bool?,
      nfcEnabled: map['nfcEnabled'] as bool?,
      keypadMenuEntryEnabled: map['keypadMenuEntryEnabled'] as bool?,
      date: map['date'] as String?,
    );

    return result;
  }
}
