//
//  TinyToastViewController.swift
//  TinyToast
//
//  Created by keygx on 2019/09/27.
//  Copyright © 2019 keygx. All rights reserved.
//

import UIKit

class TinyToastViewController: UIViewController {
    
    // Direction of Statusbar
    static var orientation: UIInterfaceOrientation {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .portrait
        } else {
            return UIApplication.shared.statusBarOrientation
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        switch TinyToastViewController.orientation {
        case .landscapeLeft, .landscapeRight:
            // LandscapeLeft | LandscapeRight
            return true
        default:
            // Unknown | Portrait | PortraitUpsideDown
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
