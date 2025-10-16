import 'package:collection/collection.dart';

import 'package:kdcreader_platform_interface/src/kdc_constants.dart';
import 'package:kdcreader_platform_interface/src/kpos_constants.dart';
import 'package:kdcreader_platform_interface/src/ksw_constants.dart'; // software decoder

DataType toDataTypeEnum(int? value) {
  return DataType.values
      .firstWhere((el) => el.value == value, orElse: () => DataType.UNKNOWN);
}

NFCTagType? toNFCTagTypeEnum(int? value) {
  final index = value;
  return (index is int) ? NFCTagType.values[index] : null;
}

ConnectState toConnectStateEnum(int? value) {
  return ConnectState.values
      .firstWhere((el) => el.value == value, orElse: () => ConnectState.None);
}

//
// Software Decoder
//
KDCSWDecoderWindowMode? toSWDecoderWindowModeEnum(int? value) {
  final index = value;
  return (index is int) ? KDCSWDecoderWindowMode.values[index] : null;
}

KDCSWDecoderOCRActiveTemplate? toSWDecoderOCRActiveTemplatEnum(int? value) {
  return KDCSWDecoderOCRActiveTemplate.values
      .firstWhereOrNull((el) => el.value == value);
}

KDCSWDecoderCameraType? toSWDecoderCameraTypeEnum(int? value) {
  final index = value;
  return (index is int) ? KDCSWDecoderCameraType.values[index] : null;
}
