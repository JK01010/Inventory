package koamtac.kdc.sdk.plugins.usb

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCDevice
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import koamtac.kdc.sdk.plugins.delegate.KCommonDelegate
import koamtac.kdc.sdk.plugins.delegate.KReaderDelegate
import koamtac.kdc.sdk.plugins.delegate.KUhfDelegate
import java.lang.ref.WeakReference

class KUsbDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val CHECK_USB_PERMISSION = "checkUsbPermission"
        private const val REQUEST_USB_PERMISSION = "requestUsbPermission"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                CHECK_USB_PERMISSION,
                REQUEST_USB_PERMISSION
            )
        )

        private const val PARAM_NAME_DEVICE = "device"
        private const val PARAM_PERMISSION = "permission"
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
            CHECK_USB_PERMISSION -> checkUsbPermission(context, reader, call, result)
            REQUEST_USB_PERMISSION -> requestUsbPermission(context, reader, call, result)
        }

        return true
    }

    private fun checkUsbPermission(context: Context, reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val device = call.argument<Map<String, Any>>(PARAM_NAME_DEVICE)

        val packageManager = context.packageManager
        var usbManager: UsbManager? = null

        if (packageManager?.hasSystemFeature(PackageManager.FEATURE_USB_HOST) == true) {
            usbManager = context.getSystemService(Context.USB_SERVICE) as UsbManager
        }

        if (usbManager == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }

        var isRequested = false
        var hasPermission = false
        val deviceName = device?.get(KConstants.DeviceKey.DeviceName) as String?

        deviceName?.let {
            if (it.isNotEmpty()) {
                val list = reader.GetAvailableDeviceListEx(KDCConstants.DeviceListType.ATTACHED_USB_LIST)
                for (d in list) {
                     if (d.GetDeviceName() == it && d.GetDevice() is UsbDevice) {
                        val usbDevice = d.GetDevice() as UsbDevice
                        hasPermission = usbManager.hasPermission(usbDevice)
                        isRequested = true
                        break
                    }
                }
            }
        }

        if (isRequested) {
            result.success(hasPermission)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
        }
    }

    private fun requestUsbPermission(context: Context, reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val device = call.argument<Map<String, Any>>(PARAM_NAME_DEVICE)

        val packageManager = context.packageManager
        var usbManager: UsbManager? = null

        if (packageManager?.hasSystemFeature(PackageManager.FEATURE_USB_HOST) == true) {
            usbManager = context.getSystemService(Context.USB_SERVICE) as UsbManager
        }

        if (usbManager == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return
        }

        var isRequested = false
        val deviceName = device?.get(KConstants.DeviceKey.DeviceName) as String?

        deviceName?.let {
            if (it.isNotEmpty()) {
                val list = reader.GetAvailableDeviceListEx(KDCConstants.DeviceListType.ATTACHED_USB_LIST)
                for (d in list) {
                    if (d.GetDeviceName() == it && d.GetDevice() is UsbDevice) {
                        val usbDevice = d.GetDevice() as UsbDevice
                        val intent = Intent(UsbBroadcastReceiver.USB_PERMISSION)

                        val pendingIntent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S &&
                            context.applicationInfo.targetSdkVersion >= Build.VERSION_CODES.S) {
                            PendingIntent.getBroadcast(
                                context,
                                UsbBroadcastReceiver.CODE_USB_PERMISSION,
                                intent,
                                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                            )
                        } else {
                            PendingIntent.getBroadcast(
                                context,
                                UsbBroadcastReceiver.CODE_USB_PERMISSION,
                                intent,
                                PendingIntent.FLAG_UPDATE_CURRENT
                            )
                        }

                        val filter = IntentFilter().apply{
                            addAction(UsbBroadcastReceiver.USB_PERMISSION)
                        }

                        // this broadcast receiver will handle the permission results
                        val usbReceiver = UsbBroadcastReceiver(context, result)
//                        context.registerReceiver(usbReceiver, filter)

                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            context.registerReceiver(usbReceiver, filter, Context.RECEIVER_NOT_EXPORTED)
                        } else {
                            context.registerReceiver(usbReceiver, filter)
                        }


                        // ask for the permission
                        usbManager.requestPermission(usbDevice, pendingIntent)
                        isRequested = true
                        break
                    }
                }
            }
        }

        if (!isRequested) {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }


}