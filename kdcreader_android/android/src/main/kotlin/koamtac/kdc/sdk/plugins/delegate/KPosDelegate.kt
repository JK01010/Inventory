package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.KPOSConstants
import koamtac.kdc.sdk.KPOSConstants.KPOSAlign
import koamtac.kdc.sdk.KPOSConstants.KPOSLocale
import koamtac.kdc.sdk.KPOSEMVTagList
import koamtac.kdc.sdk.KPOSResult
import koamtac.kdc.sdk.plugins.KConstants
import koamtac.kdc.sdk.plugins.KConverter
import java.lang.ref.WeakReference
import java.util.Objects.isNull

class KPosDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        /* KDC500 Barcode/NFC Methods */
        private const val SOFTWARE_TRIGGER_POS = "softwareTriggerPos"
        private const val ENABLE_NFC_POS = "enableNFCPos"
        private const val DISABLE_NFC_POS = "disableNFCPos"

        /* KDC500 MS/IC Transaction Methods */
        private const val ENABLE_MSR_POS = "enableMSRPos"
        private const val DISABLE_MSR_POS = "disableMSRPos"
        private const val ENABLE_CARD_READER_POS = "enableCardReaderPos"
        private const val DISABLE_CARD_READER_POS = "disableCardReaderPos"
        private const val READ_CARD_POS = "readCardPos"
        private const val CANCEL_READ_CARD_POS = "cancelReadCardPos"
        private const val SELECT_EMV_APPLICATION_POS = "selectEMVApplicationPos"
        private const val INITIATE_EMV_TRANSACTION_POS = "initiateEMVTransactionPos"
        private const val SELECT_APPLICATION_AND_INITIATE_EMV_TRANSACTION_POS =
            "selectApplicationAndInitiateEMVTransactionPos"
        private const val REPLY_EMV_TRANSACTION_POS = "replyEMVTransactionPos"
        private const val ENTER_PIN_POS = "enterPINPos"
        private const val CANCEL_ENTER_PIN_POS = "cancelEnterPINPos"

        /* KDC500 Configuration Methods */
        private const val GET_DEVICE_STATUS_POS = "getDeviceStatusPos"
        private const val SET_BEEP_SOUND_POS = "setBeepSoundPos"
        private const val GET_BEEP_SOUND_POS = "getBeepSoundPos"
        private const val SET_KEYPAD_MENU_ENTRY_POS = "setKeypadMenuEntryPos"
        private const val SYNC_DATE_TIME_POS = "syncDateTimePos"
        private const val GET_DATE_TIME_POS = "getDateTimePos"
        private const val ENABLE_BATTERY_ALARM_POS = "enableBatteryAlarmPos"
        private const val DISABLE_BATTERY_ALARM_POS = "disableBatteryAlarmPos"

        /* KDC500 Other Methods */
        private const val READ_DATA_POS = "readDataPos"
        private const val CANCEL_READ_DATA_POS = "cancelReadDataPos"
        private const val FIND_MY_KDC_POS = "findMyKDCPos"
        private const val SET_DISPLAY_MESSAGE_POS = "setDisplayMessagePos"
        private const val CLEAR_DISPLAY_POS = "clearDisplayPos"
        private const val ENABLE_KEYPAD_POS = "enableKeypadPos"
        private const val ENABLE_KEYPAD_EVENT_ONLY_POS = "enableKeypadEventOnlyPos"
        private const val DISABLE_KEYPAD_POS = "disableKeypadPos"
        private const val READ_EMV_CL_CARD_POS = "readEmvCLCardPos"
        private const val STOP_EMV_CL_TRANSACTION_POS = "stopEmvCLTransactionPos"
        private const val GET_SUPPORTED_LOCALES_POS = "getSupportedLocalesPos"
        private const val SET_DISPLAY_MESSAGE_WITH_LOCALE_POS = "setDisplayMessageWithLocalePos"
        private const val SET_DISPLAY_MESSAGE_ID_AND_READ_KEYPAD_POS = "setDisplayMessageIdAndReadKeypadPos"
        private const val SET_DISPLAY_MESSAGE_AND_READ_KEYPAD_POS = "setDisplayMessageAndReadKeypadPos"
        private const val SET_DISPLAY_MESSAGE_AND_SELECT_ITEM_POS = "setDisplayMessageAndSelectItemPos"
        private const val CLEAR_DISPLAY_AND_CANCEL_KEYPAD_POS = "clearDisplayAndCancelKeypadPos"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                SOFTWARE_TRIGGER_POS,
                ENABLE_NFC_POS,
                DISABLE_NFC_POS,
                ENABLE_MSR_POS,
                DISABLE_MSR_POS,
                ENABLE_CARD_READER_POS,
                DISABLE_CARD_READER_POS,
                READ_CARD_POS,
                CANCEL_READ_CARD_POS,
                SELECT_EMV_APPLICATION_POS,
                INITIATE_EMV_TRANSACTION_POS,
                SELECT_APPLICATION_AND_INITIATE_EMV_TRANSACTION_POS,
                REPLY_EMV_TRANSACTION_POS,
                ENTER_PIN_POS,
                CANCEL_ENTER_PIN_POS,
                GET_DEVICE_STATUS_POS,
                SET_BEEP_SOUND_POS,
                GET_BEEP_SOUND_POS,
                SET_KEYPAD_MENU_ENTRY_POS,
                SYNC_DATE_TIME_POS,
                GET_DATE_TIME_POS,
                ENABLE_BATTERY_ALARM_POS,
                DISABLE_BATTERY_ALARM_POS,
                READ_DATA_POS,
                CANCEL_READ_DATA_POS,
                FIND_MY_KDC_POS,
                SET_DISPLAY_MESSAGE_POS,
                CLEAR_DISPLAY_POS,
                ENABLE_KEYPAD_POS,
                ENABLE_KEYPAD_EVENT_ONLY_POS,
                DISABLE_KEYPAD_POS,
                READ_EMV_CL_CARD_POS,
                STOP_EMV_CL_TRANSACTION_POS,
                GET_SUPPORTED_LOCALES_POS,
                SET_DISPLAY_MESSAGE_WITH_LOCALE_POS,
                SET_DISPLAY_MESSAGE_ID_AND_READ_KEYPAD_POS,
                SET_DISPLAY_MESSAGE_AND_READ_KEYPAD_POS,
                SET_DISPLAY_MESSAGE_AND_SELECT_ITEM_POS,
                CLEAR_DISPLAY_AND_CANCEL_KEYPAD_POS,
            )
        )

        private const val PARAM_NAME_TARGET = "target"
        private const val PARAM_NAME_AID = "aid"
        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_COUNT = "count"
        private const val PARAM_NAME_CLEAR = "clear"
        private const val PARAM_NAME_TIMEOUT = "timeout"
        private const val PARAM_NAME_PIN_BLOCK_FORMAT = "pinBlockFormat"
        private const val PARAM_NAME_MAX_DIGIT = "maxDigit"
        private const val PARAM_NAME_TRANS_TYPE = "transType"
        private const val PARAM_NAME_AMOUNT = "amount"
        private const val PARAM_NAME_OTHER_AMOUNT = "otherAmount"
        private const val PARAM_NAME_OPERATION = "operation"
        private const val PARAM_NAME_PAN = "pan"
        private const val PARAM_NAME_TLV = "tlv"

        private const val PARAM_NAME_KEY_VOLUME = "keyVolume"
        private const val PARAM_NAME_BEEP_VOLUME = "beepVolume"
        private const val PARAM_NAME_BEEP_SOUND = "beepSound"
        private const val PARAM_NAME_BEEP_POWER_ON = "beepPowerOn"
        private const val PARAM_NAME_BEEP_BARCODE = "beepBarcode"
        private const val PARAM_NAME_BEEP_CONNECTION = "beepConnection"
        private const val PARAM_NAME_INTERVAL = "interval"
        private const val PARAM_NAME_LEVEL = "level"
        private const val PARAM_NAME_TITLE_ID = "titleId"
        private const val PARAM_NAME_MASK = "mask"
        private const val PARAM_NAME_LINE1 = "line1"
        private const val PARAM_NAME_LINE2 = "line2"
        private const val PARAM_NAME_LINE3 = "line3"
        private const val PARAM_NAME_LINE4 = "line4"
        private const val PARAM_NAME_LINE = "line"
        private const val PARAM_NAME_ONLINE = "online"
        private const val PARAM_NAME_LOCALE = "locale"
        private const val PARAM_NAME_KEYPAD_TYPE = "keypadType"
        private const val PARAM_NAME_INPUT_LINE = "inputLine"
        private const val PARAM_NAME_INPUT_ALIGN = "inputAlign"
        private const val PARAM_NAME_FIRST_ITEM_LINE = "firstItemLine"
        private const val PARAM_NAME_ITEMS = "items"
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
            SOFTWARE_TRIGGER_POS -> softwareTriggerPos(reader, call, result)

            ENABLE_NFC_POS -> enableNFCPos(reader, call, result)
            DISABLE_NFC_POS -> disableNFCPos(reader, call, result)

            ENABLE_MSR_POS -> enableMSRPos(reader, call, result)
            DISABLE_MSR_POS -> disableMSRPos(reader, call, result)

            ENABLE_CARD_READER_POS -> enableCardReaderPos(reader, call, result)
            DISABLE_CARD_READER_POS -> disableCardReaderPos(reader, call, result)

            READ_CARD_POS -> readCardPos(reader, call, result)
            CANCEL_READ_CARD_POS -> cancelReadCardPos(reader, call, result)

            SELECT_EMV_APPLICATION_POS -> selectEmvApplicationPos(reader, call, result)
            INITIATE_EMV_TRANSACTION_POS -> initiateEmvTransactionPos(reader, call, result)
            SELECT_APPLICATION_AND_INITIATE_EMV_TRANSACTION_POS -> selectApplicationAndInitiateEmvTransactionPos(reader, call, result)
            REPLY_EMV_TRANSACTION_POS -> replyEmvTransactionPos(reader, call, result)

            ENTER_PIN_POS -> enterPinPos(reader, call, result)
            CANCEL_ENTER_PIN_POS -> cancelEnterPinPos(reader, call, result)

            GET_DEVICE_STATUS_POS -> getDeviceStatusPos(reader, call, result)

            SET_BEEP_SOUND_POS -> setBeepSoundPos(reader, call, result)
            GET_BEEP_SOUND_POS -> getBeepSoundPos(reader, call, result)

            SET_KEYPAD_MENU_ENTRY_POS -> setKeypadMenuEntryPos(reader, call, result)

            SYNC_DATE_TIME_POS -> syncDateTimePos(reader, call, result)
            GET_DATE_TIME_POS -> getDateTimePos(reader, call, result)

            ENABLE_BATTERY_ALARM_POS -> enableBatteryAlarmPos(reader, call, result)
            DISABLE_BATTERY_ALARM_POS -> disableBatteryAlarmPos(reader, call, result)

            READ_DATA_POS -> readDataPos(reader, call, result)
            CANCEL_READ_DATA_POS -> cancelReadDataPos(reader, call, result)

            FIND_MY_KDC_POS -> findMyKDCPos(reader, call, result)

            SET_DISPLAY_MESSAGE_POS -> setDisplayMessagePos(reader, call, result)
            CLEAR_DISPLAY_POS -> clearDisplayPos(reader, call, result)

            ENABLE_KEYPAD_POS -> enableKeypadPos(reader, call, result)
            ENABLE_KEYPAD_EVENT_ONLY_POS -> enableKeypadEventOnlyPos(reader, call, result)
            DISABLE_KEYPAD_POS -> disableKeypadPos(reader, call, result)

            READ_EMV_CL_CARD_POS -> readEmvCLCardPos(reader, call, result)
            STOP_EMV_CL_TRANSACTION_POS -> stopEmvCLTransactionPos(reader, call, result)

            GET_SUPPORTED_LOCALES_POS -> getSupportedLocales(reader, call, result)

            SET_DISPLAY_MESSAGE_WITH_LOCALE_POS -> setDisplayMessageWithLocalePos(reader, call, result)
            SET_DISPLAY_MESSAGE_ID_AND_READ_KEYPAD_POS -> setDisplayMessageIdAndReadKeypadPos(reader, call, result)
            SET_DISPLAY_MESSAGE_AND_READ_KEYPAD_POS -> setDisplayMessageAndReadKeypadPos(reader, call, result)
            SET_DISPLAY_MESSAGE_AND_SELECT_ITEM_POS -> setDisplayMessageAndSelectItemPos(reader, call, result)
            CLEAR_DISPLAY_AND_CANCEL_KEYPAD_POS -> clearDisplayAndCancelKeypadPos(reader, call, result)
        }
        return true
    }

    private fun softwareTriggerPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.SoftwareTrigger_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun enableNFCPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.EnableNFC_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun disableNFCPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.DisableNFC_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun enableMSRPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.EnableMSR_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun disableMSRPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.DisableMSR_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun enableCardReaderPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val target = call.argument<Int>(PARAM_NAME_TARGET)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        target?.let {
            val retCode = reader.EnableCardReader_POS(it.toShort())

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun disableCardReaderPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val target = call.argument<Int>(PARAM_NAME_TARGET)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        target?.let {
            val retCode = reader.DisableCardReader_POS(it.toShort())

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun readCardPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val target = call.argument<Int>(PARAM_NAME_TARGET)
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (target == null || timeout == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.ReadCard_POS(target.toShort(), timeout.toShort())

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun cancelReadCardPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val target = call.argument<Int>(PARAM_NAME_TARGET)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        target?.let {
            val retCode = reader.CancelReadCard_POS(it.toShort())

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun selectEmvApplicationPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val aid = call.argument<Int>(PARAM_NAME_AID)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        aid?.let {
            val retCode = reader.SelectEMVApplication_POS(it.toShort())

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun initiateEmvTransactionPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val pinBlockFormat = call.argument<Int>(PARAM_NAME_PIN_BLOCK_FORMAT)
        val maxDigit = call.argument<Int>(PARAM_NAME_MAX_DIGIT)
        val transType = call.argument<Int>(PARAM_NAME_TRANS_TYPE)
        val amount = call.argument<Int>(PARAM_NAME_AMOUNT)
        val otherAmount = call.argument<Int>(PARAM_NAME_OTHER_AMOUNT)
        val operation = call.argument<Int>(PARAM_NAME_OPERATION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (pinBlockFormat == null || maxDigit == null || transType == null ||
            amount == null || otherAmount == null || operation == null
        ) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.InitiateEMVTransaction_POS(
            pinBlockFormat.toShort(), maxDigit.toShort(),
            transType.toShort(), amount,
            otherAmount, operation.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun selectApplicationAndInitiateEmvTransactionPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val pinBlockFormat = call.argument<Int>(PARAM_NAME_PIN_BLOCK_FORMAT)
        val maxDigit = call.argument<Int>(PARAM_NAME_MAX_DIGIT)
        val aid = call.argument<Int>(PARAM_NAME_AID)
        val transType = call.argument<Int>(PARAM_NAME_TRANS_TYPE)
        val amount = call.argument<Int>(PARAM_NAME_AMOUNT)
        val otherAmount = call.argument<Int>(PARAM_NAME_OTHER_AMOUNT)
        val additionalOperation = call.argument<Int>(PARAM_NAME_OPERATION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (pinBlockFormat == null || maxDigit == null || aid == null ||
            transType == null || amount == null || otherAmount == null ||
            additionalOperation == null
        ) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.SelectApplicationAndInitiateEMVTransaction_POS(
            pinBlockFormat.toShort(), maxDigit.toShort(),
            aid.toShort(), transType.toShort(),
            amount, otherAmount,
            additionalOperation.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun replyEmvTransactionPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val tlv = call.argument<ByteArray>(PARAM_NAME_TLV)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        tlv?.let {
            val emvTagList = KPOSEMVTagList(it, it.size.toShort())
            val retCode = reader.ReplyEMVTransaction_POS(emvTagList)

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }

        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enterPinPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val pan = call.argument<String>(PARAM_NAME_PAN)
        val pinBlockFormat = call.argument<Int>(PARAM_NAME_PIN_BLOCK_FORMAT)
        val maxDigit = call.argument<Int>(PARAM_NAME_MAX_DIGIT)
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (pan == null || pinBlockFormat == null || maxDigit == null || timeout == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.EnterPIN_POS(
            pan, pinBlockFormat.toShort(),
            maxDigit.toShort(), timeout.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun cancelEnterPinPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.CancelEnterPIN_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun getDeviceStatusPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val kposResult = reader.GetDeviceStatus_POS();

        kposResult?.let {
            val retCode = it.GetResultCode()
            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(
                    KConverter.toMap(it, KConverter.COMMAND_GET_DEVICE_STATUS_POS)
                )
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setBeepSoundPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val keyToneVolume = call.argument<Int>(PARAM_NAME_KEY_VOLUME)
        val beepVolume = call.argument<Int>(PARAM_NAME_BEEP_VOLUME)
        val beepSoundFlag = call.argument<Boolean>(PARAM_NAME_BEEP_SOUND)
        val enableBeepPowerOn = call.argument<Boolean>(PARAM_NAME_BEEP_POWER_ON)
        val enableBeepBarcode = call.argument<Boolean>(PARAM_NAME_BEEP_BARCODE)
        val enableBeepConnection = call.argument<Boolean>(PARAM_NAME_BEEP_CONNECTION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (keyToneVolume == null || beepVolume == null ||
            beepSoundFlag == null || enableBeepPowerOn == null ||
            enableBeepBarcode == null || enableBeepConnection == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.SetBeepSound_POS(
            keyToneVolume.toShort(), beepVolume.toShort(),
            beepSoundFlag, enableBeepPowerOn,
            enableBeepBarcode, enableBeepConnection
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun getBeepSoundPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val kposResult = reader.GetBeepSound_POS();

        kposResult?.let {
            val retCode = it.GetResultCode()
            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(
                    KConverter.toMap(it, KConverter.COMMAND_GET_BEEP_SOUND_POS)
                )
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setKeypadMenuEntryPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val retCode = reader.SetKeypadMenuEntry_POS(it)

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun syncDateTimePos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.SyncDateTime_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun getDateTimePos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val kposResult = reader.GetDateTime_POS();

        kposResult?.let {
            val retCode = it.GetResultCode()
            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(
                    KConverter.toMap(it, KConverter.COMMAND_GET_DATE_TIME_POS)
                )
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun enableBatteryAlarmPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val interval = call.argument<Int>(PARAM_NAME_INTERVAL)
        val level = call.argument<Int>(PARAM_NAME_LEVEL)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (interval == null || level == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.EnableBatteryAlarm_POS(
            interval.toShort(), level.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun disableBatteryAlarmPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.DisableBatteryAlarm_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun readDataPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val titleId = call.argument<Int>(PARAM_NAME_TITLE_ID)
        val target = call.argument<Int>(PARAM_NAME_TARGET)
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)
        val maxDigit = call.argument<Int>(PARAM_NAME_MAX_DIGIT)
        val enableMask = call.argument<Boolean>(PARAM_NAME_MASK)
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (titleId == null || target == null ||
            timeout == null || maxDigit == null ||
            enableMask == null
        ) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.ReadData_POS(
            titleId.toShort(), target.toShort(),
            timeout.toShort(), maxDigit.toShort(),
            enableMask
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun cancelReadDataPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.CancelReadData_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun findMyKDCPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val count = call.argument<Int>(PARAM_NAME_COUNT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        count?.let {
            val retCode = reader.FindMyKDC_POS(it.toShort())

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun setDisplayMessagePos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val line1Message = call.argument<String>(PARAM_NAME_LINE1) ?: KConstants.EMPTY_STRING
        val line2Message = call.argument<String>(PARAM_NAME_LINE2) ?: KConstants.EMPTY_STRING
        val line3Message = call.argument<String>(PARAM_NAME_LINE3) ?: KConstants.EMPTY_STRING
        val line4Message = call.argument<String>(PARAM_NAME_LINE4) ?: KConstants.EMPTY_STRING
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        timeout?.let {
            val retCode = reader.SetDisplayMessage_POS(
                line1Message, line2Message,
                line3Message, line4Message,
                timeout.toShort()
            )

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun clearDisplayPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.ClearDisplay_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun enableKeypadPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val line = call.argument<Int>(PARAM_NAME_LINE)
        val maxDigit = call.argument<Int>(PARAM_NAME_MAX_DIGIT)
        val clearFlag  = call.argument<Boolean>(PARAM_NAME_CLEAR)
        val enableMask = call.argument<Boolean>(PARAM_NAME_MASK)
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (line == null || maxDigit == null ||
            clearFlag == null || enableMask == null ||
            timeout == null
        ) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.EnableKeypad_POS(
            line.toShort(), maxDigit.toShort(),
            clearFlag, enableMask,
            timeout.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun enableKeypadEventOnlyPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.EnableKeypadEventOnly_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun disableKeypadPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val clearFlag = call.argument<Boolean>(PARAM_NAME_CLEAR)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        clearFlag?.let {
            val retCode = reader.DisableKeypad_POS(it)

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun readEmvCLCardPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val pinBlockFormat = call.argument<Int>(PARAM_NAME_PIN_BLOCK_FORMAT)
        val maxDigit = call.argument<Int>(PARAM_NAME_MAX_DIGIT)
        val transType = call.argument<Int>(PARAM_NAME_TRANS_TYPE)
        val amount = call.argument<Int>(PARAM_NAME_AMOUNT)
        val otherAmount = call.argument<Int>(PARAM_NAME_OTHER_AMOUNT)
        val onlinePinSupport = call.argument<Int>(PARAM_NAME_ONLINE)
        val timeout= call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (pinBlockFormat == null || maxDigit == null ||
            transType == null || amount == null ||
            otherAmount == null || onlinePinSupport == null ||
            timeout == null
        ) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.ReadEmvCLCard_POS(
            pinBlockFormat.toShort(), maxDigit.toShort(),
            transType.toShort(), amount,
            otherAmount, onlinePinSupport.toShort(),
            timeout.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun stopEmvCLTransactionPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.StopEmvCLTransaction_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun getSupportedLocales(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val kposResult = reader.GetSupportedLocales_POS();

        kposResult?.let {
            val retCode = it.GetResultCode()
            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(
                    KConverter.toMap(it, KConverter.COMMAND_GET_SUPPORTED_LOCALES_POS)
                )
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setDisplayMessageWithLocalePos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val line1Message = call.argument<String>(PARAM_NAME_LINE1) ?: KConstants.EMPTY_STRING
        val line2Message = call.argument<String>(PARAM_NAME_LINE2) ?: KConstants.EMPTY_STRING
        val line3Message = call.argument<String>(PARAM_NAME_LINE3) ?: KConstants.EMPTY_STRING
        val line4Message = call.argument<String>(PARAM_NAME_LINE4) ?: KConstants.EMPTY_STRING
        val locale = call.argument<Int>(PARAM_NAME_LOCALE)
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (locale == null || timeout == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val kposLocale = locale.let {
            for (l in KPOSLocale.values()) {
                if (it == l.bitMask.toInt()) {
                    return@let l
                }
            }
            null
        }

        kposLocale?.let {
            val retCode = reader.SetDisplayMessage_POS(
                line1Message, line2Message,
                line3Message, line4Message,
                kposLocale, timeout.toShort()
            )

            if (retCode == KPOSConstants.RCODE_SUCCESS) {
                result.success(true)
            } else {
                val detail = HashMap<String, Any>().apply {
                    put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
                }
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun setDisplayMessageIdAndReadKeypadPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val line1Id = call.argument<Int>(PARAM_NAME_LINE1) ?: KPOSConstants.KT_MSG_NONE.toInt()
        val line2Id = call.argument<Int>(PARAM_NAME_LINE2) ?: KPOSConstants.KT_MSG_NONE.toInt()
        val line3Id = call.argument<Int>(PARAM_NAME_LINE3) ?: KPOSConstants.KT_MSG_NONE.toInt()
        val line4Id = call.argument<Int>(PARAM_NAME_LINE4) ?: KPOSConstants.KT_MSG_NONE.toInt()

        val locale = call.argument<Int>(PARAM_NAME_LOCALE)
        val keypadType = call.argument<Int>(PARAM_NAME_KEYPAD_TYPE)
        val enableMask = call.argument<Boolean>(PARAM_NAME_MASK)
        val keyInputLineNumber = call.argument<Int>(PARAM_NAME_INPUT_LINE)
        val align = call.argument<Int>(PARAM_NAME_INPUT_ALIGN)
        val maxDigit = call.argument<Int>(PARAM_NAME_MAX_DIGIT)
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (locale == null || keypadType == null ||
            enableMask == null || keyInputLineNumber == null ||
            align == null || maxDigit == null ||
            timeout == null
        ) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val kposLocale = locale.let {
            for (l in KPOSLocale.values()) {
                if (it == l.bitMask.toInt()) {
                    return@let l
                }
            }
            null
        }

        val kposAlign = align.let {
            for (a in KPOSAlign.values()) {
                if (it == a.ordinal) {
                    return@let a
                }
            }
            null
        }

        if (kposLocale == null || kposAlign == null) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val retCode = reader.SetDisplayMessageAndReadKeypad_POS(
            line1Id.toShort(), line2Id.toShort(),
            line3Id.toShort(), line4Id.toShort(),
            kposLocale, keypadType.toShort(),
            enableMask, keyInputLineNumber.toShort(),
            kposAlign, maxDigit.toShort(),
            timeout.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun setDisplayMessageAndReadKeypadPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val line1Message = call.argument<String>(PARAM_NAME_LINE1) ?: KConstants.EMPTY_STRING
        val line2Message = call.argument<String>(PARAM_NAME_LINE2) ?: KConstants.EMPTY_STRING
        val line3Message = call.argument<String>(PARAM_NAME_LINE3) ?: KConstants.EMPTY_STRING
        val line4Message = call.argument<String>(PARAM_NAME_LINE4) ?: KConstants.EMPTY_STRING
        val locale = call.argument<Int>(PARAM_NAME_LOCALE)
        val keypadType = call.argument<Int>(PARAM_NAME_KEYPAD_TYPE)
        val enableMask = call.argument<Boolean>(PARAM_NAME_MASK)
        val keyInputLineNumber = call.argument<Int>(PARAM_NAME_INPUT_LINE)
        val align = call.argument<Int>(PARAM_NAME_INPUT_ALIGN)
        val maxDigit = call.argument<Int>(PARAM_NAME_MAX_DIGIT)
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (locale == null || keypadType == null ||
            enableMask == null || keyInputLineNumber == null ||
            align == null || maxDigit == null ||
            timeout == null
        ) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val kposLocale = locale.let {
            for (l in KPOSLocale.values()) {
                if (it == l.bitMask.toInt()) {
                    return@let l
                }
            }
            null
        }

        val kposAlign = align.let {
            for (a in KPOSAlign.values()) {
                if (it == a.ordinal) {
                    return@let a
                }
            }
            null
        }

        val retCode = reader.SetDisplayMessageAndReadKeypad_POS(
            line1Message, line2Message,
            line3Message, line4Message,
            kposLocale, keypadType.toShort(),
            enableMask, keyInputLineNumber.toShort(),
            kposAlign, maxDigit.toShort(),
            timeout.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun setDisplayMessageAndSelectItemPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val line1Message = call.argument<String>(PARAM_NAME_LINE1) ?: KConstants.EMPTY_STRING
        val line2Message = call.argument<String>(PARAM_NAME_LINE2) ?: KConstants.EMPTY_STRING
        val line3Message = call.argument<String>(PARAM_NAME_LINE3) ?: KConstants.EMPTY_STRING
        val locale = call.argument<Int>(PARAM_NAME_LOCALE)
        val firstItemLine = call.argument<Int>(PARAM_NAME_FIRST_ITEM_LINE)
        val items = call.argument<List<String>>(PARAM_NAME_ITEMS)
        val timeout = call.argument<Int>(PARAM_NAME_TIMEOUT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        if (locale == null || firstItemLine == null ||
            items == null || timeout == null
        ) {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
            return
        }

        val kposLocale = locale.let {
            for (l in KPOSLocale.values()) {
                if (it == l.bitMask.toInt()) {
                    return@let l
                }
            }
            null
        }

        val retCode = reader.SetDisplayMessageAndSelectItem_POS(
            line1Message, line2Message,
            line3Message, kposLocale,
            firstItemLine.toShort(), items.toTypedArray(),
            timeout.toShort()
        )

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }

    private fun clearDisplayAndCancelKeypadPos(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val retCode = reader.ClearDisplayAndCancelKeypad_POS()

        if (retCode == KPOSConstants.RCODE_SUCCESS) {
            result.success(true)
        } else {
            val detail = HashMap<String, Any>().apply {
                put(KConstants.ErrorCode.KEY_OPERATION_POS, retCode)
            }
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, detail, result)
        }
    }
}