package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

interface KDelegate {
    fun isSupported(action: String): Boolean
    fun run(context: Context, call: MethodCall, result: MethodChannel.Result): Boolean
}