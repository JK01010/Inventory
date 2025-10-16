package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KBluetoothDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val ENABLE_BLUETOOTH_AUTO_CONNECT = "enableBluetoothAutoConnect"
        private const val IS_AUTO_CONNECT_ENABLED = "isAutoConnectEnabled"

        private const val ENABLE_BLUETOOTH_AUTO_POWER_ON = "enableBluetoothAutoPowerOn"
        private const val IS_AUTO_POWER_ON_ENABLED = "isAutoPowerOnEnabled"

        private const val ENABLE_BLUETOOTH_AUTO_POWER_OFF = "enableBluetoothAutoPowerOff"
        private const val IS_BLUETOOTH_AUTO_POWER_OFF_ENABLED = "isBluetoothAutoPowerOffEnabled"

        private const val ENABLE_BLUETOOTH_BEEP_WARNING = "enableBluetoothBeepWarning"
        private const val IS_BLUETOOTH_BEEP_WARNING_ENABLED = "isBluetoothBeepWarningEnabled"

        private const val GET_DEVICE_PROFILE = "getDeviceProfile"
        private const val SET_DEVICE_PROFILE = "setDeviceProfile"

        private const val GET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT = "getBluetoothAutoPowerOffTimeout"
        private const val SET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT = "setBluetoothAutoPowerOffTimeout"

        private const val ENABLE_BLUETOOTH_POWER_OFF_MESSAGE = "enableBluetoothPowerOffMessage"
        private const val IS_POWER_OFF_MESSAGE_ENABLED = "isPowerOffMessageEnabled"

        private const val GET_BLUETOOTH_MAC_ADDRESS = "getBluetoothMACAddress"

        private const val GET_BLUETOOTH_AUTO_POWER_ON_DELAY = "getBluetoothAutoPowerOnDelay"
        private const val SET_BLUETOOTH_AUTO_POWER_ON_DELAY = "setBluetoothAutoPowerOnDelay"

        private const val GET_BLUETOOTH_FIRMWARE_VERSION = "getBluetoothFirmwareVersion"

        private const val ENABLE_BLUETOOTH_WAKEUP_NULL = "enableBluetoothWakeupNull"
        private const val IS_WAKEUP_NULLS_ENABLED = "isWakeupNullsEnabled"

        private const val ENABLE_BLUETOOTH_TOGGLE = "enableBluetoothToggle"
        private const val IS_BLUETOOTH_TOGGLE_ENABLED = "isBluetoothToggleEnabled"

        private const val ENABLE_BLUETOOTH_DISCONNECT_BUTTON = "enableBluetoothDisconnectButton"
        private const val IS_BLUETOOTH_DISCONNECT_BUTTON_ENABLED = "isBluetoothDisconnectButtonEnabled"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
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
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_PROFILE = "profile"
        private const val PARAM_NAME_TIMEOUT = "timeout"
        private const val PARAM_NAME_DELAY = "delay"
        private const val PARAM_NAME_ADDRESS = "address"
        private const val PARAM_NAME_VERSION = "version"
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
            ENABLE_BLUETOOTH_AUTO_CONNECT -> enableBluetoothAutoConnect(reader, call, result)
            IS_AUTO_CONNECT_ENABLED -> isAutoConnectEnabled(reader, call, result)

            ENABLE_BLUETOOTH_AUTO_POWER_ON -> enableBluetoothAutoPowerOn(reader, call, result)
            IS_AUTO_POWER_ON_ENABLED -> isAutoPowerOnEnabled(reader, call, result)

            ENABLE_BLUETOOTH_AUTO_POWER_OFF -> enableBluetoothAutoPowerOff(reader, call, result)
            IS_BLUETOOTH_AUTO_POWER_OFF_ENABLED -> isBluetoothAutoPowerOffEnabled(reader, call, result)

            ENABLE_BLUETOOTH_BEEP_WARNING -> enableBluetoothBeepWarning(reader, call, result)
            IS_BLUETOOTH_BEEP_WARNING_ENABLED -> isBluetoothBeepWarningEnabled(reader, call, result)

            GET_DEVICE_PROFILE -> getDeviceProfile(reader, call, result)
            SET_DEVICE_PROFILE -> setDeviceProfile(reader, call, result)

            GET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT -> getBluetoothAutoPowerOffTimeout(reader, call, result)
            SET_BLUETOOTH_AUTO_POWER_OFF_TIMEOUT -> setBluetoothAutoPowerOffTimeout(reader, call, result)

            ENABLE_BLUETOOTH_POWER_OFF_MESSAGE -> enableBluetoothPowerOffMessage(reader, call, result)
            IS_POWER_OFF_MESSAGE_ENABLED -> isPowerOffMessageEnabled(reader, call, result)

            GET_BLUETOOTH_MAC_ADDRESS -> getBluetoothMACAddress(reader, call, result)

            GET_BLUETOOTH_AUTO_POWER_ON_DELAY -> getBluetoothAutoPowerOnDelay(reader, call, result)
            SET_BLUETOOTH_AUTO_POWER_ON_DELAY -> setBluetoothAutoPowerOnDelay(reader, call, result)

            GET_BLUETOOTH_FIRMWARE_VERSION -> getBluetoothFirmwareVersion(reader, call, result)

            ENABLE_BLUETOOTH_WAKEUP_NULL -> enableBluetoothWakeupNull(reader, call, result)
            IS_WAKEUP_NULLS_ENABLED -> isWakeupNullsEnabled(reader, call, result)

            ENABLE_BLUETOOTH_TOGGLE -> enableBluetoothToggle(reader, call, result)
            IS_BLUETOOTH_TOGGLE_ENABLED -> isBluetoothToggleEnabled(reader, call, result)

            ENABLE_BLUETOOTH_DISCONNECT_BUTTON -> enableBluetoothDisconnectButton(reader, call, result)
            IS_BLUETOOTH_DISCONNECT_BUTTON_ENABLED -> isBluetoothDisconnectButtonEnabled(reader, call, result)
        }

        return true
    }

    private fun enableBluetoothAutoConnect(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBluetoothAutoConnect(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isAutoConnectEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsAutoConnectEnabled()
        result.success(enable)
    }

    private fun enableBluetoothAutoPowerOn(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBluetoothAutoPowerOn(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isAutoPowerOnEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsAutoPowerOnEnabled()
        result.success(enable)
    }

    private fun enableBluetoothAutoPowerOff(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBluetoothAutoPowerOff(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isBluetoothAutoPowerOffEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsBluetoothAutoPowerOffEnabled()
        result.success(enable)
    }

    private fun enableBluetoothBeepWarning(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBluetoothBeepWarning(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isBluetoothBeepWarningEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsBluetoothBeepWarningEnabled()
        result.success(enable)
    }

    private fun getDeviceProfile(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val profile = reader.GetDeviceProfile()

        profile?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setDeviceProfile(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val profile = call.argument<Int>(PARAM_NAME_PROFILE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val deviceProfile = profile?.let {
            for (p in KDCConstants.DeviceProfile.values()) {
                if (it == p.GetValue()) {
                    return@let p
                }
            }
            null
        }

        deviceProfile?.let {
            val bRet = reader.SetDeviceProfile(it)
            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getBluetoothAutoPowerOffTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val timeout = reader.GetBluetoothAutoPowerOffTimeout()

        timeout?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setBluetoothAutoPowerOffTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val offTimeout = timeout?.let {
            for (t in KDCConstants.BluetoothAutoPowerOffDelay.values()) {
                if (it == t.GetValue()) {
                    return@let t
                }
            }
            null
        }

        offTimeout?.let {
            val bRet = reader.SetBluetoothAutoPowerOffTimeout(offTimeout)
            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableBluetoothPowerOffMessage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBluetoothPowerOffMessage(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isPowerOffMessageEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsPowerOffMessageEnabled()
        result.success(enable)
    }

    private fun getBluetoothMACAddress(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val address = reader.GetBluetoothMACAddress()

        address?.let {
            result.success(address)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getBluetoothAutoPowerOnDelay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val delay = reader.GetBluetoothAutoPowerOnDelay()

        delay?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setBluetoothAutoPowerOnDelay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val delay = call.argument<Int>(PARAM_NAME_DELAY)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val onDelay = delay?.let {
            for (d in KDCConstants.BluetoothAutoPowerOnDelay.values()) {
                if (it == d.ordinal) {
                    return@let d
                }
            }
            null
        }

        onDelay?.let {
            val bRet = reader.SetBluetoothAutoPowerOnDelay(it)
            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getBluetoothFirmwareVersion(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val version = reader.GetBluetoothFirmwareVersion()

        version?.let {
            result.success(version)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableBluetoothWakeupNull(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBluetoothWakeupNull(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isWakeupNullsEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsWakeupNullsEnabled()
        result.success(enable)
    }

    private fun enableBluetoothToggle(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBluetoothToggle(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isBluetoothToggleEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsBluetoothToggleEnabled()
        result.success(enable)
    }

    private fun enableBluetoothDisconnectButton(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableBluetoothDisconnectButton(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isBluetoothDisconnectButtonEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsBluetoothDisconnectButtonEnabled()
        result.success(enable)
    }
}