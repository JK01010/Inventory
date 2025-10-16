//
//  KCommonDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/19/24.
//

import Flutter

class KCommonDelegate : KReaderDelegate {
    private let GET_AVAIL_DEVICE_LIST_EX = "getAvailDeviceListEx"

    private let ENABLE_ATTACH_TYPE = "enableAttachType"
    private let ENABLE_ATTACH_SERIAL_NUMBER = "enableAttachSerialNumber"
    private let ENABLE_ATTACH_TIMESTAMP = "enableAttachTimestamp"

    private let SET_DATA_DELIMITER = "setDataDelimiter"
    private let SET_RECORD_DELIMITER = "setRecordDelimiter"

    private let GET_DEVICE_INFO = "getDeviceInfo"

    private let GET_CONNECTED_DEVICE_EX = "getConnectedDeviceEx"

    private let IS_CONNECTED = "isConnected"

    private let CONNECT_EX = "connectEx"
    private let DISCONNECT = "disconnect"

    private let SOFTWARE_TRIGGER = "softwareTrigger"
    
    /* PARAM */
    private let PARAM_NAME_TYPE = "type"
    private let PARAM_NAME_OPTIONS = "options"
    private let PARAM_NAME_IDENTIFIERS = "identifiers"
    
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_DELIMITER = "delimiter"

    private let PARAM_NAME_DEVICE = "device"

    private let PARAM_NAME_CONNECTED = "connected"
    private let PARAM_NAME_DEVICES = "devices"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            GET_AVAIL_DEVICE_LIST_EX,
            
            ENABLE_ATTACH_TYPE,
            ENABLE_ATTACH_SERIAL_NUMBER,
            ENABLE_ATTACH_TIMESTAMP,
            
            SET_DATA_DELIMITER,
            SET_RECORD_DELIMITER,
            
            GET_DEVICE_INFO,
            
            GET_CONNECTED_DEVICE_EX,
            
            IS_CONNECTED,
            
            CONNECT_EX,
            DISCONNECT,
            
