//
//  WindowBuilder.swift
//  TinyToast
//
//  Created by keygx on 2019/09/24.
//  Copyright © 2019 keygx. All rights reserved.
//

import UIKit

final class WindowBuilder {
    static func build(frame: CGRect, orientation: UIInterfaceOrientation) -> UIWindow {
        var baseWindow: UIWindow
        
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes
                                .filter { $0.activationState == .foregroundActive }.first
            if let windowScene = windowScene as? UIWindowScene {
                baseWindow = UIWindow(windowScene: windowScene)
            } else {
                baseWindow = UIWindow()
            }
        } else {
            baseWindow = UIWindow()
        }
        
        baseWindow.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        baseWindow.backgroundColor = UIColor.clear
        baseWindow.windowLevel = UIWindow.Level.normal
        baseWindow.isUserInteractionEnabled = false
        baseWindow.makeKey()
        baseWindow.makeKeyAndVisible()
        
        return baseWindow
    }
}
