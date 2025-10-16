//
//  KConstants.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/20/24.
//

import Foundation

struct KConstants {
    static let EMPTY_STRING = ""
    static let OpCode = "opCode"
    
    struct ConnectionKey {
        static let State = "state"
        static let Device = "device"
    }

    // Info updated Notification - CBManagerState
    struct InfoUpdatedKey {
        static let CbMnagerState = "cbManagerState"
    }
    
    struct DeviceInfoKey {
        static let Name = "name"
        static let Firmware = "firmware"
        static let SerialNumber = "serial"
        static let IsFlash = "isFlash"
        static let IsBluetooth = "isBluetooth"
        static let IsBarcode = "isBarcode"
        static let Is2D = "is2D"
        static let IsMSR = "isMSR"
        static let IsNFC = "isNFC"
        static let IsGPS = "isGPS"
        static let IsUHF = "isUHF"
        static let IsWiFi = "isWiFi"
        static let IsKeypad = "isKeypad"
        static let IsVibrator = "isVibrator"
        static let IsDisplay = "isDisplay"
        static let IsPassportReader = "isPassportReader"
        static let IsFingerPrint = "isFingerPrint"
        static let IsMsrIc = "isMSRIC"
        static let IsSocialDistance = "isSocialDistance"
        static let IsOCR = "isOCR"
        static let IsMRZ = "isMRZ"
        static let IsSLED = "isSLED"
        static let IsNewArchitectureModel = "isNA"
        static let IsPos = "isPOS"
    }

    struct DeviceKey {
        static let DeviceName = "deviceName"
        static let Device = "device"
        static let DeviceType = "type"
        static let SubType = "subType"
        static let KDCName = "kdcName"
        
        static let Identifier = "identifier" // for BLE
    }
    
    struct DeviceListTypeKey {
        static let ExternalAccessory = "ExternalAccessory"
        static let ScannedPeripheral = "ScannedBluetooth"
        static let ConnectedPeripheral = "ConnectedPeripheral"
        static let KnownPeripheral = "KnownPeripheral"
        static let SoftwareDecoder = "SoftwareDecoder" // Software Decoder
        
        static let IdentifiersOption = "identifiers"
    }
    
    struct DataKey {
        static let DataType = "type"
        static let Data = "data"
        static let DataBytes = "dataBytes"
        static let Symbol = "symbol"
        static let Barcode = "barcode"
        static let BarcodeBytes = "barcodeBytes"
        static let GPS = "gps"
        static let MSR = "msr"
        static let MSRBytes = "msrBytes"
        static let NFCTagType = "nfcType"
        static let NFCUid = "nfcUid"
        static let NFC = "nfc"
        static let NFCBytes = "nfcBytes"
        static let KeyEvent = "key"
        static let UHFListType = "uhfListType"
        static let UHFList = "uhfList"
        static let UHFRssiList = "uhfRssiList"
        static let Record = "record"
    }

    struct SelectParameterKey {
        static let Target = "target"
        static let Action = "action"

        //static final String MemoryBank = "memBank";
        static let Bank = "bank"
        static let Pointer = "pointer"
        static let Length = "length"
        static let MaskData = "maskData"
        static let MaskDataBytes = "maskDataBytes"

        //static final String IsTruncated = "isTruncated";
        static let Truncated = "truncated"
    }

    struct QueryParameterKey {
        static let Dr = "dr"
        static let Cycle = "cycle"
        static let TRext = "tRext"
        static let Sel = "sel"
        static let Session = "session"
        static let Target = "target"
        static let SlotNum = "slotNum"
    }

