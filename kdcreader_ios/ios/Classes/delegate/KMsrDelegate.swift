//
//  KMsrDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/21/24.
//

import Flutter

class KMsrDelegate: KReaderDelegate {
    private let ENABLE_MSR_ERROR_BEEP = "enableMSRErrorBeep"
    private let IS_MSR_ERROR_BEEP_ENABLED = "isMSRErrorBeepEnabled"

    private let ENABLE_MSR_SENTINEL = "enableMSRSentinel"
    private let IS_MSR_SENTINEL_ENABLED = "isMSRSentinelEnabled"

    private let GET_MSR_CARD_TYPE = "getMSRCardType"
    private let SET_MSR_CARD_TYPE = "setMSRCardType"

    private let GET_MSR_DATA_TYPE = "getMSRDataType"
    private let SET_MSR_DATA_TYPE = "setMSRDataType"

    private let GET_MSR_DATA_ENCRYPTION = "getMSRDataEncryption"
    private let SET_MSR_DATA_ENCRYPTION = "setMSRDataEncryption"

    private let GET_MSR_TRACK_SEPARATOR = "getMSRTrackSeparator"
    private let SET_MSR_TRACK_SEPARATOR = "setMSRTrackSeparator"

    private let GET_MSR_TRACK_SELECTION = "getMSRTrackSelection"
    private let SET_MSR_TRACK_SELECTION = "setMSRTrackSelection"

    private let GET_PARTIAL_DATA_MSR_START_POSITION = "getPartialDataMSRStartPosition"
    private let SET_PARTIAL_DATA_MSR_START_POSITION = "setPartialDataMSRStartPosition"

    private let GET_PARTIAL_DATA_MSR_LENGTH = "getPartialDataMSRLength"
    private let SET_PARTIAL_DATA_MSR_LENGTH = "setPartialDataMSRLength"

    private let GET_PARTIAL_DATA_MSR_ACTION = "getPartialDataMSRAction"
    private let SET_PARTIAL_DATA_MSR_ACTION = "setPartialDataMSRAction"

    /* PARAM */
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_TYPE = "type"
    private let PARAM_NAME_ENCRYPTION = "encryption"
    private let PARAM_NAME_SEPARATOR = "separator"
    private let PARAM_NAME_SELECTION = "selection"
    private let PARAM_NAME_POSITION = "position"
    private let PARAM_NAME_LENGTH = "length"
    private let PARAM_NAME_ACTION = "action"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            ENABLE_MSR_ERROR_BEEP,
            IS_MSR_ERROR_BEEP_ENABLED,
            
            ENABLE_MSR_SENTINEL,
            IS_MSR_SENTINEL_ENABLED,
            
            GET_MSR_CARD_TYPE,
            SET_MSR_CARD_TYPE,
            
            GET_MSR_DATA_TYPE,
            SET_MSR_DATA_TYPE,
            
            GET_MSR_DATA_ENCRYPTION,
            SET_MSR_DATA_ENCRYPTION,
            
            GET_MSR_TRACK_SEPARATOR,
            SET_MSR_TRACK_SEPARATOR,
            
            GET_MSR_TRACK_SELECTION,
            SET_MSR_TRACK_SELECTION,
            
            GET_PARTIAL_DATA_MSR_START_POSITION,
            SET_PARTIAL_DATA_MSR_START_POSITION,
            
            GET_PARTIAL_DATA_MSR_LENGTH,
            SET_PARTIAL_DATA_MSR_LENGTH,
            
            GET_PARTIAL_DATA_MSR_ACTION,
            SET_PARTIAL_DATA_MSR_ACTION,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case ENABLE_MSR_ERROR_BEEP:
            enableMSRErrorBeep(call, result:result)
            
        case IS_MSR_ERROR_BEEP_ENABLED:
            isMSRErrorBeepEnabled(call, result:result)

        case ENABLE_MSR_SENTINEL:
            enableMSRSentinel(call, result:result)
            
        case IS_MSR_SENTINEL_ENABLED:
            isMSRSentinelEnabled(call, result:result)

        case GET_MSR_CARD_TYPE:
            getMSRCardType(call, result:result)
            
        case SET_MSR_CARD_TYPE:
            setMSRCardType(call, result:result)

