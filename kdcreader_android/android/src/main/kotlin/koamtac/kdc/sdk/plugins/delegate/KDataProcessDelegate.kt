package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCConstants.BarcodeOption
import koamtac.kdc.sdk.KDCConstants.Symbology
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import koamtac.kdc.sdk.plugins.KConverter
import java.lang.ref.WeakReference

class KDataProcessDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val GET_DATA_PREFIX = "getDataPrefix"
        private const val SET_DATA_PREFIX = "setDataPrefix"

        private const val GET_DATA_SUFFIX = "getDataSuffix"
        private const val SET_DATA_SUFFIX = "setDataSuffix"

        private const val GET_SYMBOLOGY = "getSymbology"
        private const val SET_SYMBOLOGY = "setSymbology"
        private const val ENABLE_ALL_SYMBOLOGY = "enableAllSymbology"
        private const val DISABLE_ALL_SYMBOLOGY = "disableAllSymbology"

        private const val GET_BARCODE_OPTION = "getBarcodeOption"
        private const val SET_BARCODE_OPTION = "setBarcodeOption"
        private const val ENABLE_ALL_OPTIONS = "enableAllOptions"
        private const val DISABLE_ALL_OPTIONS = "disableAllOptions"

        private const val GET_MINIMUM_BARCODE_LENGTH = "getMinimumBarcodeLength"
        private const val SET_MINIMUM_BARCODE_LENGTH = "setMinimumBarcodeLength"

        private const val GET_NUMBER_OF_STORED_BARCODE = "getNumberOfStoredBarcode"

        private const val GET_STORED_DATA_SINGLE = "getStoredDataSingle"

        private const val GET_DATA_FORMAT = "getDataFormat"
        private const val SET_DATA_FORMAT = "setDataFormat"

        private const val GET_DATA_PROCESS_MODE = "getDataProcessMode"
        private const val SET_DATA_PROCESS_MODE = "setDataProcessMode"

        private const val GET_SECURITY_LEVEL = "getSecurityLevel"
        private const val SET_SECURITY_LEVEL = "setSecurityLevel"

        private const val ENABLE_AGE_VERIFY = "enableAgeVerify"
        private const val IS_AGE_VERIFY_ENABLED = "isAgeVerifyEnabled"

        private const val GET_AIMID_SETTING = "getAIMIDSetting"
        private const val SET_AIMID_SETTING = "setAIMIDSetting"

        private const val GET_PARTIAL_DATA_START_POSITION = "getPartialDataStartPosition"
        private const val SET_PARTIAL_DATA_START_POSITION = "setPartialDataStartPosition"

        private const val GET_PARTIAL_DATA_LENGTH = "getPartialDataLength"
        private const val SET_PARTIAL_DATA_LENGTH = "setPartialDataLength"

        private const val GET_PARTIAL_DATA_ACTION = "getPartialDataAction"
        private const val SET_PARTIAL_DATA_ACTION = "setPartialDataAction"

        private const val START_SYNCHRONIZATION = "startSynchronization"
        private const val FINISH_SYNCHRONIZATION = "finishSynchronization"

        private const val GET_DATA_TERMINATOR = "getDataTerminator"
        private const val SET_DATA_TERMINATOR = "setDataTerminator"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                GET_DATA_PREFIX,
                SET_DATA_PREFIX,

                GET_DATA_SUFFIX,
                SET_DATA_SUFFIX,

                GET_SYMBOLOGY,
                SET_SYMBOLOGY,
                ENABLE_ALL_SYMBOLOGY,
                DISABLE_ALL_SYMBOLOGY,

                GET_BARCODE_OPTION,
                SET_BARCODE_OPTION,
                ENABLE_ALL_OPTIONS,
                DISABLE_ALL_OPTIONS,

                GET_MINIMUM_BARCODE_LENGTH,
                SET_MINIMUM_BARCODE_LENGTH,

                GET_NUMBER_OF_STORED_BARCODE,

                GET_STORED_DATA_SINGLE,

                GET_DATA_FORMAT,
                SET_DATA_FORMAT,

                GET_DATA_PROCESS_MODE,
                SET_DATA_PROCESS_MODE,

                GET_SECURITY_LEVEL,
                SET_SECURITY_LEVEL,

                ENABLE_AGE_VERIFY,
                IS_AGE_VERIFY_ENABLED,

                GET_AIMID_SETTING,
                SET_AIMID_SETTING,

                GET_PARTIAL_DATA_START_POSITION,
                SET_PARTIAL_DATA_START_POSITION,

                GET_PARTIAL_DATA_LENGTH,
                SET_PARTIAL_DATA_LENGTH,

                GET_PARTIAL_DATA_ACTION,
                SET_PARTIAL_DATA_ACTION,

                START_SYNCHRONIZATION,
                FINISH_SYNCHRONIZATION,

                GET_DATA_TERMINATOR,
                SET_DATA_TERMINATOR,
            )
        )

        private const val PARAM_NAME_PREFIX = "prefix"
        private const val PARAM_NAME_SUFFIX = "suffix"
        private const val PARAM_NAME_LENGTH = "length"
        private const val PARAM_NAME_SYMBOLS = "symbols"
        private const val PARAM_NAME_OPTIONS = "options"
        private const val PARAM_NAME_FORMAT = "format"
        private const val PARAM_NAME_MODE = "mode"
        private const val PARAM_NAME_LEVEL = "level"
        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_AIMID = "aimid"
        private const val PARAM_NAME_POSITION = "position"
        private const val PARAM_NAME_ACTION = "action"
        private const val PARAM_NAME_TERMINATOR = "terminator"
        private const val PARAM_NAME_COUNT = "count"
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
            GET_DATA_PREFIX -> getDataPrefix(reader, call, result)
            SET_DATA_PREFIX -> setDataPrefix(reader, call, result)

            GET_DATA_SUFFIX -> getDataSuffix(reader, call, result)
            SET_DATA_SUFFIX -> setDataSuffix(reader, call, result)

            GET_SYMBOLOGY -> getSymbology(reader, call, result)
            SET_SYMBOLOGY -> setSymbology(reader, call, result)
            ENABLE_ALL_SYMBOLOGY -> enableAllSymbology(reader, call, result)
            DISABLE_ALL_SYMBOLOGY -> disableAllSymbology(reader, call, result)

            GET_BARCODE_OPTION -> getBarcodeOption(reader, call, result)
            SET_BARCODE_OPTION -> setBarcodeOption(reader, call, result)
            ENABLE_ALL_OPTIONS -> enableAllOptions(reader, call, result)
            DISABLE_ALL_OPTIONS -> disableAllOptions(reader, call, result)

            GET_MINIMUM_BARCODE_LENGTH -> getMinimumBarcodeLength(reader, call, result)
            SET_MINIMUM_BARCODE_LENGTH -> setMinimumBarcodeLength(reader, call, result)

            GET_NUMBER_OF_STORED_BARCODE -> getNumberOfStoredBarcode(reader, call, result)

            GET_STORED_DATA_SINGLE -> getStoredDataSingle(reader, call, result)

            GET_DATA_FORMAT -> getDataFormat(reader, call, result)
            SET_DATA_FORMAT -> setDataFormat(reader, call, result)

            GET_DATA_PROCESS_MODE -> getDataProcessMode(reader, call, result)
            SET_DATA_PROCESS_MODE -> setDataProcessMode(reader, call, result)

            GET_SECURITY_LEVEL -> getSecurityLevel(reader, call, result)
            SET_SECURITY_LEVEL -> setSecurityLevel(reader, call, result)

            ENABLE_AGE_VERIFY -> enableAgeVerify(reader, call, result)
            IS_AGE_VERIFY_ENABLED -> isAgeVerifyEnabled(reader, call, result)

            GET_AIMID_SETTING -> getAIMIDSetting(reader, call, result)
            SET_AIMID_SETTING -> setAIMIDSetting(reader, call, result)

            GET_PARTIAL_DATA_START_POSITION -> getPartialDataStartPosition(reader, call, result)
            SET_PARTIAL_DATA_START_POSITION -> setPartialDataStartPosition(reader, call, result)

            GET_PARTIAL_DATA_LENGTH -> getPartialDataLength(reader, call, result)
            SET_PARTIAL_DATA_LENGTH -> setPartialDataLength(reader, call, result)

            GET_PARTIAL_DATA_ACTION -> getPartialDataAction(reader, call, result)
            SET_PARTIAL_DATA_ACTION -> setPartialDataAction(reader, call, result)

            START_SYNCHRONIZATION -> startSynchronization(reader, call, result)
            FINISH_SYNCHRONIZATION -> finishSynchronization(reader, call, result)

            GET_DATA_TERMINATOR -> getDataTerminator(reader, call, result)
            SET_DATA_TERMINATOR -> setDataTerminator(reader, call, result)
        }

        return true
    }

    private fun getDataPrefix(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val prefix = reader.GetDataPrefix()
        result.success(prefix ?: KConstants.EMPTY_STRING)
    }

    private fun setDataPrefix(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val prefix = call.argument<String>(PARAM_NAME_PREFIX)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetDataPrefix(prefix ?: KConstants.EMPTY_STRING)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getDataSuffix(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val suffix = reader.GetDataSuffix()
        result.success(suffix ?: KConstants.EMPTY_STRING)
    }

    private fun setDataSuffix(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val suffix = call.argument<String>(PARAM_NAME_SUFFIX)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetDataSuffix(suffix ?: KConstants.EMPTY_STRING)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getSymbology(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val symbol = reader.GetSymbology()

        if (symbol != null) {
            result.success(KConverter.toMap(symbol))
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setSymbology(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val map = call.argument<Map<String, Any?>>(PARAM_NAME_SYMBOLS);

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        map?.let {
            var bRet = false

            val deviceInfo = reader.GetKDCDeviceInfo()
            val symbol = reader.GetSymbology()

            if (deviceInfo != null && symbol != null) {
                it.forEach {(k, v) ->
                    val enable = v as? Boolean

                    enable?.run {
                        try {
                            val s = Symbology.valueOf(k)
                            symbol.Enable(s, this)
                        } catch (e: IllegalArgumentException) {
                            e.printStackTrace()
                            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
                            return
                        }
                    }
                }

                bRet = reader.SetSymbology(symbol, deviceInfo)
            }

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableAllSymbology(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.EnableAllSymbologies()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun disableAllSymbology(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.DisableAllSymbologies()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getBarcodeOption(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val option = reader.GetBarcodeOption()

        if (option != null) {
            result.success(KConverter.toMap(option))
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setBarcodeOption(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val map = call.argument<Map<String, Any?>>(PARAM_NAME_OPTIONS);

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        map?.let {
            var bRet = false

            val deviceInfo = reader.GetKDCDeviceInfo()
            val option = reader.GetBarcodeOption()

            if (deviceInfo != null && option != null) {
                it.forEach { (k, v) ->
                    val enable = v as? Boolean

                    enable?.run {
                        try {
                            val o = BarcodeOption.valueOf(k)
                            option.Enable(o, this)
                        } catch (e: IllegalArgumentException) {
                            e.printStackTrace()
                            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
                            return
                        }
                    }
                }

                bRet = reader.SetBarcodeOption(option, deviceInfo)
            }

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableAllOptions(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.EnableAllOptions()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun disableAllOptions(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.DisableAllOptions()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getMinimumBarcodeLength(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val length = reader.GetMinimumBarcodeLength()

        if (length > -1) {
            result.success(length)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setMinimumBarcodeLength(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val length = call.argument<Int>(PARAM_NAME_LENGTH)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        length?.let {
            val bRet = reader.SetMinimumBarcodeLength(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getNumberOfStoredBarcode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val size = reader.GetNumberOfStoredBarcode()

        if (size > -1) {
            result.success(size)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }


    private fun getStoredDataSingle(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        reader.GetStoredDataSingle();
        result.success(true)
    }

    private fun getDataFormat(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val format = reader.GetDataFormat()

        format?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setDataFormat(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val format = call.argument<Int>(PARAM_NAME_FORMAT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataFormat = format?.let {
            for (d in KDCConstants.DataFormat.values()) {
                if (it == d.ordinal) {
                    return@let d
                }
            }
            null
        }

        dataFormat?.let {
            val bRet = reader.SetDataFormat(it)
            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getDataProcessMode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val mode = reader.GetDataProcessMode()

        mode?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setDataProcessMode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val mode = call.argument<Int>(PARAM_NAME_MODE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataFormat = mode?.let {
            for (d in KDCConstants.DataFormat.values()) {
                if (it == d.ordinal) {
                    return@let d
                }
            }
            null
        }

        dataFormat?.let {
            val bRet = reader.SetDataFormat(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getSecurityLevel(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val level = reader.GetSecurityLevel()

        if (level > -1) {
            result.success(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setSecurityLevel(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val level = call.argument<Int>(PARAM_NAME_LEVEL)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        level?.let {
            val bRet = reader.SetSecurityLevel(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableAgeVerify(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableAgeVerify(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isAgeVerifyEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsAgeVerifyEnabled()
        result.success(enable)
    }

    private fun getAIMIDSetting(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val status = reader.GetAIMIDSetting()

        status?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setAIMIDSetting(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val status = call.argument<Int>(PARAM_NAME_AIMID)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val aimidStatus = status?.let {
            for (s in KDCConstants.AIMIDStatus.values()) {
                if (it == s.ordinal) {
                    return@let s
                }
            }
            null
        }

        aimidStatus?.let {
            val bRet = reader.SetAIMIDSetting(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getPartialDataStartPosition(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val position = reader.GetPartialDataStartPosition()

        if (position > -1) {
            result.success(position)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setPartialDataStartPosition(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val position = call.argument<Int>(PARAM_NAME_POSITION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        position?.let {
            val bRet = reader.SetPartialDataStartPosition(position)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getPartialDataLength(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val length = reader.GetPartialDataLength()

        if (length > -1) {
            result.success(length)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setPartialDataLength(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val length = call.argument<Int>(PARAM_NAME_LENGTH)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        length?.let {
            val bRet = reader.SetPartialDataLength(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getPartialDataAction(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val action = reader.GetPartialDataAction()

        action?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setPartialDataAction(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val action = call.argument<Int>(PARAM_NAME_ACTION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataAction = action?.let {
            for (a in KDCConstants.PartialDataAction.values()) {
                if (it == a.ordinal) {
                    return@let a
                }
            }
            null
        }

        dataAction?.let {
            val bRet = reader.SetPartialDataAction(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun startSynchronization(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.StartSynchronization()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun finishSynchronization(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.FinishSynchronization()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getDataTerminator(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val terminator = reader.GetDataTerminator()

        terminator?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setDataTerminator(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val terminator = call.argument<Int>(PARAM_NAME_TERMINATOR)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val dataTerminator = terminator?.let {
            for (a in KDCConstants.DataTerminator.values()) {
                if (it == a.ordinal) {
                    return@let a
                }
            }
            null
        }

        dataTerminator?.let {
            val bRet = reader.SetDataTerminator(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }
}