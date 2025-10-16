package koamtac.kdc.sdk.plugins.delegate

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.graphics.Point
import android.widget.Toast
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCDataBounds
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.KDCSWConstants.KDCSWDecoderCameraType
import koamtac.kdc.sdk.KDCSWConstants.KDCSWDecoderWindowMode
import koamtac.kdc.sdk.KDCSWDecoderSetting
import koamtac.kdc.sdk.plugins.KConstants
import koamtac.kdc.sdk.plugins.KConverter
import koamtac.kdc.sdk.plugins.activity.ComponentScanActivity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.lang.ref.WeakReference
import java.util.Arrays
import java.util.Objects.isNull

class KSWDecoderDelegate(reader: KDCReader): KReaderDelegate() {
    private val REQUEST_CODE_COMPONENT_SCAN = 0

    companion object {
        private const val IS_SOFTWARE_DECODER_ACTIVATED = "isSoftwareDecoderActivated"
        private const val ACTIVATE_SOFTWARE_DECODER = "activateSoftwareDecoder"

        private const val SET_SOFTWARE_DECODER_ACTIVATION_PERIOD = "setSoftwareDecoderActivationPeriod"

        private const val GET_SOFTWARE_DECODER_SETTING = "getSoftwareDecoderSetting"
        private const val SET_SOFTWARE_DECODER_SETTING = "setSoftwareDecoderSetting"

        private const val GET_SOFTWARE_DECODER_DEVICE_ID = "getSoftwareDecoderDeviceId"

        private const val GET_SOFTWARE_DECODER_LAST_PROCESSED_IMAGE = "getSoftwareDecoderLastProcessedImage"
        private const val GET_SOFTWARE_DECODER_LAST_DECODED_IMAGE = "getSoftwareDecoderLastDecodedImage"
        private const val GET_SOFTWARE_DECODER_LAST_BARCODE_IMAGE = "getSoftwareDecoderLastBarcodeImage"

        private const val START_COMPONENT_SCAN_ACTIVITY = "startComponentScanActivity"

        private val SUPPORTED_ACTIONS = HashSet(
            Arrays.asList(
                IS_SOFTWARE_DECODER_ACTIVATED,
                ACTIVATE_SOFTWARE_DECODER,
                SET_SOFTWARE_DECODER_ACTIVATION_PERIOD,
                GET_SOFTWARE_DECODER_SETTING,
                SET_SOFTWARE_DECODER_SETTING,
                GET_SOFTWARE_DECODER_DEVICE_ID,
                GET_SOFTWARE_DECODER_LAST_PROCESSED_IMAGE,
                GET_SOFTWARE_DECODER_LAST_DECODED_IMAGE,
                GET_SOFTWARE_DECODER_LAST_BARCODE_IMAGE,
                START_COMPONENT_SCAN_ACTIVITY
            )
        )

        private const val PARAM_NAME_LICENSE = "license"
        private const val PARAM_NAME_PERIOD = "period"
        private const val PARAM_NAME_VOLUME = "volume"
        private const val PARAM_NAME_DELAY = "delay"
        private const val PARAM_NAME_VERSION = "version"
    }

    var activity: Activity? = null;

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
            IS_SOFTWARE_DECODER_ACTIVATED -> isSoftwareDecoderActivated(reader, call, result)
            ACTIVATE_SOFTWARE_DECODER -> activateSoftwareDecoder(reader, call, result)
            SET_SOFTWARE_DECODER_ACTIVATION_PERIOD -> setSoftwareDecoderActivationPeriod(reader, call, result)

            GET_SOFTWARE_DECODER_SETTING -> getSoftwareDecoderSetting(reader, call, result)
            SET_SOFTWARE_DECODER_SETTING -> setSoftwareDecoderSetting(reader, call, result)

            GET_SOFTWARE_DECODER_DEVICE_ID -> getSoftwareDecoderDeviceId(reader, call, result)

            GET_SOFTWARE_DECODER_LAST_PROCESSED_IMAGE -> getSoftwareDecoderLastProcessedImage(reader, call, result)
            GET_SOFTWARE_DECODER_LAST_DECODED_IMAGE -> getSoftwareDecoderLastDecodedImage(reader, call, result)
            GET_SOFTWARE_DECODER_LAST_BARCODE_IMAGE -> getSoftwareDecoderLastBarcodeImage(reader, call, result)

