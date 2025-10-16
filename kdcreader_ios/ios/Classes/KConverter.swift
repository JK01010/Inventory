//
//  KConverter.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/20/24.
//

import Foundation
import CoreBluetooth
import Flutter

class KConverter {
    let COMMAND_GET_DEVICE_STATUS_POS = 1
    let COMMAND_GET_BEEP_SOUND_POS = 2
    let COMMAND_GET_DATE_TIME_POS = 3
    let COMMAND_GET_SUPPORTED_LOCALES_POS = 4
    
//    static let IOS_LASER_SYMBOL = [
//        "EAN 13", // 0
//        "EAN 8",
//        "UPCA",
//        "UPCE",
//        "Code 39", // 4
//        "ITF-14",
//        "Code 128",
//        "I2of5",
//        "CodaBar",
//        "UCC/EAN-128", // 9
//        "Code 93",
//        "Code 35",
//        "Unknown",
//        "Unknown",
//        "Bookland EAN", // 14
//        "GS1 Omni",
//        "GS1 Limited",
//        "GS1 Expanded",
//        "Unknown",
//        "Unknown", // 19
//        "Social"
//    ]
//    
//    static let IOS_CAMERA_SYMBOL = [
//        "Code 32",
//        "Trioptic",
//        "Korea Post",
//        "Aus. Post",
//        "British Post", // 4
//        "Canada Post",
//        "EAN-8",
//        "UPC-E",
//        "UCC/EAN-128",
//        "Japan Post", // 9
//        "KIX Post",
//        "Planet Code",
//        "OCR",
//        "Postnet",
//        "China Post", // 14
//        "Micro PDF417",
//        "TLC 39",
//        "PosiCode",
//        "Codabar",
//        "Code 39", // 19
//        "UPC-A",
//        "EAN-13",
//        "I2of5",
//        "IATA",
//        "MSI", // 24
//        "Code 11",
//        "Code 93",
//        "Code 128",
//        "Code 49",
//        "Matrix2of5", // 29
//        "Plessey",
//        "Code 16K",
//        "Codablock F",
//        "PDF417",
//        "QR/Micro QR", // 34
//        "Telepen",
//        "VeriCode",
//        "Data Matrix",
//        "MaxiCode",
//        "GS1 Omni", // 39
//        "GS1 Limited",
//        "Aztec Code",
//        "GS1 Expanded",
//        "HanXin Code",
//        "Unknown", // 44
//        "Driver License",
//        "GS1 Data Matrix",
//        "Social"
//    ]
//    
//    static let ANDROID_LASER_SYMBOL = [
//        "EAN13", // 0
//        "EAN8",
//        "UPCA",
//        "UPCE",
//        "CODE39", // 4
//        "ITF14",
//        "CODE128",
//        "I2OF5",
//        "CODABAR",
//        "GS1128", // 9
//        "CODE93",
//        "CODE35",
//        "UNDEFINED",
//        "UNDEFINED",
//        "BOOKLANDEAN", // 14
//        "GS1_OMNI",
//        "GS1_LIMITED",
//        "GS1_EXPANDED",
//        "UNDEFINED",
//        "UNDEFINED", // 19
//        "SOCIAL",
//    ]
//
//    static let ANDROID_CAMERA_SYMBOL = [
//        "CODE32",
//        "TRIOPTIC",
//        "KOREA_POST",
//        "AUSTRALIAN_POST",
//        "BRITISH_POST", // 4
//        "CANADIAN_POST",
//        "EAN8",
//        "UPCE",
//        "GS1128",
//        "JAPANESE_POST", // 9
//        "KIX_POST",
//        "PLANET_CODE",
//        "OCR",
//        "POSTNET",
//        "CHINA_POST", // 14
//        "MICROPDF417",
//        "TLC39",
//        "POSICODE",
//        "CODABAR",
//        "CODE39", // 19
//        "UPCA",
//        "EAN13",
//        "I2OF5",
//        "S2OF5IATA",
//        "MSI", // 24
//        "CODE11",
//        "CODE93",
//        "CODE128",
//        "CODE49",
//        "MATRIX2OF5", // 29
//        "PLESSEY_CODE",
//        "CODE16K",
//        "CODABLOCK_F",
//        "PDF417",
//        "QR_CODE", // 34
//        "TELEPEN",
//        "VERICODE",
//        "DATA_MATRIX",
//        "MAXICODE",
//        "GS1_OMNI", // 39
//        "GS1_LIMITED",
//        "AZTEC_CODE",
//        "GS1_EXPANDED",
//        "HANXIN",
//        "UNDEFINED", // 44
//        "DRIVER_LICENSE",
//        "GS1_DATA_MATRIX",
//        "SOCIAL",
//    ]
    
//    private func toAndroidBarcodeSymbolString(symbol: String?) -> String {
//        guard let iosSymbol = symbol else {
//            return KConstants.EMPTY_STRING
//        }
//        
//        for (index, element) in KConverter.IOS_LASER_SYMBOL.enumerated() {
//            if iosSymbol == element {
//                return KConverter.ANDROID_LASER_SYMBOL[index]
//            }
//        }
//        
//        for (index, element) in KConverter.IOS_CAMERA_SYMBOL.enumerated() {
//            if iosSymbol == element {
//                return KConverter.ANDROID_CAMERA_SYMBOL[index]
//            }
//        }
//        return iosSymbol
//    }
    
