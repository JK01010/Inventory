//
//  KWiFiDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/22/24.
//

import Flutter

class KWiFiDelegate: KReaderDelegate {
    /* ACTION */
    private let IS_WIFI_INSTALLED = "isWiFiInstalled"

    private let ENABLE_WIFI_POWER = "enableWiFiPower"
    private let IS_WIFI_POWER_ENABLED = "isWiFiPowerEnabled"

    private let ENABLE_WIFI_AUTO_CONNECT = "enableWiFiAutoConnect"
    private let IS_WIFI_AUTO_CONNECT_ENABLED = "isWiFiAutoConnectEnabled"

    private let SET_WIFI_SERVER_IP_ADDRESS = "setWiFiServerIPAddress"
    private let GET_WIFI_SERVER_IP_ADDRESS = "getWiFiServerIPAddress"

    private let SET_WIFI_SERVER_URL_ADDRESS = "setWiFiServerURLAddress"
    private let GET_WIFI_SERVER_URL_ADDRESS = "getWiFiServerURLAddress"

    private let SET_WIFI_SERVER_PORT_NUMBER = "setWiFiServerPortNumber"
    private let GET_WIFI_SERVER_PORT_NUMBER = "getWiFiServerPortNumber"

    private let SET_WIFI_PROTOCOL = "setWiFiProtocol"
    private let GET_WIFI_PROTOCOL = "getWiFiProtocol"

    private let ENABLE_WIFI_SSL = "enableWiFiSSL"
    private let IS_WIFI_SSL_ENABLED = "isWiFiSSLEnabled"

    private let SET_WIFI_SERVER_PAGE = "setWiFiServerPage"
    private let GET_WIFI_SERVER_PAGE = "getWiFiServerPage"

    private let SET_WIFI_CERTIFICATION = "setWiFiCertification"
    private let GET_WIFI_CERTIFICATION = "getWiFiCertification"

    private let SET_WIFI_AP_SSID = "setWiFiApSSID"
    private let GET_WIFI_AP_SSID = "getWiFiApSSID"

    private let SET_WIFI_AP_PASSCODE = "setWiFiApPasscode"
    private let GET_WIFI_AP_PASSCODE = "getWiFiApPasscode"

    /* PARAM */
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_IP = "ip"
    private let PARAM_NAME_URL = "url"
    private let PARAM_NAME_PORT = "port"
    private let PARAM_NAME_PROTOCOL = "protocol"
    private let PARAM_NAME_SERVER_PAGE = "page"
    private let PARAM_NAME_CERTIFICATION = "cert"
    private let PARAM_NAME_SSID = "ssid"
    private let PARAM_NAME_PASSCODE = "passcode"

    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            IS_WIFI_INSTALLED,
            
            ENABLE_WIFI_POWER,
            IS_WIFI_POWER_ENABLED,
            
            ENABLE_WIFI_AUTO_CONNECT,
            IS_WIFI_AUTO_CONNECT_ENABLED,
            
            SET_WIFI_SERVER_IP_ADDRESS,
            GET_WIFI_SERVER_IP_ADDRESS,
            
            SET_WIFI_SERVER_URL_ADDRESS,
            GET_WIFI_SERVER_URL_ADDRESS,
            
            SET_WIFI_SERVER_PORT_NUMBER,
            GET_WIFI_SERVER_PORT_NUMBER,
            
            SET_WIFI_PROTOCOL,
            GET_WIFI_PROTOCOL,
            
            ENABLE_WIFI_SSL,
            IS_WIFI_SSL_ENABLED,
            
            SET_WIFI_SERVER_PAGE,
            GET_WIFI_SERVER_PAGE,
            
            SET_WIFI_CERTIFICATION,
            GET_WIFI_CERTIFICATION,
            
            SET_WIFI_AP_SSID,
            GET_WIFI_AP_SSID,
            
