//
//  KUhfDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/22/24.
//

import Flutter

class KUhfDelegate: KReaderDelegate {
    private let IS_UHF_MODULE_ATTACHED = "isUHFModuleAttached"

    private let IS_UHF_POWER_ENABLED = "isUHFPowerEnabled"
    private let ENABLE_UHF_POWER = "enableUHFPower"

    private let GET_UHF_POWER_LEVEL = "getUHFPowerLevel"
    private let SET_UHF_POWER_LEVEL = "setUHFPowerLevel"

    private let GET_UHF_READ_MODE = "getUHFReadMode"
    private let SET_UHF_READ_MODE = "setUHFReadMode"

    private let GET_UHF_READ_TAG_MODE = "getUHFReadTagMode"
    private let SET_UHF_READ_TAG_MODE = "setUHFReadTagMode"

    private let GET_UHF_DATA_TYPE = "getUHFDataType"
    private let SET_UHF_DATA_TYPE = "setUHFDataType"

    private let GET_UHF_DATA_FORMAT = "getUHFDataFormat"
    private let SET_UHF_DATA_FORMAT = "setUHFDataFormat"

    private let IS_UHF_DUPLICATE_CHECK_ENABLED = "isUHFDuplicateCheckEnabled"
    private let ENABLE_UHF_DUPLICATE_CHECK = "enableUHFDuplicateCheck"

    private let IS_UHF_BURST_MODE_ENABLED = "isUHFBurstModeEnabled"
    private let ENABLE_UHF_BURST_MODE = "enableUHFBurstMode"

    private let IS_UHF_KEY_EVENT_ENABLED = "isUHFKeyEventEnabled"
    private let ENABLE_UHF_KEY_EVENT = "enableUHFKeyEvent"

    private let CANCEL_UHF_READING = "cancelUHFReading"

    private let GET_UHF_MODULE_TYPE = "getUHFModuleType"

    private let GET_UHF_POWER_LEVEL_EX = "getUHFPowerLevelEx"
    private let SET_UHF_POWER_LEVEL_EX = "setUHFPowerLevelEx"

    private let GET_UHF_POWER_TIMEOUT = "getUHFPowerTimeout"
    private let SET_UHF_POWER_TIMEOUT = "setUHFPowerTimeout"

    private let GET_UHF_READING_TIMEOUT = "getUHFReadingTimeout"
    private let SET_UHF_READING_TIMEOUT = "setUHFReadingTimeout"

    private let GET_UHF_REGION = "getUHFRegion"

    private let GET_UHF_TAG_LIST = "getUHFTagList"

    private let SELECT_UHF_TAG = "selectUHFTag"

    private let READ_UHF_TAG_MEMORY = "readUHFTagMemory"
    private let WRITE_UHF_TAG_MEMORY = "writeUHFTagMemory"

    private let SET_UHF_TAG_LOCK = "setUHFTagLock"
    private let KILL_UHF_TAG = "killUHFTag"

    private let SET_UHF_UNTRACEABLE = "setUHFUntraceable"

    private let GET_UHF_SELECT_PARAMETER = "getUHFSelectParameter"
    private let SET_UHF_SELECT_PARAMETER = "setUHFSelectParameter"

    private let GET_UHF_QUERY_PARAMETER = "getUHFQueryParameter"
    private let SET_UHF_QUERY_PARAMETER = "setUHFQueryParameter"

    private let AUTHENTICATE_UHF_TAG = "authenticateUHFTag"

    /* PARAM */
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_LEVEL = "level"
    private let PARAM_NAME_MODE = "mode"
    private let PARAM_NAME_TYPE = "type"
    private let PARAM_NAME_FORMAT = "format"
    private let PARAM_NAME_TIMEOUT = "timeout"
    private let PARAM_NAME_EPC = "epc"
    private let PARAM_NAME_PASSWORD = "pwd"

    private let PARAM_NAME_BANK = "bank"
    private let PARAM_NAME_START = "start"
    private let PARAM_NAME_LENGTH = "length"
    private let PARAM_NAME_DATA = "data"
    private let PARAM_NAME_MASK = "mask"

    private let PARAM_NAME_MASK_DATA = "maskData"

