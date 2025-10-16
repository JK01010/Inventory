package koamtac.kdc.sdk.plugins.delegate

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.KDCScanResultListener
import koamtac.kdc.sdk.plugins.KConstants
import java.lang.ref.WeakReference

class KBLEDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private val START_SCAN = "startScan"
        private val STOP_SCAN = "stopScan"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                START_SCAN,
                STOP_SCAN,
            )
        )
    }

    var resultListener: KDCScanResultListener?

    init {
        wrReader = WeakReference(reader)
        resultListener = null
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
            START_SCAN -> startScan(context, reader, call, result)
            STOP_SCAN -> stopScan(reader, call, result)
        }

        return true
    }

    private fun startScan(context:Context, reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        var bRet = false

        var permission = Manifest.permission.BLUETOOTH

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            permission = Manifest.permission.BLUETOOTH_SCAN
        }

        if (ContextCompat.checkSelfPermission(
                context.applicationContext, permission) == PackageManager.PERMISSION_GRANTED) {
            // change KDCReader's connection mode to BLE so that peripheral scanning works correctly
            if (reader.GetConnectionMode() != KDCConstants.ConnectionMode.BLUETOOTH_SMART) {
                reader.SetConnectionMode(KDCConstants.ConnectionMode.BLUETOOTH_SMART)
            }
            bRet = reader.StartScan(resultListener)
        }

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun stopScan(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        reader.StopScan()
        result.success(true)
    }
}