//
//  KViewFactory.swift
//  device_info_plus
//
//  Created by koamtac on 4/3/24.
//

import Flutter

class KViewFactory: NSObject, FlutterPlatformViewFactory {
    static let SW_DECODER_COMPONENT_VIEW_TYPE_ID = "SWComponentView"
    
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return KComponentView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}