    func toDeviceListType(type: String) -> DeviceListType? {
        var listType: DeviceListType? = nil
        
        switch (type) {
        case KConstants.DeviceListTypeKey.ExternalAccessory:
            listType = .EXTERNAL_ACCESSORY_LIST
            
        case KConstants.DeviceListTypeKey.ScannedPeripheral:
            listType = .SCANNED_PERIPHERAL_LIST
            
        case KConstants.DeviceListTypeKey.ConnectedPeripheral:
            listType = .CONNECTED_PERIPHERAL_LIST
            
        case KConstants.DeviceListTypeKey.KnownPeripheral:
            listType = .KNOWN_PERIPHERAL_LIST
            
        case KConstants.DeviceListTypeKey.SoftwareDecoder:
            listType = .SOFTWARE_DECODER_LIST
            
        default:
            break
        }
        
        return listType
    }
    
    func fromKDCDevice(_ kdcDevice: KDCDevice?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        if let device = kdcDevice {
            dict[KConstants.DeviceKey.DeviceType] = device.type
            dict[KConstants.DeviceKey.SubType] = device.subtype
            dict[KConstants.DeviceKey.DeviceName] = device.name
            dict[KConstants.DeviceKey.KDCName] = device.name
            
            if device.device is CBPeripheral,
               let peripheral = device.device as? CBPeripheral {
                dict[KConstants.DeviceKey.Identifier] = peripheral.identifier.uuidString
            }
        }
        
        return dict
    }
    
