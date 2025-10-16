//
//  KSystemDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/22/24.
//

import Flutter

class KSystemDelegate: KReaderDelegate {
    private let ENABLE_BUTTON_LOCK = "enableButtonLock"
    private let ENABLE_SCAN_BUTTON_LOCK = "enableScanButtonLock"

    private let ERASE_MEMORY = "eraseMemory"
    private let ERASE_LAST_DATA = "eraseLastData"

    private let GET_MEMORY_LEFT = "getMemoryLeft"

    private let GET_SLEEP_TIMEOUT = "getSleepTimeout"
    private let SET_SLEEP_TIMEOUT = "setSleepTimeout"

    private let GET_SCAN_TIMEOUT = "getScanTimeout"
    private let SET_SCAN_TIMEOUT = "setScanTimeout"

    private let GET_BATTERY_LEVEL = "getBatteryLevel"
    private let GET_EXTENDED_BATTERY_LEVEL = "getExtendedBatteryLevel"

    private let SYNC_SYSTEM_TIME = "syncSystemTime"
    private let RESET_SYSTEM_TIME = "resetSystemTime"

    private let SET_FACTORY_DEFAULT = "setFactoryDefault"

    private let GET_BEEP_VOLUME = "getBeepVolume"
    private let SET_BEEP_VOLUME = "setBeepVolume"
    
    private let ENABLE_HIGH_BEEP_VOLUME = "enableHighBeepVolume"
    private let IS_HIGH_BEEP_VOLUME_ENABLED = "isHighBeepVolumeEnabled"

    private let ENABLE_BEEP_SOUND = "enableBeepSound"
    private let IS_BEEP_SOUND_ENABLED = "isBeepSoundEnabled"

    private let ENABLE_POWER_ON_BEEP = "enablePowerOnBeep"
    private let IS_POWER_ON_BEEP_ENABLED = "isPowerOnBeepEnabled"

    private let ENABLE_BEEP_ON_SCAN = "enableBeepOnScan"
    private let IS_BEEP_ON_SCAN_ENABLED = "isBeepOnScanEnabled"

    private let ENABLE_BEEP_ON_CONNECT = "enableBeepOnConnect"
    private let IS_BEEP_ON_CONNECT_ENABLED = "isBeepOnConnectEnabled"

    private let SET_FAILURE_ALERT_BEEP = "setFailureAlertBeep"

    private let SET_SUCCESS_ALERT_BEEP = "setSuccessAlertBeep"

    private let SET_CUSTOM_BEEP_TONE = "setCustomBeepTone"

    private let ENABLE_MFI_MODE = "enableMFiMode"
    private let IS_MFI_ENABLED = "isMFiEnabled"

    private let IS_MFI_AUTH_CHIP_INSTALLED = "isMFiAuthChipInstalled"

    private let ENABLE_DUPLICATE_CHECK = "enableDuplicateCheck"
    private let IS_DUPLICATE_CHECK_ENABLED = "isDuplicateCheckEnabled"

    private let ENABLE_AUTO_ERASE = "enableAutoErase"
    private let IS_AUTO_ERASE_ENABLED = "isAutoEraseEnabled"

    private let ENABLE_SCAN_IF_CONNECTED = "enableScanIfConnected"
    private let IS_SCAN_IF_CONNECTED_ENABLED = "isScanIfConnectedEnabled"

    private let GET_AUTO_TRIGGER_REREAD_DELAY = "getAutoTriggerRereadDelay"
    private let SET_AUTO_TRIGGER_REREAD_DELAY = "setAutoTriggerRereadDelay"

    private let ENABLE_AUTO_TRIGGER = "enableAutoTrigger"
    private let IS_AUTO_TRIGGER_ENABLED = "isAutoTriggerEnabled"

    private let GET_KDC_FIRMWARE_VERSION = "getKDCFirmwareVersion"
    private let GET_KDC_FIRMWARE_BUILD_VERSION = "getKDCFirmwareBuildVersion"

//    // Unsupported
//    private let GET_INTERFACE_VERSION = "getInterfaceVersion"
//    private let GET_POWER_DELIVERY_VERSION = "getPowerDeliveryVersion"
    
    private let ENABLE_SCAN_KEY_EVENT = "EnableScanKeyEvent"
    private let IS_SCAN_KEY_EVENT_ENABLED = "IsScanKeyEventEnabled"

