//
//  ViewController.swift
//  TinyToastSample
//
//  Created by keygx on 2017/08/08.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit
import TinyToast

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segVAlign: UISegmentedControl!
    @IBOutlet weak var segDuration: UISegmentedControl!
    
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segVAlign.selectedSegmentIndex = 1
        segDuration.selectedSegmentIndex = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    @IBAction func segVAlign(_ sender: UISegmentedControl) {
        segVAlign.selectedSegmentIndex = sender.selectedSegmentIndex
    }
    
    @IBAction func segDuration(_ sender: UISegmentedControl) {
        segDuration.selectedSegmentIndex = sender.selectedSegmentIndex
    }
    
    @IBAction func btnShowAction(_ sender: UIButton) {
        message = textView.text
        
        var valign: TinyToastDisplayVAlign = .center
        switch segVAlign.selectedSegmentIndex {
        case 0:
            valign = .top
            message += " | .top"
        case 1:
            valign = .center
            message += " | .center"
        case 2:
            valign = .bottom
            message += " | .bottom"
        default:
            break
        }
        
        var duration: TinyToastDisplayDuration = .normal
        switch segDuration.selectedSegmentIndex {
        case 0:
            duration = .short
            message += " | .short"
        case 1:
            duration = .normal
            message += " | .normal"
        case 2:
            duration = .long
            message += " | .long"
        case 3:
            duration = .longLong
            message += " | .longLong"
        default:
            break
        }
        
        // Show Toast
        TinyToast.shared.show(message: message, valign: valign, duration: duration)
    }
    
    @IBAction func btnDismissAction(_ sender: UIButton) {
        // Dismiss first Toast
        TinyToast.shared.dismiss()
    }
    
    @IBAction func btnDismissAllAction(_ sender: UIButton) {
        // Dismiss All
        TinyToast.shared.dismissAll()
    }
}

extension UINavigationController {
    open override var shouldAutorotate: Bool {
        guard let viewCtrl = self.visibleViewController else{return true}
        return viewCtrl.shouldAutorotate
    }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let viewCtrl = self.visibleViewController else{return .all}
        return viewCtrl.supportedInterfaceOrientations
    }
}