            SOFTWARE_TRIGGER,
        ])
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        switch call.method {
        case ENABLE_ATTACH_TYPE:
            enableAttachType(call, result: result)
            
        case ENABLE_ATTACH_SERIAL_NUMBER:
            enableAttachSerialNumber(call, result: result)
            
        case ENABLE_ATTACH_TIMESTAMP:
            enableAttachTimestamp(call, result: result)
            
        case SET_DATA_DELIMITER:
            setDataDelimiter(call, result: result)
            
        case SET_RECORD_DELIMITER:
            setRecordDelimiter(call, result: result)
            
        case GET_AVAIL_DEVICE_LIST_EX:
            getAvailDeviceListEx(call, result: result)
            
        case CONNECT_EX:
            connectEx(call, result: result)
            
        case DISCONNECT: 
            disconnect(call, result: result)
            
        case IS_CONNECTED: 
            isReaderConnected(call, result: result)
            
        case SOFTWARE_TRIGGER: 
            softwareTrigger(call, result: result)
            
        case GET_DEVICE_INFO: 
            getDeviceInfo(call, result: result)
            
        case GET_CONNECTED_DEVICE_EX: 
            getConnectedDeviceEx(call, result: result)
            
        default:
            break
        }
        
        return true
    }
    
    private func enableAttachType(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        reader.enableAttachType(enable)
        result(true)
    }
    
    private func enableAttachSerialNumber(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        reader.enableAttachSerialNumber(enable)
        result(true)
    }
    
    private func enableAttachTimestamp(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        reader.enableAttachTimestamp(enable)
        result(true)
    }

    private func setDataDelimiter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_DELIMITER] as? Int,
              let delimiter = DataDelimiter(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
                
        reader.setDataDelimiter(delimiter)
        result(true)
    }

    private func setRecordDelimiter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_DELIMITER] as? Int,
              let delimiter = RecordDelimiter(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
                
        reader.setRecordDelimiter(delimiter)
        result(true)
    }

    private func getAvailDeviceListEx(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let t = args[PARAM_NAME_TYPE] as? String,
              let type = converter.toDeviceListType(type: t) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        var retDevices = [[String: Any]]()
        var options: [String:Any]? = nil
        
        if type == .KNOWN_PERIPHERAL_LIST, let opts = args[PARAM_NAME_OPTIONS] as? Dictionary<String, Any> {
            if let ids = opts[PARAM_NAME_IDENTIFIERS] as? Array<String> {
                var identifiers = Array<NSUUID>()
                
                for identifier in ids {
                    if let uuid = NSUUID(uuidString: identifier) {
                        identifiers.append(uuid)
                    }
                }
                
                if !identifiers.isEmpty {
                    options = [String: Any]()
                    options?[keyIdentifiers] = identifiers
                }
            }
        }
        
        if let deviceList = reader.getAvailableDeviceListEx(type, options: options) as? [KDCDevice] {
            for device in deviceList {
                let dict = converter.fromKDCDevice(device)
                retDevices.append(dict)
            }
        }
        
        result(retDevices)
    }
    
    private func connectEx(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        var bRet = false
        let device = args[PARAM_NAME_DEVICE] as? Dictionary<String, Any>
    
        if device == nil {
            bRet = reader.connectEx()
        } else {
            var targetDevice: KDCDevice? = nil
            
            if let deviceName = device?[KConstants.DeviceKey.DeviceName] as? String {
                var lists = [Array<KDCDevice>]()

                // EAAccessory
                if let accessorylist = reader.getAvailableDeviceListEx(.EXTERNAL_ACCESSORY_LIST) as? [KDCDevice] {
                    lists.append(accessorylist)
                }
                
                // Connected BLE
                if let connectedList = reader.getAvailableDeviceListEx(.CONNECTED_PERIPHERAL_LIST) as? [KDCDevice] {
                    lists.append(connectedList)
                }
                
                // Known BLE
                if let identifier = device?[KConstants.DeviceKey.Identifier] as? String {
                    if let uuid = NSUUID(uuidString: identifier) {
                        let options = [keyIdentifiers: [uuid]]
                        if let knownList = reader.getAvailableDeviceListEx(.KNOWN_PERIPHERAL_LIST, options: options) as? [KDCDevice] {
                            lists.append(knownList)
                        }
                    }
                }
                
                // Scanned BLE
                if let scannedList = reader.getAvailableDeviceListEx(.SCANNED_PERIPHERAL_LIST) as? [KDCDevice] {
                    lists.append(scannedList)
                }
                
                // Software Decoder
                if let softwareDecoderList = reader.getAvailableDeviceListEx(.SOFTWARE_DECODER_LIST) as? [KDCDevice] {
                    lists.append(softwareDecoderList)
                }
            
            loop:
                for list in lists {
                    for dev in list {
                        if deviceName == dev.name {
                            targetDevice = dev
                            break loop
                        }
                    }
                }
            }
            
            if let target = targetDevice {
                bRet = reader.connectEx(target)
            } else {
                sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result: result)
                return
            }
        }
        
        result(bRet)
    }

    private func disconnect(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        reader.disconnect()
        result(true)
    }

    private func isReaderConnected(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(reader.isConnected())
    }

    private func softwareTrigger(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if !isConnected() {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result: result)
            return
        }
        
        reader.softwareTrigger()
        result(true)
    }

    private func getDeviceInfo(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if !isConnected() {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result: result)
            return
        }
        
        var dict = [String: Any]()
        
        if let name = reader.getKDCModelName() {
            dict[KConstants.DeviceInfoKey.Name] = String(format: "%s", name)
        } else {
            dict[KConstants.DeviceInfoKey.Name] = ""
        }

        if !reader.isPOSSupported(), let firmware = reader.getFirmwareVersion() {
            dict[KConstants.DeviceInfoKey.Firmware] = String(format: "%s", firmware)
        } else {
            dict[KConstants.DeviceInfoKey.Firmware] = ""
        }
        
        // use the serial number stored during initialization
        if let serial = reader.getKDCSerialNumber(false) {
            dict[KConstants.DeviceInfoKey.SerialNumber] = serial
        }
        
        dict[KConstants.DeviceInfoKey.IsFlash] = reader.isFlashSupported()
        dict[KConstants.DeviceInfoKey.IsBluetooth] = reader.isBluetoothSupported()
        dict[KConstants.DeviceInfoKey.IsBarcode] = reader.isBarcodeSupported()
        dict[KConstants.DeviceInfoKey.Is2D] = reader.is2DSupported()
        dict[KConstants.DeviceInfoKey.IsMSR] = reader.isMSRSupported()
        dict[KConstants.DeviceInfoKey.IsNFC] = reader.isNFCSupported()
        dict[KConstants.DeviceInfoKey.IsGPS] = reader.isGPSSupported()
        dict[KConstants.DeviceInfoKey.IsUHF] = reader.isUHFSupported()
        dict[KConstants.DeviceInfoKey.IsWiFi] = reader.isWiFiSupported()
        dict[KConstants.DeviceInfoKey.IsKeypad] = reader.isKeyPadSupported()
        dict[KConstants.DeviceInfoKey.IsVibrator] = reader.isVibratorSupported()
        dict[KConstants.DeviceInfoKey.IsDisplay] = reader.isDisplaySupported()
        dict[KConstants.DeviceInfoKey.IsPassportReader] = reader.isPassportReaderSupported()
        dict[KConstants.DeviceInfoKey.IsFingerPrint] = reader.isFingerPrintSupported()
        dict[KConstants.DeviceInfoKey.IsMsrIc] = reader.isMSRICSupported()
        
        if reader.isFeatureInformationExSupported() {
            dict[KConstants.DeviceInfoKey.IsSocialDistance] = reader.isSocialDistanceSupported()
            dict[KConstants.DeviceInfoKey.IsOCR] = reader.isOCRSupported()
            dict[KConstants.DeviceInfoKey.IsMRZ] = reader.isMRZSupported()
            dict[KConstants.DeviceInfoKey.IsSLED] = reader.isSLEDSupported()
        }
        
        dict[KConstants.DeviceInfoKey.IsNewArchitectureModel] = reader.isNewArchitectureModel()
        dict[KConstants.DeviceInfoKey.IsPos] = reader.isPOSSupported()

        result(dict)
    }

    private func getConnectedDeviceEx(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if !isConnected() {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result: result)
            return
        }
        
        let device = reader.getConnectedDeviceEx()
        let dict = converter.fromKDCDevice(device)

        result(dict)
    }
}
