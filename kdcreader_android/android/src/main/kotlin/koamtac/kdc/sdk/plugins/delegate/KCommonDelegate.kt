package koamtac.kdc.sdk.plugins.delegate

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.text.TextUtils
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCConstants.DataDelimiter
import koamtac.kdc.sdk.KDCConstants.RecordDelimiter
import koamtac.kdc.sdk.KDCDevice
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import koamtac.kdc.sdk.plugins.KConverter
import java.lang.ref.WeakReference

class KCommonDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val GET_AVAIL_DEVICE_LIST_EX = "getAvailDeviceListEx"

        private const val ENABLE_ATTACH_TYPE = "enableAttachType"
        private const val ENABLE_ATTACH_SERIAL_NUMBER = "enableAttachSerialNumber"
        private const val ENABLE_ATTACH_TIMESTAMP = "enableAttachTimestamp"

        private const val SET_DATA_DELIMITER = "setDataDelimiter"
        private const val SET_RECORD_DELIMITER = "setRecordDelimiter"

        private const val GET_DEVICE_INFO = "getDeviceInfo"

        private const val GET_CONNECTED_DEVICE_EX = "getConnectedDeviceEx"

        private const val IS_CONNECTED = "isConnected"

        private const val CONNECT_EX = "connectEx"
        private const val DISCONNECT = "disconnect"

        private const val SOFTWARE_TRIGGER = "softwareTrigger"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                ENABLE_ATTACH_TYPE,
                ENABLE_ATTACH_SERIAL_NUMBER,
                ENABLE_ATTACH_TIMESTAMP,

                SET_DATA_DELIMITER,
                SET_RECORD_DELIMITER,

                GET_AVAIL_DEVICE_LIST_EX,

                CONNECT_EX,
                DISCONNECT,

                IS_CONNECTED,

                SOFTWARE_TRIGGER,

                GET_DEVICE_INFO,

                GET_CONNECTED_DEVICE_EX,
            )
        )

        private const val PARAM_NAME_TYPE = "type"
        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_DELIMITER = "delimiter"

        private const val PARAM_NAME_DEVICE = "device"

        private const val PARAM_NAME_CONNECTED = "connected"
        private const val PARAM_NAME_DEVICES = "devices"
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
            ENABLE_ATTACH_TYPE -> enableAttachType(reader, call, result)
            ENABLE_ATTACH_SERIAL_NUMBER -> enableAttachSerialNumber(reader, call, result)
            ENABLE_ATTACH_TIMESTAMP -> enableAttachTimestamp(reader, call, result)
            SET_DATA_DELIMITER -> setDataDelimiter(reader, call, result)
            SET_RECORD_DELIMITER -> setRecordDelimiter(reader, call, result)
            GET_AVAIL_DEVICE_LIST_EX -> getAvailDeviceListEx(reader, call, result)
            CONNECT_EX -> connectEx(context, reader, call, result)
            DISCONNECT -> disconnect(reader, call, result)
            IS_CONNECTED -> isConnected(reader, call, result)
            SOFTWARE_TRIGGER -> softwareTrigger(reader, call, result)
            GET_DEVICE_INFO -> getDeviceInfo(reader, call, result)
            GET_CONNECTED_DEVICE_EX -> getConnectedDeviceEx(reader, call, result)
        }

        return true
    }

    private fun hasBluetoothConnectPermission(context: Context): Boolean {
        val granted: Int = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S &&
            context.applicationInfo.targetSdkVersion >= Build.VERSION_CODES.S
        ) {
            ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_CONNECT)
        } else {
            ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH)
        }
        return granted == PackageManager.PERMISSION_GRANTED
    }

    private fun enableAttachType(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        enable?.let {
            reader.EnableAttachType(it)
            result.success(true)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableAttachSerialNumber(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        enable?.let {
            reader.EnableAttachSerialNumber(it)
            result.success(true)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun enableAttachTimestamp(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        enable?.let {
            reader.EnableAttachTimestamp(it)
            result.success(true)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun setDataDelimiter(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val del = call.argument<Int>(PARAM_NAME_DELIMITER)

        val delimiter = del?.let {
            for (d in DataDelimiter.values()) {
                if (it == d.ordinal) {
                    return@let d
                }
            }
            null
        }

        delimiter?.let {
            reader.SetDataDelimiter(it)
            result.success(true)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun setRecordDelimiter(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val del = call.argument<Int>(PARAM_NAME_DELIMITER)

        val delimiter = del?.let {
            for (d in RecordDelimiter.values()) {
                if (it == d.ordinal) {
                    return@let d
                }
            }
            null
        }

        delimiter?.let {
            reader.SetRecordDelimiter(it)
            result.success(true)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getAvailDeviceListEx(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val type = call.argument<String>(PARAM_NAME_TYPE)

        type?.let {
            val deviceList = reader.GetAvailableDeviceListEx(type)
            val jsonArray = KConverter.toArray(deviceList);

            jsonArray.also {
                result.success(it)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun connectEx(context: Context, reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val device = call.argument<Map<String, Any>>(PARAM_NAME_DEVICE)
        val bRet: Boolean;

        if (device == null) {
            bRet = reader.ConnectEx()
        } else {
            val deviceName = device[KConstants.DeviceKey.DeviceName] as String?
            var targetDevice: KDCDevice<*>? = null

            deviceName?.let {
                // 1. Find in USB device list
                val usbDeviceList =
                    reader.GetAvailableDeviceListEx(KDCConstants.DeviceListType.ATTACHED_USB_LIST)

                for (kdcDevice in usbDeviceList) {
                    if (TextUtils.equals(it, kdcDevice.GetDeviceName())) {
                        targetDevice = kdcDevice
                        break
                    }
                }

                // 2. Find in Bluetooth paired device list
                if (targetDevice == null) {
                    if (hasBluetoothConnectPermission(context)) {
                        val bluetoothDeviceList =
                            reader.GetAvailableDeviceListEx(KDCConstants.DeviceListType.BONDED_BLUETOOTH_LIST)
                        for (kdcDevice in bluetoothDeviceList) {
                            if (TextUtils.equals(it, kdcDevice.GetDeviceName())) {
                                targetDevice = kdcDevice
                                break
                            }
                        }
                    }
                }

                // 3. Find in Software decoder device list
                if (targetDevice == null) {
                    val softwareDeviceList =
                        reader.GetAvailableDeviceListEx(KDCConstants.DeviceListType.SOFTWARE_DECODER_LIST)
                    for (kdcDevice in softwareDeviceList) {
                        if (TextUtils.equals(it, kdcDevice.GetDeviceName())) {
                            targetDevice = kdcDevice
                            break
                        }
                    }
                }
            }

            if (targetDevice != null) {
                bRet = reader.ConnectEx(targetDevice)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
                return
            }
        }

        result.success(bRet);
    }

    private fun disconnect(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        reader.Disconnect()
        result.success(true)
    }

    private fun isConnected(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        result.success(reader.IsConnected())
    }

    private fun softwareTrigger(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        reader.SoftwareTrigger()
        result.success(true)
    }

    private fun getDeviceInfo(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val info = reader.GetKDCDeviceInfo()

        info?.let {
            result.success(KConverter.toMap(it))
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun getConnectedDeviceEx(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val device = reader.GetConnectedDeviceEx()

        device?.let {
            result.success(KConverter.toMap(it))
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }
}