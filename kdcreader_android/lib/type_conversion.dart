import 'package:kdcreader_platform_interface/kdcreader_platform_interface.dart';
import 'package:collection/collection.dart';

String toDeviceListTypeString(DeviceListType type) {
  switch (type) {
    case DeviceListType.BONDED_BLUETOOTH_LIST:
      return "BondedBluetooth";
    case DeviceListType.ATTACHED_USB_LIST:
      return "AttachedUsbDevice";
    case DeviceListType.SCANNED_BLUETOOTH_LIST:
      return "ScannedBluetooth";
    case DeviceListType.SOFTWARE_DECODER_LIST: // Software Decoder
      return "SoftwareDecoder";
    default:
      return "";
  }
}

SleepTimeout? toSleepTimeoutEnum(int value) {
  return SleepTimeout.values.firstWhereOrNull((el) => el.value == value);
}

int? toSleepTimeoutValue(SleepTimeout timeout) {
  return timeout.value;
}

BluetoothAutoPowerOffDelay? toBluetoothAutoPowerOffDelayEnum(int value) {
  return BluetoothAutoPowerOffDelay.values
      .firstWhereOrNull((el) => el.value == value);
}

int? toBluetoothAutoPowerOffDelayValue(BluetoothAutoPowerOffDelay timeout) {
  return timeout.value;
}

HIDAutoLockTime? toHIDAutoLockTimeEnum(int value) {
  return HIDAutoLockTime.values.firstWhereOrNull((el) => el.value == value);
}

int? toHIDAutoLockTimeValue(HIDAutoLockTime timeout) {
  return timeout.value;
}

HIDInitialDelay? toHIDInitialDelayEnum(int value) {
  return HIDInitialDelay.values.firstWhereOrNull((el) => el.value == value);
}

int? toHIDInitialDelayValue(HIDInitialDelay delay) {
  return delay.value;
}

HIDInterDelay? toHIDInterDelayEnum(int value) {
  return HIDInterDelay.values.firstWhereOrNull((el) => el.value == value);
}

int? toHIDInterDelayValue(HIDInterDelay delay) {
  return delay.value;
}

UHFRegion? toUHFRegionEnum(int value) {
  return UHFRegion.values.firstWhereOrNull((el) => el.value == value);
}

int? toUHFRegionValue(UHFRegion region) {
  return region.value;
}

KPOSLocale? toKPOSLocaleEnum(int value) {
  return KPOSLocale.values.firstWhereOrNull((el) => el.value == value);
}

int? toKPOSLocaleValue(KPOSLocale locale) {
  return locale.value;
}

/*
 * Software Decoder
 */
int? toSWDecoderOCRActiveTemplatValue(KDCSWDecoderOCRActiveTemplate? active) {
  return active?.value;
}
