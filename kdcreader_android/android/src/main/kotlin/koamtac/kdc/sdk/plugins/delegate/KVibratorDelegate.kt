package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KVibratorDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val ENABLE_VIBRATOR = "enableVibrator"
        private const val IS_VIBRATOR_ENABLED = "isVibratorEnabled"

        private const val SET_CUSTOM_VIBRATION = "setCustomVibration"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                ENABLE_VIBRATOR,
                IS_VIBRATOR_ENABLED,
                SET_CUSTOM_VIBRATION,
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
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
            ENABLE_VIBRATOR -> enableVibrator(reader, call, result)
            IS_VIBRATOR_ENABLED -> isVibratorEnabled(reader, call, result)

            SET_CUSTOM_VIBRATION -> setCustomVibration(reader, call, result)
        }
        return true
    }

    private fun enableVibrator(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableVibrator(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isVibratorEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsVibratorEnabled()
        result.success(enable)
    }

    private fun setCustomVibration(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val onTime = call.argument<Int>(PARAM_NAME_ONTIME)
        val offTime = call.argument<Int>(PARAM_NAME_OFFTIME)
        val repeat = call.argument<Int>(PARAM_NAME_REPEAT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (onTime == null || offTime == null || repeat == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val bRet = reader.SetCustomVibration(onTime, offTime, repeat)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }
}