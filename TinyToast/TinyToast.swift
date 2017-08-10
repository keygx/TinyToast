//
//  TinyToast.swift
//  TinyToast
//
//  Created by keygx on 2017/08/09.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit

public class TinyToast {
    
    let serialQueue = DispatchQueue(label: "tinytoast.serial.queue")
    
    public init() {}
    
    public func show(message: String, valign: TinyToastDisplayVAlign = .center, duration: TinyToastDisplayDuration) -> Void {
        serialQueue.sync {
            DispatchQueue.main.async {
                TTView().show(message: message, valign: valign, duration: duration)
            }
        }
    }
}
