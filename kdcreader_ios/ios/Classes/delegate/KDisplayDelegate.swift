//
//  KDisplayDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/21/24.
//

import Flutter

class KDisplayDelegate: KReaderDelegate {
    private let ENABLE_DISPLAY_CONNECTION_STATUS = "enableDisplayConnectionStatus"
    private let IS_DISPLAY_CONNECTION_STATUS_ENABLED = "isDisplayConnectionStatusEnabled"

    private let ENABLE_MENU_BARCODE_STATE = "enableMenuBarcodeState"
    private let IS_MENU_BARCODE_STATE_ENABLED = "isMenuBarcodeStateEnabled"

    private let ENABLE_DISPLAY_SCROLL = "enableDisplayScroll"
    private let IS_SCROLLING_ENABLED = "isScrollingEnabled"

    private let SET_DISPLAY_POSITION = "setDisplayPosition"

    private let CLEAR_DISPLAY = "clearDisplay"

    private let SET_DISPLAY_MESSAGE_FONT_SIZE = "setDisplayMessageFontSize"
    private let SET_DISPLAY_MESSAGE_DURATION = "setDisplayMessageDuration"
    private let SET_MESSAGE_TEXT_ATTRIBUTE = "setMessageTextAttribute"

    private let SET_DISPLAY_MESSAGE = "setDisplayMessage"
    // unsupported private let SET_DISPLAY_MESSAGE_AND_GET_USER_CONFIRM = "setDisplayMessageAndGetUserConfirm"
    
    private let ENABLE_AUTO_MENU_EXIT = "enableAutoMenuExit"
    private let IS_AUTO_MENU_EXIT_ENABLED = "isAutoMenuExitEnabled"

    private let SET_LANGUAGE = "setLanguage"
    private let GET_LANGUAGE = "getLanguage"
    
    /* PARAM */
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_SIZE = "size"
    private let PARAM_NAME_DURATION = "duration"
    private let PARAM_NAME_ATTRIBUTE = "attribute"
    private let PARAM_NAME_MESSAGE = "message"
    private let PARAM_NAME_LANGUAGE = "language"
    private let PARAM_NAME_ROW = "row"
    private let PARAM_NAME_COLUMN = "column"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            ENABLE_DISPLAY_CONNECTION_STATUS,
            IS_DISPLAY_CONNECTION_STATUS_ENABLED,
            
            ENABLE_MENU_BARCODE_STATE,
            IS_MENU_BARCODE_STATE_ENABLED,
            
            ENABLE_DISPLAY_SCROLL,
            IS_SCROLLING_ENABLED,
            
            SET_DISPLAY_POSITION,
            
            CLEAR_DISPLAY,
            
            SET_DISPLAY_MESSAGE_FONT_SIZE,
            
            SET_DISPLAY_MESSAGE_DURATION,
            
            SET_MESSAGE_TEXT_ATTRIBUTE,
            
            SET_DISPLAY_MESSAGE,
            
            ENABLE_AUTO_MENU_EXIT,
            IS_AUTO_MENU_EXIT_ENABLED,
            
            SET_LANGUAGE,
            GET_LANGUAGE,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case ENABLE_DISPLAY_CONNECTION_STATUS:
            enableDisplayConnectionStatus(call, result: result)
            
        case IS_DISPLAY_CONNECTION_STATUS_ENABLED:
            isDisplayConnectionStatusEnabled(call, result: result)

        case ENABLE_MENU_BARCODE_STATE:
            enableMenuBarcodeState(call, result: result)
            
        case IS_MENU_BARCODE_STATE_ENABLED:
            isMenuBarcodeStateEnabled(call, result: result)

        case ENABLE_DISPLAY_SCROLL:
            enableDisplayScroll(call, result: result)
            
        case IS_SCROLLING_ENABLED:
            isScrollingEnabled(call, result: result)

        case SET_DISPLAY_POSITION:
            setDisplayPosition(call, result: result)
            
        case CLEAR_DISPLAY:
            clearDisplay(call, result: result)
            
        case SET_DISPLAY_MESSAGE_FONT_SIZE:
            setDisplayMessageFontSize(call, result: result)
            
        case SET_DISPLAY_MESSAGE_DURATION:
            setDisplayMessageDuration(call, result: result)
            
        case SET_MESSAGE_TEXT_ATTRIBUTE:
            setMessageTextAttribute(call, result: result)

        case SET_DISPLAY_MESSAGE:
            setDisplayMessage(call, result: result)

        case ENABLE_AUTO_MENU_EXIT:
            enableAutoMenuExit(call, result: result)
            
        case IS_AUTO_MENU_EXIT_ENABLED:
            isAutoMenuExitEnabled(call, result: result)

        case SET_LANGUAGE:
            setLanguage(call, result: result)
            
        case GET_LANGUAGE:
            getLanguage(call, result: result)
            
        default:
            break
        }
        return true
    }
    
    private func enableDisplayConnectionStatus(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableDisplayConnectionStatus(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isDisplayConnectionStatusEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isDisplayConnectionStatusEnabled()
        result(enable == .ENABLE)
    }

    private func enableMenuBarcodeState(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableMenuBarcodeState(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isMenuBarcodeStateEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isMenuBarcodeStateEnabled()
        result(enable == .ENABLE)
    }

    private func enableDisplayScroll(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableDisplayScroll(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isScrollingEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isScrollingEnabled()
        result(enable == .ENABLE)
    }

    private func setDisplayPosition(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let row = args[PARAM_NAME_ROW] as? Int,
              let column = args[PARAM_NAME_COLUMN] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setDisplayPosition(Int32(row), Int32(column))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func clearDisplay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.clearDisplay()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setDisplayMessageFontSize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_SIZE] as? Int,
              let size = MessageFontSize(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setDisplay(size) // setDisplayMessageFontSize
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setDisplayMessageDuration(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let duration = args[PARAM_NAME_DURATION] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setDisplayMessageDuration(Int32(duration))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setMessageTextAttribute(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_ATTRIBUTE] as? Int,
              let attr = MessageTextAttribute(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setMessageTextAttribute(attr)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setDisplayMessage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let message = args[PARAM_NAME_MESSAGE] as? String ?? KConstants.EMPTY_STRING

        let bRet = reader.setDisplayMessage(
            UnsafeMutablePointer<Int8>.init(mutating: (message as NSString).utf8String)
        )
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func enableAutoMenuExit(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableAutoMenuExit(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isAutoMenuExitEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isAutoMenuExitEnabled()
        result(enable == .ENABLE)
    }
    
    private func setLanguage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_LANGUAGE] as? Int,
              let lang = Language(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setLanguage(lang)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getLanguage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let lang = reader.getLanguage().rawValue
        
        if let _ = Language(rawValue: lang) {
            result(lang)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
}
