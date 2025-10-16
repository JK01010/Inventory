package koamtac.kdc.sdk.plugins.delegate

import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

abstract class KReaderDelegate: KDelegate {
    lateinit var wrReader: WeakReference<KDCReader>

    fun isConnected(reader: KDCReader?): Boolean {
        return reader?.IsConnected() ?: false;
    }

    fun sendErrorResult(err: Map<String, Any>, result: MethodChannel.Result) {
        sendErrorResult(err, null, result);
    }

    fun sendErrorResult(err: Map<String, Any>, detail: Any?, result: MethodChannel.Result) {
        val code = err.get(KConstants.ErrorCode.KEY_CODE) as String;
        val message = err.get(KConstants.ErrorCode.KEY_MESSAGE) as String;
        result.error(code, message, detail)
    }
}