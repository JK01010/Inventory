package koamtac.kdc.sdk.plugins

class KConstants {
    companion object {
        const val EMPTY_STRING = ""
        const val OpCode = "opCode"
    }

    object ConnectionKey {
        const val State = "state"
        const val Device = "device"
    }

    object DeviceInfoKey {
        const val Name = "name"
        const val Firmware = "firmware"
        const val SerialNumber = "serial"
        const val IsFlash = "isFlash"
        const val IsBluetooth = "isBluetooth"
        const val IsBarcode = "isBarcode"
        const val Is2D = "is2D"
        const val IsMSR = "isMSR"
        const val IsNFC = "isNFC"
        const val IsGPS = "isGPS"
        const val IsUHF = "isUHF"
        const val IsWiFi = "isWiFi"
        const val IsKeypad = "isKeypad"
        const val IsVibrator = "isVibrator"
        const val IsDisplay = "isDisplay"
        const val IsPassportReader = "isPassportReader"
        const val IsFingerPrint = "isFingerPrint"
        const val IsMsrIc = "isMSRIC"
        const val IsSocialDistance = "isSocialDistance"
        const val IsOCR = "isOCR"
        const val IsMRZ = "isMRZ"
        const val IsSLED = "isSLED"
        const val IsNewArchitectureModel = "isNA"
        const val IsPos = "isPOS"
    }

    object DeviceKey {
        const val DeviceName = "deviceName"
        const val Device = "device"
        const val Type = "type"
        const val SubType = "subType"
        const val KDCName = "kdcName"
    }

    object ResultKey {
        const val ErrorCode = "errorCode" // Result code from native SDK
    }

    object DataKey {
        const val Type = "type"
        const val Data = "data"
        const val DataBytes = "dataBytes"
        const val Symbol = "symbol"
        const val Barcode = "barcode"
        const val GPS = "gps"
        const val MSR = "msr"
        const val MSRBytes = "msrBytes"
        const val NFCTagType = "nfcType"
        const val NFCUid = "nfcUid"
        const val NFC = "nfc"
        const val NFCBytes = "nfcBytes"
        const val KeyEvent = "key"
        const val UHFListType = "uhfListType"
        const val UHFList = "uhfList"
        const val UHFRssiList = "uhfRssiList"
        const val Record = "record"
    }

    object SelectParameterKey {
        const val Target = "target"
        const val Action = "action"

        //static final String MemoryBank = "memBank";
        const val Bank = "bank"
        const val Pointer = "pointer"
        const val Length = "length"
        const val MaskData = "maskData"
        const val MaskDataBytes = "maskDataBytes"

        //static final String IsTruncated = "isTruncated";
        const val Truncated = "truncated"
    }

    object QueryParameterKey {
        const val Dr = "dr"
        const val Cycle = "cycle"
        const val TRext = "tRext"
        const val Sel = "sel"
        const val Session = "session"
        const val Target = "target"
        const val SlotNum = "slotNum"
    }

