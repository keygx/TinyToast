//
//  AsyncUtil.swift
//  TinyToast
//
//  Created by keygx on 2017/08/10.
//  Copyright © 2017年 keygx. All rights reserved.
//

import Foundation

let serialQueue = DispatchQueue(label: "tinytoast.queue.serial", attributes: [])

class AsyncUtil {
    class func onMainThread(_ block: @escaping () -> Void, delay: Double) {
        if delay == 0.0 {
            DispatchQueue.main.async {
                block()
            }
            return
        }
        
        let d = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: d) {
            block()
        }
    }
    
    class func sync(_ block: () -> Void) {
        serialQueue.sync {
            block()
        }
    }
}