    /* PARAM */
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_TIMEOUT = "timeout"
    private let PARAM_NAME_VOLUME = "volume"
    private let PARAM_NAME_DELAY = "delay"
    private let PARAM_NAME_VERSION = "version"

    private let PARAM_NAME_SIZE = "size"
    private let PARAM_NAME_LEVEL = "level"
    private let PARAM_NAME_ONTIME = "onTime"
    private let PARAM_NAME_OFFTIME = "offTime"
    private let PARAM_NAME_REPEAT = "repeat"

    private enum Volume : Int {
        case None
        case Low
        case High
        
    }
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            ENABLE_BUTTON_LOCK,
            ENABLE_SCAN_BUTTON_LOCK,

            ERASE_MEMORY,
            ERASE_LAST_DATA,

            GET_MEMORY_LEFT,

            GET_SLEEP_TIMEOUT,
            SET_SLEEP_TIMEOUT,

            GET_SCAN_TIMEOUT,
            SET_SCAN_TIMEOUT,

            GET_BATTERY_LEVEL,
            GET_EXTENDED_BATTERY_LEVEL,

            SYNC_SYSTEM_TIME,
            RESET_SYSTEM_TIME,

            SET_FACTORY_DEFAULT,

            GET_BEEP_VOLUME,
            SET_BEEP_VOLUME,
            
            ENABLE_HIGH_BEEP_VOLUME,
            IS_HIGH_BEEP_VOLUME_ENABLED,

            ENABLE_BEEP_SOUND,
            IS_BEEP_SOUND_ENABLED,

            ENABLE_POWER_ON_BEEP,
            IS_POWER_ON_BEEP_ENABLED,

            ENABLE_BEEP_ON_SCAN,
            IS_BEEP_ON_SCAN_ENABLED,

            ENABLE_BEEP_ON_CONNECT,
            IS_BEEP_ON_CONNECT_ENABLED,

            SET_FAILURE_ALERT_BEEP,

            SET_SUCCESS_ALERT_BEEP,

            SET_CUSTOM_BEEP_TONE,

            ENABLE_MFI_MODE,
            IS_MFI_ENABLED,

            IS_MFI_AUTH_CHIP_INSTALLED,

            ENABLE_DUPLICATE_CHECK,
            IS_DUPLICATE_CHECK_ENABLED,

            ENABLE_AUTO_ERASE,
            IS_AUTO_ERASE_ENABLED,

            ENABLE_SCAN_IF_CONNECTED,
            IS_SCAN_IF_CONNECTED_ENABLED,

            GET_AUTO_TRIGGER_REREAD_DELAY,
            SET_AUTO_TRIGGER_REREAD_DELAY,

            ENABLE_AUTO_TRIGGER,
            IS_AUTO_TRIGGER_ENABLED,

            GET_KDC_FIRMWARE_VERSION,
            GET_KDC_FIRMWARE_BUILD_VERSION,

            ENABLE_SCAN_KEY_EVENT,
            IS_SCAN_KEY_EVENT_ENABLED,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case ENABLE_BUTTON_LOCK:
            enableButtonLock(call, result: result)
            
        case ENABLE_SCAN_BUTTON_LOCK:
            enableScanButtonLock(call, result: result)

        case ERASE_MEMORY:
            eraseMemory(call, result: result)

        case ERASE_LAST_DATA:
            eraseLastData(call, result: result)

        case GET_MEMORY_LEFT:
            getMemoryLeft(call, result: result)

        case GET_SLEEP_TIMEOUT:
            getSleepTimeout(call, result: result)

        case SET_SLEEP_TIMEOUT:
            setSleepTimeout(call, result: result)

        case GET_SCAN_TIMEOUT:
            getScanTimeout(call, result: result)

        case SET_SCAN_TIMEOUT:
            setScanTimeout(call, result: result)

        case GET_BATTERY_LEVEL:
            getBatteryLevel(call, result: result)

        case GET_EXTENDED_BATTERY_LEVEL:
            getExtendedBatteryLevel(call, result: result)

        case SYNC_SYSTEM_TIME:
            syncSystemTime(call, result: result)

        case RESET_SYSTEM_TIME:
            resetSystemTime(call, result: result)

        case SET_FACTORY_DEFAULT:
            setFactoryDefault(call, result: result)
            
        case GET_BEEP_VOLUME:
            getBeepVolume(call, result: result)
            
