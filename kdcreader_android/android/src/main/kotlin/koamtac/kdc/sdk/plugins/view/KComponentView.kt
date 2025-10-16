package koamtac.kdc.sdk.plugins.view

import android.content.Context
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import koamtac.kdc.sdk.KDCSWDecoderComponent

class KComponentView(context: Context?, id: Int, messenger: BinaryMessenger, params: Map<*, *>?) :
    PlatformView, MethodCallHandler {

    companion object {
        private const val SW_DECODER_COMPONENT_VIEW_METHOD_CHANNEL_NAME = "plugins.flutter.koamtac/swcomponentview"

        private const val ENABLE_SCANNING = "enableScanning"
        private const val SET_FREEZE_MODE = "setFreezeMode"

        private const val PARAM_NAME_SCANNING = "scanning"
        private const val PARAM_NAME_FREEZE_MODE = "freeze"
    }

    private val componentView: KDCSWDecoderComponent = KDCSWDecoderComponent(context)
    private val methodChannel : MethodChannel

    override fun getView(): View {
        return componentView
    }

    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }

    init {
//        val scanning: Boolean? = params?.get(PARAM_NAME_SCANNING) as Boolean?
//        scanning?.let {
//            componentView.enableScanning(it)
//        }
//
//        val freeze: Boolean? = params?.get(PARAM_NAME_FREEZE_MODE) as Boolean?
//        freeze?.let {
//            componentView.setFreezeMode(it)
//        }

        methodChannel = MethodChannel(messenger, SW_DECODER_COMPONENT_VIEW_METHOD_CHANNEL_NAME + "_$id")
        methodChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            ENABLE_SCANNING -> enableScanning(call, result)
            SET_FREEZE_MODE -> setFreezeMode(call, result)
            else -> result.notImplemented()
        }
    }

    private fun enableScanning(call: MethodCall, result: MethodChannel.Result) {
        val isEnable = call.arguments<Boolean>()
        isEnable?.let {
            componentView.enableScanning(it)
        }
    }

    private fun setFreezeMode(call: MethodCall, result: MethodChannel.Result) {
        val isEnable = call.arguments<Boolean>()
        isEnable?.let {
            componentView.setFreezeMode(it)
        }
    }
}