package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KMsrIcDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val IS_MSR_MODULE_ATTACHED = "isMSRICModuleAttached"
        private const val SEND_MSRIC_DATA = "sendMSRICData"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                IS_MSR_MODULE_ATTACHED,
                SEND_MSRIC_DATA,
            )
        )

        private const val PARAM_NAME_ATTACH = "attached"
        private const val PARAM_NAME_MESSAGE = "message"
        private const val PARAM_NAME_RESPONSE = "resp"
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
            IS_MSR_MODULE_ATTACHED -> isMSRICModuleAttached(reader, call, result)

            SEND_MSRIC_DATA -> sendMSRICData(reader, call, result)
        }
        return true
    }

    private fun isMSRICModuleAttached(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val attached = reader.IsMSRICModuleAttached()
        result.success(attached)
    }

    private fun sendMSRICData(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val message = call.argument<String>(PARAM_NAME_MESSAGE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        message?.let {
            val response = reader.SendMSRICData(it)

            response?.let {
                result.success(it)
            } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }
}