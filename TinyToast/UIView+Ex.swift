//
//  UIView+Ex.swift
//  TinyToast
//
//  Created by keygx on 2019/09/28.
//  Copyright © 2019 keygx. All rights reserved.
//

import UIKit

extension UIView {
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        return false
    }
}
