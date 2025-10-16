//
//  KdcReaderManager.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/19/24.
//

import Flutter
import Foundation
import CoreBluetooth

class KdcReaderManager {
    // Defer creation and initialization of BLE-related objects
    // Please enable it, if you do not plan to use BLE and do not want to see BLE permission popup.
    private static let USE_LAZY_INIT_FOR_BLE = false
    
    // ** Experimental **
    // Execute commands using disaptch serial queue
    private static let USE_DISPATCH_SERIAL_QUEUE = false

    // Software Decoder using separate notification
    private static let USE_SEPARATE_SW_BARCODE_NOTIFICATION = false
    
    let reader: KDCReader
    
    let converter: KConverter
    var workQueue: DispatchQueue? = nil

    var eventSinkMap = [String: FlutterEventSink]()
    var delegates = [KReaderDelegate]()
    
    // software decoder
    var swDecoderDelegate: KSWDecoderDelegate
    
    init() {
        if KdcReaderManager.USE_LAZY_INIT_FOR_BLE {
//            let options: [String : Any] = [
//                keyLazyInitBLE: true,
//                keyConnectionMode: ConnectionMode.CONNECTION_MODE_ACCESSORY.rawValue
//            ]
            let options: [String : Any] = [
                keyLazyInitBLE: true
            ]
            self.reader = KDCReader(options: options)
        } else {
            self.reader = KDCReader()
        }
        
        self.reader.enableBleAutoReconnect(false)

        self.converter = KConverter()

        if KdcReaderManager.USE_SEPARATE_SW_BARCODE_NOTIFICATION {
            self.reader.enableSoftwareDecoderBarcodeListener(true)
        }

        if KdcReaderManager.USE_DISPATCH_SERIAL_QUEUE {
            self.workQueue = DispatchQueue(label: "koamtac.kdc.sdk.flutter")
        }

        self.swDecoderDelegate = KSWDecoderDelegate(reader: self.reader, converter: self.converter)
        
        let nc = NotificationCenter.default
        
        // Register connection notification
        nc.addObserver(self, selector: #selector(kdcConnectionChanged), name: NSNotification.Name.kdcConnectionChanged, object: nil)
        
        // Register KDC legacy data notification
        nc.addObserver(self, selector: #selector(kdcBarcodeDataArrived), name: NSNotification.Name.kdcBarcodeDataArrived, object: nil)
        nc.addObserver(self, selector: #selector(kdcMSRDataArrived), name: NSNotification.Name.kdcMSRDataArrived, object: nil)
        nc.addObserver(self, selector: #selector(kdcNFCDataArrived), name: NSNotification.Name.kdcNFCDataArrived, object: nil)
        nc.addObserver(self, selector: #selector(kdcDataArrived), name: NSNotification.Name.kdcDataArrived, object: nil)

        // Register KDC mPOS(KDC500) data notification
        nc.addObserver(self, selector: #selector(kposDataArrived), name: NSNotification.Name.kposDataArrived, object: nil)

        // Register error notification
        nc.addObserver(self, selector: #selector(kdcErrorReceived), name: NSNotification.Name.kdcErrorReceived, object: nil)

        // Register information updated notification
        nc.addObserver(self, selector: #selector(kdcInfoUpdated), name: NSNotification.Name.kdcInfoUpdated, object: nil)

        // Register scanned BLE device notification
        nc.addObserver(self, selector: #selector(kdcDeviceScanned), name: NSNotification.Name.kdcDeviceScanned, object: nil)
        
        // Software Decoder When sperate listener used
        nc.addObserver(self, selector: #selector(kdcSwBarcodeDataArrived), name: NSNotification.Name.kdcSwBarcodeDataArrived, object: nil)

        delegates.append(KBLEDelegate(reader: self.reader, converter: self.converter))
        
        delegates.append(KCommonDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KDataProcessDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KSystemDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KBluetoothDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KDisplayDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KVibratorDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KKeypadDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KHidDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KWiFiDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KNfcDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KMsrDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KMsrIcDelegate(reader: self.reader, converter: self.converter))
        delegates.append(KUhfDelegate(reader: self.reader, converter: self.converter))
        
        delegates.append(KPosDelegate(reader: self.reader, converter: self.converter))
        
        delegates.append(swDecoderDelegate)
    }
    
    func execute(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        for delegate in delegates {
            if delegate.isSupported(call.method) {
                if let queue = self.workQueue {
                    queue.async {
                        _ = delegate.run(call, result: result)
                    }
                    return true
                } else {
                    return delegate.run(call, result: result)
                }
            }
        }
        return false
    }
    
    func setEventSink(_ name:String, eventSink: FlutterEventSink?) {
        if let events = eventSink {
            eventSinkMap[name] = events
        } else {
            eventSinkMap.removeValue(forKey: name)
        }
    }
    
    func removeAllEventSink() {
        eventSinkMap.removeAll()
    }

    func setCurrentViewController(viewController: UIViewController) {
        swDecoderDelegate.viewController = viewController
    }

    @objc
    func kdcConnectionChanged(notification: NSNotification) {
        if (notification.object as? KDCReader) != nil {
            if let userInfo = notification.userInfo as? NSDictionary,
                let s = userInfo.object(forKey: keyConnectionState) as? NSNumber,
                let _ = ConnectionState(rawValue: s.intValue) {
                
                var dict = [String: Any]()
                dict[KConstants.ConnectionKey.State] = s
                
                var deviceName: String? = nil

                var device = [String: Any]()
                
                if let accessory = userInfo.object(forKey: keyAccessory) as? EAAccessory {
                    deviceName = String(format: "%@[%@]",
                                        accessory.modelNumber, (accessory.serialNumber as NSString).substring(from: 4))
                    
                    device[KConstants.DeviceKey.DeviceType] = TYPE_ACCESSORY
                    device[KConstants.DeviceKey.SubType] = SUBTYPE_ACCESSORY
                } else if let peripheral = userInfo.object(forKey: keyPeripheral) as? CBPeripheral {
                    deviceName = peripheral.name
                    
                    device[KConstants.DeviceKey.DeviceType] = TYPE_CORE_BLUETOOTH
                    device[KConstants.DeviceKey.SubType] = SUBTYPE_BLUETOOTH_SMART
                    device[KConstants.DeviceKey.Identifier] = peripheral.identifier.uuidString
                } else if let software = userInfo.object(forKey: keySoftware) as? SoftwareDevice {
                    deviceName = software.name
                    device[KConstants.DeviceKey.DeviceType] = TYPE_SOFTWARE
                    device[KConstants.DeviceKey.SubType] = SUBTYPE_SOFTWARE_DECODER
                }
                
                if let name = deviceName {
                    device[KConstants.DeviceKey.DeviceName] = name
                    device[KConstants.DeviceKey.KDCName] = name
                    dict[KConstants.ConnectionKey.Device] = device
                }
                
                if let eventSink = eventSinkMap[KEvent.Name.CONNECTION_STATE_CHANGED] {
                    eventSink(dict)
                }
            }
        }
    }

    @objc
    func kdcBarcodeDataArrived(notification: NSNotification) {
        if let userInfo = notification.userInfo as? NSDictionary,
           let data = userInfo.object(forKey: keyKDCData) as? KDCData {
            let dict = converter.fromKDCData(data)
            
            if let eventSink = eventSinkMap[KEvent.Name.BARCODE_DATA_RECEIVED] {
                eventSink(dict)
            }
        }
    }

    @objc
    func kdcSwBarcodeDataArrived(notification: NSNotification) {
        if let userInfo = notification.userInfo as? NSDictionary,
           let dataList = userInfo.object(forKey: keyKDCSWDataList) as? NSArray {
            var arr = [Dictionary<String, Any>]()
            
            for (index, item) in dataList.enumerated() {
                if let data = item as? KDCData {
                    arr.append(converter.fromKDCData(data))
                }
            }
            
            if let eventSink = eventSinkMap[KEvent.Name.SW_BARCODE_DATA_RECEIVED] {
                eventSink(arr)
            }
        }
    }
    
    @objc
    func kdcMSRDataArrived(notification: NSNotification) {
        if let userInfo = notification.userInfo as? NSDictionary,
           let data = userInfo.object(forKey: keyKDCData) as? KDCData {
            let dict = converter.fromKDCData(data)
            
            if let eventSink = eventSinkMap[KEvent.Name.MSR_DATA_RECEIVED] {
                eventSink(dict)
            }
        }
    }

    @objc
    func kdcNFCDataArrived(notification: NSNotification) {
        if let userInfo = notification.userInfo as? NSDictionary,
           let data = userInfo.object(forKey: keyKDCData) as? KDCData {
            let dict = converter.fromKDCData(data)
            
            if let eventSink = eventSinkMap[KEvent.Name.NFC_DATA_RECEIVED] {
                eventSink(dict)
            }
        }
    }

    @objc
    func kdcDataArrived(notification: NSNotification) {
        if let userInfo = notification.userInfo as? NSDictionary,
           let data = userInfo.object(forKey: keyKDCData) as? KDCData {
            let dict = converter.fromKDCData(data)
            
            if let eventSink = eventSinkMap[KEvent.Name.GENERAL_DATA_RECEIVED] {
                eventSink(dict)
            }
        }
    }

    @objc
    func kposDataArrived(notification: NSNotification) {
        if let data = reader.getPOSData() {
            let dict = converter.fromKPOSData(data)
            
            if let eventSink = eventSinkMap[KEvent.Name.POS_DATA_RECEIVED] {
                eventSink(dict)
            }
        }
    }

    @objc
    func kdcErrorReceived(notification: NSNotification) {
        if let userInfo = notification.userInfo as? NSDictionary,
           let errorCode = userInfo.object(forKey: keyErrorCode) as? Int,
           let errorObject = userInfo.object(forKey: keyErrorObject) as? NSError {
            var dict = [String: Any]()
            dict[KConstants.ResultKey.ErrorCode] = errorCode
            
            let nsErrDict = converter.fromNSError(errorObject)
            dict[KConstants.ResultKey.NSErrorObject] = nsErrDict
            
            if let eventSink = eventSinkMap[KEvent.Name.ERROR_RECEIVED] {
                eventSink(dict)
            }
        }
    }

    @objc
    func kdcInfoUpdated(notification: NSNotification) {
        if let userInfo = notification.userInfo as? NSDictionary,
           let state = userInfo.object(forKey: keyCBManagerState) as? Int {
            var dict = [String: Any]()
            dict[KConstants.InfoUpdatedKey.CbMnagerState] = state
            
            if let eventSink = eventSinkMap[KEvent.Name.INFO_UPDATED] {
                eventSink(dict)
            }
        }
    }
    
    @objc
    func kdcDeviceScanned(notification: NSNotification) {
        if let userInfo = notification.userInfo as? NSDictionary,
           let device = userInfo.object(forKey: keyScannedKdcDevice) as? KDCDevice {
            let dict = converter.fromKDCDevice(device)
            
            if let eventSink = eventSinkMap[KEvent.Name.DEVICE_SCANNED] {
                eventSink(dict)
            }
        }
    }

}
