package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.UHFStatus
import koamtac.kdc.sdk.plugins.KConstants
import koamtac.kdc.sdk.plugins.KConverter
import java.lang.ref.WeakReference

class KUhfDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val IS_UHF_MODULE_ATTACHED = "isUHFModuleAttached"

        private const val IS_UHF_POWER_ENABLED = "isUHFPowerEnabled"
        private const val ENABLE_UHF_POWER = "enableUHFPower"

        private const val GET_UHF_POWER_LEVEL = "getUHFPowerLevel"
        private const val SET_UHF_POWER_LEVEL = "setUHFPowerLevel"

        private const val GET_UHF_READ_MODE = "getUHFReadMode"
        private const val SET_UHF_READ_MODE = "setUHFReadMode"

        private const val GET_UHF_READ_TAG_MODE = "getUHFReadTagMode"
        private const val SET_UHF_READ_TAG_MODE = "setUHFReadTagMode"

        private const val GET_UHF_DATA_TYPE = "getUHFDataType"
        private const val SET_UHF_DATA_TYPE = "setUHFDataType"

        private const val GET_UHF_DATA_FORMAT = "getUHFDataFormat"
        private const val SET_UHF_DATA_FORMAT = "setUHFDataFormat"

        private const val IS_UHF_DUPLICATE_CHECK_ENABLED = "isUHFDuplicateCheckEnabled"
        private const val ENABLE_UHF_DUPLICATE_CHECK = "enableUHFDuplicateCheck"

        private const val IS_UHF_BURST_MODE_ENABLED = "isUHFBurstModeEnabled"
        private const val ENABLE_UHF_BURST_MODE = "enableUHFBurstMode"

        private const val IS_UHF_KEY_EVENT_ENABLED = "isUHFKeyEventEnabled"
        private const val ENABLE_UHF_KEY_EVENT = "enableUHFKeyEvent"

        private const val CANCEL_UHF_READING = "cancelUHFReading"

        private const val GET_UHF_MODULE_TYPE = "getUHFModuleType"

        private const val GET_UHF_POWER_LEVEL_EX = "getUHFPowerLevelEx"
        private const val SET_UHF_POWER_LEVEL_EX = "setUHFPowerLevelEx"

        private const val GET_UHF_POWER_TIMEOUT = "getUHFPowerTimeout"
        private const val SET_UHF_POWER_TIMEOUT = "setUHFPowerTimeout"

        private const val GET_UHF_READING_TIMEOUT = "getUHFReadingTimeout"
        private const val SET_UHF_READING_TIMEOUT = "setUHFReadingTimeout"

        private const val GET_UHF_REGION = "getUHFRegion"

        private const val GET_UHF_TAG_LIST = "getUHFTagList"

        private const val SELECT_UHF_TAG = "selectUHFTag"

        private const val READ_UHF_TAG_MEMORY = "readUHFTagMemory"
        private const val WRITE_UHF_TAG_MEMORY = "writeUHFTagMemory"

        private const val SET_UHF_TAG_LOCK = "setUHFTagLock"
        private const val KILL_UHF_TAG = "killUHFTag"

        private const val SET_UHF_UNTRACEABLE = "setUHFUntraceable"

        private const val GET_UHF_SELECT_PARAMETER = "getUHFSelectParameter"
        private const val SET_UHF_SELECT_PARAMETER = "setUHFSelectParameter"

        private const val GET_UHF_QUERY_PARAMETER = "getUHFQueryParameter"
        private const val SET_UHF_QUERY_PARAMETER = "setUHFQueryParameter"

        private const val AUTHENTICATE_UHF_TAG = "authenticateUHFTag"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                IS_UHF_MODULE_ATTACHED,
                IS_UHF_POWER_ENABLED,
                ENABLE_UHF_POWER,
                GET_UHF_POWER_LEVEL,
                SET_UHF_POWER_LEVEL,
                GET_UHF_READ_MODE,
                SET_UHF_READ_MODE,
                GET_UHF_READ_TAG_MODE,
                SET_UHF_READ_TAG_MODE,
                GET_UHF_DATA_TYPE,
                SET_UHF_DATA_TYPE,
                GET_UHF_DATA_FORMAT,
                SET_UHF_DATA_FORMAT,
                IS_UHF_DUPLICATE_CHECK_ENABLED,
                ENABLE_UHF_DUPLICATE_CHECK,
                IS_UHF_BURST_MODE_ENABLED,
                ENABLE_UHF_BURST_MODE,
                IS_UHF_KEY_EVENT_ENABLED,
                ENABLE_UHF_KEY_EVENT,
                CANCEL_UHF_READING,
                GET_UHF_MODULE_TYPE,
                GET_UHF_POWER_LEVEL_EX,
                SET_UHF_POWER_LEVEL_EX,
                GET_UHF_POWER_TIMEOUT,
                SET_UHF_POWER_TIMEOUT,
                GET_UHF_READING_TIMEOUT,
                SET_UHF_READING_TIMEOUT,
                GET_UHF_REGION,
                GET_UHF_TAG_LIST,
                SELECT_UHF_TAG,
                READ_UHF_TAG_MEMORY,
                WRITE_UHF_TAG_MEMORY,
                SET_UHF_TAG_LOCK,
                KILL_UHF_TAG,
                SET_UHF_UNTRACEABLE,
                GET_UHF_SELECT_PARAMETER,
                SET_UHF_SELECT_PARAMETER,
                GET_UHF_QUERY_PARAMETER,
                SET_UHF_QUERY_PARAMETER,
                AUTHENTICATE_UHF_TAG,
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_LEVEL = "level"
        private const val PARAM_NAME_MODE = "mode"
        private const val PARAM_NAME_TYPE = "type"
        private const val PARAM_NAME_FORMAT = "format"
        private const val PARAM_NAME_TIMEOUT = "timeout"
        private const val PARAM_NAME_EPC = "epc"
        private const val PARAM_NAME_PASSWORD = "pwd"

        private const val PARAM_NAME_BANK = "bank"
        private const val PARAM_NAME_START = "start"
        private const val PARAM_NAME_LENGTH = "length"
        private const val PARAM_NAME_DATA = "data"
        private const val PARAM_NAME_MASK = "mask"

        private const val PARAM_NAME_MASK_DATA = "maskData"

        private const val PARAM_NAME_XPC = "xpc"
        private const val PARAM_NAME_TID = "tid"
        private const val PARAM_NAME_USER = "user"
        private const val PARAM_NAME_RANGE = "range"
        private const val PARAM_NAME_TARGET = "target"
        private const val PARAM_NAME_ACTION = "action"
        private const val PARAM_NAME_POINTER = "pointer"
        private const val PARAM_NAME_TRUNCATED = "truncated"
        private const val PARAM_NAME_DR = "dr"
        private const val PARAM_NAME_CYCLE = "cycle"
        private const val PARAM_NAME_TREXT = "tRext"
        private const val PARAM_NAME_SEL = "sel"
        private const val PARAM_NAME_SESSION = "session"
        private const val PARAM_NAME_SLOT_NUM = "slotNum"
        private const val PARAM_NAME_SEN_REP = "senRep"
        private const val PARAM_NAME_INC_REP_LEN = "incRepLen"
        private const val PARAM_NAME_CSI = "csi"
        private const val PARAM_NAME_MESSAGE = "message"
        private const val PARAM_NAME_ATTACH = "attached"
        private const val PARAM_NAME_REGION = "region"
        private const val PARAM_NAME_LIST = "list"
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
            IS_UHF_MODULE_ATTACHED -> isUHFModuleAttached(reader, call, result)

            IS_UHF_POWER_ENABLED -> isUHFPowerEnabled(reader, call, result)
            ENABLE_UHF_POWER -> enableUHFPower(reader, call, result)

            GET_UHF_POWER_LEVEL -> getUHFPowerLevel(reader, call, result)
            SET_UHF_POWER_LEVEL -> setUHFPowerLevel(reader, call, result)

            GET_UHF_READ_MODE -> getUHFReadMode(reader, call, result)
            SET_UHF_READ_MODE -> setUHFReadMode(reader, call, result)

            GET_UHF_READ_TAG_MODE -> getUHFReadTagMode(reader, call, result)
            SET_UHF_READ_TAG_MODE -> setUHFReadTagMode(reader, call, result)

            GET_UHF_DATA_TYPE -> getUHFDataType(reader, call, result)
            SET_UHF_DATA_TYPE -> setUHFDataType(reader, call, result)

            GET_UHF_DATA_FORMAT -> getUHFDataFormat(reader, call, result)
            SET_UHF_DATA_FORMAT -> setUHFDataFormat(reader, call, result)

            IS_UHF_DUPLICATE_CHECK_ENABLED -> isUHFDuplicateCheckEnabled(reader, call, result)
            ENABLE_UHF_DUPLICATE_CHECK -> enableUHFDuplicateCheck(reader, call, result)

            IS_UHF_BURST_MODE_ENABLED -> isUHFBurstModeEnabled(reader, call, result)
            ENABLE_UHF_BURST_MODE -> enableUHFBurstMode(reader, call, result)

            IS_UHF_KEY_EVENT_ENABLED -> isUHFKeyEventEnabled(reader, call, result)
            ENABLE_UHF_KEY_EVENT -> enableUHFKeyEvent(reader, call, result)

            CANCEL_UHF_READING -> cancelUHFReading(reader, call, result)

            GET_UHF_MODULE_TYPE -> getUHFModuleType(reader, call, result)

            GET_UHF_POWER_LEVEL_EX -> getUHFPowerLevelEx(reader, call, result)
            SET_UHF_POWER_LEVEL_EX -> setUHFPowerLevelEx(reader, call, result)

            GET_UHF_POWER_TIMEOUT -> getUHFPowerTimeout(reader, call, result)
            SET_UHF_POWER_TIMEOUT -> setUHFPowerTimeout(reader, call, result)

            GET_UHF_READING_TIMEOUT -> getUHFReadingTimeout(reader, call, result)
            SET_UHF_READING_TIMEOUT -> setUHFReadingTimeout(reader, call, result)

            GET_UHF_REGION -> getUHFRegion(reader, call, result)

            GET_UHF_TAG_LIST -> getUHFTagList(reader, call, result)

            SELECT_UHF_TAG -> selectUHFTag(reader, call, result)

            READ_UHF_TAG_MEMORY -> readUHFTagMemory(reader, call, result)
            WRITE_UHF_TAG_MEMORY -> writeUHFTagMemory(reader, call, result)

            SET_UHF_TAG_LOCK -> setUHFTagLock(reader, call, result)

            KILL_UHF_TAG -> killUHFTag(reader, call, result)

            SET_UHF_UNTRACEABLE -> setUHFUntraceable(reader, call, result)

            GET_UHF_SELECT_PARAMETER -> getUHFSelectParameter(reader, call, result)
            SET_UHF_SELECT_PARAMETER -> setUHFSelectParameter(reader, call, result)

            GET_UHF_QUERY_PARAMETER -> getUHFQueryParameter(reader, call, result)
            SET_UHF_QUERY_PARAMETER -> setUHFQueryParameter(reader, call, result)

            AUTHENTICATE_UHF_TAG -> authenticateUHFTag(reader, call, result)
        }
        return true
    }

    private fun isUHFModuleAttached(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val attached = reader.IsUHFModuleAttached()
        result.success(attached)
    }

    private fun isUHFPowerEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsUHFPowerEnabled()
        result.success(enable)
    }

    private fun enableUHFPower(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableUHFPower(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getUHFPowerLevel(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val level = reader.GetUHFPowerLevel()

        level?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setUHFPowerLevel(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val level = call.argument<Int>(PARAM_NAME_LEVEL)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val powerLevel = level?.let {
            for (p in KDCConstants.UHFPowerLevel.values()) {
                if (it == p.ordinal) {
                    return@let p
                }
            }
            null
        }

        powerLevel?.let {
            val bRet = reader.SetUHFPowerLevel(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getUHFReadMode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val mode = reader.GetUHFReadMode()

        mode?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setUHFReadMode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val mode = call.argument<Int>(PARAM_NAME_MODE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val readMode = mode?.let {
            for (m in KDCConstants.UHFReadMode.values()) {
                if (it == m.ordinal) {
                    return@let m
                }
            }
            null
        }

        readMode?.let {
            val bRet = reader.SetUHFReadMode(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getUHFReadTagMode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val mode = reader.GetUHFReadTagMode()

        mode?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setUHFReadTagMode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val mode = call.argument<Int>(PARAM_NAME_MODE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val readTagMode = mode?.let {
            for (m in KDCConstants.UHFReadTagMode.values()) {
                if (it == m.ordinal) {
                    return@let m
                }
            }
            null
        }

        readTagMode?.let {
            val bRet = reader.SetUHFReadTagMode(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getUHFDataType(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val type = reader.GetUHFDataType()

        type?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setUHFDataType(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val type = call.argument<Int>(PARAM_NAME_TYPE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataType = type?.let {
            for (t in KDCConstants.UHFDataType.values()) {
                if (it == t.ordinal) {
                    return@let t
                }
            }
            null
        }

        dataType?.let {
            val bRet = reader.SetUHFDataType(it)
            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getUHFDataFormat(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val format = reader.GetUHFDataFormat()

        format?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setUHFDataFormat(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val format = call.argument<Int>(PARAM_NAME_FORMAT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataFormat = format?.let {
            for (a in KDCConstants.UHFDataFormat.values()) {
                if (it == a.ordinal) {
                    return@let a
                }
            }
            null
        }

        dataFormat?.let {
            val bRet = reader.SetUHFDataFormat(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isUHFDuplicateCheckEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsUHFDuplicateCheckEnabled()
        result.success(enable)
    }

    private fun enableUHFDuplicateCheck(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableUHFDuplicateCheck(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun isUHFBurstModeEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsUHFBurstModeEnabled()
        result.success(enable)
    }

    private fun enableUHFBurstMode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableUHFBurstMode(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isUHFKeyEventEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsUHFKeyEventEnabled()
        result.success(enable)
    }

    private fun enableUHFKeyEvent(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableUHFKeyEvent(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

    }

    private fun cancelUHFReading(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        reader.CancelUHFReading()
        result.success(true)
    }

    private fun getUHFModuleType(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val type = reader.GetUHFModuleType()

        type?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getUHFPowerLevelEx(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val level = reader.GetUHFPowerLevelEx()

        if (level > -1) {
            result.success(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setUHFPowerLevelEx(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val level = call.argument<Int>(PARAM_NAME_LEVEL)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        level?.let {
            val bRet = reader.SetUHFPowerLevelEx(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getUHFPowerTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val timeout = reader.GetUHFPowerTimeout()

        if (timeout > -1) {
            result.success(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setUHFPowerTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        timeout?.let {
            val bRet = reader.SetUHFPowerTimeout(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getUHFReadingTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val timeout = reader.GetUHFReadingTimeout()

        if (timeout > -1) {
            result.success(timeout)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setUHFReadingTimeout(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        timeout?.let {
            val bRet = reader.SetUHFReadingTimeout(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getUHFRegion(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val region = reader.GetUHFRegion()

        region?.let {
            result.success(region.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getUHFTagList(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        timeout?.let {
            val status = UHFStatus().apply {
                SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
            }

            val list = reader.GetUHFTagList(it, status)

            if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
                val tagList = ArrayList<String>()

                for (b in list) {
                    b?.let {
                        tagList.add(String(b))
                    }
                }
                result.success(tagList)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun selectUHFTag(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val epc = call.argument<String>(PARAM_NAME_EPC)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        epc?.let {
            val status = UHFStatus().apply {
                SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
            }

            reader.SelectUHFTag(it.toByteArray(), status)

            if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun readUHFTagMemory(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val pwd = call.argument<String>(PARAM_NAME_PASSWORD)
        val bank = call.argument<Int>(PARAM_NAME_BANK)
        val start = call.argument<Int>(PARAM_NAME_START)
        val length = call.argument<Int>(PARAM_NAME_LENGTH)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (pwd == null || bank == null || start == null || length == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val memoryBank = bank.let {
            for (b in KDCConstants.UHFMemoryBank.values()) {
                if (it == b.ordinal) {
                    return@let b
                }
            }
            null
        }

        memoryBank?.let {
            val status = UHFStatus().apply {
                SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
            }

            val readData = reader.ReadUHFTagMemory(pwd.toByteArray(), memoryBank, start, length, status)

            if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
                result.success(String(readData))
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun writeUHFTagMemory(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val pwd = call.argument<String>(PARAM_NAME_PASSWORD)
        val bank = call.argument<Int>(PARAM_NAME_BANK)
        val start = call.argument<Int>(PARAM_NAME_START)
        val length = call.argument<Int>(PARAM_NAME_LENGTH)
        val data = call.argument<String>(PARAM_NAME_DATA)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (pwd == null || bank == null || start == null || length == null || data == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val memoryBank = bank.let {
            for (b in KDCConstants.UHFMemoryBank.values()) {
                if (it == b.ordinal) {
                    return@let b
                }
            }
            null
        }

        memoryBank?.let {
            val status = UHFStatus().apply {
                SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
            }

            reader.WriteUHFTagMemory(pwd.toByteArray(), memoryBank, start, length,
                data.toByteArray(), status)

            if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun setUHFTagLock(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val pwd = call.argument<String>(PARAM_NAME_PASSWORD)
        val mask = call.argument<Int>(PARAM_NAME_MASK)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (pwd == null || mask == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val status = UHFStatus().apply {
            SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
        }

        reader.SetUHFTagLock(pwd.toByteArray(), mask, status)

        if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun killUHFTag(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val pwd = call.argument<String>(PARAM_NAME_PASSWORD) // kill password

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (pwd == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val status = UHFStatus().apply {
            SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
        }

        reader.KillUHFTag(pwd.toByteArray(), status)

        if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun setUHFUntraceable(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val xpc = call.argument<Int>(PARAM_NAME_XPC)
        val epc = call.argument<Int>(PARAM_NAME_EPC)
        val tid = call.argument<Int>(PARAM_NAME_TID)
        val user = call.argument<Int>(PARAM_NAME_USER)
        val range = call.argument<Int>(PARAM_NAME_RANGE)
        val pwd = call.argument<String>(PARAM_NAME_PASSWORD)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (xpc == null || epc == null || tid == null ||
            user == null || range == null || pwd == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val status = UHFStatus().apply {
            SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
        }

        reader.SetUHFUntraceable(xpc, epc, tid, user, range, pwd.toByteArray(), status)

        if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun getUHFSelectParameter(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val status = UHFStatus().apply {
            SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
        }

        val uhfResult = reader.GetUHFSelectParameter(status)
        val parameter = uhfResult?.GetSelectParameter()

        if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS && parameter != null) {
            val parameterMap = KConverter.toMap(parameter)
            result.success(parameterMap)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun setUHFSelectParameter(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val target = call.argument<Int>(PARAM_NAME_TARGET)
        val action = call.argument<Int>(PARAM_NAME_ACTION)
        val bank = call.argument<Int>(PARAM_NAME_BANK)
        val pointer = call.argument<Int>(PARAM_NAME_POINTER)
        val length = call.argument<Int>(PARAM_NAME_LENGTH)
        val mask = call.argument<String>(PARAM_NAME_MASK_DATA)
        val isTruncated = call.argument<Boolean>(PARAM_NAME_TRUNCATED)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (target == null || action == null || bank == null || pointer == null ||
            length == null || mask == null || isTruncated == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val memoryBank = bank.let {
            for (b in KDCConstants.UHFMemoryBank.values()) {
                if (it == b.ordinal) {
                    return@let b
                }
            }
            null
        }


        memoryBank?.let {
            val status = UHFStatus().apply {
                SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
            }

            reader.SetUHFSelectParameter(target, action, memoryBank, pointer,
                length, mask.toByteArray(), isTruncated, status)

            if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        }
    }

    private fun getUHFQueryParameter(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val status = UHFStatus().apply {
            SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
        }

        val uhfResult = reader.GetUHFQueryParameter(status)
        val parameter = uhfResult?.GetQueryParameter()

        if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS && parameter != null) {
            val parameterMap = KConverter.toMap(parameter)
            result.success(parameterMap)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun setUHFQueryParameter(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val dr = call.argument<Int>(PARAM_NAME_DR)
        val cycle = call.argument<Int>(PARAM_NAME_CYCLE)
        val tRext = call.argument<Int>(PARAM_NAME_TREXT)
        val sel = call.argument<Int>(PARAM_NAME_SEL)
        val session = call.argument<Int>(PARAM_NAME_SESSION)
        val target = call.argument<Int>(PARAM_NAME_TARGET)
        val slotNum = call.argument<Int>(PARAM_NAME_SLOT_NUM)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (dr == null || cycle == null || tRext == null || sel == null ||
            session == null || target == null || slotNum == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val status = UHFStatus().apply {
            SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
        }

        reader.SetUHFQueryParameter(dr, cycle, tRext, sel, session, target, slotNum, status);

        if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun authenticateUHFTag(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val senRep = call.argument<Int>(PARAM_NAME_SEN_REP)
        val incRepLen = call.argument<Int>(PARAM_NAME_INC_REP_LEN)
        val csi = call.argument<Int>(PARAM_NAME_CSI)
        val length = call.argument<Int>(PARAM_NAME_LENGTH)
        val message = call.argument<String>(PARAM_NAME_MESSAGE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (senRep == null || incRepLen == null || csi == null ||
            length == null || message == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val status = UHFStatus().apply {
            SetUHFDataFormat(KDCConstants.UHFDataFormat.HEX_DECIMAL)
        }

        reader.AuthenticateUHFTag(senRep, incRepLen, csi, length, message.toByteArray(), status);

        if (status.GetErrorCode() == UHFStatus.UHF_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION, status.GetErrorCode())
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }
}