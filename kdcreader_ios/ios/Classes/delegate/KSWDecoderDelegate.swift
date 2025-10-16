//
//  KSWDecoderDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 4/1/24.
//

import Flutter

class KSWDecoderDelegate: KReaderDelegate {
    /* ACTION */
    private let IS_SOFTWARE_DECODER_ACTIVATED = "isSoftwareDecoderActivated"
    private let ACTIVATE_SOFTWARE_DECODER = "activateSoftwareDecoder"

    private let SET_SOFTWARE_DECODER_ACTIVATION_PERIOD = "setSoftwareDecoderActivationPeriod"

    private let GET_SOFTWARE_DECODER_SETTING = "getSoftwareDecoderSetting"
    private let SET_SOFTWARE_DECODER_SETTING = "setSoftwareDecoderSetting"

    private let GET_SOFTWARE_DECODER_DEVICE_ID = "getSoftwareDecoderDeviceId"

    private let GET_SOFTWARE_DECODER_LAST_PROCESSED_IMAGE = "getSoftwareDecoderLastProcessedImage"
    private let GET_SOFTWARE_DECODER_LAST_DECODED_IMAGE = "getSoftwareDecoderLastDecodedImage"
    private let GET_SOFTWARE_DECODER_LAST_BARCODE_IMAGE = "getSoftwareDecoderLastBarcodeImage"

    private let START_COMPONENT_SCAN_ACTIVITY = "startComponentScanActivity"

    /* PARAM */
    private let PARAM_NAME_LICENSE = "license"
    private let PARAM_NAME_PERIOD = "period"
    private let PARAM_NAME_VOLUME = "volume"
    private let PARAM_NAME_DELAY = "delay"
    private let PARAM_NAME_VERSION = "version"
    
    var viewController: UIViewController?
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            IS_SOFTWARE_DECODER_ACTIVATED,
            ACTIVATE_SOFTWARE_DECODER,
            
            SET_SOFTWARE_DECODER_ACTIVATION_PERIOD,
            
            GET_SOFTWARE_DECODER_SETTING,
            SET_SOFTWARE_DECODER_SETTING,
            
            GET_SOFTWARE_DECODER_DEVICE_ID,

            GET_SOFTWARE_DECODER_LAST_PROCESSED_IMAGE,
            GET_SOFTWARE_DECODER_LAST_DECODED_IMAGE,
            GET_SOFTWARE_DECODER_LAST_BARCODE_IMAGE,

