package koamtac.kdc.sdk.plugins.usb

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.hardware.usb.UsbManager
import android.util.Log
import io.flutter.plugin.common.MethodChannel

// USB Permission BroadcastReceiver
class UsbBroadcastReceiver(val context: Context, val result: MethodChannel.Result): BroadcastReceiver() {
    companion object {
        private val TAG = UsbBroadcastReceiver::class.java.simpleName

        private const val PARAM_PERMISSION = "permission"

        const val CODE_USB_PERMISSION = 0
        const val USB_PERMISSION = "com.koamtac.plugins.sdk.USB_PERMISSION"
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == USB_PERMISSION) {
            // deal with the user answer about the permission
            val isGranted = intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)

            val message = if (isGranted) "accepted" else "denied"
            Log.d(TAG, "Permission to connect to the device was ${message}!")

            // send result
            result.success(isGranted)

            // unregister the broadcast receiver since it's no longer needed
            context?.unregisterReceiver(this)
        }
    }
}