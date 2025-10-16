//
//  KEvent.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/20/24.
//

import Foundation

struct KEvent {
    struct Name {
        static let CONNECTION_STATE_CHANGED = "onConnectionChanged"
        
        static let BARCODE_DATA_RECEIVED = "onBarcodeDataReceived"
        static let NFC_DATA_RECEIVED = "onNfcDataReceived"
        static let MSR_DATA_RECEIVED = "onMsrDataReceived"
        static let GENERAL_DATA_RECEIVED = "onDataReceived"
        
        static let POS_DATA_RECEIVED = "onPosDataReceived"
        
        static let ERROR_RECEIVED = "onErrorReceived"
        
        static let DEVICE_SCANNED = "onDeviceScanned"
        
        static let INFO_UPDATED = "onInfoUpdated"

        // Software Decoder
        static let SW_BARCODE_DATA_RECEIVED = "onSwBarcodeDataReceived"

        private init() {}
    }

    private init() {}
}
