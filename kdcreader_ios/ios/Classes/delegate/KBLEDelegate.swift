//
//  KBLEDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/27/24.
//

import Flutter

class KBLEDelegate: KReaderDelegate {
    private let START_SCAN = "startScan"
    private let STOP_SCAN = "stopScan"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            START_SCAN,
            STOP_SCAN,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        switch call.method {
        case START_SCAN:
            startScan(call, result: result)
            
        case STOP_SCAN:
            stopScan(call, result: result)
            
        default:
            break
        }
        return true
    }
    
    private func startScan(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var bRet = false

        let mode = reader.getConnectionMode()
        
        if mode != .CONNECTION_MODE_BLUETOOTH_SMART {
            bRet = reader.setConnectionMode(.CONNECTION_MODE_BLUETOOTH_SMART)
        }
        bRet = reader.startScan()

        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func stopScan(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        reader.stopScan()
        result(true)
    }
}