    func fromKDCData(_ kdcData: KDCData?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        if let data = kdcData {
            // data type
            dict[KConstants.DataKey.DataType] = data.getType().rawValue
            
            // data
            dict[KConstants.DataKey.Data] = data.getData()
            
            // data as bytes
            if let bytes = data.getBytes() {
                dict[KConstants.DataKey.DataBytes] = Data(bytes: bytes, count: Int(data.getBytesLength()))
            }
            
            // record
            dict[KConstants.DataKey.Record] = data.getRecord()
            
            switch data.getType() {
            case .BARCODE:
                //dict[KConstants.DataKey.Symbol] = toAndroidBarcodeSymbolString(symbol: data.getBarcodeSymbology())
                dict[KConstants.DataKey.Symbol] = data.getBarcodeSymbology()
                dict[KConstants.DataKey.Barcode] = data.getBarcodeData()
                
                if let bytes = data.getBarcodeDataBytes() {
                    dict[KConstants.DataKey.BarcodeBytes] = Data(bytes: bytes, count: Int(data.getBarcodeDataBytesLength()))
                }
                
                // Software Decoder
                if data.isKind(of: KDCSWData.self), let swData = data as? KDCSWData {
                    if let bounds = swData.getBounds() {
                        var boundsDict = [String: Any]()
                        var pointDict = [String: Any]()
                        
                        pointDict[KConstants.SWDecoderBoundsKey.X] = Int(bounds.upperLeft.x)
                        pointDict[KConstants.SWDecoderBoundsKey.Y] = Int(bounds.upperLeft.y)
                        boundsDict[KConstants.SWDecoderBoundsKey.TopLeft] = pointDict
                        
                        pointDict.removeAll()
                        pointDict[KConstants.SWDecoderBoundsKey.X] = Int(bounds.upperRight.x)
                        pointDict[KConstants.SWDecoderBoundsKey.Y] = Int(bounds.upperRight.y)
                        boundsDict[KConstants.SWDecoderBoundsKey.TopRight] = pointDict

                        pointDict.removeAll()
                        pointDict[KConstants.SWDecoderBoundsKey.X] = Int(bounds.bottomLeft.x)
                        pointDict[KConstants.SWDecoderBoundsKey.Y] = Int(bounds.bottomLeft.y)
                        boundsDict[KConstants.SWDecoderBoundsKey.BottomLeft] = pointDict
                        
                        pointDict.removeAll()
                        pointDict[KConstants.SWDecoderBoundsKey.X] = Int(bounds.bottomRight.x)
                        pointDict[KConstants.SWDecoderBoundsKey.Y] = Int(bounds.bottomRight.y)
                        boundsDict[KConstants.SWDecoderBoundsKey.BottomRight] = pointDict
                        
                        boundsDict[KConstants.SWDecoderBoundsKey.Width] = Int(bounds.imageSize.width)
                        boundsDict[KConstants.SWDecoderBoundsKey.Height] = Int(bounds.imageSize.height)
                        
                        dict[KConstants.SWDecoderDataKey.Bounds] = boundsDict
                    }
                }

            case .MSR:
                dict[KConstants.DataKey.MSR] = data.getMSRData()
                
                if let bytes = data.getMSRDataBytes() {
                    dict[KConstants.DataKey.MSRBytes] = Data(bytes: bytes, count: Int(data.getMSRDataBytesLength()))
                }

            case .GPS:
                dict[KConstants.DataKey.GPS] = data.getGPSData()

            case .NFC_OLD, .NFC_NEW, .NFC:
                dict[KConstants.DataKey.NFCTagType] = data.getNFCTagType().rawValue
                dict[KConstants.DataKey.NFCUid] = data.getNFCUID()
                dict[KConstants.DataKey.NFC] = data.getNFCData()
                
                if let bytes = data.getNFCDataBytes() {
                    dict[KConstants.DataKey.NFCBytes] = Data(bytes: bytes, count: Int(data.getNFCDataBytesLength()))
                }

            case .KEY_EVENT:
                dict[KConstants.DataKey.KeyEvent] = data.getKeyEvent()

            case .UHF_LIST:
                dict[KConstants.DataKey.UHFListType] = data.getUHFListDataType().rawValue
                dict[KConstants.DataKey.UHFList] = data.getUHFList()
                dict[KConstants.DataKey.UHFRssiList] = data.getUHFRssiList()
                
            default: // do nothing
                break
            }
        }
        
        return dict

    }
    
    func fromNSError(_ error: NSError?) -> Dictionary<String, Any> {
        var dict = [String: Any]()

        if let err = error {
            dict[KConstants.ResultKey.NSErrorDomain] = err.domain
            dict[KConstants.ResultKey.NSErrorCode] = err.code
        }
        return dict
    }
    
    func fromSelectParameter(_ parameter: SelectParameter?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        if let param = parameter {
            dict[KConstants.SelectParameterKey.Target] = param.target
            dict[KConstants.SelectParameterKey.Action] = param.action
            dict[KConstants.SelectParameterKey.Bank] = param.memBank.rawValue
            dict[KConstants.SelectParameterKey.Pointer] = param.pointer
            dict[KConstants.SelectParameterKey.Length] = param.length

            if let data = param.mask {
                dict[KConstants.SelectParameterKey.MaskData] = String(data:data, encoding: .utf8)
            }

            dict[KConstants.SelectParameterKey.MaskDataBytes] = param.mask
            dict[KConstants.SelectParameterKey.Truncated] = param.isTruncated

        }
        return dict
    }

