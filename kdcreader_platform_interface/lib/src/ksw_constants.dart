//
// Software Decoder
//
import 'dart:ui';
import 'package:flutter/foundation.dart';

import 'package:kdcreader_platform_interface/src/kdc_constants.dart';
import 'package:kdcreader_platform_interface/src/type_conversion.dart';

/// Software decoder component view type
const SWComponentViewType = "SWComponentView";

/// Software decoder Window Mode
enum KDCSWDecoderWindowMode {
  /// Windowing disabled, full image is decoded.
  OFF,

  /// Only barcodes that are within or crossing the defined window will be decoded.
  CENTERING,

  /// Only barcodes completely within the defined window will be decoded.
  WINDOWING,
}

/// Software decoder OCR Active Template Type
enum KDCSWDecoderOCRActiveTemplate {
  OCR_ACTIVE_USER_TEMPLATE(1),
  OCR_ACTIVE_PASSPORT_TEMPLATE(2),
  OCR_ACTIVE_ISBN_TEMPLATE(4),
  OCR_ACTIVE_PRICE_FIELD_TEMPLATE(8),
  OCR_ACTIVE_MICR_TEMPLATE(16);

  final int value;
  const KDCSWDecoderOCRActiveTemplate(this.value);
}

/// Software decoder Camera Type
enum KDCSWDecoderCameraType {
  REAR_FACING,
  FRONT_FACING,
}

/// Software decoder Activation Result
class KDCSWDecoderActivationResult {
  KDCSWDecoderActivationResult._(this.code,
      {required this.message, required this.deviceId});

  /// Native SDK Result code [RCode]
  int code;

  /// Result message
  String message;

  /// Device Id
  String deviceId;

  static KDCSWDecoderActivationResult fromMap(Map<String, dynamic> map) {
    return KDCSWDecoderActivationResult._(map['code'] as int,
        message: map['message'] as String, deviceId: map['deviceId'] as String);
  }
}

/// Software decoder Setting
class KDCSWDecoderSetting {
  KDCSWDecoderSetting();

  KDCSWDecoderSetting._(this.flashOnDecode,
      {this.decode,
      this.window,
      this.windowMode,
      this.sound,
      this.aimer,
      this.aimerColor,
      this.overlayText,
      this.overlayTextColor,
      this.ocrActive,
      this.ocrUser,
      this.activeCamera});

  /// Enable or disable the camera flash on a barcode scan attempt.
  bool? flashOnDecode;

  /// Enable or disable decoding.
  bool? decode;

  /// Subset of the image to decode. Each value means that [left, right, top, bottom].
  ///
  /// The bound of the windows as a percentage of the entire image. (e.g. 85 lef would indicate: .85 * imgWidth)
  Int32List? window;

  /// A specific region within the image that will be decoded.
  KDCSWDecoderWindowMode? windowMode;

  /// Enable or disable an audible beep on a successful decode.
  bool? sound;

  /// Enable or disable an aimer that will be displayed on the preview screen.
  bool? aimer;

  /// Set the color of the camera aimer graphic.
  int? aimerColor;

  /// Set the text of the overlay on the camera preview screen.
  String? overlayText;

  /// Set the color of the text overlay.
  int? overlayTextColor;

  /// The Active OCR template.
  KDCSWDecoderOCRActiveTemplate? ocrActive;

  /// The OCR user template.
  Uint8List? ocrUser;

  /// Set the camera that will be used for decoding.
  KDCSWDecoderCameraType? activeCamera;

  static KDCSWDecoderSetting fromMap(Map<String, dynamic> map) {
    // final window = (map['window'] as List?)?.cast<int>();
    final window = map['window'] as Int32List?;
    final windowMode = toSWDecoderWindowModeEnum(map['windowMode'] as int?);

    final ocrActiveTemplate =
        toSWDecoderOCRActiveTemplatEnum(map['ocrActive'] as int?);
    //final ocrUser = (map['ocrUser'] as List?)?.cast<int>();

    final cameraType = toSWDecoderCameraTypeEnum(map['activeCamera'] as int?);

    return KDCSWDecoderSetting._(map['flashOnDecode'] as bool?,
        decode: map['decode'] as bool?,
        window: window as Int32List?,
        windowMode: windowMode,
        sound: map['sound'] as bool?,
        aimer: map['aimer'] as bool?,
        aimerColor: map['aimerColor'] as int?,
        overlayText: map['overlayText'] as String?,
        overlayTextColor: map['overlayTextColor'] as int?,
        ocrActive: ocrActiveTemplate,
        ocrUser: map['ocrUser'] as Uint8List?,
        activeCamera: cameraType);
  }
}

