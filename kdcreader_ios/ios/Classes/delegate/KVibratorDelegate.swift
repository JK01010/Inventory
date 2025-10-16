//
//  KVibratorDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/22/24.
//

import Flutter

class KVibratorDelegate: KReaderDelegate {
    private let ENABLE_VIBRATOR = "enableVibrator"
    private let IS_VIBRATOR_ENABLED = "isVibratorEnabled"

    private let SET_CUSTOM_VIBRATION = "setCustomVibration"

    /* PARAM */
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_ONTIME = "onTime"
    private let PARAM_NAME_OFFTIME = "offTime"
    private let PARAM_NAME_REPEAT = "repeat"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            ENABLE_VIBRATOR,
            IS_VIBRATOR_ENABLED,
            
            SET_CUSTOM_VIBRATION,
        ]);
    }

    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case ENABLE_VIBRATOR:
            enableVibrator(call, result: result)
            
        case IS_VIBRATOR_ENABLED:
            isVibratorEnabled(call, result: result)

        case SET_CUSTOM_VIBRATION:
            setCustomVibration(call, result: result)
            
        default:
            break
        }
        return true
    }
    
    private func enableVibrator(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableVibrator(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isVibratorEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isVibratorEnabled()
        result(enable == .ENABLE)
    }
    
    private func setCustomVibration(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let onTime = args[PARAM_NAME_ONTIME] as? Int,
              let offTime = args[PARAM_NAME_OFFTIME] as? Int,
              let rep = args[PARAM_NAME_REPEAT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        // duration, interval, repeat
        let bRet = reader.setCustomVibration(Int32(onTime), Int32(offTime), Int32(rep))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
}
