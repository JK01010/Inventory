import Flutter
import UIKit

public class KdcreaderIosPlugin: NSObject, FlutterPlugin {
    var readerManager: KdcReaderManager
    
    static let METHOD_CHANNEL_NAME = "plugins.flutter.koamtac/ios/kdcreader"

    static let CONNECTION_STATE_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/connection"
    static let BARCODE_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/barcode"
    static let NFC_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/nfc"
    static let MSR_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/msr"
    static let GENERAL_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/general"

    static let POS_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/pos"

    static let ERROR_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/error"

    static let DEVICE_SCANNED_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/device_scanned"
    
    static let INFO_UPDATED_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/info_updated"
    
    // Software Decoder
    static let SW_BARCODE_DATA_EVENT_CHANNEL_NAME = "plugins.flutter.koamtac/ios/sw_barcode"

    override init() {
        self.readerManager = KdcReaderManager()
        super.init()
    }
        
    public static func register(with registrar: FlutterPluginRegistrar) {
        /* Plugin */
        let instance = KdcreaderIosPlugin()
        let methodChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: methodChannel)

        /* Connection State */
        let connectionChannel = FlutterEventChannel(name: CONNECTION_STATE_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let connectionHandler = KSteamHandler(KEvent.Name.CONNECTION_STATE_CHANGED, manager: instance.readerManager)
        connectionChannel.setStreamHandler(connectionHandler)
        
        /* Barcode Data */
        let barcodeChannel = FlutterEventChannel(name: BARCODE_DATA_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let barcodeHandler = KSteamHandler(KEvent.Name.BARCODE_DATA_RECEIVED, manager: instance.readerManager)
        barcodeChannel.setStreamHandler(barcodeHandler)
        
        /* NFC Data */
        let nfcChannel = FlutterEventChannel(name: NFC_DATA_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let nfcHandler = KSteamHandler(KEvent.Name.NFC_DATA_RECEIVED, manager: instance.readerManager)
        nfcChannel.setStreamHandler(nfcHandler)
        
        /* MSR Data */
        let msrChannel = FlutterEventChannel(name: MSR_DATA_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let msrHandler = KSteamHandler(KEvent.Name.MSR_DATA_RECEIVED, manager: instance.readerManager)
        msrChannel.setStreamHandler(msrHandler)
        
        /* General Data */
        let generalChannel = FlutterEventChannel(name: GENERAL_DATA_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let generalHandler = KSteamHandler(KEvent.Name.GENERAL_DATA_RECEIVED, manager: instance.readerManager)
        generalChannel.setStreamHandler(generalHandler)
        
        /* POS Data(KDC500) */
        let posChannel = FlutterEventChannel(name: POS_DATA_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let posHandler = KSteamHandler(KEvent.Name.POS_DATA_RECEIVED, manager: instance.readerManager)
        posChannel.setStreamHandler(posHandler)
        
        /* Error */
        let errorChannel = FlutterEventChannel(name: ERROR_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let errorHandler = KSteamHandler(KEvent.Name.ERROR_RECEIVED, manager: instance.readerManager)
        errorChannel.setStreamHandler(errorHandler)
        
        /* BLE Device Scan */
        let deviceScannedChannel = FlutterEventChannel(name: DEVICE_SCANNED_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let deviceScannedHandler = KSteamHandler(KEvent.Name.DEVICE_SCANNED, manager: instance.readerManager)
        deviceScannedChannel.setStreamHandler(deviceScannedHandler)
        
        /* Info Updated (Core Bluetooth Manager State) */
        let infoUpdatedChannel = FlutterEventChannel(name: INFO_UPDATED_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let infoUpdatedHandler = KSteamHandler(KEvent.Name.INFO_UPDATED, manager: instance.readerManager)
        infoUpdatedChannel.setStreamHandler(infoUpdatedHandler)
        
        /* Software Decoder when separate listener used */
        let swBarcodeChannel = FlutterEventChannel(name: SW_BARCODE_DATA_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let swBarcodeHandler = KSteamHandler(KEvent.Name.SW_BARCODE_DATA_RECEIVED, manager: instance.readerManager)
        swBarcodeChannel.setStreamHandler(swBarcodeHandler)

        /* Component View Factory */
        let factory = KViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: KViewFactory.SW_DECODER_COMPONENT_VIEW_TYPE_ID)
        
        if let vc = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
            instance.readerManager.setCurrentViewController(viewController: vc)
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if !readerManager.execute(call, result: result) {
            result(FlutterMethodNotImplemented)
        }
    }
}
