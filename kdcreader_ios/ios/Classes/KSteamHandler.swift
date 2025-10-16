//
//  KSteamHandler.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/19/24.
//

import Flutter

class KSteamHandler: NSObject, FlutterStreamHandler {
    var name: String
    weak var readerManager: KdcReaderManager?
    
    init(_ name: String, manager: KdcReaderManager) {
        self.name = name
        self.readerManager = manager
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        readerManager?.setEventSink(name, eventSink: events)
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        readerManager?.setEventSink(name, eventSink: nil)
        return nil
    }
}