    private let PARAM_NAME_XPC = "xpc"
    private let PARAM_NAME_TID = "tid"
    private let PARAM_NAME_USER = "user"
    private let PARAM_NAME_RANGE = "range"
    private let PARAM_NAME_TARGET = "target"
    private let PARAM_NAME_ACTION = "action"
    private let PARAM_NAME_POINTER = "pointer"
    private let PARAM_NAME_TRUNCATED = "truncated"
    private let PARAM_NAME_DR = "dr"
    private let PARAM_NAME_CYCLE = "cycle"
    private let PARAM_NAME_TREXT = "tRext"
    private let PARAM_NAME_SEL = "sel"
    private let PARAM_NAME_SESSION = "session"
    private let PARAM_NAME_SLOT_NUM = "slotNum"
    private let PARAM_NAME_SEN_REP = "senRep"
    private let PARAM_NAME_INC_REP_LEN = "incRepLen"
    private let PARAM_NAME_CSI = "csi"
    private let PARAM_NAME_MESSAGE = "message"
    private let PARAM_NAME_ATTACH = "attached"
    private let PARAM_NAME_REGION = "region"
    private let PARAM_NAME_LIST = "list"

    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            IS_UHF_MODULE_ATTACHED,
            
            IS_UHF_POWER_ENABLED,
            ENABLE_UHF_POWER,
            
            GET_UHF_POWER_LEVEL,
            SET_UHF_POWER_LEVEL,
            
            GET_UHF_READ_MODE,
            SET_UHF_READ_MODE,
            
            GET_UHF_READ_TAG_MODE,
            SET_UHF_READ_TAG_MODE,
            
            GET_UHF_DATA_TYPE,
            SET_UHF_DATA_TYPE,
            
            GET_UHF_DATA_FORMAT,
            SET_UHF_DATA_FORMAT,
            
            IS_UHF_DUPLICATE_CHECK_ENABLED,
            ENABLE_UHF_DUPLICATE_CHECK,
            
            IS_UHF_BURST_MODE_ENABLED,
            ENABLE_UHF_BURST_MODE,
            
            IS_UHF_KEY_EVENT_ENABLED,
            ENABLE_UHF_KEY_EVENT,
            
            CANCEL_UHF_READING,
            
            GET_UHF_MODULE_TYPE,
            
            GET_UHF_POWER_LEVEL_EX,
            SET_UHF_POWER_LEVEL_EX,
            
            GET_UHF_POWER_TIMEOUT,
            SET_UHF_POWER_TIMEOUT,
            
            GET_UHF_READING_TIMEOUT,
            SET_UHF_READING_TIMEOUT,
            
            GET_UHF_REGION,
            
            GET_UHF_TAG_LIST,
            
            SELECT_UHF_TAG,
            
            READ_UHF_TAG_MEMORY,
            WRITE_UHF_TAG_MEMORY,
            
            SET_UHF_TAG_LOCK,
            KILL_UHF_TAG,
            SET_UHF_UNTRACEABLE,
            
            GET_UHF_SELECT_PARAMETER,
            SET_UHF_SELECT_PARAMETER,
            
            GET_UHF_QUERY_PARAMETER,
            SET_UHF_QUERY_PARAMETER,
            
            AUTHENTICATE_UHF_TAG,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case IS_UHF_MODULE_ATTACHED: 
            isUHFModuleAttached(call, result: result)

        case IS_UHF_POWER_ENABLED: 
            isUHFPowerEnabled(call, result: result)
            
        case ENABLE_UHF_POWER:
            enableUHFPower(call, result: result)

        case GET_UHF_POWER_LEVEL: 
            getUHFPowerLevel(call, result: result)
            
        case SET_UHF_POWER_LEVEL:
            setUHFPowerLevel(call, result: result)

        case GET_UHF_READ_MODE: 
            getUHFReadMode(call, result: result)
            
        case SET_UHF_READ_MODE:
            setUHFReadMode(call, result: result)

        case GET_UHF_READ_TAG_MODE: 
            getUHFReadTagMode(call, result: result)
            
        case SET_UHF_READ_TAG_MODE:
            setUHFReadTagMode(call, result: result)

        case GET_UHF_DATA_TYPE: 
            getUHFDataType(call, result: result)
            
        case SET_UHF_DATA_TYPE:
            setUHFDataType(call, result: result)

        case GET_UHF_DATA_FORMAT: 
            getUHFDataFormat(call, result: result)
            
        case SET_UHF_DATA_FORMAT:
            setUHFDataFormat(call, result: result)

        case IS_UHF_DUPLICATE_CHECK_ENABLED: 
            isUHFDuplicateCheckEnabled(call, result: result)
            
        case ENABLE_UHF_DUPLICATE_CHECK:
            enableUHFDuplicateCheck(call, result: result)

        case IS_UHF_BURST_MODE_ENABLED: 
            isUHFBurstModeEnabled(call, result: result)
            