    struct PosDataKey {
        static let CommandCode = "commandCode"
        static let EventCode = "eventCode"
        static let ErrorCode = "errorCode"
        static let Data = "data"
        static let DataBytes = "dataBytes"
        static let Barcode = "barcode"
        static let BarcodeBytes = "barcodeBytes"
        static let NFC = "nfc"
        static let NFCUid = "nfcUid"
        static let NFCBytes = "nfcBytes"
        static let PinBlock = "pinBlock"
        static let PinBlockBytes = "pinBlockBytes"
        static let CardDataKSN = "cardDataKSN"
        static let PinBlockKSN = "pinBlockKSN"
        static let DeviceSerialNumber = "deviceSerialNumber"
        static let Track1 = "track1"
        static let Track2 = "track2"
        static let Track3 = "track3"
        static let EncryptSpec = "encryptSpec"
        static let EncryptType = "encryptType"
        static let EncryptedDataSize = "encryptedDataLength"
        
        // Unsupported
//        static let MaskedTrack1 = "maskedTrack1"
//        static let MaskedTrack2 = "maskedTrack2"
//        static let MaskedTrack3 = "maskedTrack3"
        
        static let UnencryptedTrack1Length = "unencryptedTrack1Length"
        static let UnencryptedTrack2Length = "unencryptedTrack2Length"
        static let UnencryptedTrack3Length = "unencryptedTrack3Length"
        static let UnencryptedPANLength = "unencryptedPANLength"
        static let EncryptedTrack1 = "encryptedTrack1"
        static let EncryptedTrack2 = "encryptedTrack2"
        static let EncryptedTrack3 = "encryptedTrack3"
        static let EncryptedTrack1Bytes = "encryptedTrack1Bytes"
        static let EncryptedTrack2Bytes = "encryptedTrack2Bytes"
        static let EncryptedTrack3Bytes = "encryptedTrack3Bytes"
        static let EncryptedPAN = "encryptedPAN"
        static let EncryptedPANBytes = "encryptedPANBytes"
        static let DigestType = "digestType"
        static let DigestTrack1 = "digestTrack1"
        static let DigestTrack2 = "digestTrack2"
        static let DigestTrack3 = "digestTrack3"
        static let DigestTrack1Bytes = "digestTrack1Bytes"
        static let DigestTrack2Bytes = "digestTrack2Bytes"
        static let DigestTrack3Bytes = "digestTrack3Bytes"
        static let DigestPAN = "digestPAN"
        static let DigestPANBytes = "digestPANBytes"
        static let IsAutoAppSelection = "isAutoAppSelection"
        static let NumberOfAIDs = "numberOfAIDs"
        static let EMVApplicationList = "emvApps"
        static let EMVTagList = "emvTagList"
        static let EMVResultCode = "emvResultCode"
        static let EMVFallbackType = "emvFallbackType"
        static let PosEntryMode = "posEntryMode"
        static let BatteryStatus = "batteryStatus"
        static let PressedKey = "pressedKey"
        static let ValueEntered = "valueEntered"
        static let SelectedItemIndex = "selectedItemIndex"
    }

    struct PosResultKey {
        static let ResultCode = OpCode
        static let SerialNumber = "serialNumber"
        static let LoaderVersion = "loaderVersion"
        static let FirmwareVersion = "firmwareVersion"
        static let ApplicationVersion = "applicationVersion"
        static let BluetoothVersion = "bluetoothVersion"
        static let BluetoothName = "bluetoothName"
        static let BarcodeType = "barcodeType"
        static let BatteryStatus = "batteryStatus"
        static let KeyToneVolume = "keyToneVolume"
        static let BeepVolume = "beepVolume"
        static let BeepSoundFlag = "beepSoundFlag"
        static let BeepPowerOn = "beepPowerOn"
        static let BeepBarcodeScan = "beepBarcodeScan"
        static let BeepConnection = "beepConnection"
        static let MsrEnabled = "msrEnabled"
        static let NfcEnabled = "nfcEnabled"
        static let KeypadMenuEntryEnabled = "keypadMenuEntryEnabled"
        static let Date = "date"
        static let Locales = "locales"
        static let NumOfEMVBatchData = "numOfEMVBatchData"
    }

    struct PosEMVTagKey {
        static let TLV = "tlvs"
        static let Brand = "brand"
    }

    struct PosEMVAppKey {
        static let Index = "index"
        static let Priority = "priority"
        static let Name = "name"
    }

