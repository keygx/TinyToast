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
    
    let message = "TinyToast is simple toast library in Swift."
    var valign: TinyToastDisplayVAlign = .center
    var duration: TinyToastDisplayDuration = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segVAlign.selectedSegmentIndex = 1
        segDuration.selectedSegmentIndex = 1
        updateTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(textView.isFirstResponder){
            textView.resignFirstResponder()
        }
    }
}

extension ViewController {
    func updateTextView() {
        var v = ""
        switch segVAlign.selectedSegmentIndex {
        case 0:
            valign = .top
            v = " | .top"
        case 1:
            valign = .center
            v = " | .center"
        case 2:
            valign = .bottom
            v = " | .bottom"
        default:
            break
        }
        
        var d = ""
        switch segDuration.selectedSegmentIndex {
        case 0:
            duration = .short
            d = " | .short"
        case 1:
            duration = .normal
            d = " | .normal"
        case 2:
            duration = .long
            d = " | .long"
        case 3:
            duration = .longLong
            d = " | .longLong"
        default:
            break
        }
        
        textView.text = message + v + d
    }
    
    @IBAction func segVAlign(_ sender: UISegmentedControl) {
        segVAlign.selectedSegmentIndex = sender.selectedSegmentIndex
        updateTextView()
    }
    
    @IBAction func segDuration(_ sender: UISegmentedControl) {
        segDuration.selectedSegmentIndex = sender.selectedSegmentIndex
        updateTextView()
    }
    
    @IBAction func btnShowAction(_ sender: StandardButton) {
        // Show Toast
        TinyToast.shared.show(message: textView.text!, valign: valign, duration: duration)
    }
    
    @IBAction func btnDismissAction(_ sender: StandardButton) {
        // Dismiss first Toast
        TinyToast.shared.dismiss()
    }
    
    @IBAction func btnDismissAllAction(_ sender: StandardButton) {
        // Dismiss All
        TinyToast.shared.dismissAll()
    }
}

extension ViewController {
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
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