    func fromQueryParameter(_ parameter: QueryParameter?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        if let param = parameter {
            dict[KConstants.QueryParameterKey.Dr] = param.dr
            dict[KConstants.QueryParameterKey.Cycle] = param.cycle
            dict[KConstants.QueryParameterKey.TRext] = param.tRext
            dict[KConstants.QueryParameterKey.Sel] = param.sel
            dict[KConstants.QueryParameterKey.Session] = param.session
            dict[KConstants.QueryParameterKey.Target] = param.target
            dict[KConstants.QueryParameterKey.SlotNum] = param.slotNum
        }
        return dict
    }

    func fromKPOSEMVAplication(_ emvApp: KPOSEMVApplication?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        if let app = emvApp {
            dict[KConstants.PosEMVAppKey.Index] = app.getIndex()
            dict[KConstants.PosEMVAppKey.Priority] = app.getPriority()
            
            if let name = app.getName() {
                dict[KConstants.PosEMVAppKey.Name] = name
            }
        }
        return dict
    }
    
    func fromKPOSEMVTagList(_ emvTags: KPOSEMVTagList?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        if let tags = emvTags {
//            let tlvData = Data(bytes: tags.getTLVs(), count: Int(tags.getLength()))
//            dict[KConstants.PosEMVTagKey.TLV] = FlutterStandardTypedData(bytes: tlvData)
            dict[KConstants.PosEMVTagKey.TLV] = Data(bytes: tags.getTLVs(), count: Int(tags.getLength()))
        }
        return dict
    }
    
    func fromKPOSData(_ kposData: KPOSData?) -> Dictionary<String, Any?> {
        var dict = [String: Any]()
        
        if let data = kposData {
            dict[KConstants.PosDataKey.CommandCode] = data.getCommandCode()
            dict[KConstants.PosDataKey.EventCode] = data.getEventCode()

            // Barcode bytes
            if let bytes = data.getBarcodeBytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getBarcodeLength()))
                dict[KConstants.PosDataKey.Barcode] = String(data: bytesData, encoding: .utf8)
                dict[KConstants.PosDataKey.BarcodeBytes] = bytesData
            }

            dict[KConstants.PosDataKey.NFC] = data.getNFCData()
            dict[KConstants.PosDataKey.NFCUid] = data.getNFCUID()
            
            // NFC bytes
            if let bytesData = data.getNFCDataBytes() {
                dict[KConstants.PosDataKey.NFCBytes] = bytesData
            }
            
            // PinBlock bytes
            if let bytes = data.getPinBlockBytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getPinBlockLength()))
                dict[KConstants.PosDataKey.PinBlockBytes] = bytesData
            }
            
            dict[KConstants.PosDataKey.CardDataKSN] = data.getCardDataKSN()
            dict[KConstants.PosDataKey.PinBlockKSN] = data.getPinBlockKSN()
            dict[KConstants.PosDataKey.DeviceSerialNumber] = data.getDeviceSerialNumber()
            dict[KConstants.PosDataKey.Track1] = data.getTrack1()
            dict[KConstants.PosDataKey.Track2] = data.getTrack2()
            dict[KConstants.PosDataKey.Track3] = data.getTrack3()
            dict[KConstants.PosDataKey.PosEntryMode] = data.getPOSEntryMode()
            dict[KConstants.PosDataKey.EncryptSpec] = data.getEncryptionSpec()
            dict[KConstants.PosDataKey.EncryptType] = data.getEncryptionType()
            dict[KConstants.PosDataKey.EncryptedDataSize] = data.getEncryptedDataSize()

            // Unsupported