    struct ResultKey {
        // Result code from native SDK
        static let ErrorCode = "errorCode"
        static let Operation = "opCode"
        static let OperationPos = "opCode"
        
        // NSError object from iOS
        static let NSErrorObject = "nsError"
        static let NSErrorDomain = "domain"
        static let NSErrorCode = "code"
    }
    
    class ErrorCode {
        static let Code = "code" // Result code from Plugin
        static let Message = "message"
        
        private static let CODE_SUCCESS = 0
        private static let CODE_FAILED = 1
        private static let CODE_NULL = 2
        private static let CODE_NOT_CONNECTED = 3
        private static let CODE_USB_PERMISSION_DENIED = 4
        private static let CODE_INVALID_PARAMETER = 5
        private static let CODE_UNSUPPORTED = 6
        private static let CODE_JSON_EXCEPTION = 7

        private static let MESSAGE_SUCCESS = "The operation is succeeded."
        private static let MESSAGE_FAILED = "The operation is failed."
        private static let MESSAGE_NULL = "Instance is null."
        private static let MESSAGE_NOT_CONNECTED = "KDC Device is not connected."
        private static let MESSAGE_USB_PERMISSION_DENIED = "USB Permission is denied."
        private static let MESSAGE_INVALID_PARAMETER = "The parameter is not valid."
        private static let MESSAGE_UNSUPPORTED = "The operation is unsupported."
        private static let MESSAGE_JSON_EXCEPTION = "Json exception occurs."
        
        static let SUCCESS = [
            Code: String(CODE_SUCCESS),
            Message: MESSAGE_SUCCESS
        ]
        
        static let FAILED = [
            Code: String(CODE_FAILED),
            Message: MESSAGE_FAILED
        ]
        
        static let NULL = [
            Code: String(CODE_NULL),
            Message: MESSAGE_NULL
        ]
        
        static let NOT_CONNECTED = [
            Code: String(CODE_NOT_CONNECTED),
            Message: MESSAGE_NOT_CONNECTED
        ]
        
        static let USB_PERMISSION_DENIED = [
            Code: String(CODE_USB_PERMISSION_DENIED),
            Message: MESSAGE_USB_PERMISSION_DENIED
        ]
        
        static let INVALID_PARAMETER = [
            Code: String(CODE_INVALID_PARAMETER),
            Message: MESSAGE_INVALID_PARAMETER
        ]
        
        static let UNSUPPORTED = [
            Code: String(CODE_UNSUPPORTED),
            Message: MESSAGE_UNSUPPORTED
        ]
        
        static let JSON_EXCEPTION = [
            Code: String(CODE_JSON_EXCEPTION),
            Message: MESSAGE_JSON_EXCEPTION
        ]
    }

// MARK: - Software Decoder
    struct SWDecoderActivationKey {
        static let Code = "code"
        static let Message = "message"
        static let DeviceId = "deviceId"
    }

    struct SWDecoderSettingKey {
        static let FlashOnDecode = "flashOnDecode"
        static let Decode = "decode"

//        static let EnabledSymbol = "enabledSymbol";
//        static let DisabledSymbol = "disabledSymbolEnabled";
        static let Window = "window"
        static let WindowMode = "windowMode"
        static let Sound = "sound"
        static let Aimer = "aimer"
        static let AimerColor = "aimerColor"
        static let OverlayText = "overlayText"
        static let OverlayTextColor = "overlayTextColor"
        static let OCRActiveTemplate = "ocrActive"
        static let OCRUserTemplate = "ocrUser"
        static let ActiveCamera = "activeCamera"
    }
    
    struct SWDecoderImageKey {
        static let Width = "width"
        static let Height = "height"
        static let Png = "png"
    }

    struct SWDecoderBoundsKey {
        static let TopLeft = "topLeft"
        static let TopRight = "topRight"
        static let BottomLeft = "bottomLeft"
        static let BottomRight = "bottomRight"
        static let Width = "width"
        static let Height = "height"
        static let X = "x"
        static let Y = "y"
    }
    
    struct SWDecoderDataKey {
        static let Bounds = "bounds"
    }
    
    private init() {}
}
