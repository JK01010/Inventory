package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KDisplayDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val ENABLE_DISPLAY_CONNECTION_STATUS = "enableDisplayConnectionStatus"
        private const val IS_DISPLAY_CONNECTION_STATUS_ENABLED = "isDisplayConnectionStatusEnabled"

        private const val ENABLE_MENU_BARCODE_STATE = "enableMenuBarcodeState"
        private const val IS_MENU_BARCODE_STATE_ENABLED = "isMenuBarcodeStateEnabled"

        private const val ENABLE_DISPLAY_SCROLL = "enableDisplayScroll"
        private const val IS_SCROLLING_ENABLED = "isScrollingEnabled"

        private const val SET_DISPLAY_POSITION = "setDisplayPosition"

        private const val CLEAR_DISPLAY = "clearDisplay"

        private const val SET_DISPLAY_MESSAGE_FONT_SIZE = "setDisplayMessageFontSize"
        private const val SET_DISPLAY_MESSAGE_DURATION = "setDisplayMessageDuration"
        private const val SET_MESSAGE_TEXT_ATTRIBUTE = "setMessageTextAttribute"

        private const val SET_DISPLAY_MESSAGE = "setDisplayMessage"
        private const val SET_DISPLAY_MESSAGE_AND_GET_USER_CONFIRM = "setDisplayMessageAndGetUserConfirm"

        private const val ENABLE_AUTO_MENU_EXIT = "enableAutoMenuExit"
        private const val IS_AUTO_MENU_EXIT_ENABLED = "isAutoMenuExitEnabled"

        private const val SET_LANGUAGE = "setLanguage"
        private const val GET_LANGUAGE = "getLanguage"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                ENABLE_DISPLAY_CONNECTION_STATUS,
                IS_DISPLAY_CONNECTION_STATUS_ENABLED,
                ENABLE_MENU_BARCODE_STATE,
                IS_MENU_BARCODE_STATE_ENABLED,
                ENABLE_DISPLAY_SCROLL,
                IS_SCROLLING_ENABLED,
                SET_DISPLAY_POSITION,
                CLEAR_DISPLAY,
                SET_DISPLAY_MESSAGE_FONT_SIZE,
                SET_DISPLAY_MESSAGE_DURATION,
                SET_MESSAGE_TEXT_ATTRIBUTE,
                SET_DISPLAY_MESSAGE,
                SET_DISPLAY_MESSAGE_AND_GET_USER_CONFIRM,
                ENABLE_AUTO_MENU_EXIT,
                IS_AUTO_MENU_EXIT_ENABLED,
                SET_LANGUAGE,
                GET_LANGUAGE,
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_SIZE = "size"
        private const val PARAM_NAME_DURATION = "duration"
        private const val PARAM_NAME_ATTRIBUTE = "attribute"
        private const val PARAM_NAME_MESSAGE = "message"
        private const val PARAM_NAME_LANGUAGE = "language"
        private const val PARAM_NAME_ROW = "row"
        private const val PARAM_NAME_COLUMN = "column"
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
            ENABLE_DISPLAY_CONNECTION_STATUS -> enableDisplayConnectionStatus(reader, call, result)
            IS_DISPLAY_CONNECTION_STATUS_ENABLED -> isDisplayConnectionStatusEnabled(reader, call, result)

            ENABLE_MENU_BARCODE_STATE -> enableMenuBarcodeState(reader, call, result)
            IS_MENU_BARCODE_STATE_ENABLED -> isMenuBarcodeStateEnabled(reader, call, result)

            ENABLE_DISPLAY_SCROLL -> enableDisplayScroll(reader, call, result)
            IS_SCROLLING_ENABLED -> isScrollingEnabled(reader, call, result)

            SET_DISPLAY_POSITION -> setDisplayPosition(reader, call, result)
            CLEAR_DISPLAY -> clearDisplay(reader, call, result)
            SET_DISPLAY_MESSAGE_FONT_SIZE -> setDisplayMessageFontSize(reader, call, result)
            SET_DISPLAY_MESSAGE_DURATION -> setDisplayMessageDuration(reader, call, result)
            SET_MESSAGE_TEXT_ATTRIBUTE -> setMessageTextAttribute(reader, call, result)

            SET_DISPLAY_MESSAGE -> setDisplayMessage(reader, call, result)
            SET_DISPLAY_MESSAGE_AND_GET_USER_CONFIRM -> setDisplayMessageAndGetUserConfirm(reader, call, result)

            ENABLE_AUTO_MENU_EXIT -> enableAutoMenuExit(reader, call, result)
            IS_AUTO_MENU_EXIT_ENABLED -> isAutoMenuExitEnabled(reader, call, result)

            SET_LANGUAGE -> setLanguage(reader, call, result)
            GET_LANGUAGE -> getLanguage(reader, call, result)
        }
        return true
    }

    private fun enableDisplayConnectionStatus(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableDisplayConnectionStatus(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isDisplayConnectionStatusEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsDisplayConnectionStatusEnabled()
        result.success(enable)
    }

    private fun enableMenuBarcodeState(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableMenuBarcodeState(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isMenuBarcodeStateEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsMenuBarcodeStateEnabled()
        result.success(enable)
    }

    private fun enableDisplayScroll(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableDisplayScroll(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isScrollingEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsScrollingEnabled()
        result.success(enable)
    }

    private fun setDisplayPosition(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val row = call.argument<Int>(PARAM_NAME_ROW)
        val column = call.argument<Int>(PARAM_NAME_COLUMN)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (row == null || column == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val bRet = reader.SetDisplayPosition(row, column)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun clearDisplay(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.ClearDisplay()

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setDisplayMessageFontSize(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val size = call.argument<Int>(PARAM_NAME_SIZE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val fontSize = size?.let {
            for (f in KDCConstants.FontSize.values()) {
                if (it == f.ordinal) {
                    return@let f
                }
            }
            null
        }

        fontSize?.let {
            val bRet = reader.SetDisplayMessageFontSize(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun setDisplayMessageDuration(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val duration = call.argument<Int>(PARAM_NAME_DURATION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        duration?.let {
            val bRet = reader.SetDisplayMessageDuration(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun setMessageTextAttribute(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val attr = call.argument<Int>(PARAM_NAME_ATTRIBUTE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val textAttr = attr?.let {
            for (a in KDCConstants.MessageTextAttribute.values()) {
                if (it == a.ordinal) {
                    return@let a
                }
            }
            null
        }

        textAttr?.let {
            val bRet = reader.SetMessageTextAttribute(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun setDisplayMessage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val message = call.argument<String>(PARAM_NAME_MESSAGE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetDisplayMessage(message ?: KConstants.EMPTY_STRING)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setDisplayMessageAndGetUserConfirm(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val message = call.argument<String>(PARAM_NAME_MESSAGE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val confirm = reader.SetDisplayMessageAndGetUserConfirmation(
            message ?: KConstants.EMPTY_STRING)
       result.success(confirm)
    }

    private fun enableAutoMenuExit(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableAutoMenuExit(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isAutoMenuExitEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsAutoMenuExitEnabled()
        result.success(enable)
    }

    private fun setLanguage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val lang = call.argument<Int>(PARAM_NAME_LANGUAGE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val language = lang?.let {
            for (l in KDCConstants.Language.values()) {
                if (it == l.GetValue()) {
                    return@let l
                }
            }
            null
        }

        language?.let {
            val bRet = reader.SetLanguage(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getLanguage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val language = reader.GetLanguage()

        language?.let {
            result.success(it.GetValue())
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }
}