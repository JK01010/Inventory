package koamtac.kdc.sdk.plugins

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import koamtac.kdc.sdk.plugins.view.KViewFactory

/** KdcreaderAndroidPlugin */
class KdcreaderAndroidPlugin: FlutterPlugin, MethodCallHandler, ActivityAware,
  PluginRegistry.NewIntentListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var methodChannel : MethodChannel

  private lateinit var connectionStateEventChannel: EventChannel
  private lateinit var barcodeDataEventChannel: EventChannel
  private lateinit var nfcDataEventChannel: EventChannel
  private lateinit var msrDataEventChannel: EventChannel
  private lateinit var generalDataEventChannel: EventChannel

  private lateinit var posDataEventChannel: EventChannel

  private lateinit var errorEventChannel: EventChannel

  private lateinit var deviceScannedEventChannel: EventChannel
  private lateinit var deviceScanFailedEventChannel: EventChannel

  private lateinit var usbAttachedEventChannel: EventChannel
  private lateinit var usbDetachedEventChannel: EventChannel

  // Software Decoder when separate listener used
  private lateinit var swBarcodeDataEventChannel: EventChannel

  private lateinit var appContext: Context
  private var activity: Activity? = null

  private lateinit var readerManager : KdcReaderManager

  companion object {
    // No need to register BroadcastReceiver for ACTION_USB_DEVICE_ATTACHED,
    // when device filter is registered in AndroidManifest.xml
    // If launchMode is single like singleTask or singleTop, onNewIntent is called instead.
    private const val IS_DEVICE_FILTER_REGISTERED = true

    private const val METHOD_CHANNEL_NAME = "plugins.flutter.koamtac/android/kdcreader"

    private const val CONNECTION_STATE_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/connection"
    private const val BARCODE_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/barcode"
    private const val NFC_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/nfc"
    private const val MSR_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/msr"
    private const val GENERAL_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/general"

    private const val POS_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/pos"

    private const val ERROR_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/error"

    private const val DEVICE_SCANNED_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/device_scanned"
    private const val DEVICE_SCAN_FAILED_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/device_scan_failed"

    private const val USB_DEVICE_ATTACHED_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/usb_attached"
    private const val USB_DEVICE_DETACHED_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/usb_detached"

    // Software Decoder when separate listener used
    private const val SW_BARCODE_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/android/sw_barcode"
  }

  private val usbStateReceiver: BroadcastReceiver = object : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
      val action = intent.action
      if (action == UsbManager.ACTION_USB_DEVICE_ATTACHED || action == UsbManager.ACTION_USB_DEVICE_DETACHED) {
        val device: UsbDevice? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
          intent.getParcelableExtra(UsbManager.EXTRA_DEVICE, UsbDevice::class.java)
        } else {
          intent.getParcelableExtra(UsbManager.EXTRA_DEVICE)
        }

        device?.let {
          readerManager.handleUsbStateEvent(action, it)
        }
      }
    }
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    appContext = flutterPluginBinding.applicationContext
    readerManager = KdcReaderManager(appContext)

    /* Method Channel */
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL_NAME)
    methodChannel.setMethodCallHandler(this)

    /* Connection State */
    connectionStateEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, CONNECTION_STATE_EVENT_CHANNEL_NAME)
    connectionStateEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.CONNECTION_STATE_CHANGED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.CONNECTION_STATE_CHANGED, null)
      }
    })

    /* Barcode Data */
    barcodeDataEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, BARCODE_DATA_EVENT_CHANNEL_NAME)
    barcodeDataEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.BARCODE_DATA_RECEIVED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.BARCODE_DATA_RECEIVED, null)
      }
    })

    /* NFC Data */
    nfcDataEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, NFC_DATA_EVENT_CHANNEL_NAME)
    nfcDataEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.NFC_DATA_RECEIVED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.NFC_DATA_RECEIVED, null)
      }
    })

    /* MSR Data */
    msrDataEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, MSR_DATA_EVENT_CHANNEL_NAME)
    msrDataEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.MSR_DATA_RECEIVED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.MSR_DATA_RECEIVED, null)
      }
    })

    /* General Data */
    generalDataEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, GENERAL_DATA_EVENT_CHANNEL_NAME)
    generalDataEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.GENERAL_DATA_RECEIVED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.GENERAL_DATA_RECEIVED, null)
      }
    })

    /* POS Data(KDC500) */
    posDataEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, POS_DATA_EVENT_CHANNEL_NAME)
    posDataEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.POS_DATA_RECEIVED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.POS_DATA_RECEIVED, null)
      }
    })

    /* Error */
    errorEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, ERROR_EVENT_CHANNEL_NAME)
    errorEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.ERROR_RECEIVED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.ERROR_RECEIVED, null)
      }
    })

    /* BLE Device Scanned */
    deviceScannedEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, DEVICE_SCANNED_EVENT_CHANNEL_NAME)
    deviceScannedEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.DEVICE_SCANNED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.DEVICE_SCANNED, null)
      }
    })

    /* BLE Device Scan Failed */
    deviceScanFailedEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, DEVICE_SCAN_FAILED_EVENT_CHANNEL_NAME)
    deviceScanFailedEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.DEVICE_SCAN_FAILED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.DEVICE_SCAN_FAILED, null)
      }
    })

    /* USB Device Attached */
    usbAttachedEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, USB_DEVICE_ATTACHED_EVENT_CHANNEL_NAME)
    usbAttachedEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.USB_DEVICE_ATTACHED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.USB_DEVICE_ATTACHED, null)
      }
    })

    /* USB Device Detached */
    usbDetachedEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, USB_DEVICE_DETACHED_EVENT_CHANNEL_NAME)
    usbDetachedEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.USB_DEVICE_DETACHED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.USB_DEVICE_DETACHED, null)
      }
    })

    /* Software Decoder Barcode Data when separate listener used */
    swBarcodeDataEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, SW_BARCODE_DATA_EVENT_CHANNEL_NAME)
    swBarcodeDataEventChannel.setStreamHandler(object: EventChannel.StreamHandler{
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        readerManager.setEventSink(KEvent.Name.SW_BARCODE_DATA_RECEIVED, events)
      }

      override fun onCancel(arguments: Any?) {
        readerManager.setEventSink(KEvent.Name.SW_BARCODE_DATA_RECEIVED, null)
      }
    })

    // register usb state broadcast receiver
    val intentFilter = IntentFilter()

    if (!IS_DEVICE_FILTER_REGISTERED) {
      intentFilter.addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED)
    }
    intentFilter.addAction(UsbManager.ACTION_USB_DEVICE_DETACHED)
    appContext.registerReceiver(usbStateReceiver, intentFilter)

    // software decoder
    flutterPluginBinding.platformViewRegistry.registerViewFactory(
      KViewFactory.SW_DECODER_COMPONENT_VIEW_TYPE_ID,
      KViewFactory(flutterPluginBinding.binaryMessenger))
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (!readerManager.execute(call, result)) {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)

    connectionStateEventChannel.setStreamHandler(null)

    barcodeDataEventChannel.setStreamHandler(null)
    nfcDataEventChannel.setStreamHandler(null)
    msrDataEventChannel.setStreamHandler(null)
    generalDataEventChannel.setStreamHandler(null)

    posDataEventChannel.setStreamHandler(null)

    errorEventChannel.setStreamHandler(null)

    deviceScannedEventChannel.setStreamHandler(null)
    deviceScanFailedEventChannel.setStreamHandler(null)

    usbAttachedEventChannel.setStreamHandler(null)
    usbDetachedEventChannel.setStreamHandler(null)

    swBarcodeDataEventChannel.setStreamHandler(null)

    appContext.unregisterReceiver(usbStateReceiver);

    readerManager.dispose()
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
    binding.addOnNewIntentListener(this);
    readerManager.setCurrentActivity(activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null;
    readerManager.setCurrentActivity(null)
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity;
    binding.addOnNewIntentListener(this);
    readerManager.setCurrentActivity(activity)
  }

  override fun onDetachedFromActivity() {
    activity = null;
    readerManager.setCurrentActivity(null)
  }

  override fun onNewIntent(intent: Intent): Boolean {
    if (IS_DEVICE_FILTER_REGISTERED) {
      val action = intent.action
      action?.let {
        if (it == UsbManager.ACTION_USB_DEVICE_ATTACHED) {
          val device: UsbDevice? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableExtra(UsbManager.EXTRA_DEVICE, UsbDevice::class.java)
          } else {
            intent.getParcelableExtra(UsbManager.EXTRA_DEVICE)
          }

          device?.let {
            readerManager.handleUsbStateEvent(action, it)
            return true
          }
        }
      }
    }
    return false
  }
}