    object PosDataKey {
        const val CommandCode = "commandCode"
        const val EventCode = "eventCode"
        const val ErrorCode = "errorCode"
        const val Data = "data"
        const val DataBytes = "dataBytes"
        const val Barcode = "barcode"
        const val BarcodeBytes = "barcodeBytes"
        const val NFC = "nfc"
        const val NFCUid = "nfcUid"
        const val NFCBytes = "nfcBytes"
        const val PinBlock = "pinBlock"
        const val PinBlockBytes = "pinBlockBytes"
        const val CardDataKSN = "cardDataKSN"
        const val PinBlockKSN = "pinBlockKSN"
        const val DeviceSerialNumber = "deviceSerialNumber"
        const val Track1 = "track1"
        const val Track2 = "track2"
        const val Track3 = "track3"
        const val EncryptSpec = "encryptSpec"
        const val EncryptType = "encryptType"
        const val EncryptedDataSize = "encryptedDataLength"
        const val maskedTrack1 = "maskedTrack1"
        const val maskedTrack2 = "maskedTrack2"
        const val maskedTrack3 = "maskedTrack3"
        const val UnencryptedTrack1Length = "unencryptedTrack1Length"
        const val UnencryptedTrack2Length = "unencryptedTrack2Length"
        const val UnencryptedTrack3Length = "unencryptedTrack3Length"
        const val UnencryptedPANLength = "unencryptedPANLength"
        const val EncryptedTrack1 = "encryptedTrack1"
        const val EncryptedTrack2 = "encryptedTrack2"
        const val EncryptedTrack3 = "encryptedTrack3"
        const val EncryptedTrack1Bytes = "encryptedTrack1Bytes"
        const val EncryptedTrack2Bytes = "encryptedTrack2Bytes"
        const val EncryptedTrack3Bytes = "encryptedTrack3Bytes"
        const val EncryptedPAN = "encryptedPAN"
        const val EncryptedPANBytes = "encryptedPANBytes"
        const val DigestType = "digestType"
        const val DigestTrack1 = "digestTrack1"
        const val DigestTrack2 = "digestTrack2"
        const val DigestTrack3 = "digestTrack3"
        const val DigestTrack1Bytes = "digestTrack1Bytes"
        const val DigestTrack2Bytes = "digestTrack2Bytes"
        const val DigestTrack3Bytes = "digestTrack3Bytes"
        const val DigestPAN = "digestPAN"
        const val DigestPANBytes = "digestPANBytes"
        const val IsAutoAppSelection = "isAutoAppSelection"
        const val NumberOfAIDs = "numberOfAIDs"
        const val EMVApplicationList = "emvApps"
        const val EMVTagList = "emvTagList"
        const val EMVResultCode = "emvResultCode"
        const val EMVFallbackType = "emvFallbackType"
        const val PosEntryMode = "posEntryMode"
        const val BatteryStatus = "batteryStatus"
        const val PressedKey = "pressedKey"
        const val ValueEntered = "valueEntered"
        const val SelectedItemIndex = "selectedItemIndex"
    }

    object PosResultKey {
        const val ResultCode = OpCode
        const val SerialNumber = "serialNumber"
        const val LoaderVersion = "loaderVersion"
        const val FirmwareVersion = "firmwareVersion"
        const val ApplicationVersion = "applicationVersion"
        const val BluetoothVersion = "bluetoothVersion"
        const val BluetoothName = "bluetoothName"
        const val BarcodeType = "barcodeType"
        const val BatteryStatus = "batteryStatus"
        const val KeyToneVolume = "keyToneVolume"
        const val BeepVolume = "beepVolume"
        const val BeepSoundFlag = "beepSoundFlag"
        const val BeepPowerOn = "beepPowerOn"
        const val BeepBarcodeScan = "beepBarcodeScan"
        const val BeepConnection = "beepConnection"
        const val MsrEnabled = "msrEnabled"
        const val NfcEnabled = "nfcEnabled"
        const val KeypadMenuEntryEnabled = "keypadMenuEntryEnabled"
        const val Date = "date"
        const val Locales = "locales"
        const val NumOfEMVBatchData = "numOfEMVBatchData"
    }

    object PosEMVTagKey {
        const val TLV = "tlvs"
        const val Brand = "brand"
    }

    object PosEMVAppKey {
        const val Index = "index"
        const val Priority = "priority"
        const val Name = "name"
    }

    class ErrorCode private constructor() {
        var SUCCESS: Map<String, Any>
        var FAILED: Map<String, Any>
        var NULL: Map<String, Any>
        var NOT_CONNECTED: Map<String, Any>
        var USB_PERMISSION_DENIED: Map<String, Any>
        var INVALID_PARAMETER: Map<String, Any>
        var UNSUPPORTED: Map<String, Any>
        var JSON_EXCEPTION: Map<String, Any>

