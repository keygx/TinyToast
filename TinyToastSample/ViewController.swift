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
    
    let t2 = TinyToast()
    
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
        var valign: TinyToastDisplayVAlign = .center
        switch segVAlign.selectedSegmentIndex {
        case 0:
            valign = .top
        case 1:
            valign = .center
        case 2:
            valign = .bottom
        default:
            break
        }
        
        var duration: TinyToastDisplayDuration = .normal
        switch segDuration.selectedSegmentIndex {
        case 0:
            duration = .short
        case 1:
            duration = .normal
        case 2:
            duration = .long
        case 3:
            duration = .longLong
        default:
            break
        }
        
        t2.show(message: textView.text + "\(Date())", valign: valign, duration: duration)
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
