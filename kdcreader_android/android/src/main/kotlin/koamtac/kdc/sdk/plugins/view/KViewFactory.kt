package koamtac.kdc.sdk.plugins.view

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class KViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    companion object {
        const val SW_DECODER_COMPONENT_VIEW_TYPE_ID = "SWComponentView"
    }

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<*, *>?
        return KComponentView(context, viewId, messenger, params)
    }
}