            START_COMPONENT_SCAN_ACTIVITY,
        ]);
    }

    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        switch call.method {
        case IS_SOFTWARE_DECODER_ACTIVATED:
            isSoftwareDecoderActivated(call, result: result)
            
        case ACTIVATE_SOFTWARE_DECODER:
            activateSoftwareDecoder(call, result: result)
            
        case SET_SOFTWARE_DECODER_ACTIVATION_PERIOD:
            setSoftwareDecoderActivationPeriod(call, result: result)

        case GET_SOFTWARE_DECODER_SETTING:
            getSoftwareDecoderSetting(call, result: result)
        case SET_SOFTWARE_DECODER_SETTING:
            setSoftwareDecoderSetting(call, result: result)

        case GET_SOFTWARE_DECODER_DEVICE_ID:
            getSoftwareDecoderDeviceId(call, result: result)

        case GET_SOFTWARE_DECODER_LAST_PROCESSED_IMAGE:
            getSoftwareDecoderLastProcessedImage(call, result: result)

        case GET_SOFTWARE_DECODER_LAST_DECODED_IMAGE:
            getSoftwareDecoderLastDecodedImage(call, result: result)

        case GET_SOFTWARE_DECODER_LAST_BARCODE_IMAGE:
            getSoftwareDecoderLastBarcodeImage(call, result: result)
            
        case START_COMPONENT_SCAN_ACTIVITY:
            startComponentScanActivity(call, result: result)
            
        default:
            break
        }
        return true
    }
    
    private func isSoftwareDecoderActivated(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let vc = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }

        reader.setSoftwareDecoderContext(vc)

        let isActivated = reader.isSoftwareDecoderActivated()
        result(isActivated)
    }

    private func activateSoftwareDecoder(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let license = args[PARAM_NAME_LICENSE] as? String else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        guard let vc = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }
        
        if !license.isEmpty {
            reader.setSoftwareDecoderContext(vc)
            
            let activationResult = reader.activateSoftwareDecoder(license)
            
            result(converter.fromKDCSWDecoderActivationResult(activationResult))
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result: result)
        }
    }

    private func setSoftwareDecoderActivationPeriod(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let period = args[PARAM_NAME_PERIOD] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        guard let vc = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }

        reader.setSoftwareDecoderContext(vc)
        
        reader.setActivationPeriod(period)
        result(true)
    }

    private func getSoftwareDecoderSetting(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let vc = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }
        
        reader.setSoftwareDecoderContext(vc)
        
        if let setting = reader.getSoftwareDecoderSetting() {
            result(converter.fromKDCSWDecoderSetting(setting))
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result: result)
        }
    }

    private func setSoftwareDecoderSetting(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        guard let _ = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }
        
        let decoderSetting = KDCSWDecoderSetting()
        
        if let flash = args[KConstants.SWDecoderSettingKey.FlashOnDecode] as? Bool {
            decoderSetting.enableFlash(onDecode: flash)
        }
        
        if let decode = args[KConstants.SWDecoderSettingKey.Decode] as? Bool {
            decoderSetting.enableDecoding(decode)
        }
        
        if let rect = args[KConstants.SWDecoderSettingKey.Window] as? FlutterStandardTypedData {
            if rect.elementCount >= 4 {
                let int32List = rect.data.withUnsafeBytes {
                    let pointer = $0.bindMemory(to: Int32.self)

                    let rectList = pointer.map {
                        Int32($0)
                    }
                    return rectList
                }
                
                let left = int32List[0]
                let right = int32List[1]
                let top = int32List[2]
                let bottom = int32List[3]
                decoderSetting.setWindowRect(left, right: right, top: top, bottom: bottom)
            }
        }
        
        if let v = args[KConstants.SWDecoderSettingKey.WindowMode] as? Int,
            let mode = SWDecoderWindowMode(rawValue: v) {
            decoderSetting.setWindowMode(mode)
        }
        
        if let aimer = args[KConstants.SWDecoderSettingKey.Aimer] as? Bool {
            decoderSetting.enableAimer(aimer)
        }

        if let color = args[KConstants.SWDecoderSettingKey.AimerColor] as? Int {
            let r = CGFloat((color >> 16) & 0xFF) / 255
            let g = CGFloat((color >> 8) & 0xFF) / 255
            let b = CGFloat(color & 0xFF) / 255
            let a = CGFloat((color >> 24) & 0xFF) / 255
            let aimerColor = UIColor(red: r, green: g, blue: b, alpha: a)

            decoderSetting.setAimerColor(aimerColor)
        }

        if let text = args[KConstants.SWDecoderSettingKey.OverlayText] as? String {
            decoderSetting.setOverlayText(text)
        }
        
        if let color = args[KConstants.SWDecoderSettingKey.OverlayTextColor] as? Int {
            let r = CGFloat((color >> 16) & 0xFF) / 255
            let g = CGFloat((color >> 8) & 0xFF) / 255
            let b = CGFloat(color & 0xFF) / 255
            let a = CGFloat((color >> 24) & 0xFF) / 255
            let textColor = UIColor(red: r, green: g, blue: b, alpha: a)

            decoderSetting.setOverlayTextColor(textColor)
        }
        
        if let activeTemplate = args[KConstants.SWDecoderSettingKey.OCRActiveTemplate] as? Int {
            decoderSetting.setOCRActiveTemplate(Int32(activeTemplate))
        }
        
        if let template = args[KConstants.SWDecoderSettingKey.OCRUserTemplate] as? FlutterStandardTypedData {
            var templateData = Data(template.data)
            
            templateData.withUnsafeMutableBytes {
                if let pointer = $0.bindMemory(to: UInt8.self).baseAddress {
                    decoderSetting.setOCRUserTemplate(pointer)
                }
            }
        }
        
        if let v = args[KConstants.SWDecoderSettingKey.ActiveCamera] as? Int,
          let type = SWDecoderCameraType(rawValue: v) {
            decoderSetting.setActiveCameraType(type)
        }

        let bRet = reader.setSoftwareDecoderSetting(decoderSetting)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getSoftwareDecoderDeviceId(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let _ = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }
        
        if let deviceId = reader.getSoftwareDecoderDeviceId() {
            result(deviceId)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getSoftwareDecoderLastProcessedImage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let _ = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }
        
        if let image = reader.getSoftwareDecoderLastProcessedImage() {
            result(converter.fromUIImage(image))
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getSoftwareDecoderLastDecodedImage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let _ = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }
        
        if let image = reader.getSoftwareDecoderLastDecodedImage() {
            result(converter.fromUIImage(image))
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func getSoftwareDecoderLastBarcodeImage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        guard let topLeft = args[KConstants.SWDecoderBoundsKey.TopLeft] as? Dictionary<String, Any>,
              let topLeftX = topLeft[KConstants.SWDecoderBoundsKey.X] as? Int,
              let topLeftY = topLeft[KConstants.SWDecoderBoundsKey.Y] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        guard let topRight = args[KConstants.SWDecoderBoundsKey.TopRight] as? Dictionary<String, Any>,
              let topRightX = topRight[KConstants.SWDecoderBoundsKey.X] as? Int,
              let topRightY = topRight[KConstants.SWDecoderBoundsKey.Y] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        guard let bottomLeft = args[KConstants.SWDecoderBoundsKey.BottomLeft] as? Dictionary<String, Any>,
              let bottomLeftX = bottomLeft[KConstants.SWDecoderBoundsKey.X] as? Int,
              let bottomLeftY = bottomLeft[KConstants.SWDecoderBoundsKey.Y] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        guard let bottomRight = args[KConstants.SWDecoderBoundsKey.BottomRight] as? Dictionary<String, Any>,
              let bottomRightX = bottomRight[KConstants.SWDecoderBoundsKey.X] as? Int,
              let bottomRightY = bottomRight[KConstants.SWDecoderBoundsKey.Y] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        guard let width = args[KConstants.SWDecoderBoundsKey.Width] as? Int,
              let height = args[KConstants.SWDecoderBoundsKey.Height] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        guard let _ = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }
        
        let point = [
            Int32(topLeftX), Int32(topLeftY),
            Int32(topRightX), Int32(topRightY),
            Int32(bottomRightX), Int32(bottomRightX),
            Int32(bottomLeftX), Int32(bottomLeftY)
        ]
        
        let bounds = point.withUnsafeBufferPointer { p in
            BarcodeBounds(UnsafeMutablePointer(mutating: p.baseAddress), 
                          imgWidth: Int32(width), imgHeight: Int32(height)
            )
        }
        
        if let b = bounds, let image = reader.getSoftwareDecoderLastBarcodeImage(b) {
            result(converter.fromUIImage(image))
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func startComponentScanActivity(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let vc = self.viewController else {
            sendErrorResult(KConstants.ErrorCode.NULL, result:result)
            return
        }
        
        let scanViewController = ComponentScanViewController(nibName: "ComponentScanViewController", bundle: Bundle(for: KdcreaderIosPlugin.self))
        
        if let navigationController = vc.navigationController {
            navigationController.pushViewController(scanViewController, animated: true)
        } else {
            self.viewController?.present(scanViewController, animated: true, completion: nil)
        }
        
        result(true)
    }
}
