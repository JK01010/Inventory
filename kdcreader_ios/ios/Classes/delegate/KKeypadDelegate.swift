//
//  KKeypadDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/21/24.
//

import Flutter

class KKeypadDelegate: KReaderDelegate {
    private let ENABLE_ENTER_KEY_FUNCTION = "enableEnterKeyFunction"
    private let IS_ENTER_KEY_FUNCTION_ENABLED = "isEnterKeyFunctionEnabled"

    private let ENABLE_EXTEND_KEYPAD = "enableExtendKeypad"
    private let IS_EXTEND_KEYPAD_ENABLED = "isExtendKeypadEnabled"

    private let ENABLE_KEYPAD = "enableKeypad"
    private let IS_KEYPAD_ENABLED = "isKeypadEnabled"

    /* PARAM */
    private let PARAM_NAME_ENABLE = "enable"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            ENABLE_ENTER_KEY_FUNCTION,
            IS_ENTER_KEY_FUNCTION_ENABLED,
            
            ENABLE_EXTEND_KEYPAD,
            IS_EXTEND_KEYPAD_ENABLED,
            
            ENABLE_KEYPAD,
            IS_KEYPAD_ENABLED,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case ENABLE_ENTER_KEY_FUNCTION:
            enableEnterKeyFunction(call, result: result)
            
        case IS_ENTER_KEY_FUNCTION_ENABLED:
            isEnterKeyFunctionEnabled(call, result: result)

        case ENABLE_EXTEND_KEYPAD:
            enableExtendKeypad(call, result: result)
            
        case IS_EXTEND_KEYPAD_ENABLED:
            isExtendKeypadEnabled(call, result: result)

        case ENABLE_KEYPAD:
            enableKeypad(call, result: result)
            
        case IS_KEYPAD_ENABLED:
            isKeypadEnabled(call, result: result)
            
        default:
            break
        }
        return true
    }
    
    private func enableEnterKeyFunction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableEnterKeyFunction(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isEnterKeyFunctionEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isEnterKeyFunctionEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableExtendKeypad(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableExtendKeypad(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isExtendKeypadEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isExtendKeypadEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableKeypad(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableKeypad(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isKeypadEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isKeypadEnabled()
        result(enable == .ENABLE)
    }
}