        case SET_BEEP_VOLUME:
            setBeepVolume(call, result: result)

        case ENABLE_HIGH_BEEP_VOLUME:
            enableHighBeepVolume(call, result: result)

        case IS_HIGH_BEEP_VOLUME_ENABLED:
            isHighBeepVolumeEnabled(call, result: result)

        case ENABLE_BEEP_SOUND:
            enableBeepSound(call, result: result)

        case IS_BEEP_SOUND_ENABLED:
            isBeepSoundEnabled(call, result: result)

        case ENABLE_POWER_ON_BEEP:
            enablePowerOnBeep(call, result: result)

        case IS_POWER_ON_BEEP_ENABLED:
            isPowerOnBeepEnabled(call, result: result)

        case ENABLE_BEEP_ON_SCAN:
            enableBeepOnScan(call, result: result)

        case IS_BEEP_ON_SCAN_ENABLED:
            isBeepOnScanEnabled(call, result: result)

        case ENABLE_BEEP_ON_CONNECT:
            enableBeepOnConnect(call, result: result)

        case IS_BEEP_ON_CONNECT_ENABLED:
            isBeepOnConnectEnabled(call, result: result)

        case SET_FAILURE_ALERT_BEEP:
            setFailureAlertBeep(call, result: result)

        case SET_SUCCESS_ALERT_BEEP:
            setSuccessAlertBeep(call, result: result)

        case SET_CUSTOM_BEEP_TONE:
            setCustomBeepTone(call, result: result)

        case ENABLE_MFI_MODE:
            enableMFiMode(call, result: result)

        case IS_MFI_ENABLED:
            isMFiEnabled(call, result: result)

        case IS_MFI_AUTH_CHIP_INSTALLED:
            isMFiAuthChipInstalled(call, result: result)

        case ENABLE_DUPLICATE_CHECK:
            enableDuplicateCheck(call, result: result)

        case IS_DUPLICATE_CHECK_ENABLED:
            isDuplicateCheckEnabled(call, result: result)

        case ENABLE_AUTO_ERASE:
            enableAutoErase(call, result: result)

        case IS_AUTO_ERASE_ENABLED:
            isAutoEraseEnabled(call, result: result)

        case ENABLE_SCAN_IF_CONNECTED:
            enableScanIfConnected(call, result: result)

        case IS_SCAN_IF_CONNECTED_ENABLED:
            isScanIfConnectedEnabled(call, result: result)

        case GET_AUTO_TRIGGER_REREAD_DELAY:
            getAutoTriggerRereadDelay(call, result: result)

        case SET_AUTO_TRIGGER_REREAD_DELAY:
            setAutoTriggerRereadDelay(call, result: result)

        case ENABLE_AUTO_TRIGGER:
            enableAutoTrigger(call, result: result)

        case IS_AUTO_TRIGGER_ENABLED:
            isAutoTriggerEnabled(call, result: result)

        case GET_KDC_FIRMWARE_VERSION:
            getKDCFirmwareVersion(call, result: result)

        case GET_KDC_FIRMWARE_BUILD_VERSION:
            getKDCFirmwareBuildVersion(call, result: result)

        case ENABLE_SCAN_KEY_EVENT:
            enableScanKeyEvent(call, result: result)

        case IS_SCAN_KEY_EVENT_ENABLED:
            isScanKeyEventEnabled(call, result: result)

