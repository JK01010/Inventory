//
//  KMsrIcDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/21/24.
//

import Flutter

class KMsrIcDelegate: KReaderDelegate {
    private let IS_MSR_MODULE_ATTACHED = "isMSRICModuleAttached"
    private let SEND_MSRIC_DATA = "sendMSRICData"

    /* PARAM */
    private let PARAM_NAME_ATTACH = "attached"
    private let PARAM_NAME_MESSAGE = "message"
    private let PARAM_NAME_RESPONSE = "resp"

    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            IS_MSR_MODULE_ATTACHED,
            SEND_MSRIC_DATA,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case IS_MSR_MODULE_ATTACHED:
            isMSRICModuleAttached(call, result: result)

        case SEND_MSRIC_DATA:
            sendMSRICData(call, result: result)
            
        default:
            break
        }
        return true
    }
    
    private func isMSRICModuleAttached(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let attached = reader.isMSRICModuleAttached()
        result(attached)
    }
    
    private func sendMSRICData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let message = args[PARAM_NAME_MESSAGE] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let response = reader.sendMSRICData(message)
        
        if let resp = response {
            result(resp)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

}