        init {
            SUCCESS = mapOf(
                KEY_CODE to Integer.toString(CODE_SUCCESS),
                KEY_MESSAGE to MESSAGE_SUCCESS
            );
            FAILED = mapOf(
                KEY_CODE to Integer.toString(CODE_FAILED),
                KEY_MESSAGE to MESSAGE_FAILED
            );
            NULL = mapOf(
                KEY_CODE to Integer.toString(CODE_NULL),
                KEY_MESSAGE to MESSAGE_NULL
            );
            NOT_CONNECTED = mapOf(
                KEY_CODE to Integer.toString(CODE_NOT_CONNECTED),
                KEY_MESSAGE to MESSAGE_NOT_CONNECTED
            );
            USB_PERMISSION_DENIED = mapOf(
                KEY_CODE to Integer.toString(CODE_USB_PERMISSION_DENIED),
                KEY_MESSAGE to MESSAGE_USB_PERMISSION_DENIED
            );
            INVALID_PARAMETER = mapOf(
                KEY_CODE to Integer.toString(CODE_INVALID_PARAMETER),
                KEY_MESSAGE to MESSAGE_INVALID_PARAMETER
            );
            UNSUPPORTED = mapOf(
                KEY_CODE to Integer.toString(CODE_UNSUPPORTED),
                KEY_MESSAGE to MESSAGE_UNSUPPORTED
            );
            JSON_EXCEPTION = mapOf(
                KEY_CODE to Integer.toString(CODE_JSON_EXCEPTION),
                KEY_MESSAGE to MESSAGE_JSON_EXCEPTION
            );
        }

        companion object {
            const val KEY_CODE = "code"
            const val KEY_MESSAGE = "message"

            val KEY_OPERATION: String = KConstants.OpCode
            val KEY_OPERATION_POS: String = KConstants.OpCode

            private const val CODE_SUCCESS = 0
            private const val CODE_FAILED = 1
            private const val CODE_NULL = 2
            private const val CODE_NOT_CONNECTED = 3
            private const val CODE_USB_PERMISSION_DENIED = 4
            private const val CODE_INVALID_PARAMETER = 5
            private const val CODE_UNSUPPORTED = 6
            private const val CODE_JSON_EXCEPTION = 7

            private const val MESSAGE_SUCCESS = "The operation is succeeded."
            private const val MESSAGE_FAILED = "The operation is failed."
            private const val MESSAGE_NULL = "Instance is null."
            private const val MESSAGE_NOT_CONNECTED = "KDC Device is not connected."
            private const val MESSAGE_USB_PERMISSION_DENIED = "USB Permission is denied."
            private const val MESSAGE_INVALID_PARAMETER = "The parameter is not valid."
            private const val MESSAGE_UNSUPPORTED = "The operation is unsupported."
            private const val MESSAGE_JSON_EXCEPTION = "Json exception occurs."

            val instance = ErrorCode();
        }
    }

    // region Software Decoder
    object SWDecoderActivationKey {
        const val Code = "code"
        const val Message = "message"
        const val DeviceId = "deviceId"
    }

    object SWDecoderSettingKey {
        const val FlashOnDecode = "flashOnDecode"
        const val Decode = "decode"

//        const val EnabledSymbol = "enabledSymbol";
//        const val DisabledSymbol = "disabledSymbolEnabled";
        const val Window = "window"
        const val WindowMode = "windowMode"
        const val Sound = "sound"
        const val Aimer = "aimer"
        const val AimerColor = "aimerColor"
        const val OverlayText = "overlayText"
        const val OverlayTextColor = "overlayTextColor"
        const val OCRActiveTemplate = "ocrActive"
        const val OCRUserTemplate = "ocrUser"
        const val ActiveCamera = "activeCamera"
    }

    object SWDecoderImageKey {
        const val Width = "width"
        const val Height = "height"
        const val Png = "png"
    }

    object SWDecoderBoundsKey {
        const val TopLeft = "topLeft"
        const val TopRight = "topRight"
        const val BottomLeft = "bottomLeft"
        const val BottomRight = "bottomRight"
        const val Width = "width"
        const val Height = "height"
        const val X = "x"
        const val Y = "y"
    }

    object SWDecoderDataKey {
        const val Bounds = "bounds"
    }

    // endregion SoftwareDecoder
}