package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KNfcDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val IS_NFC_INSTALLED = "isNFCInstalled"

        private const val ENABLE_NFC_POWER = "enableNFCPower"
        private const val IS_NFC_POWER_ENABLED = "isNFCPowerEnabled"

        private const val SET_NFC_DATA_FORMAT = "setNFCDataFormat"
        private const val GET_NFC_DATA_FORMAT = "getNFCDataFormat"

        private const val ENABLE_NFC_UID_ONLY = "enableNFCUIDOnly"
        private const val IS_NFC_UID_ONLY_ENABLED = "isNFCUIDOnlyEnabled"

        private const val ENABLE_NFC_EXTENDED_FORMAT = "enableNFCExtendedFormat"
        private const val IS_NFC_EXTENDED_FORMAT_ENABLED = "isNFCExtendedFormatEnabled"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                IS_NFC_INSTALLED,
                ENABLE_NFC_POWER,
                IS_NFC_POWER_ENABLED,
                SET_NFC_DATA_FORMAT,
                GET_NFC_DATA_FORMAT,
                ENABLE_NFC_UID_ONLY,
                IS_NFC_UID_ONLY_ENABLED,
                ENABLE_NFC_EXTENDED_FORMAT,
                IS_NFC_EXTENDED_FORMAT_ENABLED,
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_FORMAT = "format"
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
            IS_NFC_INSTALLED -> isNFCInstalled(reader, call, result)

            ENABLE_NFC_POWER -> enableNFCPower(reader, call, result)
            IS_NFC_POWER_ENABLED -> isNFCPowerEnabled(reader, call, result)

            SET_NFC_DATA_FORMAT -> setNFCDataFormat(reader, call, result)
            GET_NFC_DATA_FORMAT -> getNFCDataFormat(reader, call, result)

            ENABLE_NFC_UID_ONLY -> enableNFCUIDOnly(reader, call, result)
            IS_NFC_UID_ONLY_ENABLED -> isNFCUIDOnlyEnabled(reader, call, result)

            ENABLE_NFC_EXTENDED_FORMAT -> enableNFCExtendedFormat(reader, call, result)
            IS_NFC_EXTENDED_FORMAT_ENABLED -> isNFCExtendedFormatEnabled(reader, call, result)
        }
        return true
    }

    private fun isNFCInstalled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val attached = reader.IsNFCInstalled()
        result.success(attached)
    }

    private fun enableNFCPower(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableNFCPower(it)
            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isNFCPowerEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsNFCPowerEnabled()
        result.success(enable)
    }

    private fun setNFCDataFormat(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val format = call.argument<Int>(PARAM_NAME_FORMAT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataFormat = format?.let {
            for (f in KDCConstants.NFCDataFormat.values()) {
                if (it == f.ordinal) {
                    return@let f
                }
            }
            null
        }

        dataFormat?.let {
            val bRet = reader.SetNFCDataFormat(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getNFCDataFormat(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val format = reader.GetNFCDataFormat()

        format?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun enableNFCUIDOnly(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableNFCUIDOnly(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isNFCUIDOnlyEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsNFCUIDOnlyEnabled()
        result.success(enable)
    }

    private fun enableNFCExtendedFormat(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableNFCExtendedFormat(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isNFCExtendedFormatEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsNFCExtendedFormatEnabled()
        result.success(enable)
    }
}