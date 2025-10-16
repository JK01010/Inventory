package koamtac.kdc.sdk.plugins

import android.app.Activity
import android.content.Context
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCBarcodeDataReceivedListener
import koamtac.kdc.sdk.KDCConnectionListenerEx
import koamtac.kdc.sdk.KDCData
import koamtac.kdc.sdk.KDCDataReceivedListener
import koamtac.kdc.sdk.KDCDevice
import koamtac.kdc.sdk.KDCErrorListener
import koamtac.kdc.sdk.KDCMSRDataReceivedListener
import koamtac.kdc.sdk.KDCNFCDataReceivedListener
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.KDCSWBarcodeDataReceivedListener
import koamtac.kdc.sdk.KDCSWData
import koamtac.kdc.sdk.KDCScanResultListener
import koamtac.kdc.sdk.KPOSData
import koamtac.kdc.sdk.KPOSDataReceivedListener
import koamtac.kdc.sdk.plugins.KConstants.ErrorCode
import koamtac.kdc.sdk.plugins.delegate.KBLEDelegate
import koamtac.kdc.sdk.plugins.delegate.KBluetoothDelegate
import koamtac.kdc.sdk.plugins.delegate.KCommonDelegate
import koamtac.kdc.sdk.plugins.delegate.KDataProcessDelegate
import koamtac.kdc.sdk.plugins.delegate.KDisplayDelegate
import koamtac.kdc.sdk.plugins.delegate.KHidDelegate
import koamtac.kdc.sdk.plugins.delegate.KKeypadDelegate
import koamtac.kdc.sdk.plugins.delegate.KMsrDelegate
import koamtac.kdc.sdk.plugins.delegate.KMsrIcDelegate
import koamtac.kdc.sdk.plugins.delegate.KNfcDelegate
import koamtac.kdc.sdk.plugins.delegate.KPosDelegate
import koamtac.kdc.sdk.plugins.delegate.KReaderDelegate
import koamtac.kdc.sdk.plugins.delegate.KSWDecoderDelegate
import koamtac.kdc.sdk.plugins.delegate.KSystemDelegate
import koamtac.kdc.sdk.plugins.delegate.KUhfDelegate
import koamtac.kdc.sdk.plugins.delegate.KVibratorDelegate
import koamtac.kdc.sdk.plugins.delegate.KWiFiDelegate
import koamtac.kdc.sdk.plugins.usb.KUsbDelegate
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch

