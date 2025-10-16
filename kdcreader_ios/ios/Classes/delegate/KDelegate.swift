//
//  KDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/19/24.
//

import Flutter

protocol KDelegate: AnyObject {
    func isSupported(_ name: String) -> Bool
    func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool
}