        case GET_MSR_DATA_TYPE:
            getMSRDataType(call, result:result)
            
        case SET_MSR_DATA_TYPE:
            setMSRDataType(call, result:result)

        case GET_MSR_DATA_ENCRYPTION:
            getMSRDataEncryption(call, result:result)
            
        case SET_MSR_DATA_ENCRYPTION:
            setMSRDataEncryption(call, result:result)

        case GET_MSR_TRACK_SEPARATOR:
            getMSRTrackSeparator(call, result:result)
            
        case SET_MSR_TRACK_SEPARATOR:
            setMSRTrackSeparator(call, result:result)

        case GET_MSR_TRACK_SELECTION:
            getMSRTrackSelection(call, result:result)
            
        case SET_MSR_TRACK_SELECTION:
            setMSRTrackSelection(call, result:result)

        case GET_PARTIAL_DATA_MSR_START_POSITION:
            getPartialDataMSRStartPosition(call, result:result)
            
        case SET_PARTIAL_DATA_MSR_START_POSITION:
            setPartialDataMSRStartPosition(call, result:result)

        case GET_PARTIAL_DATA_MSR_LENGTH:
            getPartialDataMSRLength(call, result:result)
            
        case SET_PARTIAL_DATA_MSR_LENGTH:
            setPartialDataMSRLength(call, result:result)

        case GET_PARTIAL_DATA_MSR_ACTION:
            getPartialDataMSRAction(call, result:result)
            
        case SET_PARTIAL_DATA_MSR_ACTION:
            setPartialDataMSRAction(call, result:result)
            
        default:
            break
        }
        return true
    }

    private func enableMSRErrorBeep(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableMSRErrorBeep(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isMSRErrorBeepEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isMSRErrorBeepEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableMSRSentinel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableMSRSentinel(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isMSRSentinelEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isMSRSentinelEnabled()
        result(enable == .ENABLE)
    }
    
    private func getMSRCardType(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let type = reader.getMSRCardType().rawValue
        
        if let _ = MSRCardType(rawValue: type) {
            result(type)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setMSRCardType(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_TYPE] as? Int,
              let type = MSRCardType(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setMSRCardType(type)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getMSRDataType(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let type = reader.getMSRDataType().rawValue
        
        if let _ = MSRDataType(rawValue: type) {
            result(type)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setMSRDataType(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_TYPE] as? Int,
              let type = MSRDataType(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setMSRDataType(type)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getMSRDataEncryption(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let encryption = reader.getMSRDataEncryption().rawValue
        
        if let _ = MSRDataEncryption(rawValue: encryption) {
            result(encryption)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setMSRDataEncryption(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_ENCRYPTION] as? Int,
              let encryption = MSRDataEncryption(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setMSRDataEncryption(encryption)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getMSRTrackSeparator(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let separator = reader.getMSRTrackSeparator().rawValue
        
        if let _ = MSRTrackSeparator(rawValue: separator) {
            result(separator)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setMSRTrackSeparator(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_SEPARATOR] as? Int,
              let separator = MSRTrackSeparator(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setMSRTrackSeparator(separator)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getMSRTrackSelection(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let selection = reader.getMSRTrackSelection()
        
        if selection > -1 {
            result(selection)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setMSRTrackSelection(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let selection = args[PARAM_NAME_SELECTION] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setMSRTrackSelection(Int32(selection))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getPartialDataMSRStartPosition(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let position = reader.getPartialDataMSRStartPosition()
        
        if position > -1 {
            result(position)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setPartialDataMSRStartPosition(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_POSITION] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setPartialDataMSRStartPosition(Int32(v))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getPartialDataMSRLength(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let length = reader.getPartialDataMSRLength()
        
        if length > -1 {
            result(length)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setPartialDataMSRLength(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let length = args[PARAM_NAME_LENGTH] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setPartialDataMSRLength(Int32(length))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getPartialDataMSRAction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let action = reader.getPartialDataMSRAction().rawValue
        
        if let _ = PartialAction(rawValue: action) {
            result(action)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setPartialDataMSRAction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_ACTION] as? Int,
              let action = PartialAction(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setPartialDataMSRAction(action)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
}
