//
//  KComponentView.swift
//  device_info_plus
//
//  Created by koamtac on 4/3/24.
//

import Flutter

class KComponentView: NSObject, FlutterPlatformView {
    private let SW_DECODER_COMPONENT_VIEW_METHOD_CHANNEL_NAME = "plugins.flutter.koamtac/swcomponentview"
    
    private let ENABLE_SCANNING = "enableScanning"
    private let SET_FREEZE_MDOE = "setFreezeMode"
    
    /* PARAM */
    private let PARAM_NAME_SCANNING = "scanning"
    private let PARAM_NAME_FREEZE_MODE = "freeze"
    
    private var _view: UIView
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = KNativeView(frame: frame)

        super.init()

// TBD
//        if let nativeView = _view as? KNativeView,
//           let params = args as? Dictionary<String, Any> {
//            if let enable = params[PARAM_NAME_SCANNING] as? Bool {
//                nativeView.componentView?.enable(enable)
//            }
//         
//            if let enable = params[PARAM_NAME_FREEZE_MODE] as? Bool {
//                nativeView.componentView?.setFreezeMode(enable)
//            }
//        }
        
        if let m = messenger {
            initMethodChannel(viewId, messenger: m)
        }
    }

    func view() -> UIView {
        return _view
    }

    private func initMethodChannel(_ viewId: Int64, messenger: FlutterBinaryMessenger) {
        let methodChannel = FlutterMethodChannel(name: SW_DECODER_COMPONENT_VIEW_METHOD_CHANNEL_NAME + "_\(viewId)", binaryMessenger: messenger)
        methodChannel.setMethodCallHandler { call, result in
            switch call.method {
            case self.ENABLE_SCANNING:
                self.enableScanning(call, result: result)
                
            case self.SET_FREEZE_MDOE:
                self.setFreezeMode(call, result: result)
                
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    private func enableScanning(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let enable = call.arguments as? Bool else {
            return
        }
        
        if let nativeView = _view as? KNativeView {
            nativeView.componentView?.enable(enable)
        }
    }
    
    private func setFreezeMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let enable = call.arguments as? Bool else {
            return
        }

        if let nativeView = _view as? KNativeView {
            nativeView.componentView?.setFreezeMode(enable)
        }
    }
}

class KNativeView: UIView {
    var componentView: HSMDecodeComponent?
    
    override init(frame: CGRect) {
        componentView = HSMDecodeComponent(frame: frame)
        super.init(frame: frame)

        initComponentView()
    }
    
    required init?(coder: NSCoder) {
        componentView = HSMDecodeComponent(coder: coder) ?? nil
        super.init(coder: coder)
        
        initComponentView()
    }
    
    override func layoutSubviews() {
        if let child = componentView {
            // Re-enable scan to fit the camera screen to the view size
            if child.isEnabled() {
                child.enable(false)
                child.enable(true)
            }
        }
        super.layoutSubviews()
    }
    
    private func initComponentView() {
        if let child = componentView {
            self.addSubview(child)
            
            child.translatesAutoresizingMaskIntoConstraints = false
            
            let con = [
                child.centerXAnchor.constraint(equalTo: centerXAnchor),
                child.centerYAnchor.constraint(equalTo: centerYAnchor),
                child.widthAnchor.constraint(equalTo: widthAnchor),
                child.heightAnchor.constraint(equalTo: heightAnchor)
            ]
            NSLayoutConstraint.activate(con)
            
            // To show the camera screen when it starts.
            child.enable(true)
        }
    }
}