class KdcReaderManager(val context: Context): KDCConnectionListenerEx,
    KDCBarcodeDataReceivedListener,
    KDCSWBarcodeDataReceivedListener,
    KDCNFCDataReceivedListener,
    KDCMSRDataReceivedListener,
    KDCDataReceivedListener,
    KPOSDataReceivedListener,
    KDCErrorListener {

    companion object {
        // ** Experimental **
        // - Software Decoder using separate notification
        private const val USE_SEPARATE_SW_BARCODE_NOTIFICATION = false

        private const val USB_VENDOR_ID = 7232 // 0x1C40
        private const val USB_PRODUCT_ID = 1081 // 0x0439

        private const val PARAM_NAME_USB_DEVICE = "device"
    }

    private var reader : KDCReader

    // software decoder
    private var swDecoderDelegate : KSWDecoderDelegate

    private var eventSinkMap = HashMap<String, EventSink>()

    private var delegates : ArrayList<KReaderDelegate> = ArrayList()

    init {
        reader = KDCReader().also {
            it.SetContext(context)
            it.EnableBleAutoReconnect(false)

            it.SetKDCConnectionListenerEx(this)

            // KDC Legacy
            it.SetBarcodeDataReceivedListener(this)
            it.SetNFCDataReceivedListener(this)
            it.SetMSRDataReceivedListener(this)
            it.SetDataReceivedListener(this)

            it.SetKDCErrorListener(this)

            // KPOS (KDC500)
            it.SetKPOSDataReceivedListener(this)

            // Software Decoder using separate notification
            if (USE_SEPARATE_SW_BARCODE_NOTIFICATION) {
                it.SetSWBarcodeDataReceivedListener(this)
                it.EnableSoftwareDecoderBarcodeListener(true)
            }
        }

        val bleDelegate = KBLEDelegate(reader)
        bleDelegate.resultListener = object: KDCScanResultListener {
            override fun onDeviceScanned(device: KDCDevice<*>?) {
                val eventMap = KConverter.toMap(device)

                MainScope().launch {
                    val eventSink = eventSinkMap[KEvent.Name.DEVICE_SCANNED]
                    eventSink?.success(eventMap)
                }
            }

            override fun onScanFailed(errCode: Int) {
                val eventMap = HashMap<String, Any>(ErrorCode.instance.FAILED).apply {
                    put(ErrorCode.KEY_OPERATION, errCode)
                }

                MainScope().launch {
                    val eventSink = eventSinkMap[KEvent.Name.DEVICE_SCAN_FAILED]
                    eventSink?.success(eventMap)
                }
            }
        }

        with(delegates) {
            add(bleDelegate)

            add(KCommonDelegate(reader))
            add(KDataProcessDelegate(reader))
            add(KSystemDelegate(reader))
            add(KBluetoothDelegate(reader))
            add(KDisplayDelegate(reader))
            add(KVibratorDelegate(reader))
            add(KKeypadDelegate(reader))
            add(KHidDelegate(reader))
            add(KWiFiDelegate(reader))
            add(KNfcDelegate(reader))
            add(KMsrDelegate(reader))
            add(KMsrIcDelegate(reader))
            add(KUhfDelegate(reader))
            add(KUsbDelegate(reader))

            add(KPosDelegate(reader))

            swDecoderDelegate = KSWDecoderDelegate(reader)
            add(swDecoderDelegate);
        }
    }

    fun execute(call: MethodCall, result: MethodChannel.Result): Boolean {
        for (delegate in delegates) {
            if (delegate.isSupported(call.method)) {
                delegate.run(context, call, result)
                return true
            }
        }
        return false
    }

    fun setEventSink(name:String, eventSink: EventSink?) {
        if(eventSink != null) {
            eventSinkMap[name] = eventSink
        } else {
            eventSinkMap.remove(name)
        }
    }

    fun removeAllEventSink() {
       eventSinkMap.clear()
    }

    // software decoder
    fun setCurrentActivity(activity: Activity?) {
        swDecoderDelegate.activity = activity
    }

    override fun ConnectionChangedEx(device: KDCDevice<*>?, state: Int) {
        val eventMap = HashMap<String, Any>()
        val deviceMap = KConverter.toMap(device)

        eventMap[KConstants.ConnectionKey.Device] = deviceMap
        eventMap[KConstants.ConnectionKey.State] = state

        MainScope().launch {
            val eventSink = eventSinkMap[KEvent.Name.CONNECTION_STATE_CHANGED]
            eventSink?.success(eventMap)
        }
    }

    override fun BarcodeDataReceived(data: KDCData?) {
        val eventMap = KConverter.toMap(data)

        MainScope().launch {
            val eventSink = eventSinkMap[KEvent.Name.BARCODE_DATA_RECEIVED]
            eventSink?.success(eventMap)
        }
    }

    override fun SwBarcodeDataReceived(dataList: MutableList<KDCSWData>?) {
        val eventArr = ArrayList<Map<String, Any?>>()

        if (dataList != null) {
            for (data in dataList) {
               eventArr.add(KConverter.toMap(data))
            }
        }

        MainScope().launch {
            val eventSink = eventSinkMap[KEvent.Name.SW_BARCODE_DATA_RECEIVED]
            eventSink?.success(eventArr)
        }
    }

    override fun NFCDataReceived(data: KDCData?) {
        val eventMap = KConverter.toMap(data)

        MainScope().launch {
            val eventSink = eventSinkMap[KEvent.Name.NFC_DATA_RECEIVED]
            eventSink?.success(eventMap)
        }
    }

    override fun MSRDataReceived(data: KDCData?) {
        val eventMap = KConverter.toMap(data)

        MainScope().launch {
            val eventSink = eventSinkMap[KEvent.Name.MSR_DATA_RECEIVED]
            eventSink?.success(eventMap)
        }
    }

    override fun DataReceived(data: KDCData?) {
        val eventMap = KConverter.toMap(data)

        MainScope().launch {
            val eventSink = eventSinkMap[KEvent.Name.GENERAL_DATA_RECEIVED]
            eventSink?.success(eventMap)
        }
    }

    override fun POSDataReceived(data: KPOSData?) {
        val eventMap = KConverter.toMap(data)

        MainScope().launch {
            val eventSink = eventSinkMap[KEvent.Name.POS_DATA_RECEIVED]
            eventSink?.success(eventMap)
        }
    }

    override fun ErrorReceived(device: KDCDevice<*>?, errCode: Int) {
        val eventMap = HashMap<String, Any>()
        val deviceMap = KConverter.toMap(device)

        eventMap[KConstants.DeviceKey.Device] = deviceMap
        eventMap[KConstants.ResultKey.ErrorCode] = errCode

        MainScope().launch {
            val eventSink = eventSinkMap[KEvent.Name.ERROR_RECEIVED]
            eventSink?.success(eventMap)
        }
    }

    fun handleUsbStateEvent(action: String, device: UsbDevice) {
        if (device.vendorId == USB_VENDOR_ID && device.productId == USB_PRODUCT_ID) {
            val eventMap = KConverter.toMap(device)

            if (action == UsbManager.ACTION_USB_DEVICE_ATTACHED) {
                MainScope().launch {
                    val eventSink = eventSinkMap[KEvent.Name.USB_DEVICE_ATTACHED]
                    eventSink?.success(eventMap)
                }
            }
            if (action == UsbManager.ACTION_USB_DEVICE_DETACHED) {
                if (reader.IsConnected()) {
                    reader.Disconnect()
                }
                MainScope().launch {
                    val eventSink = eventSinkMap[KEvent.Name.USB_DEVICE_DETACHED]
                    eventSink?.success(eventMap)
                }
            }
        }
    }

    fun dispose() {
        eventSinkMap.clear()
        reader.Dispose()
    }
}