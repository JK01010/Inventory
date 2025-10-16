package koamtac.kdc.sdk.plugins

class KEvent {
    object Name {
        const val CONNECTION_STATE_CHANGED = "onConnectionChanged"
        const val BARCODE_DATA_RECEIVED = "onBarcodeDataReceived"
        const val NFC_DATA_RECEIVED = "onNfcDataReceived"
        const val MSR_DATA_RECEIVED = "onMsrDataReceived"
        const val GENERAL_DATA_RECEIVED = "onDataReceived"
        const val POS_DATA_RECEIVED = "onPosDataReceived"
        const val ERROR_RECEIVED = "onErrorReceived"
        const val DEVICE_SCANNED = "onDeviceScanned"
        const val DEVICE_SCAN_FAILED = "onDeviceScanFailed"
        const val USB_DEVICE_ATTACHED = "onUsbDeviceAttached"
        const val USB_DEVICE_DETACHED = "onUsbDeviceDetached"

        const val SW_BARCODE_DATA_RECEIVED = "onSwBarcodeDataReceived"
    }
}