package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KSystemDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val ENABLE_BUTTON_LOCK = "enableButtonLock"
        private const val ENABLE_SCAN_BUTTON_LOCK = "enableScanButtonLock"

        private const val ERASE_MEMORY = "eraseMemory"
        private const val ERASE_LAST_DATA = "eraseLastData"

        private const val GET_MEMORY_LEFT = "getMemoryLeft"

        private const val GET_SLEEP_TIMEOUT = "getSleepTimeout"
        private const val SET_SLEEP_TIMEOUT = "setSleepTimeout"

        private const val GET_SCAN_TIMEOUT = "getScanTimeout"
        private const val SET_SCAN_TIMEOUT = "setScanTimeout"

        private const val GET_BATTERY_LEVEL = "getBatteryLevel"
        private const val GET_EXTENDED_BATTERY_LEVEL = "getExtendedBatteryLevel"

        private const val SYNC_SYSTEM_TIME = "syncSystemTime"
        private const val RESET_SYSTEM_TIME = "resetSystemTime"

        private const val SET_FACTORY_DEFAULT = "setFactoryDefault"

        private const val GET_BEEP_VOLUME = "getBeepVolume"
        private const val SET_BEEP_VOLUME = "setBeepVolume"

        private const val ENABLE_HIGH_BEEP_VOLUME = "enableHighBeepVolume"
        private const val IS_HIGH_BEEP_VOLUME_ENABLED = "isHighBeepVolumeEnabled"

        private const val ENABLE_BEEP_SOUND = "enableBeepSound"
        private const val IS_BEEP_SOUND_ENABLED = "isBeepSoundEnabled"

        private const val ENABLE_POWER_ON_BEEP = "enablePowerOnBeep"
        private const val IS_POWER_ON_BEEP_ENABLED = "isPowerOnBeepEnabled"

        private const val ENABLE_BEEP_ON_SCAN = "enableBeepOnScan"
        private const val IS_BEEP_ON_SCAN_ENABLED = "isBeepOnScanEnabled"

        private const val ENABLE_BEEP_ON_CONNECT = "enableBeepOnConnect"
        private const val IS_BEEP_ON_CONNECT_ENABLED = "isBeepOnConnectEnabled"

        private const val SET_FAILURE_ALERT_BEEP = "setFailureAlertBeep"

        private const val SET_SUCCESS_ALERT_BEEP = "setSuccessAlertBeep"

        private const val SET_CUSTOM_BEEP_TONE = "setCustomBeepTone"

        private const val ENABLE_MFI_MODE = "enableMFiMode"
        private const val IS_MFI_ENABLED = "isMFiEnabled"

        private const val IS_MFI_AUTH_CHIP_INSTALLED = "isMFiAuthChipInstalled"

        private const val ENABLE_DUPLICATE_CHECK = "enableDuplicateCheck"
        private const val IS_DUPLICATE_CHECK_ENABLED = "isDuplicateCheckEnabled"

        private const val ENABLE_AUTO_ERASE = "enableAutoErase"
        private const val IS_AUTO_ERASE_ENABLED = "isAutoEraseEnabled"

        private const val ENABLE_SCAN_IF_CONNECTED = "enableScanIfConnected"
        private const val IS_SCAN_IF_CONNECTED_ENABLED = "isScanIfConnectedEnabled"

        private const val GET_AUTO_TRIGGER_REREAD_DELAY = "getAutoTriggerRereadDelay"
        private const val SET_AUTO_TRIGGER_REREAD_DELAY = "setAutoTriggerRereadDelay"

        private const val ENABLE_AUTO_TRIGGER = "enableAutoTrigger"
        private const val IS_AUTO_TRIGGER_ENABLED = "isAutoTriggerEnabled"

        private const val GET_KDC_FIRMWARE_VERSION = "getKDCFirmwareVersion"
        private const val GET_KDC_FIRMWARE_BUILD_VERSION = "getKDCFirmwareBuildVersion"

        private const val GET_INTERFACE_VERSION = "getInterfaceVersion"
        private const val GET_POWER_DELIVERY_VERSION = "getPowerDeliveryVersion"

        private const val ENABLE_SCAN_KEY_EVENT = "EnableScanKeyEvent"
        private const val IS_SCAN_KEY_EVENT_ENABLED = "IsScanKeyEventEnabled"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
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

                GET_INTERFACE_VERSION,
                GET_POWER_DELIVERY_VERSION,

                ENABLE_SCAN_KEY_EVENT,
                IS_SCAN_KEY_EVENT_ENABLED,
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_TIMEOUT = "timeout"
        private const val PARAM_NAME_VOLUME = "volume"
        private const val PARAM_NAME_DELAY = "delay"
        private const val PARAM_NAME_VERSION = "version"

        private const val PARAM_NAME_SIZE = "size"
        private const val PARAM_NAME_LEVEL = "level"
        private const val PARAM_NAME_ONTIME = "onTime"
        private const val PARAM_NAME_OFFTIME = "offTime"
        private const val PARAM_NAME_REPEAT = "repeat"
    }

    init {
        wrReader = WeakReference(reader)
    }

    override fun isSupported(action: String): Boolean {
        return SUPPORTED_ACTIONS.contains(action)
    }

    override fun run(context: Context, call: MethodCall, result: MethodChannel.Result): Boolean {
        val reader = wrReader.get();

        if (reader == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return true
        }

        when (call.method) {
            ENABLE_BUTTON_LOCK -> enableButtonLock(reader, call, result)
            ENABLE_SCAN_BUTTON_LOCK -> enableScanButtonLock(reader, call, result)

            ERASE_MEMORY -> eraseMemory(reader, call, result)
            ERASE_LAST_DATA -> eraseLastData(reader, call, result)

            GET_MEMORY_LEFT -> getMemoryLeft(reader, call, result)

            GET_SLEEP_TIMEOUT -> getSleepTimeout(reader, call, result)
            SET_SLEEP_TIMEOUT -> setSleepTimeout(reader, call, result)

            GET_SCAN_TIMEOUT -> getScanTimeout(reader, call, result)
            SET_SCAN_TIMEOUT -> setScanTimeout(reader, call, result)

            GET_BATTERY_LEVEL -> getBatteryLevel(reader, call, result)
            GET_EXTENDED_BATTERY_LEVEL -> getExtendedBatteryLevel(reader, call, result)

            SYNC_SYSTEM_TIME -> syncSystemTime(reader, call, result)
            RESET_SYSTEM_TIME -> resetSystemTime(reader, call, result)

            SET_FACTORY_DEFAULT -> setFactoryDefault(reader, call, result)

            GET_BEEP_VOLUME -> getBeepVolume(reader, call, result)
            SET_BEEP_VOLUME -> setBeepVolume(reader, call, result)

            ENABLE_HIGH_BEEP_VOLUME -> enableHighBeepVolume(reader, call, result)
            IS_HIGH_BEEP_VOLUME_ENABLED -> isHighBeepVolumeEnabled(reader, call, result)

            ENABLE_BEEP_SOUND -> enableBeepSound(reader, call, result)
            IS_BEEP_SOUND_ENABLED -> isBeepSoundEnabled(reader, call, result)

            ENABLE_POWER_ON_BEEP -> enablePowerOnBeep(reader, call, result)
            IS_POWER_ON_BEEP_ENABLED -> isPowerOnBeepEnabled(reader, call, result)

            ENABLE_BEEP_ON_SCAN -> enableBeepOnScan(reader, call, result)
            IS_BEEP_ON_SCAN_ENABLED -> isBeepOnScanEnabled(reader, call, result)

            ENABLE_BEEP_ON_CONNECT -> enableBeepOnConnect(reader, call, result)
            IS_BEEP_ON_CONNECT_ENABLED -> isBeepOnConnectEnabled(reader, call, result)

            SET_FAILURE_ALERT_BEEP -> setFailureAlertBeep(reader, call, result)
            SET_SUCCESS_ALERT_BEEP -> setSuccessAlertBeep(reader, call, result)

            SET_CUSTOM_BEEP_TONE -> setCustomBeepTone(reader, call, result)

            ENABLE_MFI_MODE -> enableMFiMode(reader, call, result)
            IS_MFI_ENABLED -> isMFiEnabled(reader, call, result)

            IS_MFI_AUTH_CHIP_INSTALLED -> isMFiAuthChipInstalled(reader, call, result)

            ENABLE_DUPLICATE_CHECK -> enableDuplicateCheck(reader, call, result)
            IS_DUPLICATE_CHECK_ENABLED -> isDuplicateCheckEnabled(reader, call, result)

            ENABLE_AUTO_ERASE -> enableAutoErase(reader, call, result)
            IS_AUTO_ERASE_ENABLED -> isAutoEraseEnabled(reader, call, result)

            ENABLE_SCAN_IF_CONNECTED -> enableScanIfConnected(reader, call, result)
            IS_SCAN_IF_CONNECTED_ENABLED -> isScanIfConnectedEnabled(reader, call, result)

            GET_AUTO_TRIGGER_REREAD_DELAY -> getAutoTriggerRereadDelay(reader, call, result)
            SET_AUTO_TRIGGER_REREAD_DELAY -> setAutoTriggerRereadDelay(reader, call, result)

            ENABLE_AUTO_TRIGGER -> enableAutoTrigger(reader, call, result)
            IS_AUTO_TRIGGER_ENABLED -> isAutoTriggerEnabled(reader, call, result)

            GET_KDC_FIRMWARE_VERSION -> getKDCFirmwareVersion(reader, call, result)
            GET_KDC_FIRMWARE_BUILD_VERSION -> getKDCFirmwareBuildVersion(reader, call, result)

            GET_INTERFACE_VERSION -> getInterfaceVersion(reader, call, result)
            GET_POWER_DELIVERY_VERSION -> getPowerDeliveryVersion(reader, call, result)

            ENABLE_SCAN_KEY_EVENT -> enableScanKeyEvent(reader, call, result)
            IS_SCAN_KEY_EVENT_ENABLED -> isScanKeyEventEnabled(reader, call, result)
        }

        return true
    }

    private fun enableButtonLock(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableButtonLock(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableScanButtonLock(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableScanButtonLock(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun eraseMemory(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.EraseMemory()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun eraseLastData(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.EraseLastData()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getMemoryLeft(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val size = reader.GetMemoryLeft()

        if (size > -1) {
            result.success(size)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getSleepTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val timeout = reader.GetSleepTimeout()

        timeout?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setSleepTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val sleepTimeout = timeout?.let {
            for (t in KDCConstants.SleepTimeout.values()) {
                if (it == t.GetValue()) {
                    return@let t
                }
            }
            null
        }

        sleepTimeout?.let {
            val bRet = reader.SetSleepTimeout(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getScanTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val timeout = reader.GetScanTimeout()

        if (timeout > -1) {
            result.success(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setScanTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        timeout?.let {
            val bRet = reader.SetScanTimeout(timeout)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getBatteryLevel(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val level = reader.GetBatteryLevel()

        if (level > -1) {
            result.success(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getExtendedBatteryLevel(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val level = reader.GetExtendedBatteryLevel()

        if (level > -1) {
            result.success(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun syncSystemTime(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SyncSystemTime()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun resetSystemTime(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.ResetSystemTime()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setFactoryDefault(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetFactoryDefault()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getBeepVolume(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val volume = reader.GetBeepVolume()

        volume?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setBeepVolume(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val volume = call.argument<Int>(PARAM_NAME_VOLUME)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val beepVolume = volume?.let {
            for (v in KDCConstants.Volume.values()) {
                if (it == v.ordinal) {
                    return@let v
                }
            }
            null
        }

        beepVolume?.let {
            reader.SetBeepVolume(beepVolume)
            result.success(true)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableHighBeepVolume(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableHighBeepVolume(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isHighBeepVolumeEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsHighBeepVolumeEnabled()
        result.success(enable)
    }

    private fun enableBeepSound(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBeepSound(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isBeepSoundEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsBeepSoundEnabled()
        result.success(enable)
    }

    private fun enablePowerOnBeep(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnablePowerOnBeep(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isPowerOnBeepEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsPowerOnBeepEnabled()
        result.success(enable)
    }

    private fun enableBeepOnScan(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBeepOnScan(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isBeepOnScanEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsBeepOnScanEnabled()
        result.success(enable)
    }

    private fun enableBeepOnConnect(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBeepOnConnect(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isBeepOnConnectEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsBeepOnConnectEnabled()
        result.success(enable)
    }

    private fun setFailureAlertBeep(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetFailureAlertBeep()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setSuccessAlertBeep(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetSuccessAlertBeep()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setCustomBeepTone(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val onTime = call.argument<Int>(PARAM_NAME_ONTIME) // duration
        val offTime = call.argument<Int>(PARAM_NAME_OFFTIME) // interval
        val repeat = call.argument<Int>(PARAM_NAME_REPEAT) // duration

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (onTime == null || offTime == null || repeat == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val bRet = reader.SetCustomBeepTone(onTime, offTime, repeat)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun enableMFiMode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableMFiMode(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isMFiEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsMFiEnabled()
        result.success(enable)
    }

    private fun isMFiAuthChipInstalled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsMFiAuthChipInstalled()
        result.success(enable)
    }

    private fun enableDuplicateCheck(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableDuplicateCheck(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isDuplicateCheckEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsDuplicateCheckEnabled()
        result.success(enable)
    }

    private fun enableAutoErase(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableAutoErase(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isAutoEraseEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsAutoEraseEnabled()
        result.success(enable)
    }

    private fun enableScanIfConnected(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableScanIfConnected(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isScanIfConnectedEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsScanIfConnectedEnabled()
        result.success(enable)
    }

    private fun getAutoTriggerRereadDelay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val delay = reader.GetAutoTriggerRereadDelay()

        delay?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setAutoTriggerRereadDelay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val delay = call.argument<Int>(PARAM_NAME_DELAY)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val readDelay = delay?.let {
            for (d in KDCConstants.RereadDelay.values()) {
                if (it == d.ordinal) {
                    return@let d
                }
            }
            null
        }

        readDelay?.let {
            val bRet = reader.SetAutoTriggerRereadDelay(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableAutoTrigger(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableAutoTrigger(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isAutoTriggerEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsAutoTriggerEnabled()
        result.success(enable)
    }

    private fun getKDCFirmwareVersion(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val version = reader.GetKDCFirmwareVersion(true)

        version?.let {
            result.success(it)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getKDCFirmwareBuildVersion(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val version = reader.GetKDCFirmwareBuild()

        version?.let {
            result.success(version)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getInterfaceVersion(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val version = reader.GetInterfaceVersion()

        version?.let {
            result.success(version)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getPowerDeliveryVersion(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val version = reader.GetPowerDeliveryVersion()

        version?.let {
            result.success(version)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun enableScanKeyEvent(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableScanKeyEvent(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isScanKeyEventEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsScanKeyEventEnabled()
        result.success(enable)
    }
}