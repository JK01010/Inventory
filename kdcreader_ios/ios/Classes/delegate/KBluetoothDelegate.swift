//
//  KBluetoothDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/21/24.
//

import Flutter

class KBluetoothDelegate: KReaderDelegate {
    let ENABLE_BLUETOOTH_AUTO_CONNECT = "enableBluetoothAutoConnect"
    let IS_AUTO_CONNECT_ENABLED = "isAutoConnectEnabled"

    let ENABLE_BLUETOOTH_AUTO_POWER_ON = "enableBluetoothAutoPowerOn"
    let IS_AUTO_POWER_ON_ENABLED = "isAutoPowerOnEnabled"

    let ENABLE_BLUETOOTH_AUTO_POWER_OFF = "enableBluetoothAutoPowerOff"
    let IS_BLUETOOTH_AUTO_POWER_OFF_ENABLED = "isBluetoothAutoPowerOffEnabled"

    let ENABLE_BLUETOOTH_BEEP_WARNING = "enableBluetoothBeepWarning"
    let IS_BLUETOOTH_BEEP_WARNING_ENABLED = "isBluetoothBeepWarningEnabled"

    let GET_DEVICE_PROFILE = "getDeviceProfile"
    let SET_DEVICE_PROFILE = "setDeviceProfile"

    let GET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT = "getBluetoothAutoPowerOffTimeout"
    let SET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT = "setBluetoothAutoPowerOffTimeout"

    let ENABLE_BLUETOOTH_POWER_OFF_MESSAGE = "enableBluetoothPowerOffMessage"
    let IS_POWER_OFF_MESSAGE_ENABLED = "isPowerOffMessageEnabled"

    let GET_BLUETOOTH_MAC_ADDRESS = "getBluetoothMACAddress"

    let GET_BLUETOOTH_AUTO_POWER_ON_DELAY = "getBluetoothAutoPowerOnDelay"
    let SET_BLUETOOTH_AUTO_POWER_ON_DELAY = "setBluetoothAutoPowerOnDelay"

    let GET_BLUETOOTH_FIRMWARE_VERSION = "getBluetoothFirmwareVersion"

    let ENABLE_BLUETOOTH_WAKEUP_NULL = "enableBluetoothWakeupNull"
    let IS_WAKEUP_NULLS_ENABLED = "isWakeupNullsEnabled"

    let ENABLE_BLUETOOTH_TOGGLE = "enableBluetoothToggle"
    let IS_BLUETOOTH_TOGGLE_ENABLED = "isBluetoothToggleEnabled"

    let ENABLE_BLUETOOTH_DISCONNECT_BUTTON = "enableBluetoothDisconnectButton"
    let IS_BLUETOOTH_DISCONNECT_BUTTON_ENABLED = "isBluetoothDisconnectButtonEnabled"
    
    /* PARAM */
    let PARAM_NAME_ENABLE = "enable"
    let PARAM_NAME_PROFILE = "profile"
    let PARAM_NAME_TIMEOUT = "timeout"
    let PARAM_NAME_DELAY = "delay"
    let PARAM_NAME_ADDRESS = "address"
    let PARAM_NAME_VERSION = "version"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
                
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            ENABLE_BLUETOOTH_AUTO_CONNECT,
            IS_AUTO_CONNECT_ENABLED,
            
            ENABLE_BLUETOOTH_AUTO_POWER_ON,
            IS_AUTO_POWER_ON_ENABLED,
            
            ENABLE_BLUETOOTH_AUTO_POWER_OFF,
            IS_BLUETOOTH_AUTO_POWER_OFF_ENABLED,
            
            ENABLE_BLUETOOTH_BEEP_WARNING,
            IS_BLUETOOTH_BEEP_WARNING_ENABLED,
            
            GET_DEVICE_PROFILE,
            SET_DEVICE_PROFILE,
            
            GET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT,
            SET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT,
            
            ENABLE_BLUETOOTH_POWER_OFF_MESSAGE,
            IS_POWER_OFF_MESSAGE_ENABLED,
            
            GET_BLUETOOTH_MAC_ADDRESS,
            
            GET_BLUETOOTH_AUTO_POWER_ON_DELAY,
            SET_BLUETOOTH_AUTO_POWER_ON_DELAY,
            
            GET_BLUETOOTH_FIRMWARE_VERSION,
            
            ENABLE_BLUETOOTH_WAKEUP_NULL,
            IS_WAKEUP_NULLS_ENABLED,
            
            ENABLE_BLUETOOTH_TOGGLE,
            IS_BLUETOOTH_TOGGLE_ENABLED,
            
            ENABLE_BLUETOOTH_DISCONNECT_BUTTON,
            IS_BLUETOOTH_DISCONNECT_BUTTON_ENABLED,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case ENABLE_BLUETOOTH_AUTO_CONNECT:
            enableBluetoothAutoConnect(call, result: result)
            
        case IS_AUTO_CONNECT_ENABLED:
            isAutoConnectEnabled(call, result: result)

        case ENABLE_BLUETOOTH_AUTO_POWER_ON:
            enableBluetoothAutoPowerOn(call, result: result)
            
        case IS_AUTO_POWER_ON_ENABLED:
            isAutoPowerOnEnabled(call, result: result)