            START_COMPONENT_SCAN_ACTIVITY -> startComponentScanActivity(reader, call, result)
        }
        return true
    }

    private fun isSoftwareDecoderActivated(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }
        reader.SetSoftwareDecoderContext(activity)
        val isActivated = reader.IsSoftwareDecoderActivated(activity)
        result.success(isActivated)
    }

    private fun activateSoftwareDecoder(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val license = call.argument<String>(PARAM_NAME_LICENSE)

        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }

        if (!license.isNullOrEmpty() && license.isNotBlank()) {
            CoroutineScope(Dispatchers.Main).launch {
                reader.SetSoftwareDecoderContext(activity)

                val activationResult = withContext(Dispatchers.Default) {
                    reader.ActivateSoftwareDecoder(activity, license)
                }

                result.success(KConverter.toMap(activationResult))
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
        }
    }

    private fun setSoftwareDecoderActivationPeriod(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val period = call.argument<Int>(PARAM_NAME_PERIOD)

        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }
        reader.SetSoftwareDecoderContext(activity)

        period?.let {
            reader.SetSoftwareDecoderActivationPeriod(activity, period)
            result.success(true)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getSoftwareDecoderSetting(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }
        reader.SetSoftwareDecoderContext(activity)
        val decoderSetting = reader.GetSoftwareDecoderSetting()
        result.success(KConverter.toMap(decoderSetting))
    }

    private fun setSoftwareDecoderSetting(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }

        val decoderSetting = KDCSWDecoderSetting()

        val flash = call.argument<Boolean>(KConstants.SWDecoderSettingKey.FlashOnDecode)
        flash?.let {
            decoderSetting.EnableFlashOnDecode(it)
        }

        val decode = call.argument<Boolean>(KConstants.SWDecoderSettingKey.Decode)
        decode?.let {
            decoderSetting.EnableDecoding(it)
        }

        val rect = call.argument<IntArray>(KConstants.SWDecoderSettingKey.Window)
        rect?.let {
            if (it.size >= 4) {
                val left: Int = it[0]
                val right: Int = it[1]
                val top: Int = it[2]
                val bottom: Int = it[3]
                decoderSetting.SetWindow(left, right, top, bottom)
            }
        }

        val mode = call.argument<Int>(KConstants.SWDecoderSettingKey.WindowMode)
        mode?.let {
            for (m in KDCSWDecoderWindowMode.values()) {
                if (it == m.ordinal) {
                    decoderSetting.SetWindowMode(m)
                    break
                }
            }
        }

        val aimer = call.argument<Boolean>(KConstants.SWDecoderSettingKey.Aimer)
        aimer?.let {
            decoderSetting.EnableAimer(it)
        }

        val aimerColor = call.argument<Number>(KConstants.SWDecoderSettingKey.AimerColor)
        aimerColor?.let {
            decoderSetting.SetAimerColor(it.toInt())
        }

        val text = call.argument<String>(KConstants.SWDecoderSettingKey.OverlayText)
        text?.let {
            decoderSetting.SetOverlayText(it)
        }

        val textColor = call.argument<Number>(KConstants.SWDecoderSettingKey.OverlayTextColor)
        textColor?.let {
            decoderSetting.SetOverlayTextColor(it.toInt())
        }

        val activeTemplate = call.argument<Int>(KConstants.SWDecoderSettingKey.OCRActiveTemplate)
        activeTemplate?.let {
            decoderSetting.SetOCRActiveTemplate(it)
        }

        val userTemplate = call.argument<ByteArray>(KConstants.SWDecoderSettingKey.OCRUserTemplate)
        userTemplate?.let {
//            val t = ByteArray(it.size)
//            for (i in it.indices) {
//                t[i] = it[i] as Byte
//            }
//            decoderSetting.SetOCRUserTemplate(t)
            decoderSetting.SetOCRUserTemplate(it)
        }

        val type = call.argument<Int>(KConstants.SWDecoderSettingKey.ActiveCamera)
        type?.let {
            for (t in KDCSWDecoderCameraType.values()) {
                if (it == t.ordinal) {
                    decoderSetting.SetActiveCameraType(t)
                    break
                }
            }
        }

        val bRet = reader.SetSoftwareDecoderSetting(decoderSetting)
        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getSoftwareDecoderDeviceId(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }

        val deviceId = reader.GetSoftwareDecoderDeviceId(activity)
        deviceId?.let {
            result.success(deviceId)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getSoftwareDecoderLastProcessedImage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }

        reader.GetSoftwareDecoderLastProcessedImage()?.let {
            result.success(KConverter.toMap(it))
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getSoftwareDecoderLastDecodedImage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }

        reader.GetSoftwareDecoderLastDecodedImage()?.let {
            result.success(KConverter.toMap(it))
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getSoftwareDecoderLastBarcodeImage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }

        val tl = call.argument<Map<String, Int>>(KConstants.SWDecoderBoundsKey.TopLeft)
        val topLeft = tl?.let {
            val x = it[KConstants.SWDecoderBoundsKey.X];
            val y = it[KConstants.SWDecoderBoundsKey.Y];
            if (x != null && y != null) {
                return@let Point(x, y)
            }
            return@let null
        }

        val tr = call.argument<Map<String, Int>>(KConstants.SWDecoderBoundsKey.TopRight)
        val topRight = tr?.let {
            val x = it[KConstants.SWDecoderBoundsKey.X];
            val y = it[KConstants.SWDecoderBoundsKey.Y];
            if (x != null && y != null) {
                return@let Point(x, y)
            }
            return@let null
        }

        val bl = call.argument<Map<String, Int>>(KConstants.SWDecoderBoundsKey.BottomLeft)
        val bottomLeft = bl?.let {
            val x = it[KConstants.SWDecoderBoundsKey.X];
            val y = it[KConstants.SWDecoderBoundsKey.Y];
            if (x != null && y != null) {
                return@let Point(x, y)
            }
            return@let null
        }

        val br = call.argument<Map<String, Int>>(KConstants.SWDecoderBoundsKey.BottomRight)
        val bottomRight = br?.let {
            val x = it[KConstants.SWDecoderBoundsKey.X];
            val y = it[KConstants.SWDecoderBoundsKey.Y];
            if (x != null && y != null) {
                return@let Point(x, y)
            }
            return@let null
        }

        val width = call.argument<Int>(KConstants.SWDecoderBoundsKey.Width)
        val height = call.argument<Int>(KConstants.SWDecoderBoundsKey.Height)

        if (topLeft != null && topRight != null &&
                bottomLeft != null && bottomRight != null &&
                width != null && height != null) {
            val bounds = KDCDataBounds(topLeft, topRight, bottomLeft, bottomRight, width, height)
            reader.GetSoftwareDecoderLastBarcodeImage(bounds)?.let {
                result.success(KConverter.toMap(it))
            } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
        }
    }

    private fun startComponentScanActivity(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (activity == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }
        val intent = Intent(activity, ComponentScanActivity::class.java)
        activity?.startActivityForResult(intent, REQUEST_CODE_COMPONENT_SCAN, null)
        result.success(true)
    }
}