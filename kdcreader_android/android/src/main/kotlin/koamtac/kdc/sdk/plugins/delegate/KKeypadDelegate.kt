package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KKeypadDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val ENABLE_ENTER_KEY_FUNCTION = "enableEnterKeyFunction"
        private const val IS_ENTER_KEY_FUNCTION_ENABLED = "isEnterKeyFunctionEnabled"

        private const val ENABLE_EXTEND_KEYPAD = "enableExtendKeypad"
        private const val IS_EXTEND_KEYPAD_ENABLED = "isExtendKeypadEnabled"

        private const val ENABLE_KEYPAD = "enableKeypad"
        private const val IS_KEYPAD_ENABLED = "isKeypadEnabled"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                ENABLE_ENTER_KEY_FUNCTION,
                IS_ENTER_KEY_FUNCTION_ENABLED,
                ENABLE_EXTEND_KEYPAD,
                IS_EXTEND_KEYPAD_ENABLED,
                ENABLE_KEYPAD,
                IS_KEYPAD_ENABLED,
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
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
            ENABLE_ENTER_KEY_FUNCTION -> enableEnterKeyFunction(reader, call, result)
            IS_ENTER_KEY_FUNCTION_ENABLED -> isEnterKeyFunctionEnabled(reader, call, result)

            ENABLE_EXTEND_KEYPAD -> enableExtendKeypad(reader, call, result)
            IS_EXTEND_KEYPAD_ENABLED -> isExtendKeypadEnabled(reader, call, result)

            ENABLE_KEYPAD -> enableKeypad(reader, call, result)
            IS_KEYPAD_ENABLED -> isKeypadEnabled(reader, call, result)
        }
        return true
    }

    private fun enableEnterKeyFunction(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableEnterKeyFunction(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isEnterKeyFunctionEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsEnterKeyFunctionEnabled()
        result.success(enable)
    }

    private fun enableExtendKeypad(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableExtendKeypad(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isExtendKeypadEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsExtendKeypadEnabled()
        result.success(enable)
    }

    private fun enableKeypad(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableKeypad(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isKeypadEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsKeypadEnabled()
        result.success(enable)
    }
}