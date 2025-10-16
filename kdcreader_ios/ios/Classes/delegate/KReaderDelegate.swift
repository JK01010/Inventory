//
//  KReaderDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/19/24.
//

import Flutter
import Foundation

//protocol KReaderDelegate: AnyObject {
//    func isSupported(_ name: String) -> Bool
//
//    func run(_ call: FlutterMethodCall, result: @escaping FlutterResult)
//}

class KReaderDelegate: KDelegate {
    let reader: KDCReader
    let converter: KConverter
    
    var SUPPORTED_ACTIONS = [String]()
    
    init(reader: KDCReader, converter: KConverter) {
        self.reader = reader
        self.converter = converter
    }
    
    func isSupported(_ name: String) -> Bool {
        return SUPPORTED_ACTIONS.contains(name)
    }

    func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        return false
    }
    
    func isConnected() -> Bool {
        return reader.isConnected()
    }
    
    func sendErrorResult(_ err:Dictionary<String, Any>, detail: Any? = nil, result: @escaping FlutterResult) {
        guard let code = err[KConstants.ErrorCode.Code] as? String,
              let message = err[KConstants.ErrorCode.Message] as? String else {
            return
        }
        
        result(FlutterError(code: code, message: message, details: detail))
    }
}
