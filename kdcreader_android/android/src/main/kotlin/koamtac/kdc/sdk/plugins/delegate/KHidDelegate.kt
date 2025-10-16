package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KHidDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val GET_HID_AUTO_LOCK_TIME = "getHIDAutoLockTime"
        private const val SET_HID_AUTO_LOCK_TIME = "setHIDAutoLockTime"

        private const val GET_HID_KEYBOARD = "getHIDKeyboard"
        private const val SET_HID_KEYBOARD = "setHIDKeyboard"

        private const val GET_HID_INITIAL_DELAY = "getHIDInitialDelay"
        private const val SET_HID_INITIAL_DELAY = "setHIDInitialDelay"

        private const val GET_HID_INTER_DELAY = "getHIDInterDelay"
        private const val SET_HID_INTER_DELAY = "setHIDInterDelay"

        private const val GET_HID_CONTROL_CHARACTER = "getHIDControlCharacter"
        private const val SET_HID_CONTROL_CHARACTER = "setHIDControlCharacter"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
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
            )
        )

        private const val PARAM_NAME_TIMEOUT = "timeout"
        private const val PARAM_NAME_KEYBOARD = "keyboard"
        private const val PARAM_NAME_DELAY = "delay"
        private const val PARAM_NAME_CHARACTER = "character"
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
            GET_HID_AUTO_LOCK_TIME -> getHIDAutoLockTime(reader, call, result)
            SET_HID_AUTO_LOCK_TIME -> setHIDAutoLockTime(reader, call, result)

            GET_HID_KEYBOARD -> getHIDKeyboard(reader, call, result)
            SET_HID_KEYBOARD -> setHIDKeyboard(reader, call, result)

            GET_HID_INITIAL_DELAY -> getHIDInitialDelay(reader, call, result)
            SET_HID_INITIAL_DELAY -> setHIDInitialDelay(reader, call, result)

            GET_HID_INTER_DELAY -> getHIDInterDelay(reader, call, result)
            SET_HID_INTER_DELAY -> setHIDInterDelay(reader, call, result)

            GET_HID_CONTROL_CHARACTER -> getHIDControlCharacter(reader, call, result)
            SET_HID_CONTROL_CHARACTER -> setHIDControlCharacter(reader, call, result)
        }
        return true
    }

    private fun getHIDAutoLockTime(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val timeout = reader.GetHIDAutoLockTime()

        timeout?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setHIDAutoLockTime(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val lockTime = timeout?.let {
            for (t in KDCConstants.HIDAutoLockTime.values()) {
                if (it == t.GetValue()) {
                    return@let t
                }
            }
            null
        }

        lockTime?.let {
            val bRet = reader.SetHIDAutoLockTime(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getHIDKeyboard(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val keyboard = reader.GetHIDKeyboard()

        keyboard?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setHIDKeyboard(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val keyboard = call.argument<Int>(PARAM_NAME_KEYBOARD) // keyboard layout

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val hidKeyboard = keyboard?.let {
            for (k in KDCConstants.HIDKeyboard.values()) {
                if (it == k.GetValue()) {
                    return@let k
                }
            }
            null
        }

        hidKeyboard?.let {
            val bRet = reader.SetHIDKeyboard(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getHIDInitialDelay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val delay = reader.GetHIDInitialDelay()

        delay?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setHIDInitialDelay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val delay = call.argument<Int>(PARAM_NAME_DELAY)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val initialDelay = delay?.let {
            for (d in KDCConstants.HIDInitialDelay.values()) {
                if (it == d.GetValue()) {
                    return@let d
                }
            }
            null
        }

        initialDelay?.let {
            val bRet = reader.SetHIDInitialDelay(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getHIDInterDelay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val delay = reader.GetHIDInterDelay()

        delay?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setHIDInterDelay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val delay = call.argument<Int>(PARAM_NAME_DELAY)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val interDelay = delay?.let {
            for (d in KDCConstants.HIDInterDelay.values()) {
                if (it == d.GetValue()) {
                    return@let d
                }
            }
            null
        }

        interDelay?.let {
            val bRet = reader.SetHIDInterDelay(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getHIDControlCharacter(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val character = reader.GetHIDControlCharacter()

        character?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setHIDControlCharacter(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val character = call.argument<Int>(PARAM_NAME_CHARACTER) // control character

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val ctrlCharacter = character?.let {
            for (c in KDCConstants.HIDControlCharacter.values()) {
                if (it == c.ordinal) {
                    return@let c
                }
            }
            null
        }

        ctrlCharacter?.let {
            val bRet = reader.SetHIDControlCharacter(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }
}