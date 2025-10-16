package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCMSRTrack
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KMsrDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val ENABLE_MSR_ERROR_BEEP = "enableMSRErrorBeep"
        private const val IS_MSR_ERROR_BEEP_ENABLED = "isMSRErrorBeepEnabled"

        private const val ENABLE_MSR_SENTINEL = "enableMSRSentinel"
        private const val IS_MSR_SENTINEL_ENABLED = "isMSRSentinelEnabled"

        private const val GET_MSR_CARD_TYPE = "getMSRCardType"
        private const val SET_MSR_CARD_TYPE = "setMSRCardType"

        private const val GET_MSR_DATA_TYPE = "getMSRDataType"
        private const val SET_MSR_DATA_TYPE = "setMSRDataType"

        private const val GET_MSR_DATA_ENCRYPTION = "getMSRDataEncryption"
        private const val SET_MSR_DATA_ENCRYPTION = "setMSRDataEncryption"

        private const val GET_MSR_TRACK_SEPARATOR = "getMSRTrackSeparator"
        private const val SET_MSR_TRACK_SEPARATOR = "setMSRTrackSeparator"

        private const val GET_MSR_TRACK_SELECTION = "getMSRTrackSelection"
        private const val SET_MSR_TRACK_SELECTION = "setMSRTrackSelection"

        private const val GET_PARTIAL_DATA_MSR_START_POSITION = "getPartialDataMSRStartPosition"
        private const val SET_PARTIAL_DATA_MSR_START_POSITION = "setPartialDataMSRStartPosition"

        private const val GET_PARTIAL_DATA_MSR_LENGTH = "getPartialDataMSRLength"
        private const val SET_PARTIAL_DATA_MSR_LENGTH = "setPartialDataMSRLength"

        private const val GET_PARTIAL_DATA_MSR_ACTION = "getPartialDataMSRAction"
        private const val SET_PARTIAL_DATA_MSR_ACTION = "setPartialDataMSRAction"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                ENABLE_MSR_ERROR_BEEP,
                IS_MSR_ERROR_BEEP_ENABLED,
                ENABLE_MSR_SENTINEL,
                IS_MSR_SENTINEL_ENABLED,
                GET_MSR_CARD_TYPE,
                SET_MSR_CARD_TYPE,
                GET_MSR_DATA_TYPE,
                SET_MSR_DATA_TYPE,
                GET_MSR_DATA_ENCRYPTION,
                SET_MSR_DATA_ENCRYPTION,
                GET_MSR_TRACK_SEPARATOR,
                SET_MSR_TRACK_SEPARATOR,
                GET_MSR_TRACK_SELECTION,
                SET_MSR_TRACK_SELECTION,
                GET_PARTIAL_DATA_MSR_START_POSITION,
                SET_PARTIAL_DATA_MSR_START_POSITION,
                GET_PARTIAL_DATA_MSR_LENGTH,
                SET_PARTIAL_DATA_MSR_LENGTH,
                GET_PARTIAL_DATA_MSR_ACTION,
                SET_PARTIAL_DATA_MSR_ACTION,
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_TYPE = "type"
        private const val PARAM_NAME_ENCRYPTION = "encryption"
        private const val PARAM_NAME_SEPARATOR = "separator"
        private const val PARAM_NAME_SELECTION = "selection"
        private const val PARAM_NAME_POSITION = "position"
        private const val PARAM_NAME_LENGTH = "length"
        private const val PARAM_NAME_ACTION = "action"
    }

    internal enum class TRACK(val value: Int) {
        TRACK1(1), TRACK2(2), TRACK3(4);

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
            ENABLE_MSR_ERROR_BEEP -> enableMSRErrorBeep(reader, call, result)
            IS_MSR_ERROR_BEEP_ENABLED -> isMSRErrorBeepEnabled(reader, call, result)

            ENABLE_MSR_SENTINEL -> enableMSRSentinel(reader, call, result)
            IS_MSR_SENTINEL_ENABLED -> isMSRSentinelEnabled(reader, call, result)

            GET_MSR_CARD_TYPE -> getMSRCardType(reader, call, result)
            SET_MSR_CARD_TYPE -> setMSRCardType(reader, call, result)

            GET_MSR_DATA_TYPE -> getMSRDataType(reader, call, result)
            SET_MSR_DATA_TYPE -> setMSRDataType(reader, call, result)

            GET_MSR_DATA_ENCRYPTION -> getMSRDataEncryption(reader, call, result)
            SET_MSR_DATA_ENCRYPTION -> setMSRDataEncryption(reader, call, result)

            GET_MSR_TRACK_SEPARATOR -> getMSRTrackSeparator(reader, call, result)
            SET_MSR_TRACK_SEPARATOR -> setMSRTrackSeparator(reader, call, result)

            GET_MSR_TRACK_SELECTION -> getMSRTrackSelection(reader, call, result)
            SET_MSR_TRACK_SELECTION -> setMSRTrackSelection(reader, call, result)

            GET_PARTIAL_DATA_MSR_START_POSITION -> getPartialDataMSRStartPosition(reader, call, result)
            SET_PARTIAL_DATA_MSR_START_POSITION -> setPartialDataMSRStartPosition(reader, call, result)

            GET_PARTIAL_DATA_MSR_LENGTH -> getPartialDataMSRLength(reader, call, result)
            SET_PARTIAL_DATA_MSR_LENGTH -> setPartialDataMSRLength(reader, call, result)

            GET_PARTIAL_DATA_MSR_ACTION -> getPartialDataMSRAction(reader, call, result)
            SET_PARTIAL_DATA_MSR_ACTION -> setPartialDataMSRAction(reader, call, result)
        }
        return true
    }

    private fun enableMSRErrorBeep(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableMSRErrorBeep(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isMSRErrorBeepEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsMSRErrorBeepEnabled()
        result.success(enable)
    }

    private fun enableMSRSentinel(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableMSRSentinel(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isMSRSentinelEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsMSRSentinelEnabled()
        result.success(enable)
    }

    private fun getMSRCardType(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val type = reader.GetMSRCardType()

        type?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setMSRCardType(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val type = call.argument<Int>(PARAM_NAME_TYPE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val cardType = type?.let {
            for (t in KDCConstants.MSRCardType.values()) {
                if (it == t.ordinal) {
                    return@let t
                }
            }
            null
        }

        cardType?.let {
            val bRet = reader.SetMSRCardType(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getMSRDataType(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val type = reader.GetMSRDataType()

        type?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setMSRDataType(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val type = call.argument<Int>(PARAM_NAME_TYPE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataType = type?.let {
            for (t in KDCConstants.MSRDataType.values()) {
                if (it == t.ordinal) {
                    return@let t
                }
            }
            null
        }

        dataType?.let {
            val bRet = reader.SetMSRDataType(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getMSRDataEncryption(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val encryption = reader.GetMSRDataEncryption()

        encryption?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setMSRDataEncryption(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val encryption = call.argument<Int>(PARAM_NAME_ENCRYPTION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataEncryption = encryption?.let {
            for (e in KDCConstants.MSRDataEncryption.values()) {
                if (it == e.ordinal) {
                    return@let e
                }
            }
            null
        }

        dataEncryption?.let {
            val bRet = reader.SetMSRDataEncryption(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getMSRTrackSeparator(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val separator = reader.GetMSRTrackSeparator()

        separator?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setMSRTrackSeparator(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val separator = call.argument<Int>(PARAM_NAME_SEPARATOR)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val trackSeparator = separator?.let {
            for (s in KDCConstants.MSRTrackSeparator.values()) {
                if (it == s.ordinal) {
                    return@let s
                }
            }
            null
        }

        trackSeparator?.let {
            val bRet = reader.SetMSRTrackSeparator(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getMSRTrackSelection(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val track = reader.GetMSRTrackSelection()

        track?.let {
            var selection = 0;

            if (track.IsTrack1Enabled()) {
                selection = selection or TRACK.TRACK1.value
            }

            if (track.IsTrack2Enabled()) {
                selection = selection or TRACK.TRACK2.value
            }

            if (track.IsTrack3Enabled()) {
                selection = selection or TRACK.TRACK3.value
            }

            result.success(selection)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setMSRTrackSelection(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val selection = call.argument<Int>(PARAM_NAME_SELECTION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val trackSelection = selection?.let {
            val track = KDCMSRTrack(null)

            if (selection and TRACK.TRACK1.value > 0) {
                track.Enable(KDCConstants.MSRTrack.TRACK1, true)
            }

            if (selection and TRACK.TRACK2.value > 0) {
                track.Enable(KDCConstants.MSRTrack.TRACK2, true)
            }

            if (selection and TRACK.TRACK3.value > 0) {
                track.Enable(KDCConstants.MSRTrack.TRACK3, true)
            }

            return@let track
        }

        trackSelection?.let {
            val bRet = reader.SetMSRTrackSelection(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getPartialDataMSRStartPosition(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val position = reader.GetPartialDataMSRStartPosition()

        if (position > -1) {
            result.success(position)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setPartialDataMSRStartPosition(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val position = call.argument<Int>(PARAM_NAME_POSITION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        position?.let {
            val bRet = reader.SetPartialDataMSRStartPosition(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getPartialDataMSRLength(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val length = reader.GetPartialDataMSRLength()

        if (length > -1) {
            result.success(length)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setPartialDataMSRLength(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val length = call.argument<Int>(PARAM_NAME_LENGTH)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        length?.let {
            val bRet = reader.SetPartialDataMSRLength(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getPartialDataMSRAction(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val action = reader.GetPartialDataMSRAction()

        action?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setPartialDataMSRAction(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val action = call.argument<Int>(PARAM_NAME_ACTION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val msrAction = action?.let {
            for (a in KDCConstants.PartialDataAction.values()) {
                if (it == a.ordinal) {
                    return@let a
                }
            }
            null
        }

        msrAction?.let {
            val bRet = reader.SetPartialDataMSRAction(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }
}