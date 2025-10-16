//
//  ComponentScanViewController.swift
//  device_info_plus
//
//  Created by koamtac on 4/2/24.
//

import UIKit
import SwiftDecoder

class ComponentScanViewController: UIViewController {

    @IBOutlet weak var decoderComponent: KDCSWDecoderComponent!

    private var hsmDecoder : HSMDecoder?
    private var storedBarButtonItem: UIBarButtonItem?
    
    private func initComponent() {
        // get the singleton instance of the decoder - use hsmdecoder directly
        self.hsmDecoder = HSMDecoder.getInstance()
        
        if let navigationController = self.navigationController {
            storedBarButtonItem = self.navigationItem.leftBarButtonItem

            navigationController.isNavigationBarHidden = false
            let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBackButtonClicked(_:)))
            self.navigationItem.leftBarButtonItem = newBackButton
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initComponent()
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                    
        // enable the embedded decode component
        self.decoderComponent.enable(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
                
        // disable the embedded decode component
        self.decoderComponent.enable(false)
    }

    @objc
    func onBackButtonClicked(_ sender: UIBarButtonItem) {
        if let navigationController = self.navigationController {
            self.navigationItem.leftBarButtonItem = storedBarButtonItem
            navigationController.isNavigationBarHidden = true
            navigationController.popToRootViewController(animated: true)
        }
    }
}