            SET_WIFI_AP_PASSCODE,
            GET_WIFI_AP_PASSCODE,
        ]);
    }

    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case IS_WIFI_INSTALLED:
            isWiFiInstalled(call, result: result)

        case ENABLE_WIFI_POWER:
            enableWiFiPower(call, result: result)
            
        case IS_WIFI_POWER_ENABLED:
            isWiFiPowerEnabled(call, result: result)

        case ENABLE_WIFI_AUTO_CONNECT:
            enableWiFiAutoConnect(call, result: result)
            
        case IS_WIFI_AUTO_CONNECT_ENABLED:
            isWiFiAutoConnectEnabled(call, result: result)

        case SET_WIFI_SERVER_IP_ADDRESS:
            setWiFiServerIPAddress(call, result: result)
            
        case GET_WIFI_SERVER_IP_ADDRESS:
            getWiFiServerIPAddress(call, result: result)

        case SET_WIFI_SERVER_URL_ADDRESS:
            setWiFiServerURLAddress(call, result: result)
            
        case GET_WIFI_SERVER_URL_ADDRESS:
            getWiFiServerURLAddress(call, result: result)

        case SET_WIFI_SERVER_PORT_NUMBER:
            setWiFiServerPortNumber(call, result: result)
            
        case GET_WIFI_SERVER_PORT_NUMBER:
            getWiFiServerPortNumber(call, result: result)

        case SET_WIFI_PROTOCOL:
            setWiFiProtocol(call, result: result)
            
        case GET_WIFI_PROTOCOL:
            getWiFiProtocol(call, result: result)

        case ENABLE_WIFI_SSL:
            enableWiFiSSL(call, result: result)
            
        case IS_WIFI_SSL_ENABLED:
            isWiFiSSLEnabled(call, result: result)

        case SET_WIFI_SERVER_PAGE:
            setWiFiServerPage(call, result: result)
            
        case GET_WIFI_SERVER_PAGE:
            getWiFiServerPage(call, result: result)

        case SET_WIFI_CERTIFICATION:
            setWiFiCertification(call, result: result)
            
        case GET_WIFI_CERTIFICATION:
            getWiFiCertification(call, result: result)

        case SET_WIFI_AP_SSID:
            setWiFiApSSID(call, result: result)
            
        case GET_WIFI_AP_SSID:
            getWiFiApSSID(call, result: result)

        case SET_WIFI_AP_PASSCODE: 
            setWiFiApPasscode(call, result: result)
            
        case GET_WIFI_AP_PASSCODE:
            getWiFiApPasscode(call, result: result)

        default:
            break
        }
        return true
    }
    
    private func isWiFiInstalled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let attached = reader.isWiFiInstalled()
        result(attached)
    }

    private func enableWiFiPower(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableWiFiPower(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isWiFiPowerEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isWiFiPowerEnabled()
        result(enable)
    }
    
    private func enableWiFiAutoConnect(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableWiFiAutoConnect(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isWiFiAutoConnectEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isWiFiAutoConnectEnabled()
        result(enable)
    }
    
    private func setWiFiServerIPAddress(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let ip = args[PARAM_NAME_IP] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setWiFiServerIPAddress(ip)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getWiFiServerIPAddress(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let ip = reader.getWiFiServerIPAddress() {
            result(ip)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setWiFiServerURLAddress(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let url = args[PARAM_NAME_URL] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setWiFiServerURLAddress(url)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getWiFiServerURLAddress(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let url = reader.getWiFiServerURLAddress() {
            result(url)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setWiFiServerPortNumber(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let port = args[PARAM_NAME_PORT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setWiFiServerPortNumber(Int32(port))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getWiFiServerPortNumber(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let port = reader.getWiFiServerPortNumber()
        
        if port > -1 {
            result(port)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setWiFiProtocol(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_PROTOCOL] as? Int,
              let wifiProtocol = WiFiProtocol(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setWiFiProtocol(wifiProtocol)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getWiFiProtocol(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let wifiProtocol = reader.getWiFiProtocol().rawValue
        
        if let _ = WiFiProtocol(rawValue: wifiProtocol) {
            result(wifiProtocol)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func enableWiFiSSL(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableWiFiSSL(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func isWiFiSSLEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isWiFiSSLEnabled()
        result(enable)
    }
    
    private func setWiFiServerPage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let page = args[PARAM_NAME_SERVER_PAGE] as? String ?? KConstants.EMPTY_STRING
        
        let bRet = reader.setWiFiServerPage(page)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }

    }

    private func getWiFiServerPage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let page = reader.getWiFiServerPage() {
            result(page)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setWiFiCertification(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let cert = args[PARAM_NAME_CERTIFICATION] as? FlutterStandardTypedData else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        var certification = Data(cert.data)
        
        let bRet = certification.withUnsafeMutableBytes {
            let pointer = $0.bindMemory(to: UInt8.self)
            return reader.setWiFiCertification(pointer.baseAddress, length: Int32(pointer.count))
//            return reader.setWiFiCertification($0.baseAddress, length: Int32($0.count))
        }

        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getWiFiCertification(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let certification = reader.getWiFiCertification() {
            result(certification)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setWiFiApSSID(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let ssid = args[PARAM_NAME_SSID] as? String ?? KConstants.EMPTY_STRING
        
        let bRet = reader.setWiFiApSSID(ssid)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getWiFiApSSID(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let ssid = reader.getWiFiApSSID() {
            result(ssid)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setWiFiApPasscode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let passcode = args[PARAM_NAME_PASSCODE] as? String ?? KConstants.EMPTY_STRING
        
        let bRet = reader.setWiFiApPasscode(passcode)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getWiFiApPasscode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let passcode = reader.getWiFiApPasscode() {
            result(passcode)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
}