//            dict[KConstants.PosDataKey.MaskedTrack1] = data.GetMaskedTrack1()
//            dict[KConstants.PosDataKey.MaskedTrack2] = data.GetMaskedTrack2()
//            dict[KConstants.PosDataKey.MaskedTrack3] = data.GetMaskedTrack3()

            dict[KConstants.PosDataKey.UnencryptedTrack1Length] = data.getUnencryptedTrack1Length()
            dict[KConstants.PosDataKey.UnencryptedTrack2Length] = data.getUnencryptedTrack2Length()
            dict[KConstants.PosDataKey.UnencryptedTrack3Length] = data.getUnencryptedTrack3Length()
            dict[KConstants.PosDataKey.UnencryptedPANLength] = data.getUnencryptedPANLength()

            // Encrypted Track1 bytes
            if let bytes = data.getEncryptedTrack1Bytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getEncryptedTrack1Length()))
                dict[KConstants.PosDataKey.EncryptedTrack1Bytes] = bytesData
            }
            
            // Encrypted Track2 bytes
            if let bytes = data.getEncryptedTrack2Bytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getEncryptedTrack2Length()))
                dict[KConstants.PosDataKey.EncryptedTrack2Bytes] = bytesData
            }
            
            // Encrypted Track3 bytes
            if let bytes = data.getEncryptedTrack3Bytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getEncryptedTrack3Length()))
                dict[KConstants.PosDataKey.EncryptedTrack3Bytes] = bytesData
            }
            
            // Encrypted PAN bytes
            if let bytes = data.getEncryptedPANBytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getEncryptedPANLength()))
                dict[KConstants.PosDataKey.EncryptedPANBytes] = bytesData
            }

            // Digest
            dict[KConstants.PosDataKey.DigestType] = data.getDigestType()
            
            // Track1 Digest bytes
            if let bytes = data.getTrack1DigestBytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getTrack1DigestLength()))
                dict[KConstants.PosDataKey.DigestTrack1Bytes] = bytesData
            }
            
            // Track2 Digest bytes
            if let bytes = data.getTrack2DigestBytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getTrack2DigestLength()))
                dict[KConstants.PosDataKey.DigestTrack2Bytes] = bytesData
            }
            
            // Track3 Digest bytes
            if let bytes = data.getTrack3DigestBytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getTrack3DigestLength()))
                dict[KConstants.PosDataKey.DigestTrack3Bytes] = bytesData
            }
            
            // PAN Digest bytes
            if let bytes = data.getPANDigestBytes() {
                let bytesData = Data(bytes: bytes, count: Int(data.getPANDigestLength()))
                dict[KConstants.PosDataKey.DigestPANBytes] = bytesData
            }

            dict[KConstants.PosDataKey.IsAutoAppSelection] = data.isAutoAppSelection()
            dict[KConstants.PosDataKey.NumberOfAIDs] = data.getNumberOfAIDs()

            // EMV Application List
            var emvAppsDict = [[String: Any]]()
            
            if let emvApps = data.getEMVApplicationList() {
                for emvApp in emvApps {
                    if let app = emvApp as? KPOSEMVApplication {
                        emvAppsDict.append(fromKPOSEMVAplication(app))
                    }
                }
                dict[KConstants.PosDataKey.EMVApplicationList] = emvAppsDict
            }
            
            // EMV Tag List
            dict[KConstants.PosDataKey.EMVTagList] = fromKPOSEMVTagList(data.getEMVTagList())

            dict[KConstants.PosDataKey.EMVResultCode] = data.getEMVResultCode()
            dict[KConstants.PosDataKey.EMVFallbackType] = data.getEMVFallbackType()
            dict[KConstants.PosDataKey.ErrorCode] = data.getErrorCode()
            dict[KConstants.PosDataKey.BatteryStatus] = data.getBatteryStatus()
            dict[KConstants.PosDataKey.PressedKey] = data.getPressedKey()
            dict[KConstants.PosDataKey.ValueEntered] = data.getValueEntered()
            dict[KConstants.PosDataKey.SelectedItemIndex] = data.getSelectedItemIndex()
        }
        
        return dict
    }

    func fromKPOSResult(_ result: KPOSResult?, commandType: Int) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        if let res = result {
            switch (commandType) {
            case COMMAND_GET_DEVICE_STATUS_POS:
                dict[KConstants.PosResultKey.SerialNumber] = res.getSerialNumber()
                dict[KConstants.PosResultKey.LoaderVersion] = res.getLoaderVersion()
                dict[KConstants.PosResultKey.FirmwareVersion] = res.getFirmwareVersion()
                dict[KConstants.PosResultKey.ApplicationVersion] = res.getApplicationVersion()
                dict[KConstants.PosResultKey.BluetoothVersion] = res.getBluetoothVersion()
                dict[KConstants.PosResultKey.BluetoothName] = res.getBluetoothName()
                dict[KConstants.PosResultKey.BarcodeType] = res.getBarcodeType()
                dict[KConstants.PosResultKey.BatteryStatus] = res.getBatteryStatus()
                dict[KConstants.PosResultKey.MsrEnabled] = res.isMSREnabled()
                dict[KConstants.PosResultKey.NfcEnabled] = res.isNFCEnabled()
                dict[KConstants.PosResultKey.KeypadMenuEntryEnabled] = res.isKeypadMenuEntryEnabled()
                dict[KConstants.PosResultKey.NumOfEMVBatchData] = res.getNumOfEMVBatchData()

            case COMMAND_GET_BEEP_SOUND_POS:
                dict[KConstants.PosResultKey.KeyToneVolume] = res.getKeyToneVolume()
                dict[KConstants.PosResultKey.BeepVolume] = res.getBeepVolume()
                dict[KConstants.PosResultKey.BeepSoundFlag] = res.getBeepSoundFlag()
                dict[KConstants.PosResultKey.BeepPowerOn] = res.isBeepOnPowerOnEvent()
                dict[KConstants.PosResultKey.BeepBarcodeScan] = res.isBeepOnBarcodeScanEvent()
                dict[KConstants.PosResultKey.BeepConnection] = res.isBeepOnConnectionEvent()

            case COMMAND_GET_DATE_TIME_POS:
                if let dateComponents = res.getDateTime(),
                   let date = NSCalendar.current.date(from: dateComponents) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dict[KConstants.PosResultKey.Date] = formatter.string(from: date)
                }

            case COMMAND_GET_SUPPORTED_LOCALES_POS:
                dict[KConstants.PosResultKey.Locales] = res.getSupportedLocales()

            
            default:
                break
            }
        }
        return dict
    }
    