        case ENABLE_BLUETOOTH_AUTO_POWER_OFF:
            enableBluetoothAutoPowerOff(call, result: result)
            
        case IS_BLUETOOTH_AUTO_POWER_OFF_ENABLED:
            isBluetoothAutoPowerOffEnabled(call, result: result)

        case ENABLE_BLUETOOTH_BEEP_WARNING: 
            enableBluetoothBeepWarning(call, result: result)
            
        case IS_BLUETOOTH_BEEP_WARNING_ENABLED:
            isBluetoothBeepWarningEnabled(call, result: result)

        case GET_DEVICE_PROFILE: 
            getDeviceProfile(call, result: result)
            
        case SET_DEVICE_PROFILE:
            setDeviceProfile(call, result: result)

        case GET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT: 
            getBluetoothAutoPowerOffTimeout(call, result: result)
            
        case SET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT:
            setBluetoothAutoPowerOffTimeout(call, result: result)

        case ENABLE_BLUETOOTH_POWER_OFF_MESSAGE: 
            enableBluetoothPowerOffMessage(call, result: result)
            
        case IS_POWER_OFF_MESSAGE_ENABLED:
            isPowerOffMessageEnabled(call, result: result)

        case GET_BLUETOOTH_MAC_ADDRESS: 
            getBluetoothMACAddress(call, result: result)

        case GET_BLUETOOTH_AUTO_POWER_ON_DELAY: 
            getBluetoothAutoPowerOnDelay(call, result: result)
            
        case SET_BLUETOOTH_AUTO_POWER_ON_DELAY:
            setBluetoothAutoPowerOnDelay(call, result: result)

        case GET_BLUETOOTH_FIRMWARE_VERSION: 
            getBluetoothFirmwareVersion(call, result: result)

        case ENABLE_BLUETOOTH_WAKEUP_NULL: 
            enableBluetoothWakeupNull(call, result: result)
            
        case IS_WAKEUP_NULLS_ENABLED:
            isWakeupNullsEnabled(call, result: result)

        case ENABLE_BLUETOOTH_TOGGLE: 
            enableBluetoothToggle(call, result: result)
            
        case IS_BLUETOOTH_TOGGLE_ENABLED:
            isBluetoothToggleEnabled(call, result: result)

        case ENABLE_BLUETOOTH_DISCONNECT_BUTTON: 
            enableBluetoothDisconnectButton(call, result: result)
            
        case IS_BLUETOOTH_DISCONNECT_BUTTON_ENABLED:
            isBluetoothDisconnectButtonEnabled(call, result: result)

        default:
            break
        }
        return true
    }
    
    
    private func enableBluetoothAutoConnect(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBluetoothAutoConnect(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isAutoConnectEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isAutoConnectEnabled()
        result(enable == .ENABLE)
    }

    private func enableBluetoothAutoPowerOn(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBluetoothAutoPower(on: enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isAutoPowerOnEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isAutoPowerOnEnabled()
        result(enable == .ENABLE)
    }

    private func enableBluetoothAutoPowerOff(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBluetoothAutoPowerOff(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isBluetoothAutoPowerOffEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isBluetoothAutoPowerOffEnabled()
        result(enable == .ENABLE)
    }

    private func enableBluetoothBeepWarning(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBluetoothBeepWarning(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isBluetoothBeepWarningEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isBluetoothBeepWarningEnabled()
        result(enable == .ENABLE)
    }

    private func getDeviceProfile(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let profile = reader.getDeviceProfile().rawValue
        
        if let _ = DeviceProfile(rawValue: profile) {
            result(profile)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setDeviceProfile(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_PROFILE] as? Int,
              let profile = DeviceProfile(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setDeviceProfile(profile)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getBluetoothAutoPowerOffTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let timeout = reader.getBluetoothAutoPowerOffTimeout().rawValue
        
        if let _ = AutoPowerOffTimeout(rawValue: timeout) {
            result(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setBluetoothAutoPowerOffTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_TIMEOUT] as? Int,
              let timeout = AutoPowerOffTimeout(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setBluetoothAutoPowerOffTimeout(timeout)
     
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func enableBluetoothPowerOffMessage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBluetoothPowerOffMessage(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isPowerOffMessageEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isPowerOffMessageEnabled()
        result(enable == .ENABLE)
    }

    private func getBluetoothMACAddress(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let address = reader.getBluetoothMACAddress() {
            result(String(cString: address))
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getBluetoothAutoPowerOnDelay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let delay = reader.getBluetoothAutoPowerOnDelay().rawValue
        
        if let _ = PowerOnTime(rawValue: delay) {
            result(delay)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setBluetoothAutoPowerOnDelay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_DELAY] as? Int,
              let delay = PowerOnTime(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setBluetoothAutoPower(onDelay: delay)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getBluetoothFirmwareVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let version = reader.getBluetoothFirmwareVersion() {
            result(String(cString: version))
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func enableBluetoothWakeupNull(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBluetoothWakeupNull(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isWakeupNullsEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isWakeupNullsEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableBluetoothToggle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBluetoothToggle(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isBluetoothToggleEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isBluetoothToggleEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableBluetoothDisconnectButton(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBluetoothDisconnectButton(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isBluetoothDisconnectButtonEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isBluetoothDisconnectButtonEnabled()
        result(enable == .ENABLE)
    }
}
