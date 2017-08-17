//
//  TinyToastWindow.swift
//  TinyToast
//
//  Created by keygx on 2017/08/08.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit

class TinyToastWindow: UIWindow {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        
        switch orientation {
        case .landscapeLeft:
            fallthrough
        case .landscapeRight:
            // LandscapeLeft | LandscapeRight
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
        default:
            // Unknown | Portrait | PortraitUpsideDown
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        
        backgroundColor = UIColor.clear
        windowLevel = UIWindowLevelAlert + 1
        
        makeKey()
        
        makeKeyAndVisible()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