/// Software decoder Image
class KDCSWDecoderImage {
  KDCSWDecoderImage._({this.width,
      this.height, this.png});

  /// Image width
  double? width;

  /// Image height
  double? height;

  /// Image data as PNG
  Uint8List? png;

  static KDCSWDecoderImage fromMap(Map<String, dynamic> map) {
    return KDCSWDecoderImage._(width: (map['width'] as int?)?.toDouble(),
        height: (map['height'] as int?)?.toDouble(), png: map['png'] as Uint8List?);
  }
}

/// Barocde bounds
class KDCDataBounds {
  Offset topLeft;
  Offset topRight;
  Offset bottomLeft;
  Offset bottomRight;
  double width;
  double height;

  KDCDataBounds(
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    this.width, 
    this.height);
}

/// The object contains KDC SW Data.
///
/// It is passed as a parameter when the barcode data listener is called using KDC8.
class KDCSWData extends KDCData {
  KDCSWData._(
      {required type,
      data,
      dataBytes,
      symbol,
      barcode,
      barcodeBytes,
      gps,
      msr,
      msrBytes,
      nfcType,
      nfcUid,
      nfc,
      nfcBytes,
      uhfListType,
      uhfList,
      uhfRssiList,
      key,
      record}):super(type) {
        super.data = data;
        super.dataBytes = dataBytes;
        super.symbol = symbol;
        super.barcode = barcode;
        super.barcodeBytes = barcodeBytes;
        super.gps = gps;
        super.msr = msr;
        super.msrBytes = msrBytes;
        super.nfcType = nfcType;
        super.nfcUid = nfcUid;
        super.nfc = nfc;
        super.nfcBytes = nfcBytes;
        super.uhfListType = uhfListType;
        super.uhfList = uhfList;
        super.uhfRssiList = uhfRssiList;
        super.key = key;
        super.record = record;
      }

  /// Data type.
  KDCDataBounds? bounds;

  static KDCSWData fromMap(Map<String, dynamic> map) {
    final dataType = toDataTypeEnum(map['type'] as int?);
    final nfcTagType = toNFCTagTypeEnum(map['nfcType'] as int?);

    final KDCSWData swData = KDCSWData._(
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

    final bounds = Map<String, dynamic>.from(map['bounds'] as Map<dynamic, dynamic>);

    if (bounds != null) {
      final topLeft = Map<String, dynamic>.from(bounds['topLeft'] as Map<dynamic, dynamic>);
      final topLeftX = (topLeft['x'] as int).toDouble();
      final topLeftY = (topLeft['y'] as int).toDouble();

      final topRight = Map<String, dynamic>.from(bounds['topRight'] as Map<dynamic, dynamic>);
      final topRightX = (topRight['x'] as int).toDouble();
      final topRightY = (topRight['y'] as int).toDouble();

      final bottomLeft = Map<String, dynamic>.from(bounds['bottomLeft'] as Map<dynamic, dynamic>);
      final bottomLeftX = (bottomLeft['x'] as int).toDouble();
      final bottomLeftY = (bottomLeft['y'] as int).toDouble();

      final bottomRight = Map<String, dynamic>.from(bounds['bottomRight'] as Map<dynamic, dynamic>);
      final bottomRightX = (bottomRight['x'] as int).toDouble();
      final bottomRightY = (bottomRight['y'] as int).toDouble();

      final width = (bounds['width'] as int).toDouble();
      final height = (bounds['height'] as int).toDouble();

      swData.bounds = new KDCDataBounds(
        new Offset(topLeftX, topLeftY),
        new Offset(topRightX, topRightY),
        new Offset(bottomLeftX, bottomLeftY),
        new Offset(bottomRightX, bottomRightY),
        width, height
      );   
    }
    return swData;
  }
}