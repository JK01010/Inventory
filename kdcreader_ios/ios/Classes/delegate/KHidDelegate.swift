//
//  KHidDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/21/24.
//

import Flutter

class KHidDelegate: KReaderDelegate {
    private let GET_HID_AUTO_LOCK_TIME = "getHIDAutoLockTime"
    private let SET_HID_AUTO_LOCK_TIME = "setHIDAutoLockTime"

    private let GET_HID_KEYBOARD = "getHIDKeyboard"
    private let SET_HID_KEYBOARD = "setHIDKeyboard"

    private let GET_HID_INITIAL_DELAY = "getHIDInitialDelay"
    private let SET_HID_INITIAL_DELAY = "setHIDInitialDelay"

    private let GET_HID_INTER_DELAY = "getHIDInterDelay"
    private let SET_HID_INTER_DELAY = "setHIDInterDelay"

    private let GET_HID_CONTROL_CHARACTER = "getHIDControlCharacter"
    private let SET_HID_CONTROL_CHARACTER = "setHIDControlCharacter"

    /* PARAM */
    private let PARAM_NAME_TIMEOUT = "timeout"
    private let PARAM_NAME_KEYBOARD = "keyboard"
    private let PARAM_NAME_DELAY = "delay"
    private let PARAM_NAME_CHARACTER = "character"

    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            GET_HID_AUTO_LOCK_TIME,
            SET_HID_AUTO_LOCK_TIME,
            
            GET_HID_KEYBOARD,
            SET_HID_KEYBOARD,
            
            GET_HID_INITIAL_DELAY,
            SET_HID_INITIAL_DELAY,
            
            GET_HID_INTER_DELAY,
            SET_HID_INTER_DELAY,
            
            GET_HID_CONTROL_CHARACTER,
            SET_HID_CONTROL_CHARACTER,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case GET_HID_AUTO_LOCK_TIME:
            getHIDAutoLockTime(call, result: result)
            
        case SET_HID_AUTO_LOCK_TIME:
            setHIDAutoLockTime(call, result: result)

        case GET_HID_KEYBOARD:
            getHIDKeyboard(call, result: result)
            
        case SET_HID_KEYBOARD:
            setHIDKeyboard(call, result: result)

        case GET_HID_INITIAL_DELAY:
            getHIDInitialDelay(call, result: result)
            
        case SET_HID_INITIAL_DELAY:
            setHIDInitialDelay(call, result: result)

        case GET_HID_INTER_DELAY:
            getHIDInterDelay(call, result: result)
            
        case SET_HID_INTER_DELAY:
            setHIDInterDelay(call, result: result)

        case GET_HID_CONTROL_CHARACTER:
            getHIDControlCharacter(call, result: result)
            
        case SET_HID_CONTROL_CHARACTER:
            setHIDControlCharacter(call, result: result)

        default:
            break
        }
        return true
    }
        
    private func getHIDAutoLockTime(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let timeout = reader.getHIDAutoLockTime().rawValue
        
        if let _ = HIDAutoLockTime(rawValue: timeout) {
            result(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setHIDAutoLockTime(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_TIMEOUT] as? Int,
              let timeout = HIDAutoLockTime(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setHIDAutoLockTime(timeout)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getHIDKeyboard(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let keyboard = reader.getHIDKeyboard().rawValue
        
        if let _ = HIDKeyboard(rawValue: keyboard) {
            result(keyboard)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setHIDKeyboard(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_KEYBOARD] as? Int,
              let keyboard = HIDKeyboard(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setHIDKeyboard(keyboard)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getHIDInitialDelay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let delay = reader.getHIDInitialDelay().rawValue
        
        if let _ = HIDInitialDelay(rawValue: delay) {
            result(delay)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setHIDInitialDelay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_DELAY] as? Int,
              let delay = HIDInitialDelay(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setHIDInitialDelay(delay)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getHIDInterDelay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let delay = reader.getHIDInterDelay().rawValue
        
        if let _ = HIDInterDelay(rawValue: delay) {
            result(delay)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setHIDInterDelay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_DELAY] as? Int,
              let delay = HIDInterDelay(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setHIDInterDelay(delay)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getHIDControlCharacter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let character = reader.getHIDControlCharacter().rawValue
        
        if let _ = HIDControlCharacter(rawValue: character) {
            result(character)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setHIDControlCharacter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_KEYBOARD] as? Int,
              let character = HIDControlCharacter(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setHIDControlCharacter(character)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

}