// MARK: - Software Decoder
    func fromKDCSWDecoderActivationResult(_ result: KDCSWDecoderActivationResult?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
     
        if let res = result {
            dict[KConstants.SWDecoderActivationKey.Code] = res.resultCode
            dict[KConstants.SWDecoderActivationKey.Message] = res.resultMessage
            dict[KConstants.SWDecoderActivationKey.DeviceId] = res.deviceId
        }
        
        return dict
    }

    func fromKDCSWDecoderSetting(_ setting: KDCSWDecoderSetting?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
     
        if let s = setting {
            dict[KConstants.SWDecoderSettingKey.FlashOnDecode] = s.isFlashToggled()
            dict[KConstants.SWDecoderSettingKey.Decode] = s.isDecodingEnabled()

            if let rect = s.getWindowRect() as? [Int32] {
                let data = rect.withUnsafeBufferPointer({
                    Data(buffer: $0)
                })
                dict[KConstants.SWDecoderSettingKey.Window] = FlutterStandardTypedData(int32: data)
            }
            
            dict[KConstants.SWDecoderSettingKey.WindowMode] = s.getWindowMode().rawValue
        }
        
        return dict
    }
    
    func fromUIImage(_ image: UIImage?) -> Dictionary<String, Any> {
        var dict = [String: Any]()
     
        if let i = image, let png = i.pngData() {
            dict[KConstants.SWDecoderImageKey.Width] = Int(i.size.width)
            dict[KConstants.SWDecoderImageKey.Height] = Int(i.size.height)
            dict[KConstants.SWDecoderImageKey.Png] = png
        }
        return dict
    }
}