        case ENABLE_UHF_BURST_MODE:
            enableUHFBurstMode(call, result: result)

        case IS_UHF_KEY_EVENT_ENABLED: 
            isUHFKeyEventEnabled(call, result: result)
            
        case ENABLE_UHF_KEY_EVENT:
            enableUHFKeyEvent(call, result: result)

        case CANCEL_UHF_READING: 
            cancelUHFReading(call, result: result)

        case GET_UHF_MODULE_TYPE: 
            getUHFModuleType(call, result: result)

        case GET_UHF_POWER_LEVEL_EX: 
            getUHFPowerLevelEx(call, result: result)
            
        case SET_UHF_POWER_LEVEL_EX:
            setUHFPowerLevelEx(call, result: result)

        case GET_UHF_POWER_TIMEOUT: 
            getUHFPowerTimeout(call, result: result)
            
        case SET_UHF_POWER_TIMEOUT:
            setUHFPowerTimeout(call, result: result)

        case GET_UHF_READING_TIMEOUT: 
            getUHFReadingTimeout(call, result: result)
            
        case SET_UHF_READING_TIMEOUT:
            setUHFReadingTimeout(call, result: result)

        case GET_UHF_REGION: 
            getUHFRegion(call, result: result)

        case GET_UHF_TAG_LIST: 
            getUHFTagList(call, result: result)

        case SELECT_UHF_TAG: 
            selectUHFTag(call, result: result)

        case READ_UHF_TAG_MEMORY: 
            readUHFTagMemory(call, result: result)
            
        case WRITE_UHF_TAG_MEMORY:
            writeUHFTagMemory(call, result: result)

        case SET_UHF_TAG_LOCK: 
            setUHFTagLock(call, result: result)

        case KILL_UHF_TAG: 
            killUHFTag(call, result: result)

        case SET_UHF_UNTRACEABLE: 
            setUHFUntraceable(call, result: result)

        case GET_UHF_SELECT_PARAMETER: 
            getUHFSelectParameter(call, result: result)
            
        case SET_UHF_SELECT_PARAMETER:
            setUHFSelectParameter(call, result: result)

        case GET_UHF_QUERY_PARAMETER: 
            getUHFQueryParameter(call, result: result)
            
        case SET_UHF_QUERY_PARAMETER:
            setUHFQueryParameter(call, result: result)

        case AUTHENTICATE_UHF_TAG: 
            authenticateUHFTag(call, result: result)

