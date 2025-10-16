//
//  KNfcDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/21/24.
//

import Flutter

class KNfcDelegate: KReaderDelegate {
    private let IS_NFC_INSTALLED = "isNFCInstalled"

    private let ENABLE_NFC_POWER = "enableNFCPower"
    private let IS_NFC_POWER_ENABLED = "isNFCPowerEnabled"

    private let SET_NFC_DATA_FORMAT = "setNFCDataFormat"
    private let GET_NFC_DATA_FORMAT = "getNFCDataFormat"

    private let ENABLE_NFC_UID_ONLY = "enableNFCUIDOnly"
    private let IS_NFC_UID_ONLY_ENABLED = "isNFCUIDOnlyEnabled"

    private let ENABLE_NFC_EXTENDED_FORMAT = "enableNFCExtendedFormat"
    private let IS_NFC_EXTENDED_FORMAT_ENABLED = "isNFCExtendedFormatEnabled"

    /* PARAM */
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_FORMAT = "format"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            IS_NFC_INSTALLED,
            
            ENABLE_NFC_POWER,
            IS_NFC_POWER_ENABLED,
            
            SET_NFC_DATA_FORMAT,
            GET_NFC_DATA_FORMAT,
            
            ENABLE_NFC_UID_ONLY,
            IS_NFC_UID_ONLY_ENABLED,
            
            ENABLE_NFC_EXTENDED_FORMAT,
            IS_NFC_EXTENDED_FORMAT_ENABLED,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case IS_NFC_INSTALLED:
            isNFCInstalled(call, result:result)

        case ENABLE_NFC_POWER:
            enableNFCPower(call, result:result)
            
        case IS_NFC_POWER_ENABLED:
            isNFCPowerEnabled(call, result:result)

        case SET_NFC_DATA_FORMAT:
            setNFCDataFormat(call, result:result)
            
        case GET_NFC_DATA_FORMAT:
            getNFCDataFormat(call, result:result)

        case ENABLE_NFC_UID_ONLY:
            enableNFCUIDOnly(call, result:result)
            
        case IS_NFC_UID_ONLY_ENABLED:
            isNFCUIDOnlyEnabled(call, result:result)

        case ENABLE_NFC_EXTENDED_FORMAT:
            enableNFCExtendedFormat(call, result:result)
            
        case IS_NFC_EXTENDED_FORMAT_ENABLED:
            isNFCExtendedFormatEnabled(call, result:result)
            
        default:
            break
        }
        return true
    }
    
    private func isNFCInstalled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let attached = reader.isNFCInstalled()
        result(attached)
    }
    
    private func enableNFCPower(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableNFCPower(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isNFCPowerEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isNFCPowerEnabled()
        result(enable == .ENABLE)
    }

    private func setNFCDataFormat(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_FORMAT] as? Int,
              let format = NFCDataFormat(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setNFCDataFormat(format)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getNFCDataFormat(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let format = reader.getNFCDataFormat().rawValue
        
        if let _ = NFCDataFormat(rawValue: format) {
            result(format)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func enableNFCUIDOnly(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableNFCUIDOnly(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isNFCUIDOnlyEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isNFCUIDOnlyEnabled()
        result(enable == .ENABLE)
    }

    private func enableNFCExtendedFormat(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableNFCExtendedFormat(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isNFCExtendedFormatEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isNFCExtendedFormatEnabled()
        result(enable == .ENABLE)
    }
}