        default:
            break
        }
        
        return true
    }

    private func enableButtonLock(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableButtonLock(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func enableScanButtonLock(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableScanButtonLock(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func eraseMemory(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.eraseMemory()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func eraseLastData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.eraseLastData()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getMemoryLeft(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let size = reader.getMemoryLeft()
        
        if size > -1 {
            result(size)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getSleepTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let timeout = reader.getSleepTimeout().rawValue
        
        if let _ = SleepTimeout(rawValue: timeout) {
            result(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setSleepTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_TIMEOUT] as? Int,
              let timeout = SleepTimeout(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setSleepTimeout(timeout)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getScanTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let timeout = reader.getScanTimeout().rawValue
        
        if let _ = ScanTimeout(rawValue: timeout) {
            result(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setScanTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_TIMEOUT] as? Int,
              let timeout = ScanTimeout(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setScanTimeout(timeout)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getBatteryLevel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let level = reader.getBatteryLevel()
        
        if level > -1 {
            result(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getExtendedBatteryLevel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let level = reader.getExtendedBatteryLevel()
        
        if level > -1 {
            result(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func syncSystemTime(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.syncSystemTime()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func resetSystemTime(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.resetSystemTime()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setFactoryDefault(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.setFactoryDefault()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getBeepVolume(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let isBeep = reader.isBeepSoundEnabled()
        
        switch isBeep {
        case .ENABLE:
            let isHighBeep = reader.isHighBeepVolumeEnabled()
            
            switch isHighBeep {
            case .ENABLE:
                result(Volume.High.rawValue)
            case .DISABLE:
                result(Volume.Low.rawValue)
            default:
                sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            }
            
        case.DISABLE:
            result(Volume.None.rawValue)
            
        default:
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
        }
    }

    private func setBeepVolume(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_VOLUME] as? Int,
              let volume = Volume(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        switch volume {
        case .None:
            reader.enableBeepSound(.DISABLE)
            
        case .Low:
            reader.enableBeepSound(.ENABLE)
            reader.enableHighBeepVolume(.DISABLE)
            
        case .High:
            reader.enableBeepSound(.ENABLE)
            reader.enableHighBeepVolume(.ENABLE)
        }
        
        result(true)
    }
    
    private func enableHighBeepVolume(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableHighBeepVolume(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }

    }
    
    private func isHighBeepVolumeEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isHighBeepVolumeEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableBeepSound(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBeepSound(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isBeepSoundEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isBeepSoundEnabled()
        result(enable == .ENABLE)
    }
    
    private func enablePowerOnBeep(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enablePower(onBeep: enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }

    }
    
    private func isPowerOnBeepEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isPowerOnBeepEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableBeepOnScan(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBeep(onScan: enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }

    }
    
    private func isBeepOnScanEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isBeepOnScanEnabled()
        result(enable == .ENABLE)
    }

    private func enableBeepOnConnect(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableBeep(onConnect: enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }

    }
    
    private func isBeepOnConnectEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isBeepOnConnectEnabled()
        result(enable == .ENABLE)
    }
    
    private func setFailureAlertBeep(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.setFailureAlertBeep()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setSuccessAlertBeep(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.setSuccessAlertBeep()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setCustomBeepTone(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let onTime = args[PARAM_NAME_ONTIME] as? Int,
              let offTime = args[PARAM_NAME_OFFTIME] as? Int,
              let rep = args[PARAM_NAME_REPEAT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        // duration, interval, repeat
        let bRet = reader.setCustomBeepTone(Int32(onTime), Int32(offTime), Int32(rep))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func enableMFiMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableMFiMode(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }

    }
    
    private func isMFiEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isMFiEnabled()
        result(enable == .ENABLE)
    }
    
    private func isMFiAuthChipInstalled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isMFiAuthChipInstalled()
        result(enable == .ENABLE)
    }
    
    private func enableDuplicateCheck(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableDuplicateCheck(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }

    }
    
    private func isDuplicateCheckEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isDuplicateCheckEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableAutoErase(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableAutoErase(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isAutoEraseEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isAutoEraseEnabled()
        result(enable == .ENABLE)
    }
    
    private func enableScanIfConnected(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableScanIfConnected(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }

    }
    
    private func isScanIfConnectedEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isScanIfConnectedEnabled()
        result(enable == .ENABLE)
    }
    
    private func getAutoTriggerRereadDelay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let delay = reader.getAutoTriggerRereadDelay().rawValue
        
        if let _ = AutoTriggerRereadDelay(rawValue: delay) {
            result(delay)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setAutoTriggerRereadDelay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_DELAY] as? Int,
              let delay = AutoTriggerRereadDelay(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setAutoTriggerRereadDelay(delay)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func enableAutoTrigger(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableAutoTrigger(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isAutoTriggerEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isAutoTriggerEnabled()
        result(enable == .ENABLE)
    }

    private func getKDCFirmwareVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let version = reader.getKDCFirmwareVersion(true) {
            result(version)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getKDCFirmwareBuildVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let version = reader.getKDCFirmwareBuild() {
            result(String(cString: version))
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
        
    private func enableScanKeyEvent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableScanKeyEvent(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isScanKeyEventEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isScanKeyEventEnabled()
        result(enable == .ENABLE)
    }

}