        default:
            break
        }
        return true
    }
    
    private func isUHFModuleAttached(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let attached = reader.isUHFModuleAttached()
        result(attached)
    }

    private func isUHFPowerEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isUHFPowerEnabled()
        result(enable)
    }
    
    private func enableUHFPower(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableUHFPower(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getUHFPowerLevel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let level = reader.getUHFPowerLevel().rawValue
        
        if let _ = UHFPowerLevel(rawValue: level) {
            result(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setUHFPowerLevel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_LEVEL] as? Int,
              let level = UHFPowerLevel(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setUHFPowerLevel(level)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getUHFReadMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let mode = reader.getUHFReadMode().rawValue
        
        if let _ = UHFReadMode(rawValue: mode) {
            result(mode)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setUHFReadMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_MODE] as? Int,
              let mode = UHFReadMode(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setUHFReadMode(mode)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getUHFReadTagMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let mode = reader.getUHFReadTagMode().rawValue
        
        if let _ = UHFReadTagMode(rawValue: mode) {
            result(mode)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setUHFReadTagMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_MODE] as? Int,
              let mode = UHFReadTagMode(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setUHFReadTagMode(mode)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getUHFDataType(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let type = reader.getUHFDataType().rawValue
        
        if let _ = UHFDataType(rawValue: type) {
            result(type)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setUHFDataType(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_TYPE] as? Int,
              let type = UHFDataType(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setUHFDataType(type)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getUHFDataFormat(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let format = reader.getUHFDataFormat().rawValue
        
        if let _ = UHFDataFormat(rawValue: format) {
            result(format)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setUHFDataFormat(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_FORMAT] as? Int,
              let format = UHFDataFormat(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setUHFDataFormat(format)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isUHFDuplicateCheckEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isUHFDuplicateCheckEnabled()
        result(enable)
    }
    
    private func enableUHFDuplicateCheck(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableUHFDuplicateCheck(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isUHFBurstModeEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isUHFBurstModeEnabled()
        result(enable)
    }

    private func enableUHFBurstMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableUHFBurstMode(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isUHFKeyEventEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isUHFKeyEventEnabled()
        result(enable)
    }

    private func enableUHFKeyEvent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableUHFKeyEvent(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func cancelUHFReading(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        reader.cancelUHFReading()
        result(true)
    }

    private func getUHFModuleType(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let type = reader.getUHFModuleType().rawValue
        
        if let _ = UHFModuleType(rawValue: type) {
            result(type)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getUHFPowerLevelEx(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let level = reader.getUHFPowerLevelEx()
        
        if level > -1 {
            result(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setUHFPowerLevelEx(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let level = args[PARAM_NAME_LEVEL] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setUHFPowerLevelEx(Int32(level))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getUHFPowerTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let timeout = reader.getUHFPowerTimeout()
        
        if timeout > -1 {
            result(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setUHFPowerTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setUHFPowerTimeout(Int32(timeout))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getUHFReadingTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let timeout = reader.getUHFReadingTimeout()
        
        if timeout > -1 {
            result(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setUHFReadingTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setUHFReadingTimeout(Int32(timeout))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getUHFRegion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let region = reader.getUHFRegion().rawValue
        
        if let _ = UHFRegion(rawValue: region) {
            result(region)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getUHFTagList(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        var tagList = [String]()

        var status: UHFStatus = UHFStatus()
        status.format = .DATA_HEX_DECIMAL
        
        if let list = reader .getUHFTagList(Int32(timeout), status: &status) {
            for item in list {
                if let data = item as? Data, let tag = String(data: data, encoding: .utf8) {
                    tagList.append(tag)
                }
            }
        }
        
        if status.errorCode == UHF_SUCCESS {
            result(tagList)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.Operation] = status.errorCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func selectUHFTag(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let epc = args[PARAM_NAME_EPC] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        if let e = epc.data(using: .utf8) {
            var status: UHFStatus = UHFStatus()
            status.format = .DATA_HEX_DECIMAL

            reader.selectUHFTag(e, status: &status)
            
            if status.errorCode == UHF_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.Operation] = status.errorCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }
    
    private func readUHFTagMemory(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let pwd = args[PARAM_NAME_PASSWORD] as? String,
              let bank = args[PARAM_NAME_BANK] as? Int,
              let start = args[PARAM_NAME_START] as? Int,
              let length = args[PARAM_NAME_LENGTH] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        if let memBank = UHFMemoryBank(rawValue: bank),
           let password = pwd.data(using: .utf8) {
            var status: UHFStatus = UHFStatus()
            status.format = .DATA_HEX_DECIMAL
            
            let readData = reader.readUHFTagMemory(password, bank: memBank, start: Int32(start),
                                                   length: Int32(length), status: &status)
            
            if let data = readData, status.errorCode == UHF_SUCCESS {
                result(String(data: data, encoding: .utf8))
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.Operation] = status.errorCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }
    
    private func writeUHFTagMemory(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let pwd = args[PARAM_NAME_PASSWORD] as? String,
              let bank = args[PARAM_NAME_BANK] as? Int,
              let start = args[PARAM_NAME_START] as? Int,
              let length = args[PARAM_NAME_LENGTH] as? Int,
              let data = args[PARAM_NAME_DATA] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        if let memBank = UHFMemoryBank(rawValue: bank),
           let password = pwd.data(using: .utf8),
           let writeData = data.data(using: .utf8) {
            var status: UHFStatus = UHFStatus()
            status.format = .DATA_HEX_DECIMAL
            
            reader.writeUHFTagMemory(password, bank: memBank, start: Int32(start),
                                     length: Int32(length), data: writeData, status: &status)
            
            if status.errorCode == UHF_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.Operation] = status.errorCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }
    
    private func setUHFTagLock(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let pwd = args[PARAM_NAME_PASSWORD] as? String,
              let mask = args[PARAM_NAME_MASK] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        if let password = pwd.data(using: .utf8) {
            var status: UHFStatus = UHFStatus()
            status.format = .DATA_HEX_DECIMAL
            
            reader.setUHFTagLock(password, mask: Int32(mask), status: &status)
            
            if status.errorCode == UHF_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.Operation] = status.errorCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }
    
    private func killUHFTag(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let pwd = args[PARAM_NAME_PASSWORD] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        if let password = pwd.data(using: .utf8) {
            var status: UHFStatus = UHFStatus()
            status.format = .DATA_HEX_DECIMAL
            
            reader.killUHFTag(password, status: &status)
            
            if status.errorCode == UHF_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.Operation] = status.errorCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }
    
    private func setUHFUntraceable(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let xpc = args[PARAM_NAME_XPC] as? Int,
              let epc = args[PARAM_NAME_EPC] as? Int,
              let tid = args[PARAM_NAME_TID] as? Int,
              let user = args[PARAM_NAME_USER] as? Int,
              let range = args[PARAM_NAME_RANGE] as? Int,
              let pwd = args[PARAM_NAME_PASSWORD] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        if let password = pwd.data(using: .utf8) {
            var status: UHFStatus = UHFStatus()
            status.format = .DATA_HEX_DECIMAL
            
            reader.setUHFUntraceable(Int32(xpc), epc: Int32(epc), tid: Int32(tid),
                                     user: Int32(user), range: Int32(range), pwd: password, status: &status)
            
            if status.errorCode == UHF_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.Operation] = status.errorCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }
    
    private func getUHFSelectParameter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var status: UHFStatus = UHFStatus()
        status.format = .DATA_HEX_DECIMAL
        
        let uhfResult = reader.getUHFSelectParameter(&status)
        
        if status.errorCode == UHF_SUCCESS, let parameter = uhfResult?.selectParameter {
            let parameterDict = converter.fromSelectParameter(parameter)
            result(parameterDict)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.Operation] = status.errorCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }

    private func setUHFSelectParameter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let target = args[PARAM_NAME_TARGET] as? Int,
              let action = args[PARAM_NAME_ACTION] as? Int,
              let bank = args[PARAM_NAME_BANK] as? Int,
              let pointer = args[PARAM_NAME_POINTER] as? Int,
              let length = args[PARAM_NAME_LENGTH] as? Int,
              let mask = args[PARAM_NAME_MASK_DATA] as? String,
              let isTruncated = args[PARAM_NAME_TRUNCATED] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        if let memBank = UHFMemoryBank(rawValue: bank),
           let maskData = mask.data(using: .utf8) {
            var status: UHFStatus = UHFStatus()
            status.format = .DATA_HEX_DECIMAL
            
            reader.setUHFSelectParameter(Int32(target), action: Int32(action), memBank: memBank,
                                         pointer: Int32(pointer), length: Int32(length), mask: maskData,
                                         isTruncated: isTruncated, status: &status)
            
            if status.errorCode == UHF_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.Operation] = status.errorCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }

    private func getUHFQueryParameter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var status: UHFStatus = UHFStatus()
        status.format = .DATA_HEX_DECIMAL
        
        let uhfResult = reader.getUHFQueryParameter(&status)
        
        if status.errorCode == UHF_SUCCESS, let parameter = uhfResult?.queryParameter {
            let parameterDict = converter.fromQueryParameter(parameter)
            result(parameterDict)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.Operation] = status.errorCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }

    private func setUHFQueryParameter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let dr = args[PARAM_NAME_DR] as? Int,
              let cycle = args[PARAM_NAME_CYCLE] as? Int,
              let tRext = args[PARAM_NAME_TREXT] as? Int,
              let sel = args[PARAM_NAME_SEL] as? Int,
              let session = args[PARAM_NAME_SESSION] as? Int,
              let target = args[PARAM_NAME_TARGET] as? Int,
              let slotNum = args[PARAM_NAME_SLOT_NUM] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        var status: UHFStatus = UHFStatus()
        status.format = .DATA_HEX_DECIMAL
         
        reader.setUHFQueryParameter(Int32(dr), cycle: Int32(cycle), tRext: Int32(tRext),
                                    sel: Int32(sel), session: Int32(session), target: Int32(target),
                                    slotNum: Int32(slotNum), status: &status)
        
        if status.errorCode == UHF_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.Operation] = status.errorCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }

    }

    private func authenticateUHFTag(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let senRep = args[PARAM_NAME_SEN_REP] as? Int,
              let incRepLen = args[PARAM_NAME_INC_REP_LEN] as? Int,
              let csi = args[PARAM_NAME_CSI] as? Int,
              let length = args[PARAM_NAME_LENGTH] as? Int,
              let msg = args[PARAM_NAME_MESSAGE] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        if let message = msg.data(using: .utf8) {
            var status: UHFStatus = UHFStatus()
            status.format = .DATA_HEX_DECIMAL
            
            reader.authenticateUHFTag(Int32(senRep), incRepLen: Int32(incRepLen), csi: Int32(csi),
                                      length: Int32(length), message: message, status: &status)
            
            if status.errorCode == UHF_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.Operation] = status.errorCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }
}